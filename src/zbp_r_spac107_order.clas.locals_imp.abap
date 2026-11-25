CLASS lhc_ZR_SPAC107_ORDER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Order RESULT result.

    METHODS addToCart FOR MODIFY
       keys FOR ACTION Order~addToCart RESULT result.

    METHODS cancelOrder FOR MODIFY
       keys FOR ACTION Order~cancelOrder RESULT result.

    METHODS checkoutCart FOR MODIFY
       keys FOR ACTION Order~checkoutCart RESULT result.

    METHODS markShipped FOR MODIFY
       keys FOR ACTION Order~markShipped RESULT result.

ENDCLASS.

CLASS lhc_ZR_SPAC107_ORDER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD addToCart.
     DATA lv_number TYPE int4 VALUE 1.
     DATA lv_order_id_table TYPE STANDARD TABLE OF int4.

     LOOP AT keys INTO DATA(key).
        DATA(lv_user_id)    = key-%param-UserId.
        DATA(lv_product_id) = key-%param-ProductId.
        DATA(lv_amount)     = key-%param-Amount.
    ENDLOOP.

    SELECT SINGLE from zspac107_product
        FIELDS price
        WHERE product_id = @lv_product_id
        INTO @DATA(lv_product_price).


        SELECT SINGLE FROM zspac107_order
            FIELDS order_id
            WHERE user_id = @lv_user_id
            AND status = 'CART'
            INTO @DATA(lv_order_id).

            IF sy-subrc = 0.
                READ ENTITIES OF ZR_SPAC107_ORDER IN LOCAL MODE
                ENTITY Order
                ALL FIELDS
                WITH VALUE #(
                    ( OrderId = lv_order_id )
                )
                RESULT DATA(lt_order).

            ELSE.

            SELECT order_id
                FROM zspac107_order
                INTO Table @lv_order_id_table.

            SORT lv_order_id_table.

            LOOP AT lv_order_id_table INTO DATA(ls_order_id).
                IF ls_order_id = lv_number.
                    lv_number = lv_number + 1.
                ELSEIF ls_order_id > lv_number.
                    EXIT.
                ENDIF.
              ENDLOOP.

              MODIFY ENTITIES OF ZR_SPAC107_ORDER IN LOCAL MODE
              ENTITY Order
              CREATE FIELDS ( OrderId UserId Status )
              WITH VALUE #(
                (
                  %cid    = key-%cid
                  OrderId = lv_number
                  UserId  = lv_user_id
                  Status  = 'CART'
                )
              )
                MAPPED DATA(mapped_order).
              lv_order_id = mapped_order-order[ 1 ]-OrderId.

            ENDIF.
              MODIFY ENTITIES OF ZR_SPAC107_ORDER IN LOCAL MODE
                  ENTITY Order
                  CREATE BY \_OrderItems
                  FIELDS ( ProductId Amount Price )
                  WITH VALUE #(
                    (
                         OrderId = lv_order_id
                         %target = VALUE #(
                        (
                          %cid      = key-%cid
                          ProductId = lv_product_id
                          Amount    = lv_amount
                          Price     = lv_product_price * lv_amount
                        )
                      )
                    )
                )
    MAPPED DATA(mapped_items)
    FAILED DATA(failed_items)
    REPORTED DATA(reported_items).
  ENDMETHOD.

  METHOD cancelOrder.
    LOOP AT keys INTO DATA(key).
        DATA(selected_order) = key-OrderId.
    ENDLOOP.
      READ ENTITIES OF ZR_SPAC107_ORDER IN LOCAL MODE
      ENTITY Order
      FIELDS ( OrderId Status )
      WITH VALUE #( ( OrderId = selected_order ) )
      RESULT DATA(orders).

    IF orders IS NOT INITIAL.

      IF orders[ 1 ]-Status = 'CART'
         OR orders[ 1 ]-Status = 'ORDERED'.

    MODIFY ENTITIES OF ZR_SPAC107_ORDER IN LOCAL MODE
    ENTITY Order
    DELETE FROM VALUE #(
    (   OrderId = selected_order )
    ).
          IF sy-subrc = 0.
            READ ENTITIES OF ZR_SPAC107_ORDER IN LOCAL MODE
              ENTITY Order
              BY \_OrderItems
              FIELDS ( OrderId )
              WITH VALUE #(
                ( OrderId = selected_order )
              )
              RESULT DATA(order_items).
              MODIFY ENTITIES OF ZR_SPAC107_ORDER IN LOCAL MODE
                ENTITY OrderItem
                DELETE FROM VALUE #(
                    FOR item IN order_items ( OrderId = item-OrderId )
                ).
          ENDIF.
          ENDIF.

    ENDIF.
  ENDMETHOD.

  METHOD checkoutCart.
      LOOP AT keys INTO DATA(key).
        DATA(lv_user_id)    = key-%param-UserId.
      ENDLOOP.
      SELECT SINGLE FROM zspac107_order
        FIELDS order_id
        WHERE user_id = @lv_user_id
        AND status = 'CART'
        INTO @DATA(ls_order_id).
      IF sy-subrc = 0.
        MODIFY ENTITIES OF ZR_SPAC107_ORDER IN LOCAL MODE
  ENTITY Order
  UPDATE FIELDS ( Status )
  WITH VALUE #(
    ( %key-OrderId = ls_order_id
      Status      = 'ORDERED' )
  ).
      ENDIF.

  ENDMETHOD.

  METHOD markShipped.
  ENDMETHOD.

ENDCLASS.

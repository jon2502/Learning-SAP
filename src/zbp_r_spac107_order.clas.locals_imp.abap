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
     LOOP AT keys INTO DATA(key).
        DATA(lv_user_id)    = key-%param-UserId.
        DATA(lv_product_id) = key-%param-ProductId.
        DATA(lv_amount)     = key-%param-Amount.
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
              MODIFY ENTITIES OF ZR_SPAC107_ORDER IN LOCAL MODE
              ENTITY Order
              CREATE FIELDS ( UserId Status )
              WITH VALUE #(
                (
                   %cid    = key-%cid
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
                      Price     = 10
                    )
                  )
                )
                )
   MAPPED DATA(mapped_items)
    FAILED DATA(failed_items)
    REPORTED DATA(reported_items).     ENDLOOP.
  ENDMETHOD.

  METHOD cancelOrder.
  ENDMETHOD.

  METHOD checkoutCart.
  ENDMETHOD.

  METHOD markShipped.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZR_SPAC107_STOCK DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CONSTANTS state_validate_warehouseID TYPE String VALUE 'VALIDATE_WAREHOUSE_ID'.
    CONSTANTS state_validate_productID TYPE String VALUE 'VALIDATE_PRODUCT_ID'.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zr_spac107_stock RESULT result.
    METHODS validateproductid FOR VALIDATE ON SAVE
      keys FOR zr_spac107_stock~validateproductid.

    METHODS validatewarehouseid FOR VALIDATE ON SAVE
      keys FOR zr_spac107_stock~validatewarehouseid.
    METHODS validateStockAmount FOR VALIDATE ON SAVE
      keys FOR zr_spac107_stock~validateStockAmount.

ENDCLASS.

CLASS lhc_ZR_SPAC107_STOCK IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateProductID.
    DATA products TYPE SORTED TABLE OF ZSPAC107_PRODUCT WITH UNIQUE KEY product_id.

    READ ENTITIES OF zr_spac107_stock IN LOCAL MODE
        ENTITY zr_spac107_stock
        FIELDS ( ProductId )
        WITH CORRESPONDING #(  keys )
        RESULT DATA(ID_check).

    products = CORRESPONDING #( ID_check DISCARDING DUPLICATES MAPPING product_id = productid EXCEPT * ).
    DELETE products WHERE product_id IS INITIAL.

     IF products IS NOT INITIAL.
      SELECT FROM ZR_SPAC107_PRODUCT FIELDS ProductId
        FOR ALL ENTRIES IN @products
        WHERE productid = @products-product_id
        INTO TABLE @DATA(product_db).
    ENDIF.

    LOOP AT ID_check INTO DATA(product).
      APPEND VALUE #( %tky        = product-%tky
                      %state_area = state_validate_productID )
             TO reported-zr_spac107_stock.

      IF        product-productid IS INITIAL
         OR NOT line_exists( product_db[ productid = product-ProductId ] ).

        APPEND VALUE #(  %tky = product-%tky ) TO failed-zr_spac107_stock.
        APPEND VALUE #( %tky                 = product-%tky
                        %state_area          = state_validate_productID
                        %msg                 = NEW  zcx_spac107_mes( textid      =  zcx_spac107_mes=>product_id_invalid
                                                                   productID = product-productid )
                        %element-productid = if_abap_behv=>mk-on )
               TO reported-zr_spac107_stock.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateWarehouseID.
    DATA warehouses TYPE SORTED TABLE OF ZSPAC107_LOC WITH UNIQUE KEY warehouse_id.

    READ ENTITIES OF zr_spac107_stock IN LOCAL MODE
        ENTITY zr_spac107_stock
        FIELDS ( WarehouseId )
        WITH CORRESPONDING #(  keys )
        RESULT DATA(ID_check).

    warehouses = CORRESPONDING #( ID_check DISCARDING DUPLICATES MAPPING warehouse_id = WarehouseId EXCEPT * ).
    DELETE warehouses WHERE warehouse_id IS INITIAL.

     IF warehouses IS NOT INITIAL.
      SELECT FROM ZR_SPAC107_LOC FIELDS warehouseid
        FOR ALL ENTRIES IN @warehouses
        WHERE warehouseid = @warehouses-warehouse_id
        INTO TABLE @DATA(warehouse_db).
    ENDIF.

    LOOP AT ID_check INTO DATA(warehouse).
      APPEND VALUE #( %tky        = warehouse-%tky
                      %state_area = state_validate_warehouseID )
             TO reported-zr_spac107_stock.

      IF        warehouse-WarehouseId IS INITIAL
         OR NOT line_exists( warehouse_db[ warehouseid = warehouse-WarehouseId ] ).

        APPEND VALUE #(  %tky = warehouse-%tky ) TO failed-zr_spac107_stock.
        APPEND VALUE #( %tky                 = warehouse-%tky
                        %state_area          = state_validate_warehouseID
                        %msg                 = NEW zcx_spac107_mes( textid      = zcx_spac107_mes=>warehouse_id_invalid
                                                                   warehouseID = warehouse-WarehouseId )
                        %element-warehouseid = if_abap_behv=>mk-on )
               TO reported-zr_spac107_stock.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.



  METHOD validateStockAmount.
  ENDMETHOD.

ENDCLASS.

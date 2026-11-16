CLASS lhc_ZR_SPAC107_STOCK DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zr_spac107_stock RESULT result.
    METHODS validateproductid FOR VALIDATE ON SAVE
      keys FOR zr_spac107_stock~validateproductid.

    METHODS validatewarehouseid FOR VALIDATE ON SAVE
      keys FOR zr_spac107_stock~validatewarehouseid.
    METHODS stockamount FOR VALIDATE ON SAVE
      keys FOR zr_spac107_stock~stockamount.

ENDCLASS.

CLASS lhc_ZR_SPAC107_STOCK IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateProductID.
  ENDMETHOD.

  METHOD validateWarehouseID.

  ENDMETHOD.

  METHOD stockAmount.
  ENDMETHOD.

ENDCLASS.

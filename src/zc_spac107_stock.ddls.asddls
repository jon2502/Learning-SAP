@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_SPAC107_STOCK 
    provider contract transactional_query as projection on ZR_SPAC107_STOCK
    association[1..1] to zspac107_product as _Product on $projection.ProductId = _Product.product_id
    association[1..1] to zspac107_loc as _Warehouse on $projection.WarehouseId = _Warehouse.warehouse_id
{
        @UI.facet: [
        {
          purpose: #STANDARD,
          type: #IDENTIFICATION_REFERENCE,
          label: 'Stock management',
          position: 10
        }
      ]



    @UI.lineItem: [{ position: 10 }]
    @UI.identification: [{ position: 10 }]
    @EndUserText.label: 'WarehouseId'
    key WarehouseId,
    @UI.lineItem: [{ position: 20 }]
    @UI.identification: [{ position: 20 }]
    @EndUserText.label: 'ProductId'
    key ProductId,
    @UI.lineItem: [{ position: 30 }]
    @UI.identification: [{ position: 30 }]
    @EndUserText.label: 'Amount'
    Amount,
    Location,
    ProductName,
    _Warehouse,
    _Product,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt
}

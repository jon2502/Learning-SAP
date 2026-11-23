@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'order items projection view for API'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCAPI_SPAC107_ORDER_I as projection on ZR_SPAC107_ORDER_I
{
    key OrderId,
    key ProductId,
    Amount,
    Price,
    ProductName,
    ProductImage,
    _Product,
    _Order
}

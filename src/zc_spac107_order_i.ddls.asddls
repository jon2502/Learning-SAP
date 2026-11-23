@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for order items'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_SPAC107_ORDER_I as projection on ZR_SPAC107_ORDER_I
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

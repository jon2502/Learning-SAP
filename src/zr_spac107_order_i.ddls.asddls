@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'data definition for orders items'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZR_SPAC107_ORDER_I as select from zspac107_order_i
association to parent ZR_SPAC107_ORDER as _Order on $projection.OrderId = _Order.OrderId
association[1..1] to zspac107_product as _Product on $projection.ProductId = _Product.product_id

{
    key order_id as OrderId,
    key product_id as ProductId,
    amount as Amount,
    price as Price,
    _Product.product_name as ProductName,
    _Product.product_image as ProductImage,
    _Product,
    _Order
}

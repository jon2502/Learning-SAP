@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for api'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCAPI_SPAC107_PRODUCT as projection on ZR_SPAC107_PRODUCT
{
    key ProductId,
    ProductName,
    ProductDesctiption,
    Price,
    ProductImage
}

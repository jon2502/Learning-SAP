@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'order projection view for api'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCAPI_SPAC107_ORDER as projection on ZR_SPAC107_ORDER
{
    key OrderId,
    UserId,
    TotalPrice,
    Status,
    StreetAddress,
    PostalCode,
    City,
    Country,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt
}

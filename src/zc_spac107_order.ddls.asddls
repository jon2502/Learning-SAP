@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for orders'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_SPAC107_ORDER as projection on ZR_SPAC107_ORDER
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

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'data definition for orders'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_SPAC107_ORDER as select from zspac107_order
composition [0..*] of ZR_SPAC107_ORDER_I as _OrderItems

{
    key order_id as OrderId,
    _OrderItems,
    user_id as UserId,
    total_price as TotalPrice,
    status as Status,
    street_address as StreetAddress,
    postal_code as PostalCode,
    city as City,
    country as Country,
    @Semantics.user.createdBy: true
    local_created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    local_created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    local_last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt
}

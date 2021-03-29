@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Teams HPGM'

define root view entity ZI_ZZHP_TEAM as select from zzhp_team {
    key id as Id,
    id_uf as IdUf,
    name as Name,
    exposure as Exposure,
    location as Location,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    bonus as Bonus,
    currency_code as CurrencyCode,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true  
    last_changed_at as LastChangedAt
}

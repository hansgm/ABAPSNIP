@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZZHP Team projection view'
define root view entity ZC_ZZHP_TEAM
  as projection on ZI_ZZHP_TEAM as Team
{ 
  key Id,

      @UI: {
          lineItem:       [ { position: 10, importance: #HIGH } ],
          identification: [ { position: 10, label: 'Travel ID [1,...,9]' } ] }
      @Search.defaultSearchElement: true

      IdUf,
      @UI: {
          lineItem:       [ { position: 20, importance: #HIGH } ],
          identification: [ { position: 20, label: 'Travel ID [1,...,9]' } ] }
      @Search.defaultSearchElement: true

      Name,
      Exposure,
      Location,
      Bonus,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt
}
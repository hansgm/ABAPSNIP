@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZZHP Team projection view'
@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity ZC_ZZHP_TEAM
  as projection on ZI_ZZHP_TEAM as Team
{

      @UI.facet: [ { id:              'Travel',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Team',
                     position:        10 } ]

      @UI.hidden: true

  key Id,
      IdUf,
      Name,
      Exposure,
      Location,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Bonus,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Currency', element: 'Currency' } }]
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      _Currency
      
}
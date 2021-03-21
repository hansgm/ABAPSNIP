@EndUserText.label : 'Team'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zzhp_team {
  key client      : abap.clnt not null;
  key id          : sysuuid_x16 not null;
  id_uf           : zzhp_teamiduf;
  name            : zzhp_teamname;
  exposure        : zzhp_teamexposure;
  location        : zzhp_teamlocation;
  bonus           : zzhp_teambonus;
  currency_code   : zzhp_cuky;
  created_by      : syuname;
  created_at      : timestampl;
  last_changed_by : syuname;
  last_changed_at : timestampl;

}
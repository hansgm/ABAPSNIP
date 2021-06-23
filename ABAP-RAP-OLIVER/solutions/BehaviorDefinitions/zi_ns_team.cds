managed; // implementation in class zbp_i_zzhp_team unique;

define behavior for ZI_ZZHP_TEAM alias Team
implementation in class zcl_zzhp_team2 unique
persistent table ZZHP_TEAM
lock master

{
  create;
  update;
  delete;
  field ( numbering : managed, readonly ) Id;

  validation validateTeam on save { field IdUf; }
  action action_lupa;

  mapping for ZZHP_TEAM
  {
    Id = id;
    IdUf = id_uf;
    Name = name;
    Exposure = exposure;
    Location = location;
    Bonus = bonus;
    CurrencyCode = currency_code;
    CreatedBy = created_by ;
    CreatedAt = created_at;
    LastChangedBy = last_changed_by;
    LastChangedAt = last_changed_at;
  }
}

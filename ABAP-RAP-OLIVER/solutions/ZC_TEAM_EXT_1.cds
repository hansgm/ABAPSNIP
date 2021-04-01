@Metadata.layer: #CUSTOMER
annotate view ZC_ZZHP_TEAM
    with 
{
      @UI: {
          lineItem:       [ { position: 10, importance: #HIGH } ],
          identification: [ { position: 10, label: 'Travel ID [1,...,9]' } ] }
      @Search.defaultSearchElement: true

      IdUf;
      @UI: {
          lineItem:       [ { position: 20, importance: #HIGH } ],
          identification: [ { position: 20, label: 'Travel ID [1,...,9]' } ] }
      @Search.defaultSearchElement: true

      Name;
    
}
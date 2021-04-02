@Metadata.layer: #CUSTOMER
annotate view ZC_ZZHP_TEAM
    with 
{
      @UI: {
          lineItem:       [ { position: 10 } ],
          identification: [ { position: 10 } ],
          selectionField: [ { position: 10 } ] 
          }
      @Search.defaultSearchElement: true

      IdUf;
      @UI: {
          lineItem:       [ { position: 20 } ],
          identification: [ { position: 20 } ],
          selectionField: [ { position: 20 } ]  
          }
      @Search.defaultSearchElement: true

      Name;
      
      @UI: {
          lineItem:       [ { position: 30 } ],
          identification: [ { position: 30 } ],
          selectionField: [ { position: 30 } ]  
          }
      @Search.defaultSearchElement: true      
      Exposure;
      @UI: {
          lineItem:       [ { position: 40 } ],
          identification: [ { position: 40 } ],
          selectionField: [ { position: 40 } ]  
          }
      @Search.defaultSearchElement: true      
      Location;
      @UI: {
          lineItem:       [ { position: 50 } ],
          identification: [ { position: 50 } ],
          selectionField: [ { position: 50 } ]  
          }
      @Search.defaultSearchElement: true      
      Bonus;
      @UI: {
          lineItem:       [ { position: 60 } ],
          identification: [ { position: 60 } ],
          selectionField: [ { position: 60 } ]  
          }
      @Search.defaultSearchElement: true      
      CurrencyCode;      
    
}
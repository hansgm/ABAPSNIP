Extremely simple example how to use the BOBF framework from ABAP using /bobf/if_tra_service_manager and /bobf/if_tra_transaction_mgr.
The ABAP program names explain the comsumer functions (read, update, doAction)

Two level CDS based business object 
- Project
  - Project Roles (1..N)

Example explained functinally. There are Projects, and project may have zero to n roles (e.g. projectlead, developers, analists and so on)

The assumed database tables are:
- zdb_project
- zdb_role 

Business object generated from CDS view (ZZHP_PROJECT and ZZHP_ROLE)

Most important annotations in the CDS

  Project: 
    @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]
    } 
    _Roles 

  Role: 
    @ObjectModel.association: {
          type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]
    }
    _projectRoot 

Specific issue:
- Uses SAP numberranges instead of guids for both levels   

Please mind a very good blog on this subject on SDN: 
- https://blogs.sap.com/2019/01/09/abap-programming-model-for-sap-fiori-draft-based-for-non-guid-keys-much-more../
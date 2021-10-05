@EndUserText.label: 'Test BO projectRole'
@AbapCatalog.sqlViewName: 'ZZHPROLE'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel:{
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
    writeActivePersistence: 'zdb_role',
    semanticKey:['projectid', 'id']
}

define view ZZHP_ROLE
  as select from zdb_role as role
  association [1..1] to ZZHP_PROJECT as _projectRoot   on _projectRoot.id = $projection.projectId
{
    key id as id,
    projectid as projectId,

    @ObjectModel.readOnly: true
    crea_date_time as crea_date_time, 
    @ObjectModel.readOnly: true
    crea_uname as crea_uname, 
    @ObjectModel.readOnly: true
    lchg_date_time as lchg_date_time, 
    @ObjectModel.readOnly: true
    lchg_uname as lchg_uname, 
    
    assignee as assignee,
    assigneetype as assigneeType,
    role as role,
    is_derived as is_derived,

    @ObjectModel.association: {
          type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]
    }
    _projectRoot
}
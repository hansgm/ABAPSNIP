@AbapCatalog.sqlViewName: 'ZZHPPROJECT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'OpenPAM Project Implementation'

@ObjectModel.semanticKey: 'id'

@ObjectModel.modelCategory: #BUSINESS_OBJECT 
@ObjectModel.compositionRoot: true  
@ObjectModel.transactionalProcessingEnabled: true  
@ObjectModel.writeActivePersistence: 'zdb_project'

@ObjectModel.createEnabled: true
@ObjectModel.deleteEnabled: false 
@ObjectModel.updateEnabled: true



define view ZZHP_PROJECT as select from zdb_project
  association [0..*] to ZZHP_ROLE as _Roles on zpam_project.id = _Roles.projectId
{
    key id as id,

    @ObjectModel.readOnly: true
    crea_date_time as crea_date_time, 
    @ObjectModel.readOnly: true
    crea_uname as crea_uname, 
    @ObjectModel.readOnly: true
    lchg_date_time as lchg_date_time, 
    @ObjectModel.readOnly: true
    lchg_uname as lchg_uname, 

    @ObjectModel.mandatory: true
    externalid as externalid, 
    @ObjectModel.mandatory: true
    sourceid as sourceid, 
    @ObjectModel.mandatory: true
    status as status, 
    description as description, 
    ts_workcompleted as ts_workcompleted,
    ts_plannedstart as ts_plannedstart, 
    ts_plannedend as ts_plannedend,
        
    @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]
    } 
    _Roles        
 }

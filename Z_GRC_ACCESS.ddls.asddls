@AbapCatalog.sqlViewName: 'Z_GRC_ACCESS1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType: #CONSUMPTION
define view Z_GRC_ACCESS
  with parameters
    p_name : bname
  as select from    usr02
    left outer join trdir on trdir.unam = usr02.bname
  association [1..*] to ust04     as _usrass  on _usrass.bname = usr02.bname
  association [1..*] to agr_users as _usrrole on _usrrole.uname = usr02.bname
  association [1..*] to agr_1251  as _roles   on _roles.agr_name = _usrrole.agr_name
{
  usr02.bname,
  usr02.erdat,
  _usrrole.agr_name,
  _usrrole.uname,
  _usrrole.from_dat,
  _usrrole.to_dat,
  _usrrole.exclude,
  _usrrole.change_dat,
  _usrrole.change_tim,
  _usrrole.change_tst,
  _usrrole.org_flag,
  _usrrole.col_flag,
  _usrass.profile,
  usr02.trdat,
  usr02.bcode,
  usr02.gltgv,
  usr02.gltgb,
  usr02.ustyp,
  usr02.class,
  usr02.locnt,
  usr02.uflag,
  usr02.accnt,
  usr02.aname,
  usr02.ltime,
  usr02.ocod1,
  usr02.bcda1,
  usr02.codv1,
  usr02.ocod2,
  usr02.bcda2,
  usr02.codv2,
  usr02.ocod3,
  usr02.bcda3,
  usr02.codv3,
  usr02.ocod4,
  usr02.bcda4,
  usr02.codv4,
  usr02.ocod5,
  usr02.bcda5,
  usr02.codv5,
  usr02.versn,
  usr02.codvn,
  usr02.tzone,
  usr02.zbvmaster,
  usr02.passcode,
  usr02.pwdchgdate,
  usr02.pwdstate,
  usr02.reserved,
  usr02.pwdhistory,
  usr02.pwdlgndate,
  usr02.pwdsetdate,
  usr02.pwdinitial,
  usr02.pwdlockdate,
  usr02.pwdsaltedhash,
  usr02.security_policy,
  trdir.name,
  trdir.sqlx,
  trdir.edtx,
  trdir.varcl,
  trdir.dbapl,
  trdir.dbna,
  trdir.clas,
  trdir.type,
  trdir.occurs,
  trdir.subc,
  trdir.appl,
  trdir.secu,
  trdir.cnam,
  trdir.cdat,
  trdir.unam,
  trdir.udat,
  trdir.vern,
  trdir.levl,
  trdir.rstat,
  trdir.rmand,
  trdir.rload,
  trdir.fixpt,
  trdir.sset,
  trdir.sdate,
  trdir.stime,
  trdir.idate,
  trdir.itime,
  trdir.ldbname,
  trdir.uccheck,
  case
  when _usrass.profile = 'SAP_ALL' then 'SUPER'
  when _usrass.profile = 'SAP_NEW' then 'SUPER'
  else 'NORMAL'
  end as type_user,
  _usrass,
  _usrrole,
  _roles
}
where
  usr02.bname = $parameters.p_name

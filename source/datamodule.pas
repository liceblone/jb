unit datamodule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, ImgList, dbgrids, ComCtrls, DbCtrls,StdCtrls,  Variants, Menus,
  FhlKnl, Sockets, ActiveX, Registry, ActnList,StrUtils, ComObj,    DateUtils,  UnitPublicFunction,
  ExtDlgs,UnitSetBarCodeQty, UnitBarCodeList;

type  TFormType =  (ModelFrmBill,ModelFrmTreeEditor,ModelFrmTreeGrid,
ModelFrmAnalyser,ModelFrmTabEditor,ModelFrmTreeMgr,ModelTabGrid,ModelEditor,
ModelLookup,ModelFrmYdWareProp  ,ModelPickDict ,ModelBilOpnDlgDict,
ModelTreeMgrDict ,ModelMore2MoreDict   ,modelFrmPickMulPage

);//模板类型
//ModelFrmYdWareProp 异地库参




{ if fbilldict.pickid='' then exit;
  if fPickFrm=nil then
  begin
    Screen.Cursor:=crSqlwait;
    try
      fPickFrm:=TPickFrm.Create(Application);
      fPickFrm.InitFrm(fbilldict.pickid,dbGrid1,mtDataSet1);
    finally
      Screen.Cursor:=crDefault;
    end;
  end;
  fPickFrm.Show;}

type
  TFhlUser = class(TObject)
   // procedure SetDataSet(ADataSet:TDataSet;ADataSetId:ShortString;AParams:Variant;AIsOpen:Boolean=True);
    procedure SetDataSet(ADataSet:TDataSet;ADataSetId:ShortString;AParams:Variant;AIsOpen:Boolean=True);overload;

    function  SetDbGrid(ADbGridId:String;ADbGrid:TDbGrid ;BDifReadOnlyClr :boolean=false):String; overload;
    function  SetDbGrid(ADbGridId:String;ADbGrid:TDbGrid;EditBtnClick:Taction):String;overload;

    procedure SetDbGridAndDataSet(ADbGrid:TDbGrid;ADbGridId:String;AParams:Variant;AIsOpen:Boolean=True;BDifReadOnlyClr :boolean=false); overload;
    procedure SetDbGridAndDataSet(ADbGrid: TDbGrid; ADbGridId: String;  AParams: Variant; AIsOpen: Boolean; EditBtnClick: Taction);overload;

    function  ShowFinderFrm(fAdoDataSet:TAdoDataSet;Var fFinderFrm:TForm;fFinderId:String):wideString;
    function  ShowdsFinderFrm(Var fdsFinderFrm:TForm;fdsFinderId:String):Variant;

    procedure ShowPickWindow(formID:string='' );    //2006-7-4
    function  ShowBillFrm(fFrmId:String;fCode:String=''):Tform;
    function  ShowBillFrmEX(fFrmId:String;fCode:String=''):Tform;
    procedure ShowWrtransformBillFrm(fFrmId:String;fCode:String='');
    procedure ShowBillWhOut (fFrmId: String;fCode:String='');
    procedure ShowInvoiceFrm(fFrmId:String;fCode:String='');

    procedure ShowBillOpenDlgFrm(AFrmId:string);
    procedure ShowTreeEditorFrm(fFrmId:String);
    Function  ShowModelTreeEditorFrm(fFrmId:String;AParams:variant;Model:boolean):Tform;

    procedure ShowTreeGridFrm(fFrmId:String);
    function ShowModalTreeGridFrm(fFrmId: String; AParams: variant;
      Modal: boolean):Tform;
    procedure ShowTreeMgrFrm(fFrmId:String);
    procedure ShowTabGridFrm(AFrmId:String;AOpenParams:Variant;AFree:Boolean=True);
    procedure ShowAnalyserFrm(AFrmId:String;AmtParams:Variant;FormStyle:TFormStyle=fsMDIForm);
    procedure ShowAnalyserExFrm(AFrmId:String;AmtParams:Variant;pFormStyle:TFormStyle=fsMDIForm);

    procedure ShowMainMenuFrm(FromId:string ;OpenParam:string ='');
    procedure ShowProgress(AProgress, AMaxProgress: Integer);
    procedure ShowWarePropFrm(fWareId:String;fWareSource:TDataSource);
    procedure ShowYdWarePropFrm(ADgId,AModelNo:String);
    procedure ShowClientPropFrm;
    procedure ShowMore2MoreFrm(fFrmId:String;fParams:Variant);
    function  ShowTabEditorFrm(fFrmId:String;fOpenParams:Variant;fDataSet:TDataSet=nil;fIsAppend:Boolean=False;fCursor:TCursor=crHourGlass;IsFree:Boolean=True;Aaction:Boolean=True;ConfirmButton:boolean=true;NeedChkBox:boolean=true):Integer;
    function  ShowEditorFrm(fFrmId:String;fOpenParams:Variant;fDataSet:TDataSet=nil;owner:Twincontrol=nil):TForm;
    procedure ShowCRMFrm(FromId : string; OpenParam: string='');
    procedure CheckRight(RightId:String;MyFrm:TForm=nil);
    procedure CheckToolButtonRight(ActID: String; ButtonName: string);
    function  CheckRight2(RightId:String;MyFrm:TForm=nil):boolean;
    function  GetReportGUID( f_firmCode:string ): string;

    function  GetSysParamVal(AParamName:String):Variant;
    function  GetSysParamsVal(AParamsName:Variant):Variant;
    procedure AssignDefault(fDataSet:TDataSet;UseEdit:boolean=true);
    procedure Logout(Note:String='');
    procedure DoExecProc(AUsrDataSet:TDataSet;Aparams:Variant;AProcId:String='');
    procedure MergeGridUserMenuAndSysCongfigMenu(UserPopMenu,  SysConfigMenu: tpopupMenu; GridUserMenuIDs: integer; UserMenuAction: TactionList);
    procedure ChangeUserDataBase(UserDbName: string);

    function GetTableName(datasetID: string): string;
    function AddDataSet(Name,TAbleName,CommandText:string; NeedAppend:boolean=false;NeedDefault:boolean=false): string;
    function AddGrid(name,datasetID:string): string;
    function AddTreeGrid(name, GridID,EditorID,Actions: string;TreeID:integer):string;
    function AddSubInterFace(name, SubInterFaceID,ModelTypeID,TreeGridID,EditorID:string): string;


  end;


type
  TdmFrm = class(TDataModule)
    ADOConnection1: TADOConnection;
    ImageList1: TImageList;
    FreeStoredProc1: TADOStoredProc;
    OpenDialog1: TOpenDialog;
    DbGridPopupMenu1: TPopupMenu;
    dgPupSort: TMenuItem;
    N7: TMenuItem;
    dgPupRefresh: TMenuItem;
    dgPupDfWidth: TMenuItem;
    dgPupDfVis: TMenuItem;
    dgPupDfIdx: TMenuItem;
    N4: TMenuItem;
    dgPupProp: TMenuItem;
    dgPupVis: TMenuItem;
    N9: TMenuItem;
    dgPupPrtSet: TMenuItem;
    dgPupPreview: TMenuItem;
    dbCtrlActionList1: TActionList;
    DbGridEditBtnClickAction1: TAction;
    LookupFrmShowAction1: TAction;
    DateFrmShowAction1: TAction;
    TreeDlgFrmShowAction1: TAction;
    MessageShowAction1: TAction;
    FreeQuery1: TADOQuery;
    MemoFrmShowAction1: TAction;
    BoxPopupMenu1: TPopupMenu;
    N1: TMenuItem;
    FilteredPickerAction1: TAction;
    PickFrmShowAction1: TAction;
    DataSetActionList1: TActionList;
    RequireCheckAction1: TAction;
    AssignDefaultAction1: TAction;
    TestAction1: TAction;
    BeforeDeleteAction1: TAction;
    BeforePostAction1: TAction;
    AfterPostAction1: TAction;
    FreeDataSet1: TADODataSet;
    SlInvCalcAction1: TAction;
    fnRecCalcAction1: TAction;
    fncaOpenAction1: TAction;
    AOLastAction1: TAction;
    slInvGetFundAction1: TAction;
    AfterOpenAction1: TAction;
    N2: TMenuItem;
    TabEditorShowAction1: TAction;
    PhArvCalcAction1: TAction;
    TabGridShowAction1: TAction;
    ADOConnection2: TADOConnection;
    SaveDialog1: TSaveDialog;
    actlst_maintain: TActionList;
    act_DisplayFrmCreateComponent: TAction;
    actUpdatePic: TAction;
    actLoadPic: TAction;
    dlgOpenPic1: TOpenPictureDialog;
    conSys: TADOConnection;
    qryFree_Sys: TADOQuery;
    actInvoiceCalc: TAction;
    actCheckRang: TAction;
    actCalc: TAction;
    actCaCul: TAction;
    NSelectFields: TMenuItem;
    ActGetMaxBoxId: TAction;
    ActGetMaxCode: TAction;
    ActAddDataSet: TAction;
    ActTreeGrid: TAction;
    TreeIDT507: TAction;
    ActTreeIDs: TAction;
    ActCRMTreeIDSGrid: TAction;
    ActEditorT616: TAction;
    ActCRMSubInterFace: TAction;
    ActGridID: TAction;
    ActTreeGridOpenParams: TAction;
    ActEditorOpenParams: TAction;
    ActT202: TAction;
    ActBoxs: TAction;
    GridCols: TAction;
    ActTabEdit: TAction;
    ActT102: TAction;
    ActMoreToMoreT619: TAction;
    ActFieldOFSysTable: TAction;
    ActFieldLKP: TAction;
    actGetFrmGridID: TAction;
    actGetSubSysGridColID: TAction;
    actListFrmActs: TAction;
    actListFrmModel: TAction;
    ActImages: TAction;
    ActUpdateBool: TAction;
    ActGetBoxCrmTreeIDs: TAction;
    ActGetMaxSubinterfaceID: TAction;
    LstModelActtions: TAction;
    ActGridUserMenuID: TAction;
    ActLstDataActions: TAction;
    ActGridFontColor: TAction;
    actCheckReference: TAction;
    ActGatheringData: TAction;
    ActPingYin: TAction;
    ActChkDuplicateClient: TAction;
    ActSelGatheringDate: TAction;
    ActGetAccountNamePay: TAction;
    ActGetAccountNameGather: TAction;
    ActInvoiceRefs: TAction;
    ActT401: TAction;
    ActFormalInvoiceCalc: TAction;
    ActListCrmLinkMan: TAction;
    ActIsSameWare: TAction;
    UserDbCtrlActLst: TActionList;
    Action2: TAction;
    uLookupFrmShowAction1: TAction;
    uTreeDlgFrmShowAction1: TAction;
    uDateFrmShowAction1: TAction;
    uDbGridEditBtnClickAction1: TAction;
    uactCheckRang: TAction;
    uactCaCul: TAction;
    uActGetPingYin: TAction;
    actUloadpic: TAction;
    ActT407: TAction;
    AcT525Buttons: TAction;
    ActImportT627: TAction;
    ActBarCodeQty: TAction;
    ActBarCodeList: TAction;
    ActGetPingYin: TAction;
    ActBeforPost: TAction;
    ActGetResistence: TAction;
    ActSetQtyitems: TAction;
    MPopupGridCoLRPT: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    //--------------dataset-----------------------
    function  ConnectServer(ConnStr:wideString):Boolean;
    procedure GetQuery1(fSql:wideString;fReturn:Boolean=True;Editing:boolean=false);
    procedure GetDataSet1(fSql:wideString);

    function  ExecStoredProc(AProcName:String;AParams:Variant;ShowAbortStr:boolean=false):Boolean;
    function  GetMyId(fTblId:String):String;
    function  GetMyIdWithOutTran(fTblid:String):String;    
    //--------------[Db]Ctrl Actions--------------
    procedure qDoLkpBoxCloseUp(Sender:TObject);
    procedure LookupFrmShowAction1Execute(Sender: TObject);
    procedure DateFrmShowAction1Execute(Sender: TObject);
    procedure MessageShowAction1Execute(Sender: TObject);
    procedure TreeDlgFrmShowAction1Execute(Sender: TObject);

    //--------------DbGrid PorpupMenu-------------
    procedure dgPupDfWidthClick(Sender: TObject);
    procedure dgPupDfVisClick(Sender: TObject);
    procedure dgPupDfIdxClick(Sender: TObject);
    procedure dgPupPropClick(Sender: TObject);
    procedure dgPupVisClick(Sender: TObject);
    procedure dgPupPrtSetClick(Sender: TObject);
    procedure dgPupPreviewClick(Sender: TObject);
    procedure dgPupSortClick(Sender: TObject);
    procedure dgPupRefreshClick(Sender: TObject);
    procedure DbGridEditBtnClickAction1Execute(Sender: TObject);
    procedure MemoFrmShowAction1Execute(Sender: TObject);
    procedure FilteredPickerAction1Execute(Sender: TObject);
    procedure PickFrmShowAction1Execute(Sender: TObject);
    procedure RequireCheckAction1Execute(Sender: TObject);
    procedure AssignDefaultAction1Execute(Sender: TObject);
    procedure BeforeDeleteAction1Execute(Sender: TObject);
    procedure BeforePostAction1Execute(Sender: TObject);
    procedure AfterPostAction1Execute(Sender: TObject);
    procedure SlInvCalcAction1Execute(Sender: TObject);
    procedure fnRecCalcAction1Execute(Sender: TObject);
    procedure fncaOpenAction1Execute(Sender: TObject);
    procedure AOLastAction1Execute(Sender: TObject);
    procedure slInvGetFundAction1Execute(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure TabEditorShowAction1Execute(Sender: TObject);
    procedure TabGridShowAction1Execute(Sender: TObject);
    procedure PhArvCalcAction1Execute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure  GetQry_Sys(ASql:wideString;AReturn:Boolean=True);

    procedure ConfigMenu;
    procedure actUpdatePicExecute(Sender: TObject);
    procedure actLoadPicExecute(Sender: TObject);
    procedure actInvoiceCalcExecute12(Sender: TObject);
    procedure actCheckRangExecute(Sender: TObject);
    procedure actCalcExecute(Sender: TObject);
    procedure actCaCulExecute(Sender: TObject);
    procedure NSelectFieldsClick(Sender: TObject);
    procedure updatebool(sender:tobject);
    procedure ActGetMaxBoxIdExecute(Sender: TObject);
    procedure ActAddDataSetExecute(Sender: TObject);
    procedure ActTreeGridExecute(Sender: TObject);

    procedure ConfigGrid(sender:Tobject);
    procedure ConfigGridRpt(sender:Tobject);
    procedure ConfigDatasetID(sender:Tobject);
    procedure ConfigBeforePost(sender:Tobject);
    procedure ConfigBeforeDelete(sender:Tobject);
    procedure ConfigAfterPost(sender:Tobject);
    procedure LstDataProcs(sender:Tobject);
    procedure ConfigFldGridLkp(sender:Tobject);
    procedure ConfigFldTreeDlgLkp(sender:Tobject);

    procedure ConfigCtrl(sender:Tobject);
    procedure ConfigLabel(sender:Tobject);
    procedure ConfigGetMaxBoxid(sender:Tobject);
    procedure TreeIDT507Execute(Sender: TObject);
    procedure ActTreeIDsExecute(Sender: TObject);
    procedure ActCRMTreeIDSGridExecute(Sender: TObject);
    procedure ActEditorT616Execute(Sender: TObject);
    procedure ActCRMSubInterFaceExecute(Sender: TObject);
    procedure ActGridIDExecute(Sender: TObject);
    procedure ActEditorOpenParamsExecute(Sender: TObject);
    procedure ActT202Execute(Sender: TObject);
    procedure ActBoxsExecute(Sender: TObject);
    procedure GridColsExecute(Sender: TObject);
    procedure ActTabEditExecute(Sender: TObject);
    procedure ActT102Execute(Sender: TObject);
    procedure ActMoreToMoreT619Execute(Sender: TObject);
    procedure ActFieldOFSysTableExecute(Sender: TObject);
    procedure ActFieldLKPExecute(Sender: TObject);
    procedure actGetFrmGridIDExecute(Sender: TObject);
    procedure actListFrmActsExecute(Sender: TObject);
    procedure actListFrmModelExecute(Sender: TObject);
    procedure ActImagesExecute(Sender: TObject);
    procedure ActUpdateBoolExecute(Sender: TObject);
    procedure ActGetBoxCrmTreeIDsExecute(Sender: TObject);
    procedure ActGetMaxSubinterfaceIDExecute(Sender: TObject);
    procedure LstModelActtionsExecute(Sender: TObject);
    procedure ActGridUserMenuIDExecute(Sender: TObject);
    procedure ActLstDataActionsExecute(Sender: TObject);
    procedure ActGridFontColorExecute(Sender: TObject);

    Procedure PushGlobelContext(var PSysDb,PUserDB:string);
    Procedure PopGlobelContext(var PSysDb,PUserDB:string);
    procedure actCheckReferenceExecute(Sender: TObject);
    procedure ActGatheringDataExecute(Sender: TObject);
    function GetGatheringDate(pday: integer;PaySpan:integer;SourceDay:Tdatetime): Tdatetime;
    procedure ActPingYinExecute(Sender: TObject);
    procedure ActChkDuplicateClientExecute(Sender: TObject);
    procedure ActSelGatheringDateExecute(Sender: TObject);
    procedure ActGetAccountNamePayExecute(Sender: TObject);
    procedure ActGetAccountNameGatherExecute(Sender: TObject);
    procedure ActInvoiceRefsExecute(Sender: TObject);
    procedure ActT401Execute(Sender: TObject);
    procedure ActFormalInvoiceCalcExecute(Sender: TObject);
    procedure ActListCrmLinkManExecute(Sender: TObject);
    procedure ActTreeGridOpenParamsExecute(Sender: TObject);
    procedure ActIsSameWareExecute(Sender: TObject);
    Function  GetOldDbName(CurrentDbName:string):string;
    procedure MExportToExcelClick(Sender: TObject);
    procedure ActT407Execute(Sender: TObject);
    procedure AcT525ButtonsExecute(Sender: TObject);
    procedure ActImportT627Execute(Sender: TObject);
    procedure ActBarCodeQtyExecute(Sender: TObject);
    procedure ActBarCodeListExecute(Sender: TObject);
    procedure uLookupFrmShowAction1Execute(Sender: TObject);
    procedure uTreeDlgFrmShowAction1Execute(Sender: TObject);
    procedure uDateFrmShowAction1Execute(Sender: TObject);
    procedure uDbGridEditBtnClickAction1Execute(Sender: TObject);
    procedure ActGetPingYinExecute(Sender: TObject);
    procedure ActBeforPostExecute(Sender: TObject);
    procedure ActGetResistenceExecute(Sender: TObject);
    procedure DbGridPopupMenu1Popup(Sender: TObject);
    procedure ClearFilter(sender :Tobject);
    procedure SetFQtyItems(dataset:TDataSet ; SetQty:Boolean);
    procedure ActSetQtyitemsExecute(Sender: TObject);
  private

  public
      FMenuRitDict:TMenuRightDict;
  end;

resourceString

  fsDeleteObj = #13#10+'确定要删除"%s"吗?';
  fsDbDelete = #13#10+'确定要删除该记录吗?';
  fsDbChanged = #13#10+'部份数据可能已经被更改,是否需要保存?  ';
  fsDbCancel = #13#10+'确定要放弃所做的修改吗?      ';

const 
       cftString = 0;
       cftDate = 1;
       cftDateTime = 2;
       cftBoolean = 3;
       cftFloat = 4;
       cftCurrency = 5;
       cftMemo = 6;
       cftBlob = 7;
       cftBytes = 8;
       cftAutoInc = 9;
       cftInteger = 10;

       cDsId01 = '538';
       cDsId02 = '539';
       cDsId03 = '492';
       cDsId04 = '463';

       cDgId01 = '355';
       cDgId02 = '352';
       cDgId03 = '421';

       PZero=0.000000001;      //浮点零

var
  sOpenParamsVar:Variant;
  sDefaultVals:wideString;
  dmFrm: TdmFrm;
  FhlKnl1: TFhlKnl;
  LoginInfo:TLoginInfo;        //全局登录信息
  FhlUser:TFhlUser;

implementation
uses sort,Lookup,finder,dsFinder,TabGrid,repgrid,colshower,colProp,repset,TreeDlg,WareProp,ClientProp,
  pick,More2More,YdWareProp,TabEditor,Editor,bill,TreeEditor,TreeGrid,TreeMgr,Analyser,Desktop,  UnitFrmAnalyserEx ,
  UUpdateImage,UnitMainMenu,UnitActionsGrid,UnitCrmMain,UnitFrmSelDate,UnitWrTransformBill,UnitBillWhOut,UExportToExcel ,
  UnitBillEx;

{$R *.DFM}
procedure TdmFrm.GetQuery1(fSql:wideString;fReturn:Boolean=True;Editing:boolean=false);
begin
 with FreeQuery1 do begin
      Close;
      if Editing then
         FreeQuery1.LockType :=ltOptimistic;
      Sql.Clear;
      Sql.Append(fSql);
      if fReturn then
         Open
      else
         ExecSql;
 end;
end;

procedure TdmFrm.GetDataSet1(fSql:wideString);
begin
  self.FreeDataSet1.Close;
  self.FreeDataSet1.CommandText := fsql;
  self.FreeDataSet1.Open;

end;

function TdmFrm.ExecStoredProc(AProcName:String;AParams:Variant;ShowAbortStr:boolean):Boolean;
begin
  Result:=AProcName='';
  if Result then exit;
  with FreeStoredProc1 do
  begin
    Close;
    ProcedureName:=AProcName;
    FhlKnl1.Ds_SetParams(FreeStoredProc1,AParams);
    ExecProc;

    if FreeStoredProc1.Parameters.Count >0   then
    begin
      Result:=Parameters.Items[0].Value  ;
      if ShowAbortStr and ( not Result ) then
        if FreeStoredProc1.Parameters.Items[1].Value <>null and ( dmFrm.FreeStoredProc1.Parameters.Items[1].Direction  =pdOutput )then
           MessageDlg(#13#10+FreeStoredProc1.Parameters.Items[1].Value  ,mtError,[mbOk],0);
    end
    else
    Result:=true;
  end;
end;

function  TdmFrm.ConnectServer(ConnStr:wideString):Boolean;
begin
//initialization
//  CoInitialize(nil);
   Result:=False;

   if not  logininfo.IsLocalServer  then
   FhlKnl1.Kl_SetReg4Mssql(ConnStr);

         
   if FhlKnl1.Kl_Connect(ConnStr) then
     with ADOConnection1 do
     begin
       //   ADOConnection1.  125.120.75.104
       DefaultDatabase :='';
       Connected:=False;
       ConnectionString:=ConnStr;

       try
         Connected:=true;
         Result:=Connected;

       except
       begin
         Result:=False;
       end;
       end;
     end;
//   else
//   showmessage(connstr);  
//finalization
//  CoUnInitialize;
end;


function TdmFrm.GetMyIdWithOutTran(fTblid:String):String;
begin
  Result:='';
//  FreeQuery1.Connection.BeginTrans;
  try
   GetQuery1('select pre+replace(space(xlen-len(pos)),'' '',0)+cast(pos as varchar) from sys_id where tblid='+ftblid);
   Result:=FreeQuery1.Fields[0].asString;
   GetQuery1('update sys_id set pos=pos+1 where tblid='+ftblid,False);
//   FreeQuery1.Connection.CommitTrans;
  except
//   FreeQuery1.Connection.RollbackTrans;
  end;
end;

function TdmFrm.GetMyId(fTblid:String):String;
begin
  Result:='';
  FreeQuery1.Connection.BeginTrans;
  try
   GetQuery1('select pre+replace(space(xlen-len(pos)),'' '',0)+cast(pos as varchar) from sys_id where tblid='+ftblid);
   Result:=FreeQuery1.Fields[0].asString;
   GetQuery1('update sys_id set pos=pos+1 where tblid='+ftblid,False);
   FreeQuery1.Connection.CommitTrans;
  except
   FreeQuery1.Connection.RollbackTrans;
  end;
end;

function  TFhlUser.ShowdsFinderFrm(Var fdsFinderFrm:TForm;fdsFinderId:String):Variant;
begin
  Result:=Null;
  if fdsFinderFrm=nil then
  begin
    fdsFinderFrm:=TdsFinderFrm.Create(Application);
    TdsFinderFrm(fdsFinderFrm).InitFrm(fdsFinderId);
  end;
  if fdsFinderFrm.ShowModal=mrOk then
    Result:=TdsFinderFrm(fdsFinderFrm).GetFindParams;
  {begin
    Result:=TdsFinderFrm(fdsFinderFrm).GetSqlStr;
    if (fAdoDataSet<>nil) and (fAdoDataSet.CommandType=cmdText) then
      with fAdoDataSet do
      begin
        Close;
        CommandText:=Result;
        Open;
      end;
  end;}
end;
                              //mtAdoDataSet1
procedure TFhlUser.SetDataSet(ADataSet:TDataSet;ADataSetId:ShortString;AParams:variant;AIsOpen:Boolean=True);
var
  i,j:integer;
begin
  if (ADataSetId='-1') or (ADataSetId='') then exit;

  FhlKnl1.Ds_SetParams(ADataSet,
    FhlKnl1.Vr_MergeVarArray(
      GetSysParamsVal(
         FhlKnl1.Cf_SetDataSet(ADataSet,ADataSetId,dmFrm.DataSetActionList1)
      ),
      AParams
    )
  );




  for i:=0 to ADataSet.FieldCount-1 do
    if ADataSet.Fields[i].FieldKind=fkLookup then
    begin
         for j:=0 to ADataSet.FieldCount-1 do
          if (( ADataSet.Fields[j].FieldKind=fkLookup) and ( ADataSet.Fields[j].FieldName  <>ADataSet.Fields[i].FieldName  )) then
             if (ADataSet.Fields[j].LookupDataSet.Tag=ADataSet.Fields[i].LookupDataSet.Tag ) then
                if ADataSet.Fields[j].LookupDataSet.Active then
                begin
                   ADataSet.Fields[i].LookupDataSet:=ADataSet.Fields[j].LookupDataSet ;
                   Break;
                end;

       if not ADataSet.Fields[i].LookupDataSet.Active then
       FhlKnl1.Ds_OpenDataSet(ADataSet.Fields[i].LookupDataSet,GetSysParamsVal(FhlKnl1.Cf_SetDataSet(ADataSet.Fields[i].LookupDataSet,intTostr(ADataSet.Fields[i].LookupDataSet.Tag),nil)));
    end;

  if AIsOpen then
  begin
    ADataSet.Open;
    if ADataSet.Filter<>'' then
          ADataSet.Filtered:=True;
  end;


end;

procedure TFhlUser.SetDbGridAndDataSet(ADbGrid: TDbGrid; ADbGridId: String;
  AParams: Variant; AIsOpen: Boolean; EditBtnClick: Taction);
begin
  if (ADbGridId='-1') or (ADbGridId='') then exit;
  SetDataSet(ADbGrid.DataSource.DataSet,SetDbGrid(ADbGridId,ADbGrid,EditBtnClick),AParams,AIsOpen);
end;

procedure TFhlUser.SetDbGridAndDataSet(ADbGrid:TDbGrid;ADbGridId:String;AParams:Variant;AIsOpen:Boolean=True;BDifReadOnlyClr :boolean=false);
begin
  if (ADbGridId='-1') or (ADbGridId='') then exit;
  SetDataSet(ADbGrid.DataSource.DataSet,SetDbGrid(ADbGridId,ADbGrid,BDifReadOnlyClr),AParams,AIsOpen);

end;
function  TFhlUser.SetDbGrid(ADbGridId:String;ADbGrid:TDbGrid;BDifReadOnlyClr :boolean=false):String;
begin
   ADbGrid.OnEditButtonClick:=dmFrm.DbGridEditBtnClickAction1Execute;
   Result:=FhlKnl1.Cf_SetDbGrid(ADbGridId,ADbGrid,BDifReadOnlyClr);
end;
function  TFhlUser.ShowFinderFrm(fAdoDataSet:TAdoDataSet;Var fFinderFrm:TForm;fFinderId:String):wideString;
begin
  result:='-1';
  if fFinderFrm=nil then
  begin
     fFinderFrm:=TFinderFrm.Create(Application);
     TFinderFrm(fFinderFrm).InitFrm(fFinderId);
  end;
  if fFinderFrm.ShowModal=mrOk then
  begin
    Result:=TFinderFrm(fFinderFrm).GetAllSql;
    if fAdoDataSet<>nil then
       with fAdoDataSet do
       begin
         Close;
         CommandText:=Result;
         FhlKnl1.Ds_OpenDataSet(fAdoDataSet,FhlUser.GetSysParamsVal(TFinderFrm(fFinderFrm).SysParams));
       end;
  end;
end;


procedure TdmFrm.qDoLkpBoxCloseUp(Sender:TObject);
begin
  //showmessage('c');
end;

//---------------DbGrid PopupMenu---------------
procedure TdmFrm.dgPupDfWidthClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  FhlKnl1.Dg_SetColWidth(PopDbgrid);
  //FhlKnl1.Dg_SetColWidth(TDbGrid(DbGridPopupMenu1.PopupComponent));
end;

procedure TdmFrm.dgPupDfVisClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
    FhlKnl1.Dg_SetColVisible(PopDbgrid);
//  FhlKnl1.Dg_SetColVisible(TDbGrid(DbGridPopupMenu1.PopupComponent));
end;

procedure TdmFrm.dgPupDfIdxClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  FhlKnl1.Dg_SetColOrder(PopDbgrid);
  //FhlKnl1.Dg_SetColOrder(TDbGrid(DbGridPopupMenu1.PopupComponent));
end;

procedure TdmFrm.dgPupPropClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  FhlKnl1.Dg_ColsProp(PopDbgrid);
//intTostr(TDbGrid(DbGridPopupMenu1.PopupComponent).Tag)
end;


procedure TdmFrm.dgPupVisClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  with TColShowerFrm.Create(Application) do begin
  InitFrm( PopDbgrid)   ;

       ShowModal;
       Free;
  end;
end;


procedure TdmFrm.dgPupPrtSetClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;


  with TRepSetFrm.Create(Application) do
  begin
    AdoDataSet1.Connection:=FhlKnl1.Connection;
    InitFrm(intTostr(PopDbgrid.Tag));
    ShowModal;
    Free;
  end;
end;

procedure TdmFrm.dgPupPreviewClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
VAR TITLE:STRING;
begin
 PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  if not PopDbgrid.DataSource.DataSet.IsEmpty then
  begin
      PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

      IF PopDbgrid.Parent <>NIL  THEN
         IF PopDbgrid.Parent IS tFORM THEN
            TITLE:=(PopDbgrid.Parent AS tFORM).Caption ;

      FhlKnl1.Rp_DbGrid(intTostr(PopDbgrid.Tag),PopDbgrid,TITLE);
  end;

end;

procedure TdmFrm.DgPupSortClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  FhlKnl1.Dg_Sort(PopDbgrid);
end;

procedure TdmFrm.DgPupRefreshClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  with PopDbgrid.DataSource.DataSet do begin
       Close;
       Open;
  end;

end;
//-----------------Interface----------------------


procedure TdmFrm.LookupFrmShowAction1Execute(Sender: TObject);
var fld:TField;
    TmpLookupFrm:TLookupFrm;
begin
  TmpLookupFrm:=nil;
  Screen.Cursor:=crSqlwait;
 try
  if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
  else
     fld:=TDbEdit(Sender).Field;
  if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
  begin
     if (Sender is TFhlDbEdit) then
     TmpLookupFrm:=  ((Sender as TFhlDbEdit).LookupFrm as TLookupFrm) ;

     if TmpLookupFrm=nil then
     begin
       TmpLookupFrm:= TLookupFrm.Create(sender as TComponent)  ;
       TmpLookupFrm.InitFrm(fld);
       if (Sender is TFhlDbEdit) then
          (Sender as TFhlDbEdit).LookupFrm:=TmpLookupFrm;
     end
     else
        TmpLookupFrm.RefreshLookupDataSet  ;
        
     if Sender is tdbedit  then
        TmpLookupFrm.Edit1.Text:=(Sender as tdbedit   ).Text ;
     TmpLookupFrm.ShowModal;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;

 if Sender is Tedit then
 TEdit(Sender).Modified:=False;
end;

procedure TdmFrm.DateFrmShowAction1Execute(Sender: TObject);
var
  fld:TField;
  dt:TDate;
begin
  if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
  else
     fld:=TDbEdit(Sender).Field;
  if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
  begin
    if fld.asString<>'' then
      dt:=fld.asDateTime
    else
      dt:=Now;
    if FhlKnl1.Md_ShowDateFrm(dt)=mrOk then
    begin
      if not (fld.DataSet.State=dsInsert) and Not (fld.DataSet.State=dsEdit) then
         fld.DataSet.Edit;
      if fld.DataType=ftDate then
         fld.asString:=formatdatetime('yyyy"-"mm"-"dd',dt)
      else if fld.DataType=ftDateTime then
         fld.AsString:=formatdatetime('yyyy"-"mm"-"dd',dt)+' '+formatdatetime('hh":"nn":"ss',Now);
    end;
  end;
end;

procedure TdmFrm.MessageShowAction1Execute(Sender: TObject);
begin
  showmessage(':0)');
end;

procedure TdmFrm.TreeDlgFrmShowAction1Execute(Sender: TObject);
 var fld:TField;
begin
 Screen.Cursor:=crSqlwait;
 try
       if Sender is TAction then
          fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
       else
          fld:=TDbEdit(Sender).Field;

       if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
       begin
           with TTreeDlgFrm.Create(Application) do
           begin
             InitFrm(fld);
             ShowModal;
             free;
           end;
       end;
 finally
      Screen.Cursor:=crDefault;
 end;
end;

procedure TFhlUser.ShowYdWarePropFrm(ADgId,AModelNo:String);
begin
  with TYdWarePropFrm.Create(Application) do
  begin
    InitFrm(ADgId,AModelNo);
    ShowModal;
    Free;
  end;
end;

procedure TFhlUser.ShowWarePropFrm(fWareId:String;fWareSource:TDataSource);
begin
  with TWarePropFrm.Create(Application) do
  begin
    InitFrm(fWareId,fWareSource);
    ShowModal;
    Free;
  end;
end;

procedure TFhlUser.ShowClientPropFrm;
begin
  with TClientPropFrm.Create(Application) do
  begin
    //InitFrm(fWareId,fWareSource);
    ShowModal;
    Free;
  end;
end;
procedure TFhlUser.ShowPickWindow(formID:string='' )  ;
var FrmPic:    TPickFrm;
begin
      if formID='' then exit;
    Screen.Cursor:=crSqlwait;
    FrmPic:= TPickFrm.Create(Application) ;

    begin
        try
          FrmPic.formstyle:= fsMDIChild;
          FrmPic.borderIcons:=[biSystemMenu,biMaximize,biminimize];
          FrmPic.borderstyle:=bsSizeable;

          FrmPic.InitFrm(formID,nil,nil,nil,true);
        finally
          Screen.Cursor:=crDefault;
        end;

      FrmPic.Show;
      FrmPic.WindowState := wsMaximized;
   end;
    
end;
procedure TFhlUser.ShowMore2MoreFrm(fFrmId:String;fParams:Variant);
begin
  More2MoreFrm:=TMore2MoreFrm.Create(Application);
  More2MoreFrm.InitFrm(fFrmId,fParams);
  More2MoreFrm.ShowModal;
  More2MoreFrm.Free;
end;

function  TFhlUser.ShowTabEditorFrm(fFrmId:String;fOpenParams:Variant;fDataSet:TDataSet=nil;fIsAppend:Boolean=False;fCursor:TCursor=crHourGlass;IsFree:Boolean=True;Aaction:Boolean=True;ConfirmButton:boolean=true;NeedChkBox:boolean=true):Integer;

begin
  Screen.Cursor:=fCursor;
 try
  TabEditorFrm:=TTabEditorFrm.Create(Application);
  if not ConfirmButton then
     TabEditorFrm.savBtn.Visible :=false;

  //TabEditorFrm:=TTabEditorFrm.Create(nil);
  if Not Aaction then TabEditorFrm.OnClose:=nil;
  TabEditorFrm.InitFrm(fFrmId,fOpenParams,fDataSet,fIsAppend,NeedChkBox);

  if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
  TabEditorFrm.SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
  Result:=TabEditorFrm.ShowModal;
  if IsFree then
     TabEditorFrm.Free;

 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TFhlUser.ShowCRMFrm(FromId, OpenParam: string);
var FrmCrm:TFrmCrm;
begin
   Screen.Cursor:=crAppStart;
 try
  begin
      FrmCrm:=TFrmCrm(  application.FindComponent('FrmCrm'+FromId));
      if FrmCrm=nil then
      begin
          with TFrmCrm.Create(Application) do
          begin
            InitFrm(FromId);
            SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
            Name:='FrmCrm'+FromId;
            Show;
          end;
      end
      else
       ShowWindow(FrmCrm.Handle , SW_RESTORE);
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

function  TFhlUser.ShowEditorFrm(fFrmId:String;fOpenParams:Variant;fDataSet:TDataSet=nil;owner:Twincontrol=nil):TForm;
begin
  Screen.Cursor:=crHourGlass;
  try
    Result:=TEditorFrm.Create(Application);
    TEditorFrm(Result).InitFrm(fFrmId,fOpenParams,fDataSet);
    
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFhlUser.ShowInvoiceFrm(fFrmId:String;fCode:String='');
begin
      Screen.Cursor:=crAppStart;
     try
      if FhlKnl1.Vl_FindChildFrm('BillFrm'+fFrmId)=nil then   // if find then form then show the form
      begin
        with TBillFrm.Create(Application) do
        begin
          formstyle:=fsnormal;
          hide;
          windowState:=wsNormal;
          position:=poMainFormCenter;
          Label2.Visible :=false;
          linkBtn.Visible :=false;
          importBtn.Visible := false;
           NewBtn.Visible :=false;
      
          ScrollBox1.Color :=   clwhite;
          ScrollBox2.Color :=   clwhite;

          InitFrm(fFrmId);
          if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
          SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
          Name:='BillFrm'+fFrmId;
         // NewBtn.Caption  :='调整';
          Showmodal;
          if fCode<>'' then
            OpenBill(fCode);
        end;
      end;
     finally
      Screen.Cursor:=crDefault;
     end;

end;


function TFhlUser.ShowBillFrm(fFrmId:String;fCode:String=''):Tform;
var form:TBillFrm ;
begin
   Screen.Cursor:=crAppStart;
   try
      if FhlKnl1.Vl_FindChildFrm('BillFrm'+fFrmId)=nil then   // if find then form then show the form
      begin
        form:=TBillFrm.Create(Application) ;
        with form  do
        begin
          InitFrm(fFrmId);
          if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
          SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
          Name:='BillFrm'+fFrmId;
          Show;
          if fCode<>'' then
            OpenBill(fCode);
        end;
        result:=form;
      end;
   finally
      Screen.Cursor:=crDefault;
   end;
end;

function TFhlUser.ShowBillFrmEX(fFrmId:String;fCode:String=''):Tform;
var form:TBillFrm ;
begin
   Screen.Cursor:=crAppStart;
   try
      if FhlKnl1.Vl_FindChildFrm('BillFrmEX'+fFrmId)=nil then   // if find then form then show the form
      begin
          with TFrmBillEx.Create(Application) do
          begin
            InitFrm(fFrmId);
            if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
            SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
            Name:='BillFrmEX'+fFrmId;

            Show  ;
         if fCode<>'' then
              OpenBill(fCode);
          end;
      end;
   finally
      Screen.Cursor:=crDefault;
   end;
end;
procedure TFhlUser.ShowWrtransformBillFrm(fFrmId, fCode: String);
begin
  Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('WrTransFormBillFrm'+fFrmId)=nil then   // if find then form then show the form
  begin
    with TWrTransformBillFrm.Create(Application) do
    begin
      InitFrm(fFrmId);
      if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
      SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
      Name:='WrTransFormBillFrm'+fFrmId;
      Show;
      if fCode<>'' then
        OpenBill(fCode);
    end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;
procedure TFhlUser.ShowBillWhOut (fFrmId, fCode: String);
begin
  Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('FrmBillWhOut'+fFrmId)=nil then   // if find then form then show the form
  begin
    with TFrmBillWhOut.Create(Application) do
    begin
      InitFrm(fFrmId);
      if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
      SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
      Name:='FrmBillWhOut'+fFrmId;
      Show;
      if fCode<>'' then
        OpenBill(fCode);
    end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TFhlUser.ShowMainMenuFrm(FromId, OpenParam: string);
var FrmMainMenu:TFrmMainMenu;
begin
   Screen.Cursor:=crAppStart;
 try
//  if FhlKnl1.Vl_FindChildFrm('BillFrm'+fFrmId)=nil then   // if find then form then show the form
  begin

      FrmMainMenu:=TFrmMainMenu(  application.FindComponent('FrmMainMenu'+FromId));

      if FrmMainMenu=nil then
      begin
          with TFrmMainMenu.Create(Application) do
          begin
            InitFrm(FromId,null,nil);
            Name:='FrmMainMenu'+FromId;
            Showmodal;
            FrmMainMenu.free;
          end;
      end
      else
       ShowWindow(FrmMainMenu.Handle , SW_RESTORE);

  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TFhlUser.ShowBillOpenDlgFrm(AFrmId:string);
begin
//
end;

procedure TFhlUser.ShowTreeEditorFrm(fFrmId:String);
begin
  Screen.Cursor:=crAppStart;
  try
    if FhlKnl1.Vl_FindChildFrm('TreeEditor'+fFrmId)=nil then
    begin
      with TTreeEditorFrm.Create(Application) do
      begin
        formstyle:=  fsMDIChild;
        Name:='TreeEditor'+fFrmId;
        InitFrm(fFrmId,null);
        if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then        
        SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);        
        Show;
      end;
    end;
 finally
   Screen.Cursor:=crDefault;
 end;
end;
function TFhlUser.ShowModelTreeEditorFrm(fFrmId: String;
  AParams: variant;Model:boolean): Tform;
begin
  Screen.Cursor:=crAppStart;
  try
    if FhlKnl1.Vl_FindChildFrm('TreeEditor'+fFrmId)=nil then
    begin
      Result:=TTreeEditorFrm.Create(Application);
      with TTreeEditorFrm(Result) do
      begin
        Name:='TreeEditor'+fFrmId;
        InitFrm(fFrmId,AParams,Model);
      end;
    end
    else
    Result:=nil;
 finally
   Screen.Cursor:=crDefault;
 end;

end;

procedure TFhlUser.ShowTreeGridFrm(fFrmId:String);
begin
 Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('TreeGrid'+fFrmId)=nil then
  begin
    with TTreeGridFrm.Create(Application) do
    begin
      Name:='TreeGrid'+fFrmId;
      InitFrm(fFrmId,null);
      if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
      SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);      
      Show;
    end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;
function TFhlUser.ShowModalTreeGridFrm(fFrmId: String; AParams: variant;
  Modal: boolean):Tform;
begin
 Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('TreeGrid'+fFrmId)=nil then
  begin
      Result:=TTreeGridFrm.Create(Application);
      with TTreeGridFrm(Result) do
      begin
          Name:='TreeGrid'+fFrmId;
          InitFrm(fFrmId,AParams,Modal);
          if Modal then
          hide;
      end;
  end
  else
     Result:=nil;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TFhlUser.ShowTreeMgrFrm(fFrmId:String);
begin
  Screen.Cursor:=crAppStart;
 try
  if FhlKnl1.Vl_FindChildFrm('TreeMgr'+fFrmId)=nil then
  begin
    with TTreeMgrFrm.Create(Application) do
    begin
      Name:='TreeMgr'+fFrmId;
      InitFrm(fFrmId);
      Show;
    end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TFhlUser.ShowTabGridFrm(AFrmId:String;AOpenParams:Variant;AFree:Boolean=True);
begin
  Screen.Cursor:=crAppStart;
     try
        TabGridFrm:=TTabGridFrm.Create(application);
        TabGridFrm.InitFrm(AFrmId,AOpenParams);
        TabGridFrm.Hide;
        TabGridFrm.ShowModal;
     finally
        if AFree then FreeAndNil(TabGridFrm);
        Screen.Cursor:=crDefault;
     end;
end;
 {
begin
  with TYdWarePropFrm.Create(Application) do
  begin
    InitFrm(ADgId,AModelNo);
    ShowModal;
    Free;
  end;
end;
}

procedure TFhlUser.ShowAnalyserFrm(AFrmId:String;AmtParams:Variant;FormStyle:TFormStyle=fsMDIForm);
begin
 Screen.Cursor:=crAppStart;
 try
  with TAnalyserFrm.Create(Application) do
  begin
    InitFrm(AFrmId,AmtParams);
    if    desktopfrm.dsMainMenu.FindField('subSysDBName')<>nil then
    SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);
    Show;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure  TFhlUser.ShowProgress(AProgress, AMaxProgress: Integer);
begin
end;

procedure TdmFrm.DbGridEditBtnClickAction1Execute(Sender: TObject);
begin
  with DbCtrlActionList1.Actions[FhlKnl1.Dg_GetDbGrdEdtActnId(TDbGrid(Sender))] do
  begin
      ActionComponent:=TComponent(Sender);
      Execute;
  end;
end;

procedure TdmFrm.MemoFrmShowAction1Execute(Sender: TObject);
begin
  FhlKnl1.Md_ShowMemoFrm((Sender as TDbGrid).SelectedField,(Sender as TDbGrid).DataSource);
end;

procedure TdmFrm.FilteredPickerAction1Execute(Sender: TObject);
begin
  if TEdit(Sender).Modified then
  begin
    TEdit(Sender).Modified:=False;
    dmFrm.LookupFrmShowAction1Execute(Sender);
  end;
end;

procedure TdmFrm.PickFrmShowAction1Execute(Sender: TObject);
begin
    Screen.Cursor:=crSqlwait;
    try
      PickFrm:=TPickFrm.Create(Application); 
      PickFrm.InitFrm('13',nil,nil,TDbEdit(Sender).DataSource.DataSet);
      PickFrm.OpenDataSet(varArrayof([TDbEdit(Sender).Field.DisplayText,LoginInfo.WhId]));
    finally
      Screen.Cursor:=crDefault;
    end;
    PickFrm.ShowModal;
end;

procedure TdmFrm.RequireCheckAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_RequireCheck(TDataSet(Sender));
end;

function  TFhlUser.GetSysParamVal(AParamName:String):Variant; //默认参数
var Pnow , firstDayofMonth:Tdatetime;
var str:string;
begin
         Result:=Null;
         AParamName:=uppercase(AParamName);

         if (AParamName=uppercase('sNow' )) or (Copy(AParamName,1,6)=uppercase('sToday'))
            or ( AParamName = uppercase('sFirstDayofMonth') ) then
         begin
            fhlknl1.Kl_GetQuery2('select getdate() as  Pnow, dbo.Fn_GetFirstDayofMonth(getdate()) as firstDayofMonth');
            Pnow:= fhlknl1.FreeQuery.fields[0].AsDateTime        ;
            firstDayofMonth:= fhlknl1.FreeQuery.fields[1].AsDateTime        ;
         end;

         if AParamName=uppercase('sEmpId') then
            Result:=LoginInfo.EmpId
         else if AParamName=uppercase('sWhId') then
            Result:=LoginInfo.WhId
         else if AParamName=uppercase('sYdId' ) then
            Result:=LoginInfo.YdId
         else if AParamName=uppercase('sTabId' ) then
            Result:=LoginInfo.TabId
         else if AParamName=uppercase('sLoginId' ) then
            Result:=LoginInfo.LoginId
         else if AParamName=uppercase('sNow' ) then
            Result:=Pnow
         else if  AParamName=uppercase('syear') then
            Result:= yearof(today)
        else if  AParamName=uppercase('sGUID') then
            Result:= GetGUID
        else if  Copy(AParamName,1,6)=uppercase('smonth') then
        begin
            str:=inttostr(monthof(today));
            if length(str)=1 then str:='0'+str;
            Result:=str;//monthof(today);
        end
         else if AParamName=uppercase('sToday' ) then
            Result:=formatdatetime('yyyy"-"mm"-"dd',Pnow)
         else if Copy(AParamName,1,6)=uppercase('sToday') then
            Result:=formatdatetime('yyyy"-"mm"-"dd',Pnow+StrToInt(Copy(AParamName,7,length(AParamName))))

         else if AParamName=uppercase('sClientKey' )then
            Result:=FhlKnl1.St_GetPrimaryKey(9999)
         else if AParamName=uppercase('sLocalUserDB') then
            Result:=dmfrm.ADOConnection1.DefaultDatabase

         else if AParamName=uppercase('sLocalOldUserDB') then
         begin
            Result:=dmfrm.GetOldDbName(dmfrm.ADOConnection1.DefaultDatabase );
         end
         else if AParamName=uppercase('sEmpty') then
            Result:=''
         else if AParamName=uppercase('sComputerName') then
            Result:= FhlKnl1.Os_GetComputerName

         else if AParamName=uppercase('sVersion') then
            Result:= JbGetversion
         else if AParamName=uppercase('sFirstDayofMonth') then
            Result:=formatdatetime('yyyy"-"mm"-"dd',firstDayofMonth) 

         else if AParamName<>'' then
            Result:=AParamName;
end;

function  TFhlUser.GetSysParamsVal(AParamsName:Variant):Variant;
  var i:integer;
begin
  Result:=AParamsName;
  if VarIsStr(Result) then
     Result:=FhlKnl1.Vr_CommaStrToVarArray(Result);
  if VarIsArray(Result) then
     for i:=0 to VarArrayHighBound(Result,1) do
         Result[i]:=GetSysParamVal(Result[i]);
end;

procedure  TFhlUser.AssignDefault(fDataSet:TDataSet;UseEdit:boolean=true);
// var i:integer;r:variant;
begin
FhlKnl1.Ds_AssignDefaultVals(fDataSet,sDefaultVals,UseEdit);

  sDefaultVals:='';
end;

procedure TdmFrm.AssignDefaultAction1Execute(Sender: TObject);
 var i:integer;r:variant;
begin

  with TDataSet(Sender) do
      for i:=0 to FieldCount-1 do
      begin
        r:=FhlUser.GetSysParamVal(Fields[i].DefaultExpression);
        if Not VarIsNull(r) then
          Fields[i].Value:=trim(string(r));
      end;
end;

procedure  TFhlUser.CheckRight(RightId:String;MyFrm:TForm=nil);
begin
  if RightId='' then
  begin
   exit;
  end;
  if Not dmFrm.ExecStoredProc('sys_CheckRight',varArrayof([LoginInfo.LoginId,RightId])) then
  begin
     MyFrm.Free;
     MessageDlg(#13#10'对不起,您没有权限使用该功能,请向管理员询问.',mtWarning,[mbOk],0);
     Abort;
  end;
end;

function   TFhlUser.CheckRight2(RightId:String;MyFrm:TForm=nil):boolean;
begin

  if RightId='' then
  begin
    result:=false;
    Exit;
  end;

  if Not dmFrm.ExecStoredProc('sys_CheckRight',varArrayof([LoginInfo.LoginId,RightId])) then
  begin
    result:=false;
    Exit;
  end
  else
    result:=true;

end;

procedure TdmFrm.BeforeDeleteAction1Execute(Sender: TObject);
var
  fDict:TBeforeDeleteDict;
  fDataSet:TDataSet;
//  AbortStr:string;
deleteConfirm:boolean;

begin
      deleteConfirm:=true;
      fDataSet:=TDataSet(Sender);

      if Not FhlKnl1.Cf_GetDict_BeforeDelete(intTostr(fDataSet.Tag),fdict) then exit;

      FhlUser.CheckRight(fDict.DelRitId);

      if fDict.Proc<>'' then
      if MessageDlg(#13#10+fDict.Hint,mtInformation,[mbOk,mbCancel],0)<>mrOk then
      begin
           deleteConfirm:=false
      end ;

      if   deleteConfirm then
      begin
          if Not dmFrm.ExecStoredProc(fDict.Proc,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.EdtSysParams),FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.EdtUsrParams))) then
          begin
              with dmFrm.FreeStoredProc1 do
              begin
                if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut)and (Parameters.Items[1].Value<>null) then
                  fDict.ErrorHint:=Parameters.Items[1].Value;
              end;
              if  fDict.ErrorHint<>'' then
              begin
                  MessageDlg(#13#10+fDict.ErrorHint,mtError,[mbOk],0);
                   Abort;
              end;
          end;
      end
       else
       Abort ;
end;

procedure TdmFrm.BeforePostAction1Execute(Sender: TObject);
var
  fDict:TBeforePostDict;
  fDataSet:TDataSet;
  var i:integer;
  aParam:variant;

begin
  fDataSet:=TDataSet(Sender);
  //Require
  RequireCheckAction1Execute(fDataSet);
  if Not FhlKnl1.Cf_GetDict_BeforePost(intTostr(fDataSet.Tag),fdict) then exit;
    if fDataSet.State=dsInsert then
      FhlUser.CheckRight(fDict.AddRitId)
    else
      FhlUser.CheckRight(fDict.EditRitId);

    aParam:=FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.EdtSysParams),FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.EdtUsrParams));
    //Proc        fn_shldout_bfrpst    'fn_shldout_bfrpst'
    if Not dmFrm.ExecStoredProc(fDict.EdtProc,aParam) then
    begin
        with dmFrm.FreeStoredProc1 do
        begin
  //        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) then
         if    Parameters.Items[1].Value <>null   then
            fDict.AbortStr:=Parameters.Items[1].Value;
            if Parameters.Items[2].Value <>null then
            fDict.WarningStr:=Parameters.Items[2].Value ;
        end;
        if fDict.AbortStr<>'' then
        begin
          MessageDlg(#13#10+fDict.AbortStr,mtError,[mbOk],0);
   
          Abort;
        end
        else if MessageDlg(#13#10+fDict.WarningStr,mtWarning,[mbOk,mbCancel],0)<>mrOk then
          Abort;
    end;
{
    //Duplicate
    if fDict.DupChkSql<>'' then
    begin
      dmFrm.FreeQuery1.Close;
      dmFrm.FreeQuery1.SQL.CommaText:=fDict.DupChkSql;
      FhlKnl1.Ds_OpenDataSet(dmFrm.FreeQuery1,FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.DupChkFlds));
      if (dmFrm.FreeQuery1.RecordCount>1) or ((dmFrm.FreeQuery1.RecordCount=1) and (fDataSet.State=dsInsert)) then
      begin
        if (MessageDlg(#13#10+fDict.DupHint,mtWarning,[mbOk,mbCancel],0)<>mrOk) or (Not fDict.DupCan) then
          Abort;
      end;
    end;
}    //SameVals
    if (fDict.SameValFlds<>'') and (Not FhlKnl1.Vr_VarHaveSameVal(FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.SameValFlds))) then
    begin
      MessageDlg(#13#10+fDict.SameValHint,mtWarning,[mbOk],0);
      Abort;
    end;
    //Hint

        if (fDict.PostHint<>'') and (MessageDlg(#13#10+FhlKnl1.Vr_ReplaceByVarArray( fDict.PostHint,'%s',FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.PostSysParams),FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.PostUsrParams))),mtInformation,[mbOk,mbCancel],0)<>mrOk) then
          Abort;

    //AutoKey
    if (fDataSet.State=dsInsert) and (fDict.AutoKeyId<>'') then
       fDataSet.FieldByName(fDict.AutoKeyFld).AsString:=dmFrm.GetMyId(fDict.AutoKeyId);

end;

procedure TdmFrm.AfterPostAction1Execute(Sender: TObject);
var
  fDataSet:TDataSet;
  fDict:TAfterPostDict;
begin
    fDataSet:=TDataSet(Sender);
  if Not FhlKnl1.Cf_GetDict_AfterPost(intTostr(fDataSet.Tag),fdict) then exit;
      if Not dmFrm.ExecStoredProc(fDict.fProc,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.fSysParams),FhlKnl1.Ds_GetFieldsValue(fDataSet,fDict.fDataParamFlds))) then
        MessageDlg(#13#10+fDict.fErrorHint,mtError,[mbOk],0);

end;

procedure TFhlUser.Logout(Note:String='');
begin
  if LoginInfo.LoginTime<>'' then
    try
      dmFrm.ExecStoredProc('sys_Logout',varArrayof([LoginInfo.LoginTime,Note]));
    except
//      MessageDlg(#13#10'不能写入登出日志!',mtError,[mbOk],0);
    end;
end;

procedure TFhlUser.MergeGridUserMenuAndSysCongfigMenu(UserPopMenu,  SysConfigMenu: tpopupMenu; GridUserMenuIDs: integer;
  UserMenuAction: TactionList);
var i,j,UserMenuCont:integer;
var GridMenuItem: array of TMenuItem;
var sql:string;
begin
      UserPopMenu.Items.Clear ;
      UserMenuCont:=0;

    UserPopMenu.Images := UserMenuAction.Images ;
    if not LoginInfo.isAdmin then
    begin
          sql:='select * from T624 A '
        +' left join '+FhlKnl1.UserConnection.DefaultDatabase +'.dbo.sys_right B on A.F13=B.code '
        +' where   A.f02= '+inttostr(GridUserMenuIDs )+' and ('
        +' A.f13  in ( '
        +' select rightid from '
                + FhlKnl1.UserConnection.DefaultDatabase  +'.dbo.sys_groupright  C '
        +' join '+FhlKnl1.UserConnection.DefaultDatabase +'.dbo.sys_groupuser   D  on C.groupID=D.groupID '
        +' where  userid='+quotedstr(LoginInfo.LoginId)
        +') '
        +' or (    isnull(f13,0)=0 )) '
        +'  order by F07'   ;
    end
    else
       sql:='select * From T624 where f02='+inttostr(GridUserMenuIDs )+'  order by F07';

      FhlKnl1.Kl_GetQuery2(sql)     ;

      if not FhlKnl1.FreeQuery.IsEmpty then
      begin
          UserMenuCont:=FhlKnl1.FreeQuery.RecordCount ;
          setlength(GridMenuItem,UserMenuCont+SysConfigMenu.Items.Count+1);
          for i:=0 to UserMenuCont-1 do
          begin                                                                //user menu
             if FhlKnl1.FreeQuery.fieldbyname('F11').asinteger>-1 then
             begin
                  GridMenuItem[i]           :=TMenuItem.Create (UserPopMenu);
                  GridMenuItem[i].Name      :=FhlKnl1.FreeQuery.fieldbyname('f03').AsString ;
                  GridMenuItem[i].Caption   :=FhlKnl1.FreeQuery.fieldbyname('f04').AsString ;
                  GridMenuItem[i].Checked   :=FhlKnl1.FreeQuery.fieldbyname('F05').AsBoolean ;
                  GridMenuItem[i].Visible   :=FhlKnl1.FreeQuery.fieldbyname('f06').Visible ;
                  GridMenuItem[i].hint      :=FhlKnl1.FreeQuery.fieldbyname('F08').AsString ;
                  GridMenuItem[i].ShortCut  :=Texttoshortcut (FhlKnl1.FreeQuery.fieldbyname('f09').AsString );
                  GridMenuItem[i].ImageIndex:=Taction(UserMenuAction[FhlKnl1.FreeQuery.fieldbyname('F11').asinteger]).ImageIndex  ;
                  GridMenuItem[i].OnClick   := UserMenuAction[FhlKnl1.FreeQuery.fieldbyname('F11').asinteger].OnExecute  ;
                  GridMenuItem[i].Tag       :=0;

                  UserPopMenu.Items.Add(GridMenuItem[i]);
              end;
              FhlKnl1.FreeQuery.Next ;
          end;

          GridMenuItem[UserMenuCont]         :=TMenuItem.Create (UserPopMenu); //control conifg menu visable
          GridMenuItem[UserMenuCont].Caption :='-';
//          GridMenuItem[UserMenuCont].OnClick :=self.ShowConfigMenu;
          UserPopMenu.Items.Add(GridMenuItem[UserMenuCont]);   //
      end
      else
           setlength(GridMenuItem,SysConfigMenu.Items.Count);

      j:=UserMenuCont ;

      for i:=UserMenuCont+1 to    SysConfigMenu.Items.Count -1 +j do
      begin
          GridMenuItem[i]         :=TMenuItem.Create (UserPopMenu);                     //sys config menu
          GridMenuItem[i].OnClick :=SysConfigMenu.Items [i-j].OnClick ;
          GridMenuItem[i].Name    :=  SysConfigMenu.Items [i-j].Name ;
          GridMenuItem[i].Caption :=SysConfigMenu.Items [i-j].Caption;
          //GridMenuItem[i].Visible :=false;
          GridMenuItem[i].Tag :=1;
          UserPopMenu.Items.Add(GridMenuItem[i]);
      end;
end;

procedure TFhlUser.DoExecProc(AUsrDataSet:TDataSet;Aparams:Variant;AProcId:String='');
var
  fDict:TExcPrcDict;
begin
  if AProcId='' then
    AProcId:=IntToStr(AUsrDataSet.Tag);

  FhlKnl1.Cf_GetDict_ExcPrc(AProcId,fDict);
  if fDict.ProcName<>'' then
  begin
      FhlUser.CheckRight(fDict.RightId);
      Aparams:=FhlKnl1.Vr_MergeVarArray(FhlKnl1.Ds_GetFieldsValue(AUsrDataSet,fDict.UsrParams),Aparams);
      fDict.ReturnBool:=dmFrm.ExecStoredProc(fDict.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(fDict.SysParams),Aparams));
      with dmFrm.FreeStoredProc1 do
      begin
        if (Parameters.Count>1) and (Parameters.Items[1].Direction=pdOutPut) and (Not varIsnull(Parameters.Items[1].Value)) then
          fDict.ResultHint:=Parameters.Items[1].Value;
      end;
      if fDict.ResultHint<>'' then MessageDlg(#13#10+fDict.ResultHint,mtError,[mbOk],0);
      if Not fDict.ReturnBool
      then Abort;
  end;
end;

procedure TdmFrm.SlInvCalcAction1Execute(Sender: TObject);
begin

  with TDataSet(Sender) do
  begin
    FieldByName('TotalFund').AsCurrency:=FieldByName('WareFund').AsCurrency+FieldByName('OtherFund').AsCurrency;
    FieldByName('RemainFund').AsCurrency:=FieldByName('GetFund').asCurrency-FieldByName('PayFund').asCurrency;
    FieldByName('RemainBig').AsString:=FhlKnl1.St_GetBigMoney(FieldByName('RemainFund').AsCurrency);
  end;
end;

procedure TdmFrm.fnRecCalcAction1Execute(Sender: TObject);
begin
  with TDataSet(Sender) do
  begin
    FieldByName('xBigFund').AsString:=FhlKnl1.St_GetBigMoney(FieldByName('PayFund').asCurrency);
  end;
end;

procedure TdmFrm.fncaOpenAction1Execute(Sender: TObject);
var
  fRemain,fInQty,fOutQty:Double;
begin
  with TDataSet(Sender) do
  begin
    DisableControls;
    Last;
    fRemain:=FieldByName('RmnQty').asFloat;
    Prior;
      if FieldByName('IsCalc').AsInteger=1 then
      begin
        Edit;
        FieldByName('RmnQty').asFloat:=fRemain;
        Post;
      end;
    fInQty:=FieldByName('InQty').asFloat;
    fOutQty:=FieldByName('OutQty').asFloat;
    Prior;
    while not bof do
    begin
      fRemain:=fRemain-fInQty+fOutQty;
      fInQty:=FieldByName('InQty').asFloat;
      fOutQty:=FieldByName('OutQty').asFloat;
      if FieldByName('IsCalc').AsInteger=1 then
      begin
        Edit;
        FieldByName('RmnQty').asFloat:=fRemain;
        Post;
      end;
      Prior;
    end;
    EnableControls;
  end;
end;

procedure TdmFrm.AOLastAction1Execute(Sender: TObject);
begin
  TDataSet(Sender).Last;
end;

procedure TdmFrm.slInvGetFundAction1Execute(Sender: TObject);
begin
  with TDbEdit(Sender) do
  begin
    DataSource.DataSet.Edit;
    DataSource.DataSet.FieldByName(DataField).AsCurrency:=FhlKnl1.Ds_Calc(DataSource.DataSet,'WareFund+OtherFund');
  end;
end;

procedure TdmFrm.N2Click(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;

  FhlKnl1.Dg_SetColStyle(PopDbgrid);
  //FhlKnl1.Dg_SetColStyle(TDbGrid(DbGridPopupMenu1.PopupComponent));
end;


procedure TdmFrm.TabEditorShowAction1Execute(Sender: TObject);
var
  ds:TDataSet;
begin
  ds:=TDbEdit(Sender).DataSource.DataSet;
  FhlUser.ShowTabEditorFrm(intTostr(ds.Tag)+TDbEdit(Sender).DataField,null,ds,false,-11,true,false);
end;

procedure TdmFrm.TabGridShowAction1Execute(Sender: TObject);
var
  ds1,ds2:TDataSet;
  fkey:string;
begin
  ds1:=TDbEdit(Sender).DataSource.DataSet;//intTostr(ds.Tag)+TDbEdit(Sender).DataField
  fkey:=ds1.FieldByName('ClientKey').AsString;
  FhlUser.ShowTabGridFrm('-',fkey,False);
  if TabGridFrm.ModalResult<>mrOk then exit;
  ds2:=TabGridFrm.DataSource1.DataSet;
  FhlKnl1.Ds_UpdateAllRecs(ds2,'MasterKey',fkey);
  TAdoDataSet(ds2).UpdateBatch();
  ds1.Edit;
  ds1.FieldByName('OtherFund').AsCurrency:=FhlKnl1.Ds_SumFlds(ds2,'Fund')[0];
  FreeAndNil(TabGridFrm);
end;

procedure TdmFrm.PhArvCalcAction1Execute(Sender: TObject);
begin
  with TDataSet(Sender) do
  begin
    FieldByName('TaxFund').AsCurrency:=FieldByName('WareFund').AsCurrency*FieldByName('TaxRate').AsFloat;
  end;
end;



procedure TdmFrm.DataModuleCreate(Sender: TObject);
begin
  FhlKnl1:=TFhlKnl.Create(dmFrm);
  qryFree_Sys.Connection :=fhlknl1.Connection ;
  conSys.ConnectionString :=self.ADOConnection1.ConnectionString ;



end;
procedure  TdmFrm.GetQry_Sys(ASql:wideString;AReturn:Boolean=True);
begin
  with qryFree_Sys do
  begin
    Close;
    Sql.Clear;
    Sql.Append(ASql);
    if AReturn then
      Open
    else
      ExecSql;
  end;
end;
procedure TdmFrm.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FhlKnl1);
end;

procedure TdmFrm.ConfigMenu;
var sql:string;
begin
     self.GetQry_Sys  ('select * from TMenuRits');
    with  self.qryFree_Sys  do
    begin
      FMenuRitDict.ColVisiableRitID:=FieldByName('ColVisiableRitID').asString;
      FMenuRitDict.ColOrderRitID :=  FieldByName('ColOrderRitID').asString;
    end;

    self.qryFree_Sys.Close;

    self.dgPupVis.Visible  := FhlUser.CheckRight2(FMenuRitDict.ColVisiableRitID );
    self.dgPupProp.Visible := FhlUser.CheckRight2(FMenuRitDict.ColVisiableRitID );

    sql:='select isadmin from sys_user where loginid=' +quotedstr(logininfo.LoginId );
    self.GetQuery1(sql);

    if not self.FreeQuery1.IsEmpty then
    with  self.FreeQuery1  do
    begin
      LoginInfo.isAdmin:=FieldByName('isadmin').AsBoolean  ;
      NSelectFields.Visible :=FieldByName('isadmin').AsBoolean  ;
    end;



end;

procedure TdmFrm.actUpdatePicExecute(Sender: TObject);
 var fld:TField;
begin
 Screen.Cursor:=crSqlwait;
 try
   if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
   else
     fld:=TDbEdit(Sender).Field;
   if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
   begin
     with FrmUpdateImage.Create(Application) do
     begin
       InitFrm(fld);
       ShowModal;       
       free;
     end;
   end;
 finally
  Screen.Cursor:=crDefault;
 end;

end;

procedure TdmFrm.actLoadPicExecute(Sender: TObject);
begin
if dlgOpenPic1.Execute then
    if     dlgOpenPic1.FileName <>'' then
      if Sender is TdbImage then
         (Sender as TdbImage).Picture.LoadFromFile(dlgOpenPic1.FileName );
         
end;

procedure TdmFrm.actInvoiceCalcExecute12(Sender: TObject);
begin
//2006-7-26 以后将这东西放数据库去
  with TDataSet(Sender) do
  begin
    FieldByName('DiffAmt').AsCurrency :=FieldByName('InvFund').asCurrency-FieldByName('WareFund').asCurrency;
  end;
end;

procedure TdmFrm.actCheckRangExecute(Sender: TObject);
var fld:   TField;
   msg:string;
begin
    if (sender is TDbEdit) then
    begin
          fld:=TDbEdit(Sender).Field;
          if (fld is TfloatField) or (fld is TCurrencyField) then
          begin
              if  strtofloat ((sender as TDbEdit).Text)<TfloatField(fld  ).MinValue then
              begin
                   msg:=fld.FieldName +'不能小于'  +floattostr(TfloatField(fld  ).MinValue);
              end;
              if  strtofloat ((sender as TDbEdit).Text)>TfloatField(fld  ).MaxValue then
              begin
                  msg:=fld.FieldName +'不能大于'  +floattostr(TfloatField(fld  ).MaxValue);
              end;
          end;
          if (fld is TintegerField) then
          begin
              if  strtoint ((sender as TDbEdit).Text)<TintegerField(fld  ).MinValue then
              begin
                   msg:=fld.FieldName +'不能小于'  +inttostr(TintegerField(fld  ).MinValue);
              end;
              if  strtoint ((sender as TDbEdit).Text)>TintegerField(fld  ).MaxValue then
              begin
                  msg:=fld.FieldName +'不能大于'  +inttostr(TintegerField(fld  ).MaxValue);
              end;
          end;

    end;


end;

procedure TdmFrm.actCalcExecute(Sender: TObject);
var Fields,formula:Tstringlist;
var ResultField,Calc,fieldValue, stringResult:string;
var I,J:integer;
var  vScript: Variant;
var Presult:double;
begin
//a:=(b+c)*d/f+g*h

  Fields:=Tstringlist.Create ;
  formula:=Tstringlist.Create ;
  formula.NameValueSeparator :='=';
  vScript := CreateOleObject('ScriptControl');
  vScript.Language := 'JavaScript';


  fhlknl1.Kl_GetQuery2('select* from T202 where  f02='+ inttostr(Tadodataset(sender).Tag )+'   and f08<>'+ quotedstr('') +'  and f09<>'+quotedstr('')   );
  if    not fhlknl1.FreeQuery.IsEmpty then
  begin
        for i:= 0 to   fhlknl1.FreeQuery.RecordCount -1 do
        begin
                  Fields.Clear ;
                  formula.Clear;
                  formula.NameValueSeparator :='=';
                  Fields.CommaText := fhlknl1.FreeQuery.FieldByName('F09').asString;
                  formula.CommaText := string(fhlknl1.FreeQuery.FieldByName('F08').asString);
                  ResultField:=   formula.Names [0] ;
                  Calc:=formula.values[ResultField] ;

                  if (Fields.CommaText='' ) or (formula.CommaText='' ) then continue;

                  for J:=0 to   Fields.Count -1 do
                  begin  {
                       if Tadodataset(sender).Fieldbyname(Fields[j]).AsFloat <0 then
                          FieldValue:='('+ Tadodataset(sender).Fieldbyname(Fields[j]).AsString +')'
                       else
                          FieldValue:= Tadodataset(sender).Fieldbyname(Fields[j]).AsString ;
                          }
                       if Tadodataset(sender).Fieldbyname(Fields[j]).AsString <>'' then
                       begin
                           if (Tadodataset(sender).Fieldbyname(Fields[j])  is Tfloatfield) or (Tadodataset(sender).Fieldbyname(Fields[j])  is Tintegerfield) then
                           begin
                               if Tadodataset(sender).Fieldbyname(Fields[j]).AsFloat <0 then        //2010-3-27 去掉负数加括号
                                 if pos('?', Calc)<>-1 then                                         //不能加负号 FPAmt=(("FAmt".match("-"))?0:Math.abs(FAmt))
                                   FieldValue:='('+ Tadodataset(sender).Fieldbyname(Fields[j]).AsString +')'
                                 else
                                   FieldValue:=Tadodataset(sender).Fieldbyname(Fields[j]).AsString
                               else
                                  FieldValue:= Tadodataset(sender).Fieldbyname(Fields[j]).AsString ;
                           end
                           else
                              FieldValue:= Tadodataset(sender).Fieldbyname(Fields[j]).AsString ;
                       end
                       else
                          FieldValue:='' ;

                       if   FieldValue='' then FieldValue:='0';
                      Calc:= stringreplace(trim(Calc),trim(Fields[j]),trim(FieldValue ),[rfIgnoreCase ]);
                  end;
                  
                  if  not(  Tadodataset(sender).State in [dsinsert,dsedit] ) then
                        if Tadodataset(sender).FieldByName(ResultField).FieldKind  <> fkCalculated then
                           Tadodataset(sender).Edit ;

                  if Tadodataset(sender).FieldByName(ResultField) is TNumericField then
                  begin
                      Presult   := vScript.Eval(Calc);
                      Tadodataset(sender).FieldByName(ResultField).Value  := Presult;
                  end
                  else
                  begin 
                      Tadodataset(sender).FieldByName(ResultField).Value  := Calc;
                  end;


                 fhlknl1.FreeQuery.Next ;
        end;
  end;
  if Tadodataset(sender).FindField('MyIndex')<>nil then
  begin
        with Tadodataset(sender) do
        begin
          if  FieldByName('MyIndex').asInteger<>Abs(RecNo) then
               FieldByName('MyIndex').asInteger:=Abs(RecNo);//Is fkCalculated
        end;
  end;
end;

procedure TdmFrm.actCaCulExecute(Sender: TObject);
Var fld:Tfield;

//=============
var Fields,formula:Tstringlist;
var ResultField,Calc,fieldValue,sql:string;
var I,J:integer;
var  vScript: Variant;
var Presult:double;

begin


  fld:=TDbEdit(Sender).Field ;
if     fld.Text='' then
exit;
//a:=(b+c)*d/f+g*h

  Fields:=Tstringlist.Create ;
  formula:=Tstringlist.Create ;
  formula.NameValueSeparator :='=';
  vScript := CreateOleObject('ScriptControl');
  vScript.Language := 'JavaScript';

  sql:='select * From T202 where f08<>'+quotedstr('')+' and f09<>'+quotedstr('')+' and  f02 ='+inttostr(fld.DataSet.Tag );
   fhlknl1.Kl_GetQuery2(sql);

  if    not fhlknl1.FreeQuery.IsEmpty then
  begin
        for i:=0 to fhlknl1.FreeQuery.RecordCount -1 do
        begin
                Fields.Clear ;
                formula.Clear;
                formula.NameValueSeparator :='=';
                Fields.CommaText := fhlknl1.FreeQuery.FieldByName('F09').asString;
                formula.CommaText := string(fhlknl1.FreeQuery.FieldByName('F08').asString);
                ResultField:=   formula.Names [0] ;
                Calc:=formula.values[ResultField] ;

                for J:=0 to   Fields.Count -1 do
                begin
                     if fld.DataSet.Fieldbyname(Fields[j]).AsFloat <0 then
                        FieldValue:='('+ Tadodataset(fld.DataSet).Fieldbyname(Fields[j]).AsString +')'
                     else
                        FieldValue:= Tadodataset(fld.DataSet).Fieldbyname(Fields[j]).AsString ;
                     if   FieldValue='' then FieldValue:='0';
                    Calc:= stringreplace(trim(Calc),trim(Fields[j]),trim(FieldValue ),[rfIgnoreCase ]);
                end;
                Presult   := vScript.Eval(Calc);
               if  not(   fld.DataSet.State in [dsinsert,dsedit] ) then
               fld.DataSet.Edit ;
               Tadodataset(fld.DataSet).FieldByName(ResultField).AsCurrency := Presult;
               fhlknl1.FreeQuery.Next ;
        end;
  end;



end;

procedure TdmFrm.NSelectFieldsClick(Sender: TObject);
var
  TabGridFrm: TTabGridFrm;
  Gridtag:string;
var PopDbgrid:Tdbgrid;
begin
{  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;


//581
  TabGridFrm:= TTabGridFrm.Create (nil);
  TabGridFrm.Caption :='设置需要打印的字段';
  TabGridFrm.Hide ;
  TabGridFrm.Width :=400;
  Gridtag:=inttostr(PopDbgrid.Tag);
  TabGridFrm.DBGrid1.OnDblClick :=self.updatebool;
  FhlUser.SetDbGridAndDataSet (TabGridFrm.DBGrid1 ,'581',Gridtag);//.Rp_DbGrid(intTostr(TDbGrid(DbGridPopupMenu1.PopupComponent).Tag),TDbGrid(DbGridPopupMenu1.PopupComponent));
  TabGridFrm.ShowModal ;
  if TabGridFrm.ModalResult =mrOk then
  begin
       Tadodataset(TabGridFrm.DBGrid1.DataSource.DataSet).UpdateBatch;
  end;
  }
end;

procedure TdmFrm.updatebool(sender: tobject);
begin
if sender is tdbgrid then
begin
   Tdbgrid(sender).DataSource.DataSet.Edit ;
   Tdbgrid(sender).DataSource.DataSet.FieldByName('f26').AsBoolean := not Tdbgrid(sender).DataSource.DataSet.FieldByName('f26').AsBoolean;
      Tdbgrid(sender).DataSource.DataSet.Post ; ;
end;
end;

procedure TdmFrm.ActGetMaxBoxIdExecute(Sender: TObject);
//var     fieldname:string;

var BoxPopMenu:Tpopupmenu;
var CtrlMenu,LabelMenu,GetMaxBoxIDMenu:Tmenuitem;

begin
    BoxPopMenu:=Tpopupmenu.Create (self);

    CtrlMenu:=Tmenuitem.Create (BoxPopMenu)  ;
    CtrlMenu.Caption :='CtrlMenu';
    CtrlMenu.OnClick :=self.ConfigCtrl  ;//(Sender);

    LabelMenu:=Tmenuitem.Create (BoxPopMenu)  ;
    LabelMenu.Caption :='LabelMenu';
    LabelMenu.OnClick :=self.ConfigLabel  ;//(Sender);

    GetMaxBoxIDMenu:=Tmenuitem.Create (BoxPopMenu)  ;
    GetMaxBoxIDMenu.Caption :='CtrlMenu';
    GetMaxBoxIDMenu.OnClick :=self.ConfigGetMaxBoxid ;//(Sender);

    BoxPopMenu.Items.Add(CtrlMenu);
    BoxPopMenu.Items.Add(LabelMenu);
    BoxPopMenu.Items.Add(GetMaxBoxIDMenu);

    if Sender is tdbedit then
    Tdbedit(Sender).PopupMenu := BoxPopMenu;

    if Sender is Taction then
    Tdbedit(Taction (sender).ActionComponent).PopupMenu := BoxPopMenu;






end;


procedure TdmFrm.ActAddDataSetExecute(Sender: TObject);

var DataSetPopMenu:Tpopupmenu;
var DataSetIDMenu,BeforePostMenu,BeforeDeleteMenu,AfterPostMenu,LstProcsMenu:Tmenuitem;

begin
    DataSetPopMenu:=Tpopupmenu.Create (self);

    DataSetIDMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    DataSetIDMenu.Caption :='DataSetIDMenu';
    DataSetIDMenu.OnClick :=self.ConfigDatasetID ;//(Sender);


    BeforePostMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    BeforePostMenu.Caption :='BeforePostMenu';
    BeforePostMenu.OnClick :=self.  ConfigBeforePost;//(sender);

    BeforeDeleteMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    BeforeDeleteMenu.Caption :='BeforeDeleteMenu';
    BeforeDeleteMenu.OnClick :=self.ConfigBeforeDelete  ;//(sender);

    AfterPostMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    AfterPostMenu.Caption :='AfterPostMenu';
    AfterPostMenu.OnClick :=self.ConfigAfterPost  ;//(sender);

    LstProcsMenu:=Tmenuitem.Create (DataSetPopMenu)  ;
    LstProcsMenu.Caption :='LstProcsMenu';
    LstProcsMenu.OnClick :=self.LstDataProcs  ;//(sender);


    DataSetPopMenu.Items.Add(DataSetIDMenu);
    DataSetPopMenu.Items.Add(BeforePostMenu);
    DataSetPopMenu.Items.Add(BeforeDeleteMenu);
    DataSetPopMenu.Items.Add(AfterPostMenu);
    DataSetPopMenu.Items.Add(LstProcsMenu);


    Tdbedit(Sender).PopupMenu :=DataSetPopMenu;

end;

procedure TdmFrm.ActTreeGridExecute(Sender: TObject);
var   frmeditor:Tform;
begin
if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrm('46', Tdbedit(sender).Text );

    frmeditor.ShowModal ;

    if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);

end;

procedure TdmFrm.ConfigAfterPost(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('47', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;


procedure TdmFrm.ConfigBeforeDelete(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('46', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;

procedure TdmFrm.ConfigBeforePost(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('45', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;

procedure TdmFrm.ConfigCtrl(sender: Tobject);

VAR frmeditor:Tform;
begin
// 34

//       UserdefaultDB:=dmfrm.ADOConnection1.DefaultDatabase ;
//       dmfrm.ADOConnection1.DefaultDatabase :=fhlknl1.Connection.DefaultDatabase ;





    if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

        frmeditor:=FhlUser.ShowModalTreeGridFrm( '34', Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Text ,true);//.Showmodal;
        frmeditor.ShowmodAl ;


//        fhlknl1.Connection.DefaultDatabase :=dmfrm.ADOConnection1.DefaultDatabase;
//        dmfrm.ADOConnection1.DefaultDatabase :=UserdefaultDB;




end;

procedure TdmFrm.ConfigDatasetID(sender: Tobject);
VAR frmeditor:Tform;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

    frmeditor:=FhlUser.ShowEditorFrm('35', Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent).Text );//.Showmodal;
    frmeditor.ShowmodAl ;

    if   Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent).Field.DataSet.State in [dsinsert,dsedit] then
    Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.ConfigFldGridLkp(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('48', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;

procedure TdmFrm.ConfigFldTreeDlgLkp(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('49', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;

procedure TdmFrm.ConfigGetMaxBoxid(sender: Tobject);

begin


  if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) as Tdbedit).Text ='' then

    begin
       ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) as Tdbedit).Text:=fhlknl1.GetMaxBoxID;

    end   ;
   { }
end;

procedure TdmFrm.ConfigGrid(sender: Tobject);
VAR frmeditor:Tform;
begin
    if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

        frmeditor:=FhlUser.ShowEditorFrm('34', Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Text );//.Showmodal;
        frmeditor.ShowmodAl ;

        if   Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

        freeandnil(frmeditor);


end;


procedure TdmFrm.ConfigGridRpt(sender: Tobject);
var TreeGridFrm :Tform    ;
var Aparam:string;
begin

if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

begin
        Aparam:=Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent  ).Text  ;

        TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('44', Aparam,true );

        TTreeGridFrm(TreeGridFrm ).ShowModal ;   // (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )
        freeandnil(TreeGridFrm);
end;
end;

procedure TdmFrm.ConfigLabel(sender: Tobject);

VAR frmeditor:Tform;
begin
// 53

    if ((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ) is Tdbedit) then

        frmeditor:=FhlUser.ShowModalTreeGridFrm('53', Tdbedit((Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent )).Text ,true);//.Showmodal;
        frmeditor.ShowmodAl ;


end;
procedure TdmFrm.LstDataProcs(sender: Tobject);
var frmLstProc:Tform;
var ProcsMemo:Tmemo;
var ID,values:string;
var i,j:integer;
begin
//
    ID:=  Tdbedit(Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Text ;
    frmLstProc:=Tform.Create(nil);
    ProcsMemo:=Tmemo.Create (frmLstProc);
    ProcsMemo.Parent :=frmLstProc;
    ProcsMemo.Align :=alclient;
    frmLstProc.Caption :='prcos';

    dmfrm.GetQuery1('select * from V_LstProcs where f01='+ID);
    if not dmfrm.FreeQuery1.IsEmpty then
    begin
         for j:=0 to dmfrm.FreeQuery1.RecordCount -1  do
         begin
               values:='';
               for i:=0 to dmfrm.FreeQuery1.FieldCount -1 do
               begin
                   values:=values+'   '+ dmfrm.FreeQuery1.Fields[i].AsString
               end;
               ProcsMemo.Lines.Add(values);
               dmfrm.FreeQuery1.Next ;
         end;
    end;
    frmLstProc.ShowModal ;
    frmLstProc.Free ;
end;

procedure TdmFrm.TreeIDT507Execute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrm('47', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;


procedure TdmFrm.ActTreeIDsExecute(Sender: TObject);
begin
   if Sender is Tdbedit then
  FhlUser.ShowModelTreeEditorFrm('24',Tdbedit(sender).Text ,true);

end;

procedure TdmFrm.ActCRMTreeIDSGridExecute(Sender: TObject);
var TreeGridFrm :Tform    ;
var i:integer;
var TreeIDS,ID:string;
begin
if Sender is Tdbedit then
begin
   if Tdbedit(sender).Text ='' then id:='1' else ID:=Tdbedit(sender).Text;
end;
if Sender is Tmenuitem then
begin
   id:=inttostr(Tpagecontrol (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Tag );//
end;

   TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('28',id,true );
   TTreeGridFrm(TreeGridFrm ).ShowModal ;


   if Sender is Tdbedit then
   begin
    for i:=0 to TTreeGridFrm(TreeGridFrm ).ADODataSet1.RecordCount -1 do //('TreeIDS').
    begin
        if i=0 then
            TreeIDS:=    TTreeGridFrm(TreeGridFrm ).ADODataSet1.fieldbyname('F11').AsString
        else
        begin
            if TreeIDS<>   TTreeGridFrm(TreeGridFrm ).ADODataSet1.fieldbyname('F11').AsString then
            begin
                  Tdbedit(sender).Text :=Tdbedit(sender).Text +'TreeIDS 不一致！' ;
                  freeandnil(TreeGridFrm );
                  exit;
            end;
        end;
        TTreeGridFrm(TreeGridFrm ).ADODataSet1.next;
    end;
    Tdbedit(sender).Text :=TreeIDS;
  end;

  freeandnil(TreeGridFrm );

end;

procedure TdmFrm.ActEditorT616Execute(Sender: TObject);
var frmeditor:Tform;
begin
if sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrm('49',Tdbedit(sender).Text );
    frmeditor.ShowModal ;


    if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.ActCRMSubInterFaceExecute(Sender: TObject);
var  TreeGridFrm:Tform;
var i:integer;
var TreeIDS,ID:string;

begin
if Sender is Tdbedit then
begin
      if Tdbedit(sender).Text ='' then id:='1' else ID:=Tdbedit(sender).Text;
end;

if Sender is Tmenuitem then
begin
   id:=inttostr(Tpagecontrol (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Tag );//
end;
    TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('29', ID,true );
    TreeGridFrm.ShowModal ;


    if Sender is Tdbedit then
    begin
        for i:=0 to TTreeGridFrm(TreeGridFrm ).ADODataSet1.RecordCount -1 do //('TreeIDS').
        begin
            if i=0 then
                TreeIDS:=    TTreeGridFrm(TreeGridFrm ).ADODataSet1.fieldbyname('subinterfaceid').AsString
            else
            begin
                if TreeIDS<>   TTreeGridFrm(TreeGridFrm ).ADODataSet1.fieldbyname('subinterfaceid').AsString then
                begin
                      Tdbedit(sender).Text :=Tdbedit(sender).Text +'TreeIDS 不一致！' ;
                      freeandnil(TreeGridFrm );
                      exit;
                end;
            end;
            TTreeGridFrm(TreeGridFrm ).ADODataSet1.next;
        end;
        Tdbedit(sender).Text :=TreeIDS;
    end;
    freeandnil(TreeGridFrm );

end;

procedure TdmFrm.ActGridIDExecute(Sender: TObject);
var GridPopMenu:Tpopupmenu;
var GridMenu,GridRptMenu:Tmenuitem;

begin
    GridPopMenu:=Tpopupmenu.Create (self);
    GridMenu:=Tmenuitem.Create (GridPopMenu)  ;
    GridMenu.Caption :='GridMenu';
    GridMenu.OnClick :=self.ConfigGrid;//(Sender);

    GridRptMenu:=Tmenuitem.Create (GridPopMenu)  ;
    GridRptMenu.Caption :='GridRptMenu';
    GridRptMenu.OnClick :=self.ConfigGridRpt;//(sender);

    GridPopMenu.Items.Add(GridMenu);
    GridPopMenu.Items.Add(GridRptMenu);

    Tdbedit(Sender).PopupMenu :=GridPopMenu;

end;

procedure TdmFrm.ActEditorOpenParamsExecute(Sender: TObject);
VAR frmeditor:Tform;
begin
      if Sender is Tdbtext then
      begin

          frmeditor:=FhlUser.ShowEditorFrm('56', Tdbtext(sender).Caption  );//.Showmodal;
          sDefaultVals:='';
          sDefaultVals:='f01='+Tdbtext(sender).Caption ;
          frmeditor.ShowmodAl ;

          freeandnil(frmeditor);
      end;

end;

procedure TdmFrm.ActT202Execute(Sender: TObject);
    var TreeGridFrm :Tform    ;

{ VAR frmeditor:Tform;
    if Sender is Tdbtext then
    begin

        frmeditor:=FhlUser.ShowEditorFrm('41', Tdbtext(sender).Caption  );//.Showmodal;
        sDefaultVals:='';
        sDefaultVals:='f02='+Tdbtext(sender).Caption ;
        frmeditor.ShowmodAl ;

        freeandnil(frmeditor);
    end;
    }

begin
   if Sender is Tdbtext then
   begin
   TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('50', Tdbtext(sender).Caption,true );
   TTreeGridFrm(TreeGridFrm ).ShowModal ;
   end;

end;

procedure TdmFrm.ActBoxsExecute(Sender: TObject);
begin
   if Sender is Tdbedit then
FhlUser.ShowModalTreeGridFrm('34', Tdbedit(sender).Text,true ).ShowModal ;

end;

procedure TdmFrm.GridColsExecute(Sender: TObject);
var FrmTreeGridCols:Tform;
begin
if Sender is Tdbtext then
begin
    FrmTreeGridCols:=FhlUser.ShowModalTreeGridFrm('35', Tdbtext(sender).Caption ,true );
    FrmTreeGridCols.ShowModal ;
end;

end;
procedure TdmFrm.ActTabEditExecute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrm('66', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;


procedure TdmFrm.ActT102Execute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrm('64', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.ActMoreToMoreT619Execute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrm('36', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;


procedure TdmFrm.ActFieldOFSysTableExecute(Sender: TObject);
begin
   if Sender is Tdbedit then
fhluser.ShowModalTreeGridFrm('43', Tdbedit(sender).Text,true ).ShowModal ;
end;
procedure TdmFrm.ActFieldLKPExecute(Sender: TObject);
var FieldLKPMenu:Tpopupmenu;
var FldGridDlgMenu,FldTreeDlgMenu:Tmenuitem;

begin
    FieldLKPMenu:=Tpopupmenu.Create (self);

    FldGridDlgMenu:=Tmenuitem.Create (FieldLKPMenu)  ;
    FldGridDlgMenu.Caption :='FldGridDlgMenu';
    FldGridDlgMenu.OnClick :=self.ConfigFldGridLkp ;//(Sender);

    FldTreeDlgMenu:=Tmenuitem.Create (FieldLKPMenu)  ;
    FldTreeDlgMenu.Caption :='FldTreeDlgMenu';
    FldTreeDlgMenu.OnClick :=self.ConfigFldTreeDlgLkp ;//(sender);

    FieldLKPMenu.Items.Add(FldGridDlgMenu);
    FieldLKPMenu.Items.Add(FldTreeDlgMenu);

    Tdbedit(Sender).PopupMenu :=FieldLKPMenu;

end;

procedure TdmFrm.actGetFrmGridIDExecute(Sender: TObject);
var ModelID,sql,table,GridIDField,actsField, CommActsField:string;

begin

    if ( Tdbedit(sender).Field.DataSet.FieldByName('F15')<>nil) and (Tdbedit(sender).Field.DataSet.FieldByName('F18')<>nil) then
    begin
         ModelID:=Tdbedit(sender).Field.DataSet.FieldByName('F15').AsString;
         sql:=' select note,GridIDFieldName ,isnull(actsFieldName,'+quotedstr('')+')actsFieldName '
              +' from T702 where isnull(Note,'+quotedstr('')+')<>'+quotedstr('')
              +' and modelId='+tdbedit(Sender).Text  ;
         fhlknl1.Kl_GetQuery2(sql);

         if fhlknl1.FreeQuery.IsEmpty then
         begin
             showmessage('table,GridIDField,actsField   Error!');
             exit;
         end;
         table:=fhlknl1.FreeQuery.FieldByName('note').AsString   ;
         GridIDField:=fhlknl1.FreeQuery.FieldByName('GridIDFieldName').AsString   ;
         actsField  :=fhlknl1.FreeQuery.FieldByName('actsFieldName').AsString   ;
         if actsField<>'' then
         CommActsField:=','+actsField;

         sql:='select '+GridIDField +CommActsField+ ' From '+table  +' where f01='+Tdbedit(sender).Field.DataSet.FieldByName('F18').AsString ;
         fhlknl1.Kl_GetQuery2(sql);
         if fhlknl1.FreeQuery.IsEmpty then
         begin
             showmessage(sql+'  Error!');
             exit;
         end;

          Tdbedit(sender).Field.DataSet.FieldByName('F16').value:= fhlknl1.FreeQuery.FieldByName(GridIDField).Value ;
          Tdbedit(sender).Field.DataSet.FieldByName('F17').Value  := fhlknl1.FreeQuery.FieldByName(actsField).Value  ;

    end;

end;

procedure TdmFrm.actListFrmActsExecute(Sender: TObject);
var FrmActions:TFrmActions;
var modelID:integer;
var form:Tform;
begin
     if tdbedit(sender).Field.DataSet.fieldbyname('f15').AsString='' then exit;

     modelID:=tdbedit(sender).Field.DataSet.fieldbyname('f15').AsInteger ;

     FrmActions:=TFrmActions.Create(nil);


     case modelID of
     7: begin
             form:=TAnalyserFrm.Create(nil);
             FrmActions.InitFrm(TAnalyserFrm(form).ActionList1 ,tdbedit(sender).Field.DataSet.fieldbyname('f17').AsString );
             form.free;
        end;
     2: begin
             form:=TTreeGridfrm.Create(nil);
             FrmActions.InitFrm(TTreeGridfrm(form).ActionList1 ,tdbedit(sender).Field.DataSet.fieldbyname('f17').AsString  );
             form.free;
        end;
     end  ;

     if FrmActions.ShowModal=mrOk then
     begin
          tdbedit(sender).Text:=inttostr( FrmActions.SelectedIndex);
     end ;
     { }

     FrmActions.Free;
end;

procedure TdmFrm.actListFrmModelExecute(Sender: TObject);
var FrmActions:TFrmActions;
var ActionList1:TActionList;
begin
     FrmActions:=TFrmActions.Create (self);

     ActionList1:=TActionList.Create (self);

     FrmActions.InitFrm(DesktopFrm.ActionList1,'','FRM' );
     ActionList1.Free ;

     if FrmActions.ShowModal=mrOk then
     begin
          if  tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
          tdbedit(sender).Text:=inttostr( FrmActions.SelectedIndex);
     end ;

     FrmActions.Free;
end;


procedure TdmFrm.ActImagesExecute(Sender: TObject);
var FrmActions:TFrmActions;

begin

      FrmActions:=TFrmActions.Create (nil);
      FrmActions.InitFrmImageLst(self.ImageList1 );
      FrmActions.ShowModal;
      if  Tdbedit(Sender).Field.DataSet.State in [dsinsert,dsedit] then
      Tdbedit(Sender).Text :=trim(FrmActions.ImageSelIndex );

      FrmActions.Free ;
end;


procedure TdmFrm.ActUpdateBoolExecute(Sender: TObject);
begin
//
if sender is tdbgrid then
begin
   Tdbgrid(sender).DataSource.DataSet.Edit ;
   Tdbgrid(sender).DataSource.DataSet.FieldByName('f26').AsBoolean := not Tdbgrid(sender).DataSource.DataSet.FieldByName('f26').AsBoolean;
      Tdbgrid(sender).DataSource.DataSet.Post ; ;
end;
end;
procedure TdmFrm.ActGetBoxCrmTreeIDsExecute(Sender: TObject);
begin
if    Sender is Tdbedit then
     Tdbedit (Sender ).Text :=fhlknl1.GetMaxCode('T703','F01');
end;


procedure TdmFrm.ActGetMaxSubinterfaceIDExecute(Sender: TObject);
begin
if    Sender is Tdbedit then
     Tdbedit (Sender ).Text :=fhlknl1.GetMaxCode('T701','F01');
end;

procedure TdmFrm.LstModelActtionsExecute(Sender: TObject);
var FrmActions:TFrmActions;
var form:Tform;
var actions:Tstringlist;
var i:integer;
var values:string;
var ModelTable:string;
var FrmSelectMolde:Tform;
var CombSelectMolde:Tcombobox;
var strlst:Tstrings;
begin

     fhlknl1.Kl_GetQuery2 (' select F16 from T201 where f01='+inttostr(Tdbedit(Sender).Field.DataSet.tag ));
     if  fhlknl1.FreeQuery.IsEmpty then
     begin
         showmessage('error the dataset is empty');
         exit;
     end;
     ModelTable:=rightStr(trim(fhlknl1.FreeQuery.fieldbyname('F16').AsString) ,4);
     {
T602	cfg_Bill
T612	cfg_TreeGrid
T616	cfg_editor
T611	cfg_TreeEditor
T606	cfg_TabEditor
T601	cfg_analyser
T617	cfg_TabBoxGrid
T618	cfg_TabGrid
T619	cfg_More2More
T620	cfg_TreeMgr
T700	cfg_CRm
  }
                             
      FrmActions:=TFrmActions.Create (nil);
      FrmActions.PnlLeft.Visible :=true;
      with FrmActions do
      begin
        CombSelectMolde.Items.Add('T602=cfg_Bill')  ;
        CombSelectMolde.Items.Add('T612=cfg_TreeGrid')  ;
        CombSelectMolde.Items.Add('T616=cfg_editor')  ;
        CombSelectMolde.Items.Add('T611=cfg_TreeEditor')  ;
        CombSelectMolde.Items.Add('T606=cfg_TabEditor')  ;
        CombSelectMolde.Items.Add('T601=cfg_analyser')  ;
        CombSelectMolde.Items.Add('T617=cfg_TabBoxGrid')  ;
        CombSelectMolde.Items.Add('T618=cfg_TabGrid')  ;
        CombSelectMolde.Items.Add('T619=cfg_More2More')  ;
        CombSelectMolde.Items.Add('T620=cfg_TreeMgr')  ;
        CombSelectMolde.Items.Add('T700=cfg_CRm')  ;
        CombSelectMolde.Items.Add('T625=cfg_BillEx')  ;
        CombSelectMolde.Items.Add('T627=cfg_FrmImportOpen')  ;
        CombSelectMolde.Items.Add('T628=cfg_SerialNos')  ;
      end;

     actions:=Tstringlist.Create ;
//     if Sender is tdbedit then
     actions.CommaText :=     tdbedit (Sender).Text ;


     //bill
     if uppercase(ModelTable)  ='T602' then
     begin
             form:=TTreeGridfrm.Create(nil);
             form.Caption :='bill';
             FrmActions.InitFrm(TTreeGridfrm(form).ActionList1  );
             form.free;
     end;
     //TreeGrid
     if uppercase(ModelTable)  ='T612' then
     begin
             if        messagedlg('使用treeGrid?',mtInformation,[mbYes,mbNo],0 )=mryes then  //because crm model have used T612
             begin
                 form:=TTreeGridfrm.Create(nil);
                 form.Caption :='TreeGrid';
                 FrmActions.InitFrm(TTreeGridfrm(form).ActionList1  );
                 form.free;
             end
             else
             ModelTable:='T700';
     end;
// T616 cfg_editor
     if uppercase(ModelTable)  ='T616' then
     begin
             form:=TEditorFrm.Create(nil);
             form.Caption :='cfg_editor';
             FrmActions.InitFrm(TEditorFrm(form).ActionList1  );
             form.free;
     end;
// T611	cfg_TreeEditor
     if uppercase(ModelTable)  ='T611' then
     begin
         exit;
     end;

// T601	cfg_analyser
     if uppercase(ModelTable)  ='T601' then
     begin
             form.Caption :='cfg_analyser';
             form:=TanalyserFrm.Create(nil);
             FrmActions.InitFrm(TanalyserFrm(form).ActionList1  );
             form.free;
     end;

// T700	cfg_CRm TFrmCrm
     if uppercase(ModelTable)  ='T700' then
     begin
             form.Caption :='cfg_CRm';
             form:=TFrmCrm.Create(nil);
             FrmActions.InitFrm(TFrmCrm(form).actlstCRM   );
             form.free;
     end;


     for i:=0 to  actions.Count-1 do
     begin
         FrmActions.ActionGrid.Cells [2,strtoint(actions.Strings [i])]:='   √';
     end;
     actions.Free ;
     if FrmActions.ShowModal=mrOk then
     begin
        strlst:= Tstringlist.Create ;
        strlst:=FrmActions.ActionGrid.Rows[FrmActions.SelectedIndex];

        tdbedit(sender).Field.DataSet.FieldByName('F03').Value:=strlst[0];
        tdbedit(sender).Field.DataSet.FieldByName('F04').Value:=strlst[1];
        tdbedit(sender).Field.DataSet.FieldByName('F14').Value:=strlst[4];
        tdbedit(sender).Field.DataSet.FieldByName('F16').Value:=strlst[3];
        if  ( strtoint(strlst[4]) >=0) and ( strtoint(strlst[4])<10000) then
             tdbedit(sender).Field.DataSet.FieldByName('F21').AsBoolean :=true
        else
             tdbedit(sender).Field.DataSet.FieldByName('F21').AsBoolean :=false;
     end ;

     FrmActions.Free;
end;

procedure TdmFrm.ActGridUserMenuIDExecute(Sender: TObject);
var  TreeGridFrm:Tform;
var i:integer;
var GridUserMenuID,ID:string;

  BackupsysDb,BackUpUserDB:string;
begin
  self.PushGlobelContext( BackupsysDb,BackUpUserDB)   ;

  if not  logininfo.IsTool then
  dmfrm.ADOConnection1.DefaultDatabase:=DesktopFrm.dsMainMenu.FieldByName('subSysDBName').AsString;
  fhlknl1.Connection.DefaultDatabase :=logininfo.SysDBToolName ;

if Sender is Tdbedit then
begin
      if Tdbedit(sender).Text ='' then id:='1' else ID:=Tdbedit(sender).Text;
end;

    
    TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('56', ID,true );
    TreeGridFrm.ShowModal ;


    if Sender is Tdbedit then
    begin
        for i:=0 to TTreeGridFrm(TreeGridFrm ).ADODataSet1.RecordCount -1 do //('TreeIDS').
        begin
            if i=0 then
                GridUserMenuID:=    TTreeGridFrm(TreeGridFrm ).ADODataSet1.fieldbyname('F02').AsString
            else
            begin
                if GridUserMenuID<>   TTreeGridFrm(TreeGridFrm ).ADODataSet1.fieldbyname('F02').AsString then
                begin
                      Tdbedit(sender).Text :='-1' ;
                      freeandnil(TreeGridFrm );
                      exit;
                end;
            end;
            TTreeGridFrm(TreeGridFrm ).ADODataSet1.next;
        end;
        Tdbedit(sender).Text :=GridUserMenuID;
    end;
    freeandnil(TreeGridFrm );

self.PopGlobelContext(BackupsysDb,BackUpUserDB)  ;
end;
procedure TdmFrm.ActLstDataActionsExecute(Sender: TObject);
var FrmActions:TFrmActions;

begin
     FrmActions:=TFrmActions.Create (self);


     FrmActions.InitFrm(dmfrm.DataSetActionList1  );


     if FrmActions.ShowModal=mrOk then
     begin
          if  tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
          tdbedit(sender).Text:=inttostr( FrmActions.SelectedIndex);
     end ;

     FrmActions.Free;
end;

procedure TdmFrm.ActGridFontColorExecute(Sender: TObject);
var TreeGridFrm :Tform    ;
var i:integer;
var TreeIDS,ID:string;
begin
if Sender is Tdbedit then
begin
   if Tdbedit(sender).Text ='' then id:='1' else ID:=Tdbedit(sender).Text;
end;
if Sender is Tmenuitem then
begin
   id:=inttostr(Tpagecontrol (Tpopupmenu((Sender As Tmenuitem).Owner ).PopupComponent ).Tag );//
end;

   TreeGridFrm:=FhlUser.ShowModalTreeGridFrm('57',id,true );
   TTreeGridFrm(TreeGridFrm ).ShowModal ;


   
   if Sender is Tdbedit then
   begin
    for i:=0 to TTreeGridFrm(TreeGridFrm ).ADODataSet1.RecordCount -1 do //('TreeIDS').
    begin
        if i=0 then
            TreeIDS:=    TTreeGridFrm(TreeGridFrm ).ADODataSet1.fieldbyname('F01').AsString
        else
        begin
            if TreeIDS<>   TTreeGridFrm(TreeGridFrm ).ADODataSet1.fieldbyname('F01').AsString then
            begin
                  Tdbedit(sender).Text :=Tdbedit(sender).Text +'TreeIDS 不一致！' ;
                  freeandnil(TreeGridFrm );
                  exit;
            end;
        end;
        TTreeGridFrm(TreeGridFrm ).ADODataSet1.next;
    end;
    Tdbedit(sender).Text :=TreeIDS;
  end;

  freeandnil(TreeGridFrm );

end;




function TFhlUser.GetTableName(datasetID: string): string;
begin
             fhlknl1.Kl_GetQuery2('select * from T201 where f01='+datasetID);
        if not fhlknl1.FreeQuery.IsEmpty then
           result:=fhlknl1.FreeQuery.fieldbyname('F16').AsString ;
end;

function TFhlUser.AddDataSet(Name, TAbleName, CommandText: string;
  NeedAppend, NeedDefault: boolean): string;
begin

      fhlknl1.Kl_GetQuery2('select top 0 * from T201 ',true,true);
      fhlknl1.FreeQuery.Append ;
      fhlknl1.FreeQuery.FieldByName('f02').Value :=name;        //Name
      fhlknl1.FreeQuery.FieldByName('f16').Value :=TAbleName;        //table
      fhlknl1.FreeQuery.FieldByName('f03').Value :=CommandText;

      fhlknl1.FreeQuery.FieldByName('f04').Value :=0;
      if NeedAppend then
         fhlknl1.FreeQuery.FieldByName('f05').Value :=1
      else
         fhlknl1.FreeQuery.FieldByName('f05').Value :=0;

      if NeedDefault then
      begin
          fhlknl1.FreeQuery.FieldByName('f09').Value :=4;
          fhlknl1.FreeQuery.FieldByName('f10').Value :=2;
      end
      else
      begin
          fhlknl1.FreeQuery.FieldByName('f09').Value :=-1;
          fhlknl1.FreeQuery.FieldByName('f10').Value :=-1;
      end;

      fhlknl1.FreeQuery.FieldByName('f11').Value :=-1;
      fhlknl1.FreeQuery.FieldByName('f12').Value :=-1;
      fhlknl1.FreeQuery.FieldByName('f14').Value :=-1;
      fhlknl1.FreeQuery.FieldByName('f15').Value :=-1;
      fhlknl1.FreeQuery.Post ;
      result:=fhlknl1.FreeQuery.FieldByName('f01').Value; //tree data set Id

end;

function TFhlUser.AddGrid(name, datasetID: string): string;
begin
      fhlknl1.Kl_GetQuery2('select top 0 * from T504 ',true,true);
      fhlknl1.FreeQuery.Append ;
      fhlknl1.FreeQuery.FieldByName('F02').Value :=name;
      fhlknl1.FreeQuery.FieldByName('F03').Value :=datasetID;
      fhlknl1.FreeQuery.Post ;
      result:=fhlknl1.FreeQuery.FieldByName('f01').Value; //tree data set Id
end;

function TFhlUser.AddSubInterFace(name, SubInterFaceID, ModelTypeID,
  TreeGridID, EditorID: string): string;
begin
      fhlknl1.Kl_GetQuery2('select top 0 * from T701 ',true,true);
      fhlknl1.FreeQuery.Append ;
      fhlknl1.FreeQuery.FieldByName('SubInterFaceID').Value :=SubInterFaceID;
      fhlknl1.FreeQuery.FieldByName('SubInterFaceName').Value :=Name;
      fhlknl1.FreeQuery.FieldByName('ModelTypeID').Value :=ModelTypeID;
      fhlknl1.FreeQuery.FieldByName('TreeGridID').Value :=TreeGridID;
      fhlknl1.FreeQuery.FieldByName('EditorID').Value :=EditorID;
      fhlknl1.FreeQuery.FieldByName('IsUse').Value :=true;
      fhlknl1.FreeQuery.FieldByName('Findex').Value :=10;
      fhlknl1.FreeQuery.Post ;
      result:=SubInterFaceID; //tree data set Id
end;

function TFhlUser.AddTreeGrid(name, GridID, EditorID, Actions: string;
  TreeID: integer): string;
begin
      fhlknl1.Kl_GetQuery2('select top 0 * from T612 ',true,true);
      fhlknl1.FreeQuery.Append ;
      fhlknl1.FreeQuery.FieldByName('F02').Value :=name;
      fhlknl1.FreeQuery.FieldByName('F04').Value :=GridID;
      fhlknl1.FreeQuery.FieldByName('F05').Value :=EditorID;
      fhlknl1.FreeQuery.FieldByName('F11').Value :=true;
      fhlknl1.FreeQuery.FieldByName('F09').Value :=Actions;
      if TreeID<>null then
      fhlknl1.FreeQuery.FieldByName('F16').Value :=TreeID;
      fhlknl1.FreeQuery.Post ;
      result:=fhlknl1.FreeQuery.FieldByName('f01').Value; //tree data set Id
end;

function TFhlUser.SetDbGrid(ADbGridId: String; ADbGrid: TDbGrid;
  EditBtnClick: Taction): String;
begin
  ADbGrid.OnEditButtonClick:=EditBtnClick.OnExecute ;
  Result:=FhlKnl1.Cf_SetDbGrid(ADbGridId,ADbGrid);
end;
procedure TFhlUser.changeUserDataBase(UserDbName: string);
begin
    dmfrm.ADOConnection1.DefaultDatabase :=   UserDbName;
    fhlknl1.SetUserDataBase(UserDbName);
end;

procedure TdmFrm.PopGlobelContext(var PSysDb, PUserDB: string);
begin
   dmfrm.ADOConnection1.DefaultDatabase :=PSysDb;
  fhlknl1.Connection.DefaultDatabase :=PUserDB;
  logininfo.IsTool :=false;

end;

procedure TdmFrm.PushGlobelContext(var PSysDb, PUserDB: string);
begin

  PSysDb:=dmfrm.ADOConnection1.DefaultDatabase ;
  PUserDB:=fhlknl1.Connection.DefaultDatabase ;
  logininfo.IsTool :=true;
end;

procedure TdmFrm.actCheckReferenceExecute(Sender: TObject);
var RRef:String;
begin
if   FhlKnl1.Ds_CheckReference(TDataSet(Sender),RRef) then
begin
    MessageDlg(RRef+''+#13#10#13#10+'不能删除!',mtWarning,[mbOk],0);
    abort;
end;

end;


procedure TdmFrm.ActGatheringDataExecute(Sender: TObject);
var asql,clientID:string;
var mon_cls_entry ,Cls_Entry_Months :integer;
var dlgmsg:string;
var InvoiceDate:Tdatetime;
var GatheringEmp :string;
var fld:Tfield;
begin


   if sender is Tdbedit then
     if (Tdbedit(sender).Field <>nil) and (Tdbedit(sender).Field.DataSet.Active) and (Tdbedit(sender).Field.DataSet.CanModify) and ( Tadodataset(Tdbedit(sender).Field.DataSet).LockType <>ltReadOnly) then
       if Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
         if (Tdbedit(sender).Field.DataSet.FindField ('GetFund')<>nil ) and (Tdbedit(sender).Field.DataSet.FindField ('PayFund')<>nil )  then
           if (Tdbedit(sender).Field.DataSet.Fieldbyname ('GetFund').AsInteger =Tdbedit(sender).Field.DataSet.Fieldbyname ('PayFund').AsInteger)  and (Tdbedit(sender).Field.DataSet.Fieldbyname ('PayFund').AsInteger<>0 )then       //现金
           begin
                  Tdbedit(sender).Field.Value:=FormatDateTime('yyyy-mm-dd',today);

                  clientID:=   tdbedit(Sender).Field.DataSet.FieldByName('ClientID').Value;
                  asql:='select *From crm_Client where  code='+quotedstr(clientID);
                  dmfrm.GetQuery1(asql);

                  if not dmfrm.FreeQuery1.IsEmpty then
                  begin
                        GatheringEmp:= dmfrm.FreeQuery1.Fieldbyname('GatheringEmp').AsString      ;
                        if not (tdbedit(Sender).Field.DataSet.State  in [dsEdit, dsInsert] )then
                        tdbedit(Sender).Field.DataSet.Edit ;
                        if GatheringEmp <>'' then
                        begin

                            tdbedit(Sender).Field.DataSet.FieldByName('GatheringEmp').AsString := GatheringEmp;
//                            tdbedit(Sender).Field.DataSet.FieldByName('GatheringEmp').
                        end
                        else
                            tdbedit(Sender).Field.DataSet.FieldByName('GatheringEmp').AsString := fhluser.GetSysParamVal('sEmpid');
                  end;
                  exit;
            end;


    if    Sender is tdbedit then
    begin
        if (Sender as tdbedit).Field.DataSet.findField ('InvoiceDate') <>nil then
            if (Sender as tdbedit).Field.DataSet.Fieldbyname ('InvoiceDate').Value =null then
            begin
                showmessage('请先选择发货日期！');
                exit;
            end
            else
            begin
                InvoiceDate:=(Sender as tdbedit).Field.DataSet.Fieldbyname ('InvoiceDate').AsDateTime ;

            end;


        if   tdbedit(Sender).Field.DataSet.FieldByName('ClientID').Value =null then
        begin
            showmessage('请先选择客户');
            exit;
        end
        else
        begin
           clientID:=   tdbedit(Sender).Field.DataSet.FieldByName('ClientID').Value;
           asql:='select *From crm_Client where  code='+quotedstr(clientID);
            dmfrm.GetQuery1(asql);
            if not dmfrm.FreeQuery1.IsEmpty then
            begin
               GatheringEmp:= dmfrm.FreeQuery1.Fieldbyname('GatheringEmp').AsString      ;
               if not (tdbedit(Sender).Field.DataSet.State  in [dsEdit, dsInsert] )then
                       tdbedit(Sender).Field.DataSet.Edit ;
               if GatheringEmp <>'' then
               begin
                   tdbedit(Sender).Field.DataSet.FieldByName('GatheringEmp').AsString := GatheringEmp;
               end
               else
                   tdbedit(Sender).Field.DataSet.FieldByName('GatheringEmp').AsString := fhluser.GetSysParamVal('sEmpid');



               if   (dmfrm.FreeQuery1.FieldValues ['Cls_Entry_Months']=null )or (dmfrm.FreeQuery1.FieldValues ['mon_cls_entry'  ]=null) then
                begin
                    //showmessage('该客户月结日期设置有误请改正');
                end
                else
                begin
                    mon_cls_entry  :=dmfrm.FreeQuery1.FieldValues ['mon_cls_entry'  ];
                    Cls_Entry_Months:=dmfrm.FreeQuery1.FieldValues ['Cls_Entry_Months'  ];
                end;

               if ((mon_cls_entry>31) or   (mon_cls_entry<1)) then
               begin
                   showmessage('结帐日期为'+inttostr(mon_cls_entry)+' 日，每'+inttostr(Cls_Entry_Months)+'个月结一次。 请到客户资料更正.');
                   self.ActSelGatheringDate.OnExecute (Sender);
                   exit;
               end;
               if  not ( tdbedit(Sender).Field.DataSet.State  in [dsEdit, dsInsert] )then
                 tdbedit(Sender).Field.DataSet.Edit ;

               if Cls_Entry_Months<>0 then
                  dlgmsg:='该公司结帐日期'+inttostr(mon_cls_entry)+'日'+'，每'+inttostr(Cls_Entry_Months)+'个月结一次。需要自动计算付款日期。'
               else
                  dlgmsg:='该公司结帐日期为本月 '+inttostr(mon_cls_entry)+'日';

               if messagedlg(dlgmsg,mtInformation,[mbYes,mbNo],0)=mryes then
               begin
                   tdbedit(Sender).Field.Value :=self.GetGatheringDate(mon_cls_entry,Cls_Entry_Months,InvoiceDate)    ;
                   exit;
               end;
            end ;
            self.ActSelGatheringDate.OnExecute (Sender);
        end;
    end;
end;


 function TdmFrm.GetGatheringDate(pday: integer;PaySpan:integer;SourceDay:Tdatetime): Tdatetime;
var tmpdate:Tdatetime;
var lastDateOFMonth:integer;
begin
//PaySpan 数月天数


  if not ((pday<1) or (pday>31)) then
  begin
      if dayof(SourceDay )>pday then
      begin
          tmpdate:=incmonth(SourceDay,+PaySpan+1);
      end
      else
      begin
          tmpdate:=incmonth(SourceDay,+PaySpan);
      end;
      lastDateOFMonth :=  FhlKnl1.GetLastDateForMonth(tmpdate) ;
      if ( pday>   lastDateOFMonth)    then
          pday :=   lastDateOFMonth;

      result:=strtodate(  formatdatetime('yyyy''-''mm', tmpdate)+'-'+inttostr(pday));
  end;
end;

procedure TdmFrm.ActPingYinExecute(Sender: TObject);
begin
if sender is Tdbedit then
   if Tdbedit(sender).Field.DataSet.State in [dsinsert ,dsedit] then
      if Tdbedit(sender).Field.DataSet.FindField('nickname')<>nil then
     Tdbedit(sender).Field.DataSet.fieldbyname('nickname').AsString    :=GetHZPY(Tdbedit(sender).Field.Value);
end;

procedure TdmFrm.ActChkDuplicateClientExecute(Sender: TObject);
var param:string;
var ClientID:string;
begin


if not (Sender  is Tdbedit) then exit
else
begin
     param:=Tdbedit(Sender).Text    ;
     if     Tdbedit(Sender).Text=''then exit;
     if Tdbedit(Sender).Field.DataSet.FindField('code')<>nil then
        ClientID:=Tdbedit(Sender).Field.DataSet.Fieldbyname('code').asstring;

     if Tdbedit(Sender).Field.DataSet.FindField('F_CltCode')<>nil then
        ClientID:=Tdbedit(Sender).Field.DataSet.Fieldbyname('F_CltCode').asstring;

     param:=param+','  +ClientID;
end;

     if param<>'' then
     begin
      Screen.Cursor:=crAppStart;
           try
              TabGridFrm:=TTabGridFrm.Create(application);
              TabGridFrm.Hide;
              TabGridFrm.Caption :='发现重复客户';

              fhluser.SetDbGridAndDataSet( TabGridFrm.DBGrid1,'671', param,true);

               if   not TabGridFrm.ADODataSet1.IsEmpty then
              //  TabGridFrm.ShowModal;
              begin
                 showmessage('可能存在重复客户，请与管理员联系！');
                // exit;
              end;

              ActPingYin.OnExecute (sender);
           finally
              FreeAndNil(TabGridFrm);
              Screen.Cursor:=crDefault;
           end;
     end;

end;


procedure TdmFrm.ActSelGatheringDateExecute(Sender: TObject);
var FrmSelDate:TFrmSelDate;
begin

   FrmSelDate:=TFrmSelDate.Create (nil);
   FrmSelDate.Caption :='设定付款日期';
   FrmSelDate.iniFrm ('1,5,7,15,30,45,60,75','天后付款!  ');
   if FrmSelDate.ShowModal  =mrok then
      if sender is Tdbedit then
         if Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
           if Tdbedit(sender).Field.DataSet.FindField ('InvoiceDate')<>nil then
             if FrmSelDate.cmbdate.text<>'' then
              Tdbedit(sender).Field.Value:=FormatDateTime('yyyy-mm-dd', Tdbedit(sender).Field.DataSet.Fieldbyname('InvoiceDate').AsDateTime+strtoint( FrmSelDate.cmbdate.text));

end;

procedure TdmFrm.ActGetAccountNamePayExecute(Sender: TObject);
var com:Tcomponent;
begin
TreeDlgFrmShowAction1.OnExecute (sender);


if Sender  is tdbedit then
   if (Sender  as tdbedit).Field.DataSet.FindField ('ItemID')<>nil then
     if  (Sender  as tdbedit).Field.DataSet.Fieldbyname('ItemID').AsString ='0100' then
     begin
         if (Sender  as tdbedit).Parent.FindComponent('DBChk'+'IsTax') <>nil then
         begin
            //TDBCheckBox(Sender  as tdbedit).Field.DataSet.FieldByName(TDBCheckBox(Sender  as tdbedit).Field.FullName ).Value    :=null  ;

            TDBCheckBox((Sender  as tdbedit).Parent.FindComponent('DBChk'+'IsTax')).Visible   :=true;

         end;
     end
     else
     begin
         if (Sender  as tdbedit).Parent.FindComponent('DBChk'+'IsTax') <>nil then
         begin
           //(Sender  as tdbedit).Field.Value :=null;  //    2007-1-17
            TDBCheckBox((Sender  as tdbedit).Parent.FindComponent('DBChk'+'IsTax')).Visible :=false;
         end;
     end
   {  }
end;

procedure TdmFrm.ActGetAccountNameGatherExecute(Sender: TObject);
   var com:Tcomponent;

begin
TreeDlgFrmShowAction1.OnExecute (sender);
if Sender  is tdbedit then
   if (Sender  as tdbedit).Field.DataSet.FindField ('ItemID')<>nil then
     if  ((Sender  as tdbedit).Field.DataSet.Fieldbyname('ItemID').AsString ='0101')or((Sender  as tdbedit).Field.DataSet.Fieldbyname('ItemID').AsString ='011201') then
     begin
         if (Sender  as tdbedit).Parent.FindComponent('DBChk'+'IsTax') <>nil then
            TDBCheckBox((Sender  as tdbedit).Parent.FindComponent('DBChk'+'IsTax')).Visible   :=false;
     end
     else
     begin
         if (Sender  as tdbedit).Parent.FindComponent('DBChk'+'IsTax') <>nil then
         begin
           // (Sender  as tdbedit).Field.Value :=null;     2007-1-17
            TDBCheckBox((Sender  as tdbedit).Parent.FindComponent('DBChk'+'IsTax')).Visible :=true;
         end;
     end

end;

procedure TdmFrm.ActInvoiceRefsExecute(Sender: TObject);
 var fld:TField;
 var params:string;
begin
  Screen.Cursor:=crSqlwait;
 try
  if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
  else
     fld:=TDbEdit(Sender).Field;
  if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
  begin
     if fld.DataSet.FindField('ClientID')<>nil then
        params:=fld.DataSet.Fieldbyname('ClientID').AsString ;

     with TLookupFrm.Create(Application) do
     begin
       InitFrm(params,fld);
       if Sender is tdbedit  then
       Edit1.Text:=(Sender as tdbedit   ).Text ;       
       ShowModal;
       free;
     end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;

 if Sender is Tedit then
 TEdit(Sender).Modified:=False;

end;

procedure TdmFrm.ActT401Execute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrm('88', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);


end;

procedure TdmFrm.ActFormalInvoiceCalcExecute(Sender: TObject);
begin
  with TDataSet(Sender) do
  begin
  //  if   ( FieldByName('qty').asCurrency<>0) and (FieldByName('price').asCurrency<>0) then
    FieldByName('amt').AsCurrency :=FieldByName('qty').asCurrency*FieldByName('price').asCurrency;
  end;
end;

procedure TdmFrm.ActListCrmLinkManExecute(Sender: TObject);
var sql:string;
var CltCode:string;
var i:integer;
begin
    if sender is Tdbcombobox then
    begin
        if Tdbcombobox(sender).Items.Count >0 then exit; 
        if Tdbcombobox(sender).Field.DataSet.FindField('F_cltCode')<>nil then
        begin
          if Tdbcombobox(sender).Field.DataSet.Fieldbyname('F_cltCode').AsString <>''  then
          begin
               CltCode:=Tdbcombobox(sender).Field.DataSet.Fieldbyname('F_cltCode').AsString;
               sql:='select F_linkManName From T_linkman where F_cltCode='+quotedstr(CltCode);
               self.GetQuery1(sql);
               if not  self.FreeQuery1.IsEmpty then
               begin
                     for i:=0 to self.FreeQuery1.RecordCount -1 do
                     begin
                         Tdbcombobox(sender).Items.Add ( self.FreeQuery1.FieldByName('F_linkManName').AsString );
                         self.FreeQuery1.Next ;
                     end;
               end;
          end
          else
          begin
              showmessage('');
              exit;
          end;
        end;
    end;
end;

procedure TdmFrm.ActTreeGridOpenParamsExecute(Sender: TObject);
VAR frmeditor:Tform;
begin
//
      if Sender is Tdbtext then
      begin

          frmeditor:=FhlUser.ShowEditorFrm('56', Tdbtext(sender).Caption  );//.Showmodal;
          sDefaultVals:='';
          sDefaultVals:='f01='+Tdbtext(sender).Caption ;
          frmeditor.ShowmodAl ;

          freeandnil(frmeditor);
      end;
end;

procedure TdmFrm.ActIsSameWareExecute(Sender: TObject);
var sPartno,sBrand,sOrigin:string;
var DPartno,DBrand,DOrigin:string;


begin
    if   ( Sender is Tdbedit)   then
    begin
        sPartno:=Tdbedit(Sender).Field.DataSet.fieldbyname('strc').AsString  ;
        sBrand :=Tdbedit(Sender).Field.DataSet.fieldbyname('strd').AsString  ;
        sOrigin:=Tdbedit(Sender).Field.DataSet.fieldbyname('strf').AsString  ;

        DPartno:=Tdbedit(Sender).Field.DataSet.fieldbyname('Partno').AsString  ;
        DBrand :=Tdbedit(Sender).Field.DataSet.fieldbyname('Brand').AsString  ;
        DOrigin:=Tdbedit(Sender).Field.DataSet.fieldbyname('brief').AsString  ;

        if (uppercase(sPartno)=uppercase(DPartno)) and  (uppercase(sBrand)=uppercase(DBrand)) and (uppercase(sOrigin)=uppercase(DOrigin)) then
            showmessage('您选择的选择的资料与错误的资料相同 ， 请重新选择。') ;
            Tdbedit(Sender).SetFocus ;
            exit;
    end;

end;

Function TdmFrm.GetOldDbName(CurrentDbName:string):string;
var sql:string;
begin
//
    sql:=' select * From TUserDBs  where currentdb='+quotedstr(CurrentDbName)+' and olddbname=1 '   ;
    fhlknl1.Kl_GetQuery2(sql);
    if not fhlknl1.FreeQuery.IsEmpty then
    begin
       logininfo.sLocalOldUserDB :=fhlknl1.FreeQuery.fieldbyname('Olddb').AsString ;
       result:=logininfo.sLocalOldUserDB ;

    end
    else
    begin
      showmessage('获取老帐套参数错误');
      exit;
    end;


end;

 

procedure TdmFrm.MExportToExcelClick(Sender: TObject);
var PopDbgrid:Tdbgrid;
begin
  PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
  QExportExcel(PopDbgrid,TForm(PopDbgrid.Parent).Caption+formatdatetime('yyyymmdd',now), true);

end;



procedure TdmFrm.ActT407Execute(Sender: TObject);
var frmeditor:Tform;
begin
   if Sender is Tdbedit then
    frmeditor:=FhlUser.ShowEditorFrm('92', Tdbedit(sender).Text );
    frmeditor.Showmodal          ;
        if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TEditorFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TEditorFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.AcT525ButtonsExecute(Sender: TObject);
var frmeditor:Tform;
begin
if sender is Tdbedit then
    frmeditor:=FhlUser.ShowModalTreeGridFrm('60',Tdbedit(sender).Text ,true);
    frmeditor.ShowModal ;

    if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TTreeGridFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TTreeGridFrm(frmeditor).ADODataSet1.FieldByName('F02').AsString ;

    freeandnil(frmeditor);
end;

procedure TdmFrm.ActImportT627Execute(Sender: TObject);
var frmeditor:Tform;
begin
if sender is Tdbedit then
    frmeditor:=FhlUser.ShowModalTreeGridFrm('61',Tdbedit(sender).Text ,true);
    frmeditor.ShowModal ;

    if   Tdbedit(sender).Field.DataSet.State in [dsinsert,dsedit] then
        if   not TTreeGridFrm(frmeditor).ADODataSet1.IsEmpty then
        Tdbedit(sender).Text :=TTreeGridFrm(frmeditor).ADODataSet1.FieldByName('F01').AsString ;

    freeandnil(frmeditor);

end;

procedure TFhlUser.ShowAnalyserExFrm(AFrmId: String; AmtParams: Variant;
  pFormStyle: TFormStyle);
begin
 Screen.Cursor:=crAppStart;
 try
  with TAnalyseEx.Create(Application) do
  begin
    //formstyle:=pFormStyle;
    InitFrm(AFrmId,AmtParams);
    if    desktopfrm.dsMainMenu.FindField('subSysDBName')<>nil then
    SetSubSysName(desktopfrm.dsMainMenu.FieldByName('subSysDBName').AsString);

    Show;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TdmFrm.ActBarCodeQtyExecute(Sender: TObject);
var dateset:TDataset;
begin
 Screen.Cursor:=crSqlwait;
 try
  if Sender is TAction then
  begin
     dateset:=TDbGrid(TAction(Sender).ActionComponent).DataSource.DataSet;
     if ((dateset.State in [dsBrowse,dsedit,dsinsert])   ) then
     begin
         SetFQtyItems(  dateset, true);
     end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TdmFrm.ActBarCodeListExecute(Sender: TObject);
var dateset:TDataset;
var frm:TfrmBarCodeList;
begin
 Screen.Cursor:=crSqlwait;
 try
  if Sender is TAction then
  begin
     dateset:=TDbGrid(TAction(Sender).ActionComponent).DataSource.DataSet;
     if ( dateset.FieldByName('FBarCodeList').Value<>null ) then
     begin
         frm:= TfrmBarCodeList.Create(nil);
         frm.initialData(dateset.FieldByName('FBarCodeList').AsString);
         frm.ShowModal ;

     end;
  end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;


procedure TFhlUser.CheckToolButtonRight(ActID: String; ButtonName: string);
var rgtid :string;
begin
     fhlknl1.Kl_GetQuery2(' select  f13 From T525 where f02='+ActID+' and f03=  '+quotedstr(ButtonName));
      if fhlknl1.FreeQuery.RecordCount=1 then
      begin
          with  fhlknl1.FreeQuery do
          begin
             rgtid :=FieldByName('f13').AsString;
          end;
      end;
      fhlknl1.FreeQuery.Close;

      CheckRight(rgtid);
end;

procedure TdmFrm.uLookupFrmShowAction1Execute(Sender: TObject);
var fld:TField;
    TmpLookupFrm:TLookupFrm;
begin
  TmpLookupFrm:=nil;
  Screen.Cursor:=crSqlwait;
 try
  if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
  else
     fld:=TDbEdit(Sender).Field;
  if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
  begin
     if (Sender is TFhlDbEdit) then
     TmpLookupFrm:=  ((Sender as TFhlDbEdit).LookupFrm as TLookupFrm) ;

     if TmpLookupFrm=nil then
     begin
       TmpLookupFrm:= TLookupFrm.Create(sender as TComponent)  ;
       TmpLookupFrm.InitFrm(fld);
       if (Sender is TFhlDbEdit) then
          (Sender as TFhlDbEdit).LookupFrm:=TmpLookupFrm;
     end
     else
        TmpLookupFrm.RefreshLookupDataSet  ;

     if Sender is tdbedit  then
        TmpLookupFrm.Edit1.Text:=(Sender as tdbedit   ).Text ;
     TmpLookupFrm.ShowModal;

  end;
 finally
  Screen.Cursor:=crDefault;
 end;

 if Sender is Tedit then
 TEdit(Sender).Modified:=False;
end;
procedure TdmFrm.uTreeDlgFrmShowAction1Execute(Sender: TObject);
 var fld:TField;
begin
 Screen.Cursor:=crSqlwait;
 try
       if Sender is TAction then
          fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
       else
          fld:=TDbEdit(Sender).Field;

       if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
       begin
           with TTreeDlgFrm.Create(Application) do
           begin
             InitFrm(fld);
             ShowModal;
             free;
           end;
       end;
 finally
      Screen.Cursor:=crDefault;
 end;
end;

procedure TdmFrm.uDateFrmShowAction1Execute(Sender: TObject);
var
  fld:TField;
  dt:TDate;
begin
  if Sender is TAction then
     fld:=TDbGrid(TAction(Sender).ActionComponent).SelectedField
  else
     fld:=TDbEdit(Sender).Field;
  if (fld<>nil) and (fld.DataSet.Active) and (fld.DataSet.CanModify) and (not fld.ReadOnly) then
  begin
    if fld.asString<>'' then
      dt:=fld.asDateTime
    else
      dt:=Now;
    if FhlKnl1.Md_ShowDateFrm(dt)=mrOk then
    begin
      if not (fld.DataSet.State=dsInsert) and Not (fld.DataSet.State=dsEdit) then
         fld.DataSet.Edit;
      if fld.DataType=ftDate then
         fld.asString:=formatdatetime('yyyy"-"mm"-"dd',dt)
      else if fld.DataType=ftDateTime then
         fld.AsString:=formatdatetime('yyyy"-"mm"-"dd',dt)+' '+formatdatetime('hh":"nn":"ss',Now);
    end;
  end;
end;
procedure TdmFrm.uDbGridEditBtnClickAction1Execute(Sender: TObject);
begin
  with DbCtrlActionList1.Actions[FhlKnl1.Dg_GetDbGrdEdtActnId(TDbGrid(Sender))] do
  begin
      ActionComponent:=TComponent(Sender);
      Execute;
  end;
end;

procedure TdmFrm.ActGetPingYinExecute(Sender: TObject);
begin
 if  Sender is Tdbedit then
    begin
        if Tdbedit(Sender).Field.DataSet.FindField('FPhoneticize')<>nil then
             if  Tdbedit(Sender).Field.DataSet.State in[dsEdit, dsInsert] then
             begin
                Tdbedit(Sender).Field.DataSet.FindField('FPhoneticize').AsString  := GetHZPY( Tdbedit(Sender).text);
                if Tdbedit(Sender).Field.DataSet.FindField('FPhoneticize').AsString  ='' then
                begin
                    fhlknl1.Kl_GetUserQuery(' select dbo.FN_GetPhoneticize (' + quotedstr(Tdbedit(Sender).text) +')') ;
                    Tdbedit(Sender).Field.DataSet.FindField('FPhoneticize').AsString:=fhlknl1.User_Query.Fields[0].AsString ;
                end;

             end;
    //    else           showmessage('这个表里没有拼音字段.');

    end;
end;

procedure TdmFrm.ActBeforPostExecute(Sender: TObject);
begin
TFrmBillEx(TComponent(Sender).Owner).mtDataSet1.Edit;
TFrmBillEx(TComponent(Sender).Owner).mtDataSet1.FieldByName('GetFund').Value :=null;
 
end;

procedure TdmFrm.ActGetResistenceExecute(Sender: TObject);
begin
 if  Sender is Tdbedit then
    begin
        if Tdbedit(Sender).Field.DataSet.FindField('RsSurfix')<>nil then
             if  Tdbedit(Sender).Field.DataSet.State in[dsEdit, dsInsert] then
             begin

                if Tdbedit(Sender).Field.DataSet.FindField('RsSurfix').AsString  ='' then
                begin
                    fhlknl1.Kl_GetUserQuery(' select dbo.FN_GetResistance  (' + quotedstr(Tdbedit(Sender).text) +')') ;
                    Tdbedit(Sender).Field.DataSet.FindField('RsSurfix').AsString:=fhlknl1.User_Query.Fields[0].AsString ;
                end;

             end;
    //    else           showmessage('这个表里没有拼音字段.');

    end;
end;



procedure TdmFrm.DbGridPopupMenu1Popup(Sender: TObject);
var MClearFilter:Tmenuitem;
begin
  if tdbgrid( (Tpopupmenu(  sender ).PopupComponent )).DataSource=nil then Exit;
  if  tdbgrid( (Tpopupmenu(  sender ).PopupComponent )).DataSource.DataSet.Active then 
      if  tdbgrid( (Tpopupmenu(  sender ).PopupComponent )).DataSource.DataSet.Filter <>'' then
      begin
        if (Tpopupmenu( sender )).Items.Find('取消过滤')=nil then
        begin
          MClearFilter:=Tmenuitem.Create (Tpopupmenu( sender ));
          MClearFilter.Name :='MClearFilter';
          MClearFilter.Caption :='取消过滤';
          MClearFilter.OnClick := ClearFilter;
           Tpopupmenu(  sender ).Items.Insert(0, MClearFilter) ;
        end;
      end;
//ExportExcel.Visible  := logininfo.isAdmin or logininfo.Sys  ;
end;
 

procedure TdmFrm.ClearFilter(sender: Tobject);
var MClearFilter:Tmenuitem;
begin
  Tdbgrid((Tpopupmenu(Tmenuitem(sender).Owner )).PopupComponent ).DataSource.DataSet.Filter :='';
  Tdbgrid((Tpopupmenu(Tmenuitem(sender).Owner )).PopupComponent ).DataSource.DataSet.Filtered  :=true;

  MClearFilter:=Tpopupmenu(Tmenuitem(sender).Owner ).Items[0];
//  if MClearFilter.Caption :=''
  MClearFilter.Free ;
end;


function TFhlUser.GetReportGUID( f_firmCode:string  ): string;
var reportID:string;
begin
     fhlknl1.Kl_GetUserQuery (' select  f_id From T_TranFirm  where f_firmCode=  '+quotedstr( f_firmCode ) );
      if fhlknl1.User_Query.RecordCount=1 then
      begin
          with  fhlknl1.User_Query do
          begin
             reportID :=FieldByName('f_id').AsString;
          end;
      end;

      result:=reportID;
end;

procedure TdmFrm.SetFQtyItems(dataset: TDataSet; SetQty:Boolean);
var frm:TfrmBarCodeQty;
begin
  frm:= TfrmBarCodeQty.Create(nil);
  if dataset.FieldByName('FQtyItems').Value <>null then
      frm.initialData(dataset.FieldByName('FQtyItems').AsString,dataset.FieldByName('FPackageQty').Value );

  if frm.ShowModal =  mrOK then
  begin
    dataset.Edit;
    dataset.FieldByName('FQtyItems').Value :=frm.QtyItems;

    if SetQty and (dataset.FindField('qty')<>nil) then
        dataset.FieldByName('qty').Value :=frm.SumQty;
    dataset.FieldByName('FPackageQty').Value :=frm.PackageQty;
    dataset.Post;
  end;
end;

procedure TdmFrm.ActSetQtyitemsExecute(Sender: TObject);
var dateset:TDataset;
begin
 Screen.Cursor:=crSqlwait;
 try
    if Sender is TFhlDbEdit then
        dateset:=TFhlDbEdit(Sender).DataSource.DataSet;
    if Sender is TDbMemo then
        dateset:=TDbMemo(Sender).DataSource.DataSet;

     if ((dateset.State in [dsBrowse,dsedit,dsinsert])   ) then
     begin
         SetFQtyItems(  dateset ,false );
     end;

 finally
  Screen.Cursor:=crDefault;
 end;
end;

end.



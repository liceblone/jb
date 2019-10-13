unit UnitLookUpImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,     UnitCommonInterface,    UnitSearchBarCode,
  Dialogs, ComCtrls, Grids, DBGrids, StdCtrls, ToolWin, DB,DBCtrls, ADODB, ActnList,FhlKnl,UPublicCtrl,  UPublicFunction,Menus,
  Buttons,UnitGrid, ExtCtrls;

type
  TFrmLoopUpImPortEx = class(TForm,IParentSearch)
    ScrollTop: TScrollBox;
    Label3: TLabel;
    TreeView1: TTreeView;
    ActionList1: TActionList;
    mtDataSource1: TDataSource;
    mtDataSet1: TADODataSet;
    DlDataSource1: TDataSource;
    dlDataSet1: TADODataSet;
    TreeDataSet: TADODataSet;
    OpnDlDsBtn1: TSpeedButton;
    ActClose: TAction;
    ActFreeDeliveFee: TAction;
    ActPick: TAction;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    pnlGd: TPanel;
    actPickALL: TAction;
    tmrQry: TTimer;
    LocateAction: TAction;
    SortAction1: TAction;
    GetAction1: TAction;
    MoveAction1: TAction;
    YDWarePropAction1: TAction;
    GetActMultiSel: TAction;
    phQuoteAction1: TAction;
    NewWareAction1: TAction;
    phOrderdlAction1: TAction;
    slPriceOutRfsAction1: TAction;
    slPriceInRfsAction1: TAction;
    WarePropAction1: TAction;
    actPackPic: TAction;
    actBrandPic: TAction;
    actShowPriceChange: TAction;
    ActNewSaleRefs: TAction;
    ActNewInRefs: TAction;
    ScrollBoxCtrlPanel: TScrollBox;
    ActBarCodeSearch: TAction;
    GrpBarCode: TScrollBox;
    lblTitle: TLabel;
    statLabel1: TLabel;
    ActSaleQtyStatus: TAction;
    procedure ActCloseExecute(Sender: TObject);
    procedure DBGridDLDblClick(Sender: TObject);
    procedure OpnDlDsBtn1Click(Sender: TObject);

   procedure DBGrid1DrawColumnCellFntClr(Sender: TObject;
     const Rect: TRect; DataCol: Integer; Column: TColumn;
     State: TGridDrawState);
    procedure ActPickExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPickALLExecute(Sender: TObject);
    procedure tmrQryTimer(Sender: TObject);
    procedure SortAction1Execute(Sender: TObject);
    procedure MoveAction1Execute(Sender: TObject);
    procedure YDWarePropAction1Execute(Sender: TObject);
    procedure GetActMultiSelExecute(Sender: TObject);
    procedure phQuoteAction1Execute(Sender: TObject);
    procedure NewWareAction1Execute(Sender: TObject);
    procedure phOrderdlAction1Execute(Sender: TObject);
    procedure slPriceOutRfsAction1Execute(Sender: TObject);
    procedure slPriceInRfsAction1Execute(Sender: TObject);
    procedure WarePropAction1Execute(Sender: TObject);
    procedure actPackPicExecute(Sender: TObject);
    procedure actBrandPicExecute(Sender: TObject);
    procedure actShowPriceChangeExecute(Sender: TObject);
    procedure ActNewSaleRefsExecute(Sender: TObject);
    procedure ActNewInRefsExecute(Sender: TObject);
    procedure ScrollBoxCtrlPanelDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ActBarCodeSearchExecute(Sender: TObject);
    procedure dlDataSet1AfterScroll(DataSet: TDataSet);
    procedure SetFocusEditor;
    procedure FocusGridColumn;
    procedure ActSaleQtyStatusExecute(Sender: TObject);
  public
       DBGridDL:tdbgrid ;
       frmSearchBarCode:TFrmSearchBarCode ;
  private
    { Private declarations }
    fDict: TLkpImportDict    ;
    GrpBox:TGrpSelRecord  ;//过滤条件
    GrpQueryRecord:TGrpQueryRecord;//查询
    fToDbGrid:TDbGrid;
    
    FImportToDataSet: TdataSet;
    MainPramDataSet : TdataSet;
    SecondCnt       : integer;
    FBillCodeField:string;
    procedure  IniQuickQuery(Pdbgird: Tdbgrid);
    procedure  IniShortCutFilter(Pdbgird: Tdbgrid);
    procedure  OnEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure setBillCodeField(const Value: string);
  public
    property BillCodeField:string read FBillCodeField write setBillCodeField ;
    procedure iniFrm(FrmId:string ;OpenPrams:string ='';DLPramDataSet:TdataSet=nil;PMainPramDataSet:TdataSet=nil; pToGrid:Tdbgrid=nil);
    procedure SetEditorFocuse;
    procedure  BarCodeSearch(BarCodeList:TStringList);
    procedure  AppendRecord(fdataSet:TdataSet);
    function   AddBarCode :boolean;
    function   RemoveBarCode :boolean;
    procedure  EnableDsCaculation(enabled:boolean) ;
    procedure setFBillDLF_ID;
    { Public declarations }
  end;

var
  FrmLoopUpImPortEx: TFrmLoopUpImPortEx;

implementation
       uses datamodule,UnitCreateComponent, TabEditor, UnitInOrSaleRefs, unitchyGrid;
{$R *.dfm}

{ TFrmLoopUpImPortEx }

procedure TFrmLoopUpImPortEx.iniFrm(FrmId: string;OpenPrams:string ='';DLPramDataSet:TdataSet=nil;PMainPramDataSet:TdataSet=nil ;pToGrid:Tdbgrid=nil);
var fParams:variant;
var i:integer ;
var  DbGridPopupMenu  :TPopupMenu;
begin
     if not  fhlknl1.Cf_GetDict_LkpImport(FrmId,fDict) then exit;
      self.lblTitle.Caption :='';//  fDict.caption ;
      self.Caption :=   fDict.caption ;

      FhlUser.SetDataSet(mtDataSet1,fDict.mtdatasetid,Null);
      if mtDataSet1.Active   then
      begin
          FhlUser.AssignDefault(mtDataSet1);
          if    mtDataSet1.IsEmpty then
          mtDataSet1.Append;
      end;

      if (fDict.ToolBtnsID  <>'-1') and (fDict.ToolBtnsID  <>'') then
        FhlKnl1.Tb_CreateActionBtns_ex(self.ToolBar1,self.ActionList1,fDict.ToolBtnsID )
      else
        CoolBar1.Visible :=false;


      ActBarCodeSearch.Visible:=logininfo.WhId <>'009' ;


      if   (fDict.Boxid <>'-1') and (fDict.Boxid <>'') then
      begin
         FhlKnl1.Cf_SetBox( fDict.Boxid ,MtDataSource1,ScrollBoxCtrlPanel ,dmFrm.UserDbCtrlActLst);
      end
      else
         self.ScrollTop.Visible :=false;


      FImportToDataSet:=DLPramDataSet;
      // fParams:=FhlKnl1.Ds_GetFieldsValue(DLPramDataSet,fDict.IniPramFields );


      MainPramDataSet:=PMainPramDataSet;
      //    fParams:=FhlKnl1.Ds_GetFieldsValue(MainPramDataSet,fDict.IniPramFields );

      fToDbGrid := pToGrid;
      
      FhlUser.SetDbGridAndDataSet(self.DBGridDL  ,fDict.GridID ,fParams,false);

      if  fDict.TreeID <>-1 then
        self.TreeView1.Visible :=true
      else
        self.TreeView1.Visible :=false;


     if fDict.UseDefaultFilter  then
     IniShortCutFilter(self.DBGridDL  );
     if fDict.UseDefaultqry      then
     IniQuickQuery(self.DBGridDL  );

     if fDict.DblClick>-1 then
     self.DBGridDL.OnDblClick :=self.ActionList1.Actions [fDict.DblClick].OnExecute    ;

      for i:=0 to self.DBGridDL.Columns.Count -1 do
      begin
          if uppercase(self.DBGridDL.Columns[i].FieldName) = uppercase( 'FntClr' )then
          begin
               DBGridDL.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
               break;
          end;
      end;

      for i:=0 to self.ScrollBoxCtrlPanel.ControlCount -1 do
      begin
             if  ScrollBoxCtrlPanel.Controls[i] is Tdbedit     then (ScrollBoxCtrlPanel.Controls[i] as Tdbedit).OnKeyUp  :=OnEditorKeyUp;
      end;
      DbGridPopupMenu  :=TPopupMenu.create(self);
      //fhluser.MergeGridUserMenuAndSysCongfigMenu(DbGridPopupMenu , dmfrm.DbGridPopupMenu1 ,-1,self.ActionList1 )
      
      if fDict.IsOpen then
      if mtDataSet1.Active then
        OpnDlDsBtn1.Click

end;
 
procedure TFrmLoopUpImPortEx.IniQuickQuery(Pdbgird: Tdbgrid);
begin
    GrpQueryRecord:=TGrpQueryRecord.create(self);
    GrpQueryRecord.Parent :=ScrollTop;
    GrpQueryRecord.Height :=GrpQueryRecord.Parent.Height -2  ;
    GrpQueryRecord.Left :=20;
    if GrpBox<>nil then
    begin
        GrpQueryRecord.Width :=  GrpQueryRecord.Parent.Width -self.GrpBox.Width;
        self.GrpBox.Left := GrpQueryRecord.width ;
        GrpBox.Height :=  GrpQueryRecord.Height ;
    end
    else
        GrpQueryRecord.Width :=  GrpQueryRecord.Parent.Width +30 ;

    GrpQueryRecord.Align :=alleft;

    GrpQueryRecord.IniQuickQuery(Pdbgird) ;
    self.Width := GrpQueryRecord.Width +100;
end;
procedure TFrmLoopUpImPortEx.IniShortCutFilter(Pdbgird: Tdbgrid);

begin
//
    GrpBox:=TGrpSelRecord.create(self);
    GrpBox.Parent :=self.ScrollTop;
    GrpBox.Height :=GrpBox.Parent.Height -2 ;
    GrpBox.IniGrpBox(Pdbgird)    ;

end;
procedure TFrmLoopUpImPortEx.ActCloseExecute(Sender: TObject);
begin

self.Close;
 self.ModalResult :=mrok;
end;

procedure TFrmLoopUpImPortEx.DBGridDLDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
    // modeltpe:=Bill;
    if LoginInfo.Sys  then  begin
        CrtCom:=TfrmCreateComponent.Create(self);
        CrtCom.Hide;
        //    CrtCom.fbilldict:=  fbilldict;
        CrtCom.mtDataSet1:= self.dlDataSet1  ;
        CrtCom.mtDataSetId :=inttostr(self.dlDataSet1.tag) ;

        CrtCom.DLGrid :=self.DBGridDL  ;
        CrtCom.DlGridId :=inttostr(self.DBGridDL.Tag);
 
        try
            CrtCom.Show;
        finally

        end;
    end;    { }
end;

procedure TFrmLoopUpImPortEx.OpnDlDsBtn1Click(Sender: TObject);
var fParams:variant;
var  strparm:string;
var  abortstr,WarningStr:string;
begin
    if not mtDataSet1.Active then exit;

    with mtDataSet1 do
    begin
        if (State=dsInsert) or (State=dsEdit) then  //update parameter getvalue
        begin
          UpdateRecord;
         // Post;
        end;
    end;
    fParams:=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fDict.OpenProcFlds,true );
    if MainPramDataSet<>nil then
    begin
          if fDict.IniPramFields<>'' then
          fParams:=  FhlKnl1.Vr_MergeVarArray( fParams ,FhlKnl1.Ds_GetFieldsValue(MainPramDataSet,fDict.IniPramFields ,true ));
    end;
    if Not VarIsNull(fParams) then
    begin
         FhlKnl1.Ds_OpenDataSet(dlDataSet1,fParams);
         FhlKnl1.SetColFormat(self.DBGridDL  );
    end;
    if self.Visible then
       DBGridDL.SetFocus;
 {  if assigned(  dlDataSet1.FindField('fntclr')) then
      DbGrid1.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;
      }

end;
procedure TFrmLoopUpImPortEx.DBGrid1DrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DBGridDL.DataSource.DataSet.IsEmpty then exit;

  if   dlDataSet1.FindField('FntClr') <>nil then
  begin
      DBGridDL.Canvas.Font.Color:=StringToColor(dlDataSet1.FieldByName('FntClr').AsString);
      FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,DBGridDL.Canvas.Font);
  end;
end;



procedure TFrmLoopUpImPortEx.ActPickExecute(Sender: TObject);
var fParams:Variant;
    Values,unionpk:string;
    i,x,j,k:integer;
    BackOnCalcFields: TDataSetNotifyEvent ;
    RecordExists:Boolean;
begin
      //dataset1.Locate( 'Company;Contact;Phone ',   VarArrayOf([ 'Sight   Diver ',   'P ',   '408-431-1000 ']),   [loPartialKey]);

       // fDict.ImportSourceFlds                            //  fDict.ImportDectFlds
      if not dlDataSet1.Active then exit;
      if   dlDataSet1.IsEmpty  then exit;

      BackOnCalcFields:=FImportToDataSet.OnCalcFields;
      //  FImportToDataSet.OnCalcFields:=nil;         //2010-2-12 if get rid of cal event ,after import record ,it cannot cal qty.

      fParams:=FhlKnl1.Ds_GetFieldsValue(dlDataSet1,fDict.ImportPK );

      unionpk:=  fDict.ImportPK ;
      IF  POS(',',fDict.ImportPK)>0   THEN
      begin
          for i:=0 to 10 do
              unionpk:=StringReplace(  unionpk ,',',';',[])     ;
          RecordExists:=  FImportToDataSet.Locate( unionpk,  fParams,[]);
      end
      else
          RecordExists:=  FImportToDataSet.Locate( unionpk,  dlDataSet1.fieldbyname(unionpk).asstring,[]);

      if not RecordExists then
          FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds)
      else if MessageDlg(#13#10+'警告!  在被引用的表格里已经存在该产品.是否覆盖该记录?',mtWarning,[mbYes,mbNo],0)=mrYes then
          FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds,false);

     //barcode window exists
     setFBillDLF_ID;

     FocusGridColumn;
end;
procedure TFrmLoopUpImPortEx.setFBillDLF_ID;
var j,k:integer;
begin
      if frmSearchBarCode<>nil then
      begin
           frmSearchBarCode.BarCodeDataSet.DisableControls;
          for j:=0 to dlDataSet1.RecordCount -1 do
          begin
          
              frmSearchBarCode.BarCodeDataSet.First;
              for k:=0 to frmSearchBarCode.BarCodeDataSet.RecordCount -1 do
              begin
                  if (frmSearchBarCode.BarCodeDataSet.FieldByName('wareid').Value = dlDataSet1.FieldByName('wareid').Value)then
                  begin
                     frmSearchBarCode. BarCodeDataSet.Edit;
                     frmSearchBarCode.BarCodeDataSet.FieldByName('FBillDLF_ID').Value := dlDataSet1.FieldByName('FBillDLF_ID').Value ;
                     frmSearchBarCode. BarCodeDataSet.post;
                  end;

                  frmSearchBarCode.BarCodeDataSet.next;
              end;
          end ;
          frmSearchBarCode.BarCodeDataSet.EnableControls;
      end;
end ;
procedure TFrmLoopUpImPortEx.FormCreate(Sender: TObject);
begin
    //DBGridDL:=TModelDbGrid.create(self) ;
    DBGridDL:=TChyDbGrid.create(self) ;

    DBGridDL.Parent :=pnlGd;
    DBGridDL.Align :=alclient;
    DBGridDL.DataSource:=self.DlDataSource1;
    DBGridDL.PopupMenu :=dmfrm.DbGridPopupMenu1;
    DBGridDL.OnDrawColumnCell:=DBGrid1DrawColumnCellFntClr   ;

end;

procedure TFrmLoopUpImPortEx.FormDestroy(Sender: TObject);
begin
freeandnil(DBGridDL);
end;

procedure TFrmLoopUpImPortEx.SetEditorFocuse;
var i:integer;
begin
   if self.Visible and ScrollBoxCtrlPanel.Visible then
   for i:=0 to ScrollBoxCtrlPanel.ControlCount -1  do
   begin
       if  ScrollBoxCtrlPanel.Controls[i] is TFhlDbEdit then
       begin
             (ScrollBoxCtrlPanel.Controls[i] as TFhlDbEdit ).SetFocus;
            break;
       end;
   end;
end;

procedure TFrmLoopUpImPortEx.actPickALLExecute(Sender: TObject);
var fParams:Variant;
    Values,unionpk:string;
    i,x, j :integer;
    BackOnCalcFields: TDataSetNotifyEvent ;
    RecordExists:Boolean;
begin
  try
      Screen.Cursor:=crHourGlass;
      dlDataSet1.DisableControls;

      if not dlDataSet1.Active then exit;
      if   dlDataSet1.IsEmpty  then exit;

      BackOnCalcFields := FImportToDataSet.OnCalcFields;
      FImportToDataSet.OnCalcFields :=nil;
      
      fParams:=FhlKnl1.Ds_GetFieldsValue(dlDataSet1,fDict.ImportPK );
      unionpk:=  fDict.ImportPK ;

      dlDataSet1.First;
      for j:=0 to dlDataSet1.RecordCount -1 do
      begin
        IF  POS(',',fDict.ImportPK)>0   THEN
        begin
            for i:=0 to 10 do
                unionpk:=StringReplace(  unionpk ,',',';',[])     ;
            RecordExists:=  FImportToDataSet.Locate( unionpk,  fParams,[]);
        end
        else
            RecordExists:=  FImportToDataSet.Locate( unionpk,  dlDataSet1.fieldbyname(unionpk).asstring,[]);

        if not RecordExists then
            FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds)
        else if MessageDlg(#13#10+'警告!  在被引用的表格里已经存在该产品.是否覆盖该记录?',mtWarning,[mbYes,mbNo],0)=mrYes then
            FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds,false);

        dlDataSet1.Next ;
      end;
  finally
   // if BackOnCalcFields <> nil then
      FImportToDataSet.OnCalcFields :=BackOnCalcFields;
    Screen.Cursor:=crDefault;
    dlDataSet1.EnableControls;
  end;
end;

procedure TFrmLoopUpImPortEx.OnEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SecondCnt:=0;
  //if (Key>33) then
   // tmrQry.Enabled :=true;
end;

procedure TFrmLoopUpImPortEx.tmrQryTimer(Sender: TObject);
begin
  Inc(SecondCnt)   ;
  if SecondCnt>40  then
  begin
    tmrQry.Enabled :=False;
    //self.OpnDlDsBtn1.Click   ;
  end ;
end;

procedure TFrmLoopUpImPortEx.SortAction1Execute(Sender: TObject);
begin
  FhlKnl1.Dg_Sort(DBGridDL);
end;

procedure TFrmLoopUpImPortEx.MoveAction1Execute(Sender: TObject);
begin
  //OpenMoveDataSet;
  {
  with TTabGridFrm.Create(Application) do
  begin
    FhlUser.SetDbGrid(cDgId02,DBGridDL);
    DataSource1.DataSet:=self.AdoDataSet2;
    ShowModal;
    Free;
  end;    }
end;

procedure TFrmLoopUpImPortEx.YDWarePropAction1Execute(Sender: TObject);
var ParStr:string;
begin
 FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );

    if ParStr='' then
       if  not dlDataSet1.IsEmpty then
         if   dlDataSet1.FindField('partno')<>nil then
        ParStr:= dlDataSet1.Fieldbyname('partno').AsString;

      if    ParStr='' then
      begin
          showmessage('请输入搜索条件');
      end;
    FhlUser.ShowYdWarePropFrm(cDgId03,ParStr);
end;

procedure TFrmLoopUpImPortEx.GetActMultiSelExecute(Sender: TObject);
var fParams:Variant;
        Values,unionpk:string;
        i,x,j:integer;
        BackOnCalcFields: TDataSetNotifyEvent ;
        RecordExists:Boolean;
         var bk:Pointer;
begin
  if not dlDataSet1.Active then exit;
  if   dlDataSet1.IsEmpty  then exit;

 With dlDataSet1 do
   begin
     if dgMultiSelect in self.DBGridDL.Options then
     begin
       bk:=GetBookmark;
       DisableControls;


       for j:=0 to DBGridDL.SelectedRows.Count-1 do
       begin
            DBGridDL.DataSource.DataSet.GotoBookMark(Pointer(DBGridDL.SelectedRows.Items[j]));

            BackOnCalcFields:=FImportToDataSet.OnCalcFields;
            fParams:=FhlKnl1.Ds_GetFieldsValue(dlDataSet1,fDict.ImportPK );

            unionpk:=  fDict.ImportPK ;
            IF  POS(',',fDict.ImportPK)>0   THEN
            begin
                for i:=0 to 10 do
                    unionpk:=StringReplace(  unionpk ,',',';',[])     ;
                RecordExists:=  FImportToDataSet.Locate( unionpk,  fParams,[]);
            end
            else
                RecordExists:=  FImportToDataSet.Locate( unionpk,  dlDataSet1.fieldbyname(unionpk).asstring,[]);

            if not RecordExists then
                FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds)
            else if MessageDlg(#13#10+'警告!  在被引用的表格里已经存在该产品.是否覆盖该记录?',mtWarning,[mbYes,mbNo],0)=mrYes then
                FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds,false);
        end;

       EnableControls;
       GotoBookmark(bk);
     end;
   end;
end;

procedure TFrmLoopUpImPortEx.phQuoteAction1Execute(Sender: TObject);
var ParStr:string;
begin
 FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );

    if ParStr='' then
       if  not dlDataSet1.IsEmpty then
         if   dlDataSet1.FindField('model')<>nil then
        ParStr:= dlDataSet1.Fieldbyname('model').AsString;


      FhlUser.ShowYdWarePropFrm('423',ParStr);

end;

procedure TFrmLoopUpImPortEx.NewWareAction1Execute(Sender: TObject);
begin
 {
 if FhlUser.ShowTabEditorFrm('pick.neware',null,nil,false,crHourGlass,False)=mrOk then
     FhlKnl1.Ds_CopyValues(TabEditorFrm.ADODataSet1,fToDataSet,'Id,PartNo,Brand','WareId,PartNo,Brand');
  TabEditorFrm.Free;
   }
    FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );

  if FhlUser.ShowTabEditorFrm('10001',null,nil,false,crHourGlass,False)=mrOk then
     FhlKnl1.Ds_CopyValues(TabEditorFrm.ADODataSet1,FImportToDataSet,'Id,PartNo,Brand','WareId,PartNo,Brand');
  TabEditorFrm.Free;

end;

procedure TFrmLoopUpImPortEx.phOrderdlAction1Execute(Sender: TObject);
var ParStr:string;
begin
 FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );

    if ParStr='' then
       if  not dlDataSet1.IsEmpty then
         if   dlDataSet1.FindField('model')<>nil then
        ParStr:= dlDataSet1.Fieldbyname('model').AsString;

     FhlUser.ShowYdWarePropFrm('445', ParStr);
end;

procedure TFrmLoopUpImPortEx.slPriceOutRfsAction1Execute(Sender: TObject);
var ParStr:string;
begin
 FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );

    if ParStr='' then
       if  not dlDataSet1.IsEmpty then
         if   dlDataSet1.FindField('model')<>nil then
        ParStr:= dlDataSet1.Fieldbyname('model').AsString;


    FhlUser.ShowTabGridFrm('pick.slPriceOutRfs',varArrayof([MainPramDataSet.FieldByName('ClientId').asString, ParStr  ]));

end;

procedure TFrmLoopUpImPortEx.slPriceInRfsAction1Execute(Sender: TObject);
var ParStr:string;
begin
 FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );

    if ParStr='' then
       if  not dlDataSet1.IsEmpty then
         if   dlDataSet1.FindField('model')<>nil then
        ParStr:= dlDataSet1.Fieldbyname('model').AsString;

    FhlUser.ShowTabGridFrm('pick.slPriceInRfs',varArrayof([ParStr]));

end;

procedure TFrmLoopUpImPortEx.WarePropAction1Execute(Sender: TObject);
begin

  FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );

  if not dlDataSet1.IsEmpty  then
    FhlUser.ShowWarePropFrm(dlDataSet1.FieldByName('Id').asString,DlDataSource1);
end;

procedure TFrmLoopUpImPortEx.actPackPicExecute(Sender: TObject);
begin
      //封装图片
if not self.dlDataSet1.IsEmpty  then
 FhlUser.ShowTabEditorFrm('10003',varArrayof([dlDataSet1.FieldByName('pack').asstring]),nil,false,-11,true,true,false);

end;

procedure TFrmLoopUpImPortEx.actBrandPicExecute(Sender: TObject);
begin
      //品牌图片
  if not dlDataSet1.IsEmpty   then
  FhlUser.ShowTabEditorFrm('10004',varArrayof([dlDataSet1.FieldByName('Brand').asstring]),nil,false,-11,true,true,false);

end;

procedure TFrmLoopUpImPortEx.actShowPriceChangeExecute(Sender: TObject);
begin

 FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );
  if (not dlDataSet1.IsEmpty ) and (dlDataSet1.FieldByName('PriceChange').asstring<>'' )then
  FhlUser.ShowTabEditorFrm('10006',varArrayof([dlDataSet1.FieldByName('id').asstring]),nil,false,-11,true,true,false);

end;
   
procedure TFrmLoopUpImPortEx.ActSaleQtyStatusExecute(Sender: TObject);
begin
    if dlDataSet1.Active then
    begin
        sDefaultVals :='partno='  + dlDataSet1.FieldByName('partno').asstring  ;
        sDefaultVals :=sDefaultVals+',brand='  + dlDataSet1.FieldByName('brand').asstring  ;
        sDefaultVals :=sDefaultVals+',pack='  + dlDataSet1.FieldByName('pack').asstring  ;

        FhlUser.ShowAnalyserExFrm('57' ,varArrayof([ ]));
    end;
end;

procedure TFrmLoopUpImPortEx.ActNewSaleRefsExecute(Sender: TObject);
var FrmNewOldRefs:TFrmNewOldRefs;
params:string;
begin
     FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );

    FhlUser.CheckToolButtonRight(  fDict.ToolBtnsID , (sender as Taction).Name);
    params:=MainPramDataSet.FieldByName('ClientId').asString;
    if params='' then begin
        showmessage('先选择客户');
        exit;
    end;

  //  if (ComboBox1.Text='')  and   ( cbbPartNo.Text  ='')   then
  //  begin
  //      showmessage('先选择器件');
  //      exit;
  //  end;
  //  if ComboBox1.Text<>'' then
  //     params:=params+','+  ComboBox1.Text;
  //  if cbbPartNo.Text <>'' then
  //       params:=params+','+  cbbPartNo.Text;

    if dlDataSet1.IsEmpty then
    begin
        showmessage('先选择器件');
        exit;
    end;
    params:=params+','+ dlDataSet1.fieldbyname('id').AsString ;

    try
        FrmNewOldRefs:=TFrmNewOldRefs.Create(self);
        FrmNewOldRefs.Caption :='售参';
        FrmNewOldRefs.SetFParams(params );
        FrmNewOldRefs.SetFGridID('684');
        FrmNewOldRefs.InitFrm;
        FrmNewOldRefs.ComboxNewOldDBs.ItemIndex :=0;
        FrmNewOldRefs.Select(FrmNewOldRefs.ComboxNewOldDBs) ;
        FrmNewOldRefs.ShowModal ;
    finally
        FrmNewOldRefs.Free ;
    end;

end;

procedure TFrmLoopUpImPortEx.ActNewInRefsExecute(Sender: TObject);
var FrmNewOldRefs:TFrmNewOldRefs;
var params:string;
begin
 FhlUser.CheckToolButtonRight( self.fDict.ToolBtnsID , (sender as Taction).Name );
     FhlUser.CheckToolButtonRight(  fDict.ToolBtnsID  , (sender as Taction).Name);
   {if (Self.ActiveControl=ComboBox1) or (Self.ActiveControl=cbbPartNo) then
   begin
      if ComboBox1.Text<>'' then
         params:= ComboBox1.Text;
      if cbbPartNo.Text <>'' then
         params:= cbbPartNo.Text;
   end
   else  }

    if dlDataSet1.IsEmpty then
    begin
        showmessage('先选择器件');
        exit;
    end;

    params:=self.dlDataSet1.FieldByName('PartNo').AsString;
    if trim(params)='' then
    begin
        showmessage('先选择器件');
        exit;
    end;      

    try
        FrmNewOldRefs:=TFrmNewOldRefs.Create(self);
        FrmNewOldRefs.Caption :='进参';
        FrmNewOldRefs.SetFParams(params );
        FrmNewOldRefs.SetFGridID('685');
        FrmNewOldRefs.InitFrm;
        FrmNewOldRefs.ComboxNewOldDBs.ItemIndex :=0;
        FrmNewOldRefs.Select(FrmNewOldRefs.ComboxNewOldDBs) ;
        FrmNewOldRefs.ShowModal ;
    finally
        FrmNewOldRefs.Free ;
    end;

end;

procedure TFrmLoopUpImPortEx.ScrollBoxCtrlPanelDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then begin
     CrtCom:=TfrmCreateComponent.Create(self);

      if messagedlg('mtDataSet1?',   mtConfirmation ,[mbyes,mbno],0)=mryes then
      begin
         CrtCom.mtDataSetId :=inttostr(self.mtDataSet1.tag) ;
         CrtCom.mtDataSet1 :=  mtDataSet1 ;
         CrtCom.TopOrBtm :=true;
         CrtCom.TOPBoxId  := (self.fDict.Boxid );
      end
      else
      begin
         CrtCom.mtDataSetId :=inttostr(self.dlDataSet1.tag);
         CrtCom.mtDataSet1 :=self.dlDataSet1 ;
         CrtCom.TOPBoxId  := (self.fDict.Boxid );
      end;

        CrtCom.DLGrid :=self.DBGridDL  ;
        CrtCom.DlGridId :=inttostr(self.DBGridDL.tag) ;
  

    try
        CrtCom.Show;
    finally

    end;
end;


end;

procedure TFrmLoopUpImPortEx.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case key of
       vk_Escape:
          Close;
       vk_Return:begin
                    if Self.ActiveControl =DBGridDL then
                    begin
                       DBGridDL.OnDblClick(sender);
                    end
                    else
                    begin
                       //FhlKnl1.Vl_DoBoxEnter(ActiveControl);
                       //if self.ActiveControl =twincontrol( OpnDlDsBtn1 ) then
                       OpnDlDsBtn1.Click ;
                    end;
                 end;
     end;
end;

procedure TFrmLoopUpImPortEx.FormShow(Sender: TObject);
begin
  SetEditorFocuse;
end;

procedure TFrmLoopUpImPortEx.ActBarCodeSearchExecute(Sender: TObject);
begin
     if (frmSearchBarCode=nil ) then
     begin
         frmSearchBarCode:=TFrmSearchBarCode.Create(nil);
         frmSearchBarCode.IniForm(self,MainPramDataSet.fieldbyname(self.BillCodeField).Value);
     end;

      if pnlGd.Align <> alclient then
      begin
        self.GrpBarCode.Visible:=false;
        pnlGd.Align:=alclient;
      end
      else
      begin
         pnlGd.Align:=alright;
         pnlGd.Width:= pnlGd.Width-GrpBarCode.Width-5;
         self.GrpBarCode.Visible:=true; 
      end;
      ScrollBoxCtrlPanel.Visible:=not GrpBarCode.Visible ;

      frmSearchBarCode.AutoSize :=true;
      frmSearchBarCode.Top:=15;
     // frmSearchBarCode.Left:=5;
      frmSearchBarCode.Width:= GrpBarCode.Width;
      frmSearchBarCode.Height :=frmSearchBarCode.Height;
      frmSearchBarCode.Visible:=true;
      frmSearchBarCode.Dock(self.GrpBarCode,frmSearchBarCode.ClientRect  );

      if MainPramDataSet<>nil then
      begin
          if MainPramDataSet.FieldByName('InWhId').AsString='008' then
              self.mtDataSet1.FieldByName('SourceType').Value :='发货单';
      end

end;

procedure TFrmLoopUpImPortEx.AppendRecord(fdataSet: TdataSet);
{var fParams:Variant;
    Values,unionpk:string;
    i,x, j, k :integer;
    BackOnCalcFields: TDataSetNotifyEvent ;
    RecordExists:Boolean;
    }
begin
{  try
      Screen.Cursor:=crHourGlass;
      if not dlDataSet1.Active then exit;
      if   dlDataSet1.IsEmpty  then exit;

      BackOnCalcFields:=FImportToDataSet.OnCalcFields;
      fParams:=FhlKnl1.Ds_GetFieldsValue(dlDataSet1,fDict.ImportPK );
      unionpk:=  fDict.ImportPK ;

      dlDataSet1.First;
      for j:=0 to dlDataSet1.RecordCount -1 do
      begin
        IF  POS(',',fDict.ImportPK)>0   THEN
        begin
            for i:=0 to 10 do
                unionpk:=StringReplace(  unionpk ,',',';',[])     ;
            RecordExists:=  FImportToDataSet.Locate( unionpk,  fParams,[]);
        end
        else
            RecordExists:=  FImportToDataSet.Locate( unionpk,  dlDataSet1.fieldbyname(unionpk).asstring,[]);

        if not RecordExists then
            FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds)
        else if MessageDlg(#13#10+'警告!  在被引用的表格里已经存在该产品.是否覆盖该记录?',mtWarning,[mbYes,mbNo],0)=mrYes then
            FhlKnl1.Ds_CopyValues(dlDataSet1,FImportToDataSet ,fDict.ImportSourceFlds,fDict.ImportDectFlds,false);

        dlDataSet1.Next ;
      end;

      dlDataSet1.First;
      for j:=0 to dlDataSet1.RecordCount -1 do
      begin
          setFBillDLF_ID;
          dlDataSet1.Next ;
      end;


  finally
    Screen.Cursor:=crDefault;
  end;
  }
end;


procedure TFrmLoopUpImPortEx.BarCodeSearch(BarCodeList: TStringList);
//var fParams:variant;
//var  strparm:string;
//var  abortstr,WarningStr:string;    ,barcodelist.CommaText
begin
{    fParams:=FhlKnl1.Ds_GetFieldsValue(mtDataSet1,fDict.OpenProcFlds,true );
    if MainPramDataSet<>nil then
    begin
          if fDict.IniPramFields<>'' then
          fParams:= FhlKnl1.Vr_MergeVarArray( fParams ,FhlKnl1.Ds_GetFieldsValue(MainPramDataSet,fDict.IniPramFields ,true ));

          fParams:= FhlKnl1.Vr_AttachArray(fParams , BarCodeList.CommaText);

    end;
    if Not VarIsNull(fParams) then
    begin
         FhlKnl1.Ds_OpenDataSet(dlDataSet1,fParams);
         FhlKnl1.SetColFormat(self.DBGridDL  );
    end;
       }

end;

procedure TFrmLoopUpImPortEx.setBillCodeField(const Value: string);
begin
  FBillCodeField := Value;
end;
 
function TFrmLoopUpImPortEx.AddBarCode: boolean;
var resultset: tdataset;
begin
 {resultset :=frmSearchBarCode.AddBarCode;

 if  (( not  frmSearchBarCode.BarCodeDataSet.Locate('FPackageBarCode',frmSearchBarCode.EdtBarCode.Text,[]) ) and  not resultset.IsEmpty )  then
    begin
        frmSearchBarCode.BarCodeDataSet.Append;
        //self.BarCodeDataSet.FieldByName('FOutBillCode').Value :=fbillCode;
        frmSearchBarCode.BarCodeDataSet.FieldByName('wareid').Value :=resultset.FieldByName('wareid').Value;
        frmSearchBarCode.BarCodeDataSet.FieldByName('FBarCodeQty').Value :=resultset.FieldByName('FBarCodeQty').Value;
        frmSearchBarCode.BarCodeDataSet.FieldByName('FPackageBarCode').Value :=frmSearchBarCode.EdtBarCode.Text;

        frmSearchBarCode.BarCodeDataSet.Post;
    end ;
    }
end;

procedure TFrmLoopUpImPortEx.dlDataSet1AfterScroll(DataSet: TDataSet);
begin
statLabel1.Caption:=intTostr(dlDataSet1.RecNo)+'/'+intTostr(dlDataSet1.RecordCount);
end;

function TFrmLoopUpImPortEx.RemoveBarCode: boolean;
begin
//
end;

procedure TFrmLoopUpImPortEx.SetFocusEditor;
var I:integer;
begin
    for i :=0 to  ScrollBoxCtrlPanel.ComponentCount -1 do
    begin
         if    ( ScrollBoxCtrlPanel.Components[i]  is TDbComboBox )
            or ( ScrollBoxCtrlPanel.Components[i]  is TFhlDbDatePicker )
            or ( ScrollBoxCtrlPanel.Components[i]  is TDbCheckBox  )
            or ( ScrollBoxCtrlPanel.Components[i]  is TFhlDbLookupComboBox )
            or ( ScrollBoxCtrlPanel.Components[i]  is TDbEdit )   then
         begin
             (ScrollBoxCtrlPanel.Components[i] as Twincontrol).SetFocus;
             break;
         end;
    end;
end;

procedure TFrmLoopUpImPortEx.FocusGridColumn;
var i: integer;
begin
      i:=0;
      while ((Not fToDbGrid.Columns[i].Visible) or (fToDbGrid.Columns[i].ReadOnly)) and (i<fToDbGrid.fieldcount-1) do
         i:=i+1;
      fToDbGrid.SelectedIndex :=i;
      fToDbGrid.Parent.SetFocus;
      fToDbGrid.SetFocus;
end;

procedure TFrmLoopUpImPortEx.EnableDsCaculation(enabled: boolean);
begin
//
end;


end.

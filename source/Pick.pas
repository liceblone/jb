unit Pick;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, Grids, DBGrids, ComCtrls, ToolWin, ImgList,Variants,ExtCtrls,UnitCreateComponent,
  StdCtrls, ActnList, FhlKnl,UnitInOrSaleRefs,UnitCommonInterface ,UnitSearchBarCode;

type
  TPickFrm = class(TForm,IParentSearch)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    ActionList1: TActionList;
    GetAction1: TAction;
    SelectAction1: TAction;
    CloseAction1: TAction;
    FilterAction1: TAction;
    LocateAction1: TAction;
    SortAction1: TAction;
    GetAction2: TAction;
    MoveAction1: TAction;
    YdWarePropAction1: TAction;
    GetAction3: TAction;
    phQuoteAction1: TAction;
    NewWareAction1: TAction;
    phOrderdlAction1: TAction;
    slPriceOutRfsAction1: TAction;
    slPriceInRfsAction1: TAction;
    WarePropAction1: TAction;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolBar3: TToolBar;
    Label1: TLabel;
    ComboBox1: TComboBox;
    cbbPartNo: TComboBox;
    lbl1: TLabel;
    actPackPic: TAction;
    actBrandPic: TAction;
    AdoDataSet2: TADODataSet;
    actShowPriceChange: TAction;
    ActNewSaleRefs: TAction;
    ActNewInRefs: TAction;
    ActUseBarCode: TAction;
    PnlRight: TPanel;
    DBGrid1: TDBGrid;
    SplitterRight: TSplitter;
    GrpBarCode: TScrollBox;
    ActImportAll: TAction;
    procedure InitFrm(FrmId:string;ToDbGrid:TDbGrid=nil;ParamDataSet:TDataSet=nil;ToDataSet:TDataSet=nil;dependent:boolean=false);
    procedure AssignToTarget;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenDataSet(fPreParams:Variant);
    procedure GetAction1Execute(Sender: TObject);
    procedure SelectAction1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure GetAction2Execute(Sender: TObject);
    procedure MoveAction1Execute(Sender: TObject);
    procedure OpenMoveDataSet;
    procedure YdWarePropAction1Execute(Sender: TObject);
    procedure SortAction1Execute(Sender: TObject);
    procedure GetAction3Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure phQuoteAction1Execute(Sender: TObject);
    procedure NewWareAction1Execute(Sender: TObject);
    procedure phOrderdlAction1Execute(Sender: TObject);
    procedure slPriceOutRfsAction1Execute(Sender: TObject);
    procedure slPriceInRfsAction1Execute(Sender: TObject);
    procedure WarePropAction1Execute(Sender: TObject);
    procedure ToolBar1DblClick(Sender: TObject);
    procedure cbbPartNoEnter(Sender: TObject);
    procedure ComboBox1Enter(Sender: TObject);
    procedure actPackPicExecute(Sender: TObject);
    procedure actBrandPicExecute(Sender: TObject);
    procedure actShowPriceChangeExecute(Sender: TObject);
    procedure ActNewSaleRefsExecute(Sender: TObject);
    procedure ActNewInRefsExecute(Sender: TObject);
    procedure ActUseBarCodeExecute(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ActImportAllExecute(Sender: TObject);

  private
    fDict:TPickDict;
    fToDbGrid:TDbGrid;
    fToDataSet:TDataSet;
    fParamDataSet:TDataSet;
    FBillCodeField:String;
    procedure setBillCodeField(const Value: string);
  public
    frmSearchBarCode:TFrmSearchBarCode;
    Fdependent:boolean;//标志是否以独立窗体运行
    procedure  BarCodeSearch(BarCodeList:TStringList);
    procedure  AppendRecord(fdataSet:TdataSet);
     function   AddBarCode :boolean;
     function   RemoveBarCode :boolean;
     procedure  EnableDsCaculation(enabled:boolean) ;
    property BillCodeField:string read FBillCodeField write setBillCodeField ;
  end;

var
  PickFrm: TPickFrm;

implementation
uses datamodule, TabGrid,TabEditor, desktop,UnitFrmGrid;
{$R *.DFM}

procedure TPickFrm.InitFrm(FrmId:string;ToDbGrid:TDbGrid=nil;ParamDataSet:TDataSet=nil;ToDataSet:TDataSet=nil;dependent:boolean=false);
begin
    self.Fdependent :=dependent;
    if  ToDbGrid<>nil then
       fToDbGrid:=ToDbGrid;

    fParamDataSet:=ParamDataSet;
    fToDataSet:=ToDataSet;
    if (fToDataSet=nil) and (fToDbGrid<>nil)   then
       fToDataSet:=fToDbGrid.DataSource.DataSet;

    if Not FhlKnl1.Cf_GetDict_Pick(FrmId,fdict) then Close;
    Caption:=fDict.Catpion;

    FhlUser.SetDbGridAndDataSet(DbGrid1,fDict.DbGridId, ParamDataSet.fieldbyname(self.BillCodeField).Value,fDict.IsOpen);
    FhlKnl1.Tb_CreateActionBtns(ToolBar1,ActionList1,fDict.Actions);

    if not self.Fdependent then
    DbGrid1.OnDblClick:=ToolBar1.Buttons[0].OnClick;
    
end;

procedure TPickFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var hasClientID:boolean;
begin
 if fParamDataSet.FindField('ClientID')<>nil then
    hasClientID :=  fParamDataSet.Fieldbyname('ClientID').AsString <>''   ;

 case key of
   vk_Escape:Close;
   vk_Return:begin
               if (Self.ActiveControl=ComboBox1 )or(Self.ActiveControl=cbbPartno ) then
               begin
               //加规格参数    '%'+cbbModel.Text   +'%' ,
                 if  (trim(cbbPartNo.Text)<>'') or   (  trim(ComboBox1.Text)<>'') or hasClientID then
                 begin
                     if desktopfrm.dsMainMenu.findField('subSysDBName')=nil then
                        OpenDataSet(varArrayof(   ['%'+ComboBox1.Text+'%',LoginInfo.WhId]   ))
                     else
                     begin
                         if fParamDataSet<>nil then
                         begin
                             if  fParamDataSet.FindField('ClientID')<>nil then
                             begin
                                if fParamDataSet.Fieldbyname('ClientID').AsString ='' then
                                   OpenDataSet(varArrayof(   [ '%'+trim(cbbPartNo.Text)   +'%' , '%'+trim(ComboBox1.Text)+'%',LoginInfo.WhId]  ))
                                else
                                   OpenDataSet(varArrayof(  ['%'+ trim(cbbPartNo.Text)   +'%' , '%'+trim(ComboBox1.Text)+'%',LoginInfo.WhId ,fParamDataSet.Fieldbyname('ClientID').AsString ]));
                             end
                             else
                                OpenDataSet(varArrayof(   ['%'+trim(cbbPartNo.Text)   +'%' , '%'+trim(ComboBox1.Text)+'%',LoginInfo.WhId]  ));
                         end
                         else
                           OpenDataSet(varArrayof(   ['%'+trim(cbbPartNo.Text)   +'%' , '%'+trim(ComboBox1.Text)+'%',LoginInfo.WhId]  ));
                     end;
                 end;

                // OpenDataSet(varArrayof(   ['%'+ComboBox1.Text+'%',LoginInfo.WhId,'%'+cmbModel.text+'%']   ));
                 if (ComboBox1.Items.IndexOf(ComboBox1.Text)=-1) and (ComboBox1.Text<>'') then
                    ComboBox1.Items.Insert(0,ComboBox1.Text);
                 DbGrid1.SetFocus;
               end else if Self.ActiveControl=DbGrid1 then
                 ToolBar1.Buttons[0].Click;
             end;
 end;
end;

procedure TPickFrm.OpenDataSet(fPreParams:Variant);
begin
  Screen.Cursor:=crSqlwait;
  try
    FhlKnl1.Ds_OpenDataSet(AdoDataSet1,FhlKnl1.Vr_MergeVarArray(fPreParams,FhlKnl1.Ds_GetFieldsValue(fParamDataSet,fDict.MtParams)));
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TPickFrm.GetAction1Execute(Sender: TObject);
 var bk:Pointer;i   :integer;
 var FrmGrid1       :TFrmGrid;
 var ModalResult    :TModalResult;
begin
 if (AdoDataSet1.Active) and (Not AdoDataSet1.IsEmpty) and (fToDataSet.Active) and (Not fToDbGrid.ReadOnly) then
 begin
    if ((AdoDataSet1.FindField('Isdel')<>nil )and (AdoDataSet1.FindField('ReplaceWareID')<>nil))then     //id been deleted?
     if  AdoDataSet1.FieldByName ('Isdel').AsBoolean then
     begin
        try
          FrmGrid1 :=TFrmGrid.Create (nil);
          FrmGrid1.InitFrm('706',AdoDataSet1.FieldByName ('ReplaceWareID').AsString );
          FrmGrid1.Caption :='提示';
          FrmGrid1.LblMsg.Caption :='您要导入的型号已被以下型号所取代 :';

          if ((FrmGrid1.ShowModal = mrCancel )
              or (( AdoDataSet1.FindField('myStock')<>nil) and (AdoDataSet1.FieldByName('myStock').AsCurrency>0 )) ) then
              exit;
        finally
          FrmGrid1.Free;
        end;
     end;


   fToDataSet.Cancel;
   With AdoDataSet1 do
   begin
     if dgMultiSelect in DbGrid1.Options then
     begin
       bk:=GetBookmark;
       DisableControls;
       First;
       while not Eof do
       begin
         if DbGrid1.SelectedRows.CurrentRowSelected then
            AssignToTarget;
         Next;
       end;
       EnableControls;
       GotoBookmark(bk);
     end else
     begin
       AssignToTarget;
       i:=0;
       while ((Not fToDbGrid.Columns[i].Visible) or (fToDbGrid.Columns[i].ReadOnly)) and (i<fToDbGrid.fieldcount-1) do
         i:=i+1;
       fToDbGrid.SelectedIndex :=i;
       fToDbGrid.Parent.SetFocus;
       fToDbGrid.SetFocus;
     end;
    end;
 end else if AdoDataSet1.IsEmpty then
    ComboBox1.SetFocus;
end;

procedure TPickFrm.AssignToTarget;
begin
  if AdoDataSet1.FindField(fDict.FromKeyFlds)<>nil then
      if (fDict.IsRepeat) or (Not fToDataSet.Locate(fDict.ToKeyFlds,AdoDataSet1.FieldByName(fDict.FromKeyFlds).asString,[])) then
        FhlKnl1.Ds_CopyValues(AdoDataSet1,fToDataSet,fDict.FromCpyFlds,fDict.ToCpyFlds)
      else if MessageDlg(#13#10+'警告!  在被引用的表格里已经存在该产品.是否覆盖该记录?',mtWarning,[mbYes,mbNo],0)=mrYes then
        FhlKnl1.Ds_CopyValues(AdoDataSet1,fToDataSet,fDict.FromCpyFlds,fDict.ToCpyFlds,false);
end;

procedure TPickFrm.SelectAction1Execute(Sender: TObject);
begin
 DBGrid1.DataSource.DataSet.First;
 while not DBGrid1.DataSource.DataSet.Eof do begin
  DBGrid1.SelectedRows.CurrentRowSelected := not DBGrid1.SelectedRows.CurrentRowSelected;
  DBGrid1.DataSource.DataSet.Next;
 end;
end;

procedure TPickFrm.CloseAction1Execute(Sender: TObject);
begin
 Close;
end;

procedure TPickFrm.GetAction2Execute(Sender: TObject);

begin
{ if (AdoDataSet1.Active) and (Not AdoDataSet1.IsEmpty) and (fToDataSet.Active) and (Not fToDbGrid.ReadOnly) then
 begin

   fToDataSet.Cancel;
  if InputQuery(Application.Title,'请输入该产品本次发货量:',qty) then
  begin
    if strTofloat(qty)>AdoDataSet1.FieldByName('myStok').asFloat then
    begin
      if MessageDlg(#13#10+'本仓库的可用库存不够发货,是否从其它仓库调拨?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
      begin
        if TabGridFrm=nil then
        begin
          Screen.Cursor:=crSqlWait;
          try
           TabGridFrm:=TTabGridFrm.Create(Application);
           FhlUser.SetDbGrid(cDgId01,TabGridFrm.DbGrid1);
           OpenMoveDataSet;
          finally
           Screen.Cursor:=crDefault;
          end;
        end;
        FhlUser.SetDataSet(TabGridFrm.AdoDataSet1,cDsId03,varArrayof([AdoDataSet1.FieldByName('Id').asString,LoginInfo.WhId]));
        if TabGridFrm.ShowModal=mrOk then
        begin
          with TabGridFrm.ADODataSet1 do
          begin
            First;
            while not Eof do
            begin
              if FieldByName('Assign').asFloat>0 then
              begin                                                              //'Model','Model',
                FhlKnl1.Ds_CopyValues(AdoDataSet1,AdoDataSet2,varArrayof(['Id','PartNo','Brand']),varArrayof(['WareId','PartNo','Brand']));
                FhlKnl1.Ds_AssignValues(AdoDataSet2,varArrayof(['Sake','xTime','InWhId','OutWhId','Qty']),varArrayof(['销售发货',Now,LoginInfo.WhId,FieldByName('Code').asString,FieldByName('Assign').asFloat]),false);
              end;
              Next;
            end;
          end;
        end;
      end;
    end;

    GetAction1Execute(nil);
    FhlKnl1.Ds_AssignValues(fToDataSet,varArrayof(['Qty']),varArrayof([Qty]),false);
  end;
 end else if AdoDataSet1.IsEmpty then
    ComboBox1.SetFocus;
 }                                //销售发货导入
  GetAction1Execute(nil);
end;

procedure TPickFrm.MoveAction1Execute(Sender: TObject);
begin
  OpenMoveDataSet;
  with TTabGridFrm.Create(Application) do
  begin
    FhlUser.SetDbGrid(cDgId02,DbGrid1);
    DataSource1.DataSet:=self.AdoDataSet2;
    ShowModal;
    Free;
  end;
end;

procedure TPickFrm.OpenMoveDataSet;
begin
  if Not ADODataSet2.Active then
     FhlUser.SetDataSet(AdoDataSet2,cDsId04,varArrayof([LoginInfo.WhId]));
end;

procedure TPickFrm.YdWarePropAction1Execute(Sender: TObject);
var ParStr:string;
begin
    FhlUser.CheckRight(fDict.ydWarepropRitID);

    if trim(cbbPartNo.Text) <>'' then
       ParStr:=trim(cbbPartNo.Text) ;

    if trim(ComboBox1.Text) <>'' then
       ParStr:=trim(ComboBox1.Text) ;
    if ParStr='' then
       if  not ADODataSet1.IsEmpty then
         if   ADODataSet1.FindField('partno')<>nil then
        ParStr:= ADODataSet1.Fieldbyname('partno').AsString;

      if    ParStr='' then
      begin
          showmessage('请输入搜索条件');
      end;
    FhlUser.ShowYdWarePropFrm(cDgId03,ParStr);

end;

procedure TPickFrm.SortAction1Execute(Sender: TObject);
begin
  FhlKnl1.Dg_Sort(DbGrid1);
end;

procedure TPickFrm.GetAction3Execute(Sender: TObject);
begin
  FhlKnl1.Ds_CopyValues(AdoDataSet1,fToDataSet,fDict.FromCpyFlds,fDict.ToCpyFlds,False,False);
  ModalResult:=mrOk;
end;

procedure TPickFrm.FormShow(Sender: TObject);
begin
  Top:=Screen.Height-Self.Height-40;
  Left:=10;
end;

procedure TPickFrm.phQuoteAction1Execute(Sender: TObject);
begin
FhlUser.CheckRight(fDict.phQuoteRitID);
  FhlUser.ShowYdWarePropFrm('423',ComboBox1.Text);
end;

procedure TPickFrm.NewWareAction1Execute(Sender: TObject);
begin
 {
 if FhlUser.ShowTabEditorFrm('pick.neware',null,nil,false,crHourGlass,False)=mrOk then
     FhlKnl1.Ds_CopyValues(TabEditorFrm.ADODataSet1,fToDataSet,'Id,PartNo,Brand','WareId,PartNo,Brand');
  TabEditorFrm.Free;
   }
  if FhlUser.ShowTabEditorFrm('10001',null,nil,false,crHourGlass,False)=mrOk then
     FhlKnl1.Ds_CopyValues(TabEditorFrm.ADODataSet1,fToDataSet,'Id,PartNo,Brand','WareId,PartNo,Brand');
  TabEditorFrm.Free; 
end;

procedure TPickFrm.phOrderdlAction1Execute(Sender: TObject);
begin
FhlUser.CheckRight(fDict.phOrderdlRitID);
  FhlUser.ShowYdWarePropFrm('445',ComboBox1.Text);
end;

procedure TPickFrm.slPriceOutRfsAction1Execute(Sender: TObject);
var
  s,clientid,wareid:string;
begin
    clientid:= fParamDataSet.FieldByName('ClientId').asString ;
    if clientid='' then begin
        showmessage('先选择客户');
        exit;
    end;

    wareid:= ADODataSet1.fieldbyname('id').AsString; 

FhlUser.CheckRight(fDict.slPriceOutRfsRitID );
FhlUser.ShowTabGridFrm('pick.slPriceOutRfs',varArrayof([clientid,wareid,LoginInfo.LoginId ]));
// FhlUser.ShowTabGridFrm('pick.slPriceOutRfs','');


 end;

procedure TPickFrm.slPriceInRfsAction1Execute(Sender: TObject);
var
  s:string;
begin

FhlUser.CheckRight(fDict.slPriceInRfsRitID );

  if Self.ActiveControl=ComboBox1 then
    s:=ComboBox1.Text
  else
    s:=AdoDataSet1.FieldByName('PartNo').AsString;
  FhlUser.ShowTabGridFrm('pick.slPriceInRfs',varArrayof([s]));
end;

procedure TPickFrm.WarePropAction1Execute(Sender: TObject);
begin
//  FhlUser.CheckRight(fbilldict.CheckRitId);

  FhlUser.CheckRight(fDict.WarePropRitId);
  FhlUser.ShowWarePropFrm(AdoDataSet1.FieldByName('Id').asString,DataSource1);
end;

procedure TPickFrm.ToolBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    CrtCom.DlGridId :=inttostr(self.DBGrid1.tag);
    CrtCom.DLGrid :=self.DBGrid1 ;
    CrtCom.mtDataSetId :=inttostr(self.ADODataSet1.Tag );
    CrtCom.mtDataSet1 :=self.ADODataSet1 ;
//    CrtCom.ModelType :=ModelPickDict  ;
//    CrtCom.FTPickDict := self.fDict ;
    try
    CrtCom.Show;
    finally

    end;
  end;


end;

procedure TPickFrm.cbbPartNoEnter(Sender: TObject);
begin
     combobox1.Text :='';
end;

procedure TPickFrm.ComboBox1Enter(Sender: TObject);
begin
     cbbpartno.Text :='';
end;

procedure TPickFrm.actPackPicExecute(Sender: TObject);
begin
      //封装图片
if not AdoDataSet1.IsEmpty  then
 FhlUser.ShowTabEditorFrm('10003',varArrayof([AdoDataSet1.FieldByName('pack').asstring]),nil,false,-11,true,true,false);

end;

procedure TPickFrm.actBrandPicExecute(Sender: TObject);
begin
      //品牌图片
  if not AdoDataSet1.IsEmpty   then
  FhlUser.ShowTabEditorFrm('10004',varArrayof([AdoDataSet1.FieldByName('Brand').asstring]),nil,false,-11,true,true,false);

end;

procedure TPickFrm.actShowPriceChangeExecute(Sender: TObject);
begin
  if (not ADODataSet1.IsEmpty ) and (ADODataSet1.FieldByName('PriceChange').asstring<>'' )then
  FhlUser.ShowTabEditorFrm('10006',varArrayof([ADODataSet1.FieldByName('id').asstring]),nil,false,-11,true,true,false);

end;

procedure TPickFrm.ActNewSaleRefsExecute(Sender: TObject);
var FrmNewOldRefs:TFrmNewOldRefs;
params:string;
begin
FhlUser.CheckRight(fDict.slPriceOutRfsRitID );
    params:=fParamDataSet.FieldByName('ClientId').asString;
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

    params:=params+','+ self.ADODataSet1.fieldbyname('id').AsString ;


    FrmNewOldRefs:=TFrmNewOldRefs.Create(self);
    FrmNewOldRefs.Caption :='售参';
    FrmNewOldRefs.SetFParams(params );
    FrmNewOldRefs.SetFGridID('684');
    FrmNewOldRefs.InitFrm;
    FrmNewOldRefs.ComboxNewOldDBs.ItemIndex :=0;
    FrmNewOldRefs.Select(FrmNewOldRefs.ComboxNewOldDBs) ;
    FrmNewOldRefs.ShowModal ;
    FrmNewOldRefs.Free ;
end;

procedure TPickFrm.ActNewInRefsExecute(Sender: TObject);
var FrmNewOldRefs:TFrmNewOldRefs;
params:string;
begin
FhlUser.CheckRight(fDict.slPriceInRfsRitID );
   if (Self.ActiveControl=ComboBox1) or (Self.ActiveControl=cbbPartNo) then
   begin
      if ComboBox1.Text<>'' then
         params:= ComboBox1.Text;
      if cbbPartNo.Text <>'' then
         params:= cbbPartNo.Text;
   end
   else
      params:=AdoDataSet1.FieldByName('PartNo').AsString;


    if trim(params)='' then
    begin
        showmessage('先选择器件');
        exit;
    end;


    FrmNewOldRefs:=TFrmNewOldRefs.Create(self);
    FrmNewOldRefs.Caption :='进参';
    FrmNewOldRefs.SetFParams(params );
    FrmNewOldRefs.SetFGridID('685');
    FrmNewOldRefs.InitFrm;
    FrmNewOldRefs.ComboxNewOldDBs.ItemIndex :=0;
    FrmNewOldRefs.Select(FrmNewOldRefs.ComboxNewOldDBs) ;
    FrmNewOldRefs.ShowModal ;
    FrmNewOldRefs.Free ;


end;

procedure TPickFrm.ActUseBarCodeExecute(Sender: TObject);
begin

     if (frmSearchBarCode=nil ) then
     begin
         frmSearchBarCode:=TFrmSearchBarCode.Create(nil);
         frmSearchBarCode.IniForm(self,fParamDataSet.fieldbyname(self.BillCodeField).Value);
     end;
      frmSearchBarCode.RefreshBill;
      if PnlRight.Align <> alclient then
      begin
        self.GrpBarCode.Visible:=false;
        PnlRight.Align:=alclient;
      end
      else
      begin
         PnlRight.Align:=alright;
         PnlRight.Width:= PnlRight.Width-GrpBarCode.Width-5;
         self.GrpBarCode.Visible:=true;

      end;
   

  frmSearchBarCode.AutoSize :=true;
  frmSearchBarCode.Top:=15;
 // frmSearchBarCode.Left:=5;
  frmSearchBarCode.Width:= GrpBarCode.Width;
  frmSearchBarCode.Height :=frmSearchBarCode.Height;
  frmSearchBarCode.Visible:=true;
  frmSearchBarCode.Dock(self.GrpBarCode,frmSearchBarCode.ClientRect    );

end;

procedure TPickFrm.AppendRecord(fdataSet: TdataSet);
// var bk:Pointer;i:integer;
// var FrmGrid1:TFrmGrid;
begin
     {
 if (AdoDataSet1.Active) and (Not AdoDataSet1.IsEmpty) and (fToDataSet.Active) and (Not fToDbGrid.ReadOnly) then
 begin
    fToDataSet.Cancel;

    for i:=0 to self.ADODataSet1.RecordCount-1 do
    begin
        if (Not fToDataSet.Locate(fDict.ToKeyFlds,AdoDataSet1.FieldByName(fDict.FromKeyFlds).asString,[]) )then
            FhlKnl1.Ds_CopyValues(AdoDataSet1,fToDataSet,fDict.FromCpyFlds,fDict.ToCpyFlds)   
        else
        begin
           fToDataSet.Edit;
           fToDataSet.FieldByName('Qty').Value:= AdoDataSet1.fieldbyname('FBarCodeQty').Value;
        end;

        fdataset.Next;
    end;

 end;
 }
end;



procedure TPickFrm.BarCodeSearch(BarCodeList:TStringList);
var clientid:string;
begin
{
clientid:='';
  if   fParamDataSet.findfield('ClientID') <>nil then
      clientid:=fParamDataSet.Fieldbyname('ClientID').AsString   ;

   OpenDataSet(varArrayof(   [trim(cbbPartNo.Text)  ,trim(ComboBox1.Text),LoginInfo.WhId,clientid,barcodelist.CommaText]  ));
   }
end;

procedure TPickFrm.setBillCodeField(const Value: string);
begin
  FBillCodeField := Value;
end;

procedure TPickFrm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var GridDraw:Tdbgrid;
var color:Tcolor;
begin
  GridDraw:=     (Sender as Tdbgrid);

  if GridDraw.DataSource.DataSet.IsEmpty then exit;

  if  GridDraw.DataSource.DataSet.FindField ('RowBgColor') <>nil then
  begin
      color:=  StringToColor(GridDraw.DataSource.DataSet.FieldByName('RowBgColor').AsString);
      FhlKnl1.Dg_DrawCustomizeBackgroud(Sender,Rect,DataCol,Column,State, color);
  end;


end;

procedure TPickFrm.ActImportAllExecute(Sender: TObject);
var i:integer;
begin
if (AdoDataSet1.Active) and (Not AdoDataSet1.IsEmpty) and (fToDataSet.Active) and (Not fToDbGrid.ReadOnly) and (AdoDataSet1.RecordCount<100) then
 begin
   fToDataSet.Cancel;

   AdoDataSet1.First;
   while not AdoDataSet1.Eof do
   begin
       With AdoDataSet1 do
       begin

           AssignToTarget;
           i:=0;
           while ((Not fToDbGrid.Columns[i].Visible) or (fToDbGrid.Columns[i].ReadOnly)) and (i<fToDbGrid.fieldcount-1) do
             i:=i+1;
           fToDbGrid.SelectedIndex :=i;
           fToDbGrid.Parent.SetFocus;
           fToDbGrid.SetFocus;

        end;
        AdoDataSet1.Next;
   end;
 end else if AdoDataSet1.IsEmpty then
    ComboBox1.SetFocus;
end;

function TPickFrm.AddBarCode: boolean;
begin
//
end;

function TPickFrm.RemoveBarCode: boolean;
begin
//
end;

procedure TPickFrm.EnableDsCaculation(enabled: boolean);
begin
//
end;

end.

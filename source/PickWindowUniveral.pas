unit PickWindowUniveral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, ActnList, DB, Grids, DBGrids, ADODB, FhlKnl,UnitCreateComponent,UnitSearchBarCode,
  StdCtrls, DateUtils, Buttons;

type
  TFrmPickUniversal = class(TForm)
    clbr1: TCoolBar;
    tlbToolButton: TToolBar;
    PageControl: TPageControl;
    ScrollBox1: TScrollBox;
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
    actPackPic: TAction;
    actBrandPic: TAction;
    ActInputInvoiceItem: TAction;
    actPayReceive: TAction;
    ActAlrdyBlill: TAction;
    ActInvoiceBillItems: TAction;
    ActSelALL: TAction;
    ActDelALL: TAction;
    ActBarCodeSearch: TAction;
    DateBegin: TDateTimePicker;
    Label2: TLabel;
    DateEnd: TDateTimePicker;
    Label1: TLabel;
    OpnDlDsBtn1: TSpeedButton;
    procedure InitFrm(FrmId:string;ToDbGrid:TDbGrid=nil;ParamDataSet:TDataSet=nil;ToDataSet:TDataSet=nil);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure OpenDataSet(fPreParams:Variant);
    procedure FormShow(Sender: TObject);
    procedure WarePropAction1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure ScrollBox1DblClick(Sender: TObject);
    procedure DBGridDrawColumnCellFntClr(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
    procedure AssignToTarget;
    procedure ActInputInvoiceItemExecute(Sender: TObject);
    procedure TsheetDBCLk(sender:Tobject);
    procedure tlbToolButtonDblClick(Sender: TObject);
    procedure actPayReceiveExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActAlrdyBlillExecute(Sender: TObject);
    procedure ActInvoiceBillItemsExecute(Sender: TObject);
    Function  IsDuplicateItem(ToDataSet,FromDataSet:TDataSet;ToStr,FormStr:string):boolean;
    procedure ActSelALLExecute(Sender: TObject);
    procedure ActDelALLExecute(Sender: TObject);
    procedure ActBarCodeSearchExecute(Sender: TObject);
    function  GetAllParameters: Variant ;
    procedure OpnDlDsBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    fDict:TPickDictPickMulPage;
    fToDbGrid:TDbGrid;
    fToDataSet:TDataSet;
    fParamDataSet:TDataSet;

    mtDataSource1:TDataSource;     //public parameter
    mtDataset1:TadoDataSet;

    PriMtDataSource1:array of TDataSource;     //private parameter
    PriMtDataset1:array of  TADODataSet;
    PriDbgrid1:array of  Tdbgrid;
    Tabsheet:array of  TTabSheet;

    SlstGrids,SlstGridCaptions:Tstringlist;
    //frmSearchBarCode:TFrmSearchBarCode ;
  end;

var
  FrmPickUniversal: TFrmPickUniversal;

implementation
   uses datamodule,Editor,Bill;
{$R *.dfm}
procedure TFrmPickUniversal.DBGridDrawColumnCellFntClr(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if PriDbgrid1[PageControl.ActivePageIndex].DataSource.DataSet.IsEmpty then exit;

  if PriMtDataset1[PageControl.ActivePageIndex].FindField ('FntClr')<>nil  then
  begin
      PriDbgrid1[PageControl.ActivePageIndex].Canvas.Font.Color:=StringToColor(PriMtDataset1[PageControl.ActivePageIndex].FieldByName('FntClr').AsString);
      FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,PriDbgrid1[PageControl.ActivePageIndex].Canvas.Font);
  end;
end;

procedure TFrmPickUniversal.InitFrm(FrmId:string;ToDbGrid:TDbGrid=nil;ParamDataSet:TDataSet=nil;ToDataSet:TDataSet=nil);
var
i:integer;
fParams:variant;
begin
    if Not FhlKnl1.Cf_GetDict_PickUniversal(FrmId,fdict) then Close;

    fParamDataSet:=ParamDataSet;
    fToDataSet:=ToDataSet;
    Caption:=fDict.Catpion;
    SlstGrids:=Tstringlist.Create;
    SlstGridCaptions:=Tstringlist.Create;

    SlstGrids.CommaText :=fDict.DbGridIds ;
    SlstGridCaptions.CommaText :=fdict.DbGridCaptions ;

    if    (SlstGridCaptions.Count <>  SlstGrids.Count )   then
    begin
       showmessage('  (SlstGridCaptions.Count <>  SlstGrids.Count )   ');
       exit;
    end;
    if (fdict.BoxID)<>'-1' then      //      create label and dbcontrol
    FhlKnl1.Cf_SetBox(fdict.BoxID,self.mtDataSource1 ,ScrollBox1,dmFrm.dbCtrlActionList1);


    if  ToDbGrid<>nil then
       fToDbGrid:=ToDbGrid;

    fParamDataSet:=ParamDataSet;
    fToDataSet:=ToDataSet;
    if (fToDataSet=nil) and (fToDbGrid<>nil)   then
       fToDataSet:=fToDbGrid.DataSource.DataSet;


    if strtoint(fDict.BoxID )>1 then
    begin
          mtDataset1:=TadoDataSet.Create (self);
          mtDataset1.Connection :=DMFRM.ADOConnection1 ;
          mtDataSource1:=TDataSource.Create (SELF);     //public parameter
          mtDataSource1.DataSet :=    mtDataset1;

          FhlUser.SetDataSet(mtDataset1,fDict.mtDataSetId,null);
            if mtDataset1.Active then
          begin
              FhlUser.AssignDefault(mtDataset1);
              if mtDataset1.IsEmpty then
              begin
                  mtDataset1.Append;
              end;
          end;
    end;
    FhlKnl1.Tb_CreateActionBtns(tlbToolButton,ActionList1,fDict.Actions);

    setlength(     PriMtDataSource1,  SlstGrids.Count) ;    //private parameter
    setlength(     PriMtDataset1,  SlstGrids.Count)  ;   //private parameter
    setlength(     Tabsheet,  SlstGrids.Count)  ;
    setlength(     PriDbgrid1,  SlstGrids.Count)  ;

    for i:=0 to    SlstGrids.Count-1 do
    begin
        Tabsheet[i]:=fhlknl1.Pc_CreateTabSheet(self.PageControl  ,SlstGridCaptions[i] );

        PriMtDataset1[i] :=Tadodataset.Create(Tabsheet[i]);
        PriMtDataset1[i].Connection :=dmfrm.ADOConnection1 ;
        PriMtDataSource1[i]:=Tdatasource.Create(Tabsheet[i])   ;

        PriMtDataSource1[i].DataSet :=PriMtDataset1[i];
        PriDbgrid1[i]:=tdbgrid.Create(Tabsheet[i])   ;
        PriDbgrid1[i].Parent :=  Tabsheet[i];
        PriDbgrid1[i].DataSource :=PriMtDataSource1[i];

        PriDbgrid1[i].Align :=alClient;
        PriDbgrid1[i].PopupMenu := dmFrm.DbGridPopupMenu1;
        PriDbgrid1[i].OnDblClick:=tlbToolButton.Buttons[0].OnClick;
        PriDbgrid1[i].OnDrawColumnCell :=   DBGridDrawColumnCellFntClr;

        //fParams:= FhlKnl1.Vr_MergeVarArray(  FhlKnl1.Ds_GetFieldsValue(ParamDataSet ,fDict.MtParams), FhlKnl1.Ds_GetFieldsValue(mtDataset1 ,fDict.DLParams));
        fParams:= GetAllParameters;
        FhlUser.SetDbGridAndDataSet(PriDbgrid1[i],SlstGrids[i],fParams );//,fDict.IsOpen );   //
    end;

    DateBegin.Date := today -31*6;
end;



procedure TFrmPickUniversal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var   fParams:variant;
begin
     case key of
       vk_Escape:Close;
       vk_Return:begin
               fParams:=self.GetAllParameters;// FhlKnl1.Vr_MergeVarArray(  FhlKnl1.Ds_GetFieldsValue(fParamDataSet ,fDict.MtParams),  FhlKnl1.Ds_GetFieldsValue(mtDataset1 ,fDict.DLParams));

               FhlKnl1.Ds_OpenDataSet(PriMtDataset1[self.PageControl.ActivePageIndex],fParams);



                 end;
     end;
end;
procedure TFrmPickUniversal.OpenDataSet(fPreParams:Variant);
begin
  Screen.Cursor:=crSqlwait;
  try
    FhlKnl1.Ds_OpenDataSet(PriMtDataset1[PageControl.ActivePageIndex],FhlKnl1.Vr_MergeVarArray(fPreParams,FhlKnl1.Ds_GetFieldsValue(fParamDataSet,fDict.MtParams)));
  finally
    Screen.Cursor:=crDefault;
  end;
end;
procedure TFrmPickUniversal.FormShow(Sender: TObject);
begin
  Top:=Screen.Height-Self.Height-40;
  Left:=10;

end;

procedure TFrmPickUniversal.WarePropAction1Execute(Sender: TObject);
begin
showmessage('')
end;

procedure TFrmPickUniversal.CloseAction1Execute(Sender: TObject);
begin
self.Close;
end;

procedure TFrmPickUniversal.ScrollBox1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
      // modeltpe:=Bill;
        if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
        begin
          CrtCom:=TfrmCreateComponent.Create(self);
          CrtCom.Hide;
          CrtCom.ModelType :=   ModelFrmPickMulPage;
          CrtCom.TopOrBtm :=true;
          CrtCom.TOPBoxId :=self.fDict.BoxID ;
          CrtCom.mtDataSetId :=self.fDict.mtDataSetId ;
          if  mtDataset1<>nil then
              CrtCom.mtDataSet1 :=self.mtDataset1
          else
              showmessage(' mtDataset1=nil');
          CrtCom.DlGridId :=SlstGrids[self.PageControl.ActivePageIndex ];
          try
          CrtCom.Show;
          finally
          end;
        end;

end;
procedure TFrmPickUniversal.AssignToTarget;
begin
//if (fDict.IsRepeat) or (Not fToDataSet.Locate(fDict.ToKeyFlds,PriMtDataset1[PageControl.ActivePageIndex].FieldByName(fDict.FromKeyFlds).asString,[])) then
if (fDict.IsRepeat) or (Not IsDuplicateItem (fToDataSet, PriMtDataset1[PageControl.ActivePageIndex],fDict.ToKeyFlds ,fDict.FromKeyFlds )   ) then

    FhlKnl1.Ds_CopyValues(PriMtDataset1[PageControl.ActivePageIndex],fToDataSet,fDict.FromCpyFlds,fDict.ToCpyFlds,true)
 else if MessageDlg(#13#10+'警告!  在被引用的表格里已经存在该产品.是否覆盖该记录?',mtWarning,[mbYes,mbNo],0)=mrYes then
 begin
   fToDataSet.Delete;
   FhlKnl1.Ds_CopyValues(PriMtDataset1[PageControl.ActivePageIndex],fToDataSet,fDict.FromCpyFlds,fDict.ToCpyFlds,true);
 end;
end;
procedure TFrmPickUniversal.ActInputInvoiceItemExecute(Sender: TObject);
begin
if    (PriMtDataset1[PageControl.ActivePageIndex].FindField('Input')<>nil) and (not PriMtDataset1[PageControl.ActivePageIndex].IsEmpty ) then
begin
        AssignToTarget;
        if PriMtDataset1[PageControl.ActivePageIndex].LockType  =ltBatchOptimistic then
           PriMtDataset1[PageControl.ActivePageIndex].Delete ;

end;

end;

procedure TFrmPickUniversal.TsheetDBCLk(sender:Tobject);
var CrtCom:TfrmCreateComponent    ;
begin
      // modeltpe:=Bill;
        if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
        begin
          CrtCom:=TfrmCreateComponent.Create(self);
          CrtCom.Hide;
       //  CrtCom.ModelType :=   ModelFrmPickMulPage;

          CrtCom.DlGridId :=SlstGrids[self.PageControl.ActivePageIndex ];
          CrtCom.edtGridID.Text:=CrtCom.DlGridId ;
          CrtCom.DlGrid:=PriDbgrid1[self.PageControl.ActivePageIndex];
          CrtCom.mtDataSet1:=PriMtDataset1[self.PageControl.ActivePageIndex];

       //       PriMtDataset1:array of  TADODataSet;
   // PriDbgrid1:array of  Tdbgrid;

          fhlknl1.Kl_GetQuery2('select * from T504 where  f01='+  CrtCom.DlGridId )   ;
          CrtCom.mtDataSetId   :=fhlknl1.FreeQuery.FieldByName('F03').asString;
          try
              CrtCom.Show;
          finally
          end;

        end;

end;

procedure TFrmPickUniversal.tlbToolButtonDblClick(Sender: TObject);
begin
TsheetDBCLk(sender);
end;

procedure TFrmPickUniversal.actPayReceiveExecute(Sender: TObject);
begin

      if fParamDataSet.FieldByName('diffamt').AsFloat >0 then
      begin
        fToDbGrid.DataSource.DataSet.Append;
        PriMtDataset1[self.PageControl.ActivePageIndex ].Last ;
        fToDbGrid.DataSource.DataSet.FieldByName('Frompk').AsInteger :=PriMtDataset1[self.PageControl.ActivePageIndex ].FieldByName('pk').AsInteger*10;
        fToDbGrid.DataSource.DataSet.FieldByName('qty').AsInteger :=1;
        fToDbGrid.DataSource.DataSet.FieldByName('price').AsCurrency  :=fParamDataSet.FieldByName('diffamt').AsCurrency  ;
        fToDbGrid.DataSource.DataSet.FieldByName('Taxamt').AsCurrency :=fParamDataSet.FieldByName('diffamt').AsCurrency     ;
        fToDbGrid.DataSource.DataSet.FieldByName('ItemTableName').AsString  :='fn_shldin';
        fToDbGrid.DataSource.DataSet.FieldByName('ItemTableBillCode').AsString  :='应付单';

        //

      // FhlUser.ShowEditorFrm('10004',null).ShowModal
        FhlUser.ShowTabEditorFrm('10005',null,fToDbGrid.DataSource.DataSet ,False,crAppStart,true,true,true,false);
      end;


      if fParamDataSet.FieldByName('diffamt').AsFloat <0 then
      begin
      // FhlUser.ShowEditorFrm('24',null).ShowModal;
      end;

end;

procedure TFrmPickUniversal.FormActivate(Sender: TObject);
var fParams:variant;
begin
    fParams:= GetAllParameters;

    FhlKnl1.Ds_OpenDataSet(PriMtDataset1[self.PageControl.ActivePageIndex],fParams);

end;

procedure TFrmPickUniversal.ActAlrdyBlillExecute(Sender: TObject);
var
  fCode,fBillId,TableName:string;
var   EditorFrm:TEditorFrm;

begin
if self.PageControl.ActivePageIndex <>0 then exit;
  Screen.Cursor:=crHourGlass;


    // PriMtDataset1:array of  TADODataSet;
    //PriDbgrid1:array of  Tdbgrid;

  fCode:=PriMtDataset1[PageControl.ActivePageIndex].FieldByName('Code').AsString;
  fBillId:=PriMtDataset1[PageControl.ActivePageIndex].FieldByName('BillId').AsString;

  if   (fCode<>'' ) and (fBillId<>'') then
  begin
      case    PriMtDataset1[PageControl.ActivePageIndex].FieldByName('BillType').AsInteger of
      0:
      begin
            try
                EditorFrm:=TEditorFrm.Create(nil);
                EditorFrm.InitFrm(fBillId,null,nil);
                EditorFrm.AddBtn.Enabled  :=false;
                EditorFrm.CpyBtn.Enabled  :=false;
                EditorFrm.ChgBtn.Enabled  :=false;
                EditorFrm.DelBtn.Enabled  :=false;
                {     for i:=0 to EditorFrm.PageControl1.PageCount -1 do
                    if   EditorFrm.PageControl1.Controls[i] is TWinControl then
                    with TDbEdit( EditorFrm.PageControl1.Controls[i]) do
                    begin
                        Color:=clWhite;
                        Enabled:=true;
                    end;                      }

                EditorFrm.ADODataSet1.Close;

                TableName:=   fhlknl1.GetTableName(EditorFrm.ADODataSet1.tag);
                if    TableName      ='' then      exit;

                EditorFrm.ADODataSet1.Close;
                EditorFrm.ADODataSet1.CommandText :='select *From '+TableName +' where code =' +quotedstr( fCode);
                EditorFrm.ADODataSet1.Open ;
                EditorFrm.ShowModal ;

            finally
                EditorFrm.Free  ;

            end;
      end  ;
      1:
      begin
           FhlUser.ShowBillFrm(fBillId,fCode);
      end ;
      27:
      begin
           //FhlUser.ShowInvoiceFrm(fBillId,fCode);
            with TBillFrm.Create(Application) do
                begin
                  formstyle:=fsnormal;
                  hide;
                  windowState:=wsNormal;
                  position:=poMainFormCenter;
                  Label2.Visible :=false;
                  linkBtn.Visible :=false;
                  importBtn.Visible := false;
                  RemoveBtn.Visible := false;
                  NewBtn.Visible :=false;
                  SavBtn.Visible :=false;
                  CelBtn.Visible :=false;
                  AddBtn.Visible :=false;
                  DelBtn.Visible :=false;
                  ScrollBox1.Enabled :=false;
                  ScrollBox2.Enabled :=false;
                  ScrollBox1.Color :=   clwhite;
                  ScrollBox2.Color :=   clwhite;
                  InitFrm(fBillId);

                  Name:='BillFrm'+fBillId;
                  OpenBill(fCode);
                  DBGrid1.Options :=DBGrid1.Options -[dgediting];
                  Showmodal;
                end;
      end;
    end;
 end;
Screen.Cursor:=crDefault;
end;

procedure TFrmPickUniversal.ActInvoiceBillItemsExecute(Sender: TObject);
begin
      if self.PageControl.ActivePageIndex <>1 then exit;

      if    PriDbgrid1[self.PageControl.ActivePageIndex ].DataSource.DataSet.Active  then
      begin
        sDefaultVals:='ClientId='+self.fParamDataSet.FieldByName('ClientId').asString+',';
        sDefaultVals:=sDefaultVals+'Clientname='+self.fParamDataSet.FieldByName('Clientname').asString;

        FhlUser.ShowAnalyserFrm('95',null);
      end;
end;


Function  TFrmPickUniversal.IsDuplicateItem(ToDataSet,FromDataSet:TDataSet;ToStr,FormStr:string):boolean;
var i,j:integer;
Var Tlst,Slst:Tstringlist;
begin

    Tlst:=Tstringlist.Create ;
    Slst:=Tstringlist.Create ;

    Tlst.CommaText :=  ToStr;
    Slst.CommaText :=  FormStr;

    if Tlst.Count <>  Slst.Count then
    begin
        showmessage('字段有误！');
        exit;
    end;

    try
        Result:=false;
        j:=0;
        for i:=0 to   Tlst.Count -1 do
        begin
            if ToDataSet.Locate(Tlst[i],FromDataSet.fieldbyname(Slst[i]).AsString  ,[]) then
            j:=j+1;
        end;

        if j =Tlst.Count   then
        begin
            Result:=True;
        end;


     finally
         Tlst.Free ;
         Slst.free ;
     end;


end;

procedure TFrmPickUniversal.ActSelALLExecute(Sender: TObject);
var i:integer;
begin

for i:=0 to PriMtDataset1[PageControl.ActivePageIndex].RecordCount-1 do
begin
      if    (PriMtDataset1[PageControl.ActivePageIndex].FindField('Input')<>nil) and (not PriMtDataset1[PageControl.ActivePageIndex].IsEmpty ) then
      begin
              AssignToTarget;
              if PriMtDataset1[PageControl.ActivePageIndex].LockType  =ltBatchOptimistic then
                 PriMtDataset1[PageControl.ActivePageIndex].Delete ;

      end;

end;


end;

procedure TFrmPickUniversal.ActDelALLExecute(Sender: TObject);
var i:integer;
begin

    for i:=0 to fToDataSet.RecordCount-1 do
    begin
         fToDataSet.Delete ;

    end;
end;

procedure TFrmPickUniversal.ActBarCodeSearchExecute(Sender: TObject);
begin
{
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
              }
end;

function TFrmPickUniversal.GetAllParameters: Variant;
var fParams ,fParams2, fParams3:variant;
begin
    fParams:= FhlKnl1.Vr_MergeVarArray(  FhlKnl1.Ds_GetFieldsValue(fParamDataSet ,fDict.MtParams)
                            , FhlKnl1.Ds_GetFieldsValue(mtDataset1 ,fDict.DLParams));
    fParams2:= varArrayof ( [DateBegin.Date ,dateEnd.date] );
    fParams3:= FhlKnl1.Vr_MergeVarArray( fParams, fParams2  );

    //fParams3 := varArrayof(   [ fParams, DateBegin.Date ,dateEnd.date ]  )  ;

    result:=  fParams3    ;
end;

procedure TFrmPickUniversal.OpnDlDsBtn1Click(Sender: TObject);
begin
  self.FormActivate(self);
end;

end.

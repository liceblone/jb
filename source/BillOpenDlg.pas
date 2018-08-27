unit BillOpenDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, StdCtrls, Grids, DBGrids, ComCtrls, ToolWin,Variants,FhlKnl,
  ImgList,DateUtils,UnitCreateComponent;

type
  TRefersDict = record
    BillTitles:Variant;
    FromBillIds:Variant;
    MtGridIds:Variant;
    PickIds:Variant;
    CodeFlds:Variant;
    FMastFlds:Variant;
    TMastFlds:Variant;
  end;

type
  TBillOpenDlgFrm = class(TForm)
    BtnOpen: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    FileNameComboBox: TComboBox;
    Label2: TLabel;
    FileTypeComboBox: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    ADODataSet1: TADODataSet;
    EdtCode1: TEdit;
    EdtKey1: TEdit;
    Label5: TLabel;
    ComboBox1: TComboBox;
    procedure InitFrm(AFrmId:string);
    procedure InitOneBill(BillTitle,DbGridId,CodeFld:string);
    function  InitRefers(BillId:string):boolean;
    procedure FileTypeComboBoxChange(Sender: TObject);
    procedure AdoDataSet1AfterScroll(DataSet: TDataSet);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  GetFilter(ComboboxIndex:integer):string;
    procedure FormCreate(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure BtnOpenClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  //  ft:TFieldType;
    fRefersDict:TRefersDict;
    fDict:TBilOpnDlgDict;
  public
    property RefersDict:TRefersDict read fRefersDict;
  end;

var
  BillOpenDlgFrm: TBillOpenDlgFrm;

implementation

uses datamodule,bill;
{$R *.DFM}

procedure TBillOpenDlgFrm.InitFrm(AFrmId:string);
begin
  if Not FhlKnl1.Cf_GetDict_BilOpnDlg(AFrmId,fDict) then close;
  InitOneBill(fDict.BillTitle,IntToStr(fDict.DbGridId),fDict.KeyFldName);
end;

function TBillOpenDlgFrm.InitRefers(BillId:String):Boolean;
begin
 Screen.Cursor:=crSqlwait;
 try
  Caption:='引用';
  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'468',varArrayof([BillId]));
  if FhlKnl1.FreeQuery.IsEmpty then
  begin
    MessageDlg(#13#10+'对不起,没有任何可被引用的单据,或者系统数据已丢失',mtInformation,[mbYes],0);
    Abort;
  end;
  fRefersDict.FromBillIds:=FhlKnl1.Ds_GetFieldValues(FhlKnl1.FreeQuery,'F02');
  fRefersDict.BillTitles:=FhlKnl1.Ds_GetFieldValues(FhlKnl1.FreeQuery,'BillTitle');
  fRefersDict.CodeFlds:=FhlKnl1.Ds_GetFieldValues(FhlKnl1.FreeQuery,'mkeyfld');
  fRefersDict.MtGridIds:=FhlKnl1.Ds_GetFieldValues(FhlKnl1.FreeQuery,'F04');
  fRefersDict.FMastFlds:=FhlKnl1.Ds_GetFieldValues(FhlKnl1.FreeQuery,'F06');
  fRefersDict.TMastFlds:=FhlKnl1.Ds_GetFieldValues(FhlKnl1.FreeQuery,'F08');
  fRefersDict.PickIds:=FhlKnl1.Ds_GetFieldValues(FhlKnl1.FreeQuery,'F10');
  FhlKnl1.FreeQuery.Close;
  FileTypeComboBox.Items.CommaText:=FhlKnl1.Vr_varArrayToCommaStr(fRefersDict.BillTitles);

 FileTypeComboBox.ItemIndex:=0;
 FileTypeComboBoxChange(FileTypeComboBox);
 Result:=true;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TBillOpenDlgFrm.InitOneBill(BillTitle,DbGridId,CodeFld:String);
begin

  //2006-7-13加
  fDict.DbGridId := strtoint(DbGridId);

  fRefersDict.CodeFlds:=varArrayof([CodeFld]);
  FileTypeComboBox.OnChange:=nil;
  FileTypeComboBox.Items.Append(trim(BillTitle));
  FileTypeComboBox.ItemIndex:=0;
  FhlUser.SetDbGridAndDataSet(dbGrid1,DbGridId,varArrayof([LoginInfo.LoginId,LoginInfo.WhId,'a','']));
end;

procedure TBillOpenDlgFrm.FileTypeComboBoxChange(Sender: TObject);
begin
  Screen.Cursor:=crSqlwait;
 try
  FhlUser.SetDbGridAndDataSet(dbGrid1,fRefersDict.MtGridIds[FileTypeComboBox.ItemIndex],varArrayof([LoginInfo.WhId]));
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TBillOpenDlgFrm.AdoDataSet1AfterScroll(DataSet: TDataSet);
begin
 FileNameComboBox.Text:=DataSet.FieldByName(fRefersDict.CodeFlds[FileTypeComboBox.ItemIndex]).asString;
end;

procedure TBillOpenDlgFrm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 //审核颜色
 if (DataSource1.DataSet.FindField('IsChk')<>nil) and (DataSource1.DataSet.FieldByName('IsChk').AsBoolean) then
 begin
   DbGrid1.Canvas.Font.Color := clRed;
   DbGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
 end;
 //确认颜色
 if (DataSource1.DataSet.FindField('WhInCode')<>nil) and (DataSource1.DataSet.FieldByName('WhInCode').AsString<>'') then
 begin
   DbGrid1.Canvas.Font.Color := clBlue;
   DbGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
 end;
end;

procedure TBillOpenDlgFrm.FormActivate(Sender: TObject);
begin
  EdtKey1.SetFocus;
end;

procedure TBillOpenDlgFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
  begin
    if ActiveControl=EdtKey1 then
      FhlKnl1.Ds_OpenDataSet(AdoDataSet1,varArrayof([LoginInfo.LoginId,LoginInfo.WhId,'2',EdtKey1.Text]))
    else if ActiveControl=EdtCode1 then
      FhlKnl1.Ds_OpenDataSet(AdoDataSet1,varArrayof([LoginInfo.LoginId,LoginInfo.WhId,'1',EdtCode1.Text]))
    else if ActiveControl=DbGrid1 then
      self.BtnOpenClick(self);
    DbGrid1.SetFocus;
  end;      
end;

procedure TBillOpenDlgFrm.CheckBox1Click(Sender: TObject);
begin
//  if
//      FhlKnl1.Ds_OpenDataSet(AdoDataSet1,varArrayof([LoginInfo.WhId,LoginInfo.YdId,'2',EdtKey1.Text]))
end;

procedure TBillOpenDlgFrm.ComboBox1Select(Sender: TObject);
begin
      AdoDataSet1.Filter :='';
      AdoDataSet1.Filter :=GetFilter(ComboBox1.ItemIndex);
      FhlKnl1.Ds_OpenDataSet(AdoDataSet1,varArrayof([LoginInfo.LoginId,LoginInfo.WhId,intTostr(ComboBox1.ItemIndex+3),'']))
end;

procedure TBillOpenDlgFrm.DBGrid1DblClick(Sender: TObject);
begin
     Self.ModalResult:=mrOk;
   //  BtnOpenClick(self);
end;

procedure TBillOpenDlgFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (ModalResult=mrOk) and AdoDataSet1.IsEmpty then
    ModalResult:=mrNone;
end;

function TBillOpenDlgFrm.GetFilter(ComboboxIndex: integer): string;
var filter:string;
begin
  {
未审核的
今天的
最近2天的
最近3天的
最近一个星期的

}
      case  ComboboxIndex of

            0: filter:='IsChk=0';
            1: filter:='BillTime>'+quotedstr(FormatDateTime('yyyy-mm-dd ',Now-1))+' and BillTime<'+quotedstr(FormatDateTime('yyyy-mm-dd ',Now+1) );
            2: filter:='BillTime>'+quotedstr(FormatDateTime('yyyy-mm-dd ',Now-2))+' and BillTime<'+quotedstr(FormatDateTime('yyyy-mm-dd ',Now+1) );
            3: filter:='BillTime>'+quotedstr(FormatDateTime('yyyy-mm-dd ',Now-3))+' and BillTime<'+quotedstr(FormatDateTime('yyyy-mm-dd ',Now+1) );
            4: filter:='BillTime>'+quotedstr(FormatDateTime('yyyy-mm-dd ',Now-4))+' and BillTime<'+quotedstr(FormatDateTime('yyyy-mm-dd ',Now+1) );

      end;
      result:=   filter;
end;

procedure TBillOpenDlgFrm.FormCreate(Sender: TObject);
begin
self.Caption := FormatDateTime('yyyy-mm-dd ',Now-1) ;
end;

procedure TBillOpenDlgFrm.FormDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    CrtCom.FTBilOpnDlgDict:=  self.fDict;
    CrtCom.mtDataSet1:= self.ADODataSet1  ;
    CrtCom.mtDataSetId := inttostr(self.ADODataSet1.tag) ;

    CrtCom.DlGridId :=inttostr(self.DBGrid1.tag );
    CrtCom.DLGrid :=DBGrid1;





    CrtCom.TopOrBtm :=true;
    try
    CrtCom.Show;
    finally

    end;
  end;



end;


procedure TBillOpenDlgFrm.BtnOpenClick(Sender: TObject);
begin
//TBillFrm(self.Owner).OpenBill(self.FileNameComboBox.Text );
end;

procedure TBillOpenDlgFrm.Button2Click(Sender: TObject);
begin
self.Close;
end;

end.

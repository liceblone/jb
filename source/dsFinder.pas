unit dsFinder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DB, ADODB, DBCtrls, FhlKnl;



type
  TdsFinderFrm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    procedure InitFrm(FrmId:string);
    function  GetSqlStr:wideString;
    function  GetFindParams:Variant;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    fDict:TdsFinderDict;
  public
    { Public declarations }
  end;

var
  dsFinderFrm: TdsFinderFrm;

implementation
uses datamodule;
{$R *.dfm}
procedure TdsFinderFrm.InitFrm(FrmId:string);
  var ftabs:TStringList;i:integer;
begin
  if not FhlKnl1.Cf_SetdsFinderDictInfo(FrmId,fDict) then Close;
  Caption:=fDict.Caption;
  width:=fDict.Width;
  height:=fDict.Height;
  FhlUser.SetDataSet(AdoDataSet1,fDict.DataSetId,Null);
  ftabs:=TStringList.Create;
  ftabs.CommaText:=fDict.BoxIds;
  for i:=0 to ftabs.Count-1 do
      FhlKnl1.Cf_SetBox(ftabs.Strings[i],DataSource1,FhlKnl1.Pc_CreateTabSheet(PageControl1),dmFrm.DbCtrlActionList1);
  ftabs.Free;
  AdoDataSet1.Append;
end;

function  TdsFinderFrm.GetFindParams:Variant;
  var i:integer;
begin
  Result:=null;
  with AdoDataSet1 do
  begin
    Result:=varArrayCreate([0,FieldCount-1],varVariant);
    if (State=dsInsert) or (State=dsEdit) then
      Post;
    for i:=0 to FieldCount-1 do
      Result[i]:=Fields[i].AsVariant;
  end;
end;

function  TdsFinderFrm.GetSqlStr:wideString;
 var i:integer;q,l:String;
begin
  Result:='';
  with AdoDataSet1 do
  begin
    Post;
    for i:=0 to FieldCount-1 do
    begin
      if Not (Fields[i].FieldKind=fkData) or (Fields[i].AsString='') then Continue;
      if Fields[i].DataType=ftString then
      begin
         q:='''';
         l:=' like ';
      end else
      begin
         q:='';
         l:='=';
      end;
      Result:=Result+' and '+fDict.Pre+Fields[i].FieldName+l+q+Fields[i].AsString+q;
    end;
    Edit;
  end;
  if Result<>'' then
     Result:=fDict.Select+' where'+copy(Result,5,length(Result))
  else
     Result:=fDict.Select;
//  Showmessage(s);
end;

procedure TdsFinderFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_Return then
  begin
    if ssCtrl in Shift then
       ModalResult:=mrOk
    else
       Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

end.

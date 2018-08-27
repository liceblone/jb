unit TabGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, DBGrids, DB, ADODB,datamodule,FhlKnl,
  ExtCtrls,UnitCreateComponent;


type
  TTabGridFrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    okBtn: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    Image1: TImage;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    function  InitFrm(FrmId:String;fParams:Variant):Boolean;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    fDict:TTabGridDict;
  public
    { Public declarations }
  end;

var
  TabGridFrm: TTabGridFrm;

implementation

{$R *.dfm}

function  TTabGridFrm.InitFrm(FrmId:String;fParams:Variant):Boolean;
var i:integer;
begin
  Result:=False;
  if Not FhlKnl1.Cf_GetDict_TabGrid(FrmId,fdict) then Close;
  Label1.Caption:=fDict.Caption;
  self.Caption:=fDict.Caption;
  Width:=fDict.Width;
  Height:=fDict.Height;
  FhlUser.SetDbGridAndDataSet(DbGrid1,fDict.DbGridId,fParams);


  for i:=0 to ADODataSet1.FieldCount-1 do
  begin
      if ADODataSet1.Fields[i] is Tbooleanfield then
      begin
           fhlknl1.Kl_GetQuery2 ('select * from v502  where F02='+fDict.DbGridId +' and fldname='+quotedstr(ADODataSet1.Fields[i].FieldName),true );
           Tbooleanfield(ADODataSet1.Fields[i]).DisplayValues := fhlknl1.FreeQuery.fieldbyname('DisplayValues').AsString ;
      end;
  end;

end;

procedure TTabGridFrm.FormActivate(Sender: TObject);
begin
 DbGrid1.SetFocus;
end;

procedure TTabGridFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key=vk_Return then
     begin
       if not (ActiveControl is TDBGrid) then
         Perform(WM_NEXTDLGCTL, 0, 0)
       else if Not (fDict.CanInsert) and DbGrid1.DataSource.DataSet.Eof then
         OkBtn.SetFocus
       else
         FhlKnl1.Dg_SetSelectedIndex(TDbGrid(ActiveControl),fDict.CanInsert);
     end;
end;



procedure TTabGridFrm.FormDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin

  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
   CrtCom.DLGrid :=self.DBGrid1 ;
    CrtCom.DlGridId :=inttostr(self.DBGrid1.Tag );

    CrtCom.mtDataSet1 :=self.ADODataSet1 ;
    CrtCom.mtDataSetId :=inttostr(ADODataSet1.Tag );
    try
    CrtCom.Show;
    finally

    end;
  end;


   {    }

end;

procedure TTabGridFrm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DbGrid1.DataSource.DataSet.IsEmpty then exit;
  if ADODataSet1.FindField('FntClr') =nil then exit;
  
  if ADODataSet1.FieldByName('FntClr').AsString<>'' then
  begin
  DbGrid1.Canvas.Font.Color:=StringToColor(ADODataSet1.FieldByName('FntClr').AsString);
  FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,DbGrid1.Canvas.Font);
  end;
end;

end.

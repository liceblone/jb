unit WareProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, ExtCtrls, DB, ADODB, ValEdit;

type
  TwarePropFrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    WhLabel1: TLabel;
    AllLabel1: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    TabSheet4: TTabSheet;
    DBGrid11: TDBGrid;
    DataSource01: TDataSource;
    ADODataSet11: TADODataSet;
    DataSource11: TDataSource;
    Image1: TImage;
    Button2: TButton;
    Image2: TImage;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    PriceRateLabel1: TLabel;
    procedure InitFrm(WareId:String;WareDataSource:TDataSource=nil);
    procedure DBGrid11DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    WareDataSet:Tadodataset;
  end;

var
  warePropFrm: TwarePropFrm;

implementation
uses datamodule,UnitCreateComponent;
{$R *.dfm}
procedure TWarePropFrm.InitFrm(WareId:String;WareDataSource:TDataSource=nil);
begin
 Screen.Cursor:=crHourGlass;
 try
   if WareDataSource<>nil then WareDataSet:=Tadodataset(WareDataSource.dataset);
   //¿â´æ
   FhlUser.SetDbGridAndDataSet(DbGrid11,'329',varArrayof([WareId]));
   AllLabel1.Caption:=AllLabel1.Caption+FloatToStr(FhlKnl1.Ds_SumFlds(AdoDataSet11,'Stock')[0]);
   if AdoDataSet11.locate('Code',LoginInfo.WhId,[]) then
      WhLabel1.Caption:=WhLabel1.Caption+AdoDataSet11.FieldByName('Stock').asString;
   PageControl1.ActivePageIndex:=1;
   //´æ»õ
   if WareDataSource<>nil then
      FhlKnl1.Cf_SetBox('41',WareDataSource,TabSheet1,dmFrm.DbCtrlActionList1);
   //¼Û¸ñ
 //  FhlUser.SetDbGridAndDataSet(DbGrid21,'347',varArrayof([WareId]));
 //  FhlUser.SetDbGridAndDataSet(DbGrid22,'348',varArrayof([WareId]));
    dmFrm.GetQuery1('select convert(varchar(20),convert(decimal(19,6),isnull(w.salePrice, w.cost* IsNull(w.PriceRate,c.PriceRate)))) from wr_ware w inner join wr_class c on w.ClassId=c.Code and w.Id='+WareId);
    PriceRateLabel1.Caption:= dmFrm.FreeQuery1.Fields[0].AsString;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TwarePropFrm.DBGrid11DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 if AdoDataSet11.FieldByName('Code').AsString=LoginInfo.WhId then
 begin
   DBGrid11.Canvas.Font.Color := clRed;
   DBGrid11.DefaultDrawColumnCell(Rect, DataCol, Column, State);
 end;
end;

procedure TwarePropFrm.FormDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);

    CrtCom.TopOrBtm :=true;
    CrtCom.TOPBoxId :='41';

    CrtCom.mtDataSetId :=inttostr(WareDataSet.Tag ); 
    CrtCom.mtDataSet1:=self.WareDataSet ;

    CrtCom.ShowModal ;

  end;
end;

end.

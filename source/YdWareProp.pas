unit YdWareProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, ComCtrls, DB, ADODB,UnitCreateComponent;

type
  TYdWarePropFrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Image1: TImage;
    Bevel1: TBevel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    procedure InitFrm(ADgId,AModelNo:String);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDblClick(Sender: TObject);
  private
    fModel:String;
    fYds:TStringList;

    dlgridID:string;
  public
    { Public declarations }
  end;

var
  YdWarePropFrm: TYdWarePropFrm;

implementation
uses datamodule;
{$R *.dfm}

procedure TYdWarePropFrm.InitFrm(ADgId,AModelNo:String);
  var i:integer;
begin
  dlgridID:=  ADgId;
  fYds:=TStringList.Create;
  fModel:=AModelNo;
  FhlUser.SetDataSet(FhlKnl1.FreeQuery,cDsId02,null);
  with FhlKnl1.FreeQuery do
  begin
    for i:=1 to RecordCount do
    begin
      ComboBox1.Items.Append(Fields[0].asString);
      fYds.Append(Fields[1].asString);
      Next;
    end;
    Close;
  end;
//  FhlUser.SetDbGrid(ADgId,DbGrid1);
  FhlUser.SetDbGridAndDataSet(DbGrid1,ADgId,null,false);
  ComboBox1.ItemIndex:=0;
  ComboBox1Select(ComboBox1);
end;

procedure TYdWarePropFrm.ComboBox1Select(Sender: TObject);
begin
//  FhlUser.SetDataSet(AdoDataSet1,cDsId01,varArrayof([fYds.Strings[ComboBox1.ItemIndex],fModel]));
  FhlKnl1.Ds_OpenDataSet(DbGrid1.DataSource.DataSet,varArrayof([fYds.Strings[ComboBox1.ItemIndex],fModel]));
end;

procedure TYdWarePropFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fYds.Free;
  fYds:=nil;
end;

procedure TYdWarePropFrm.FormDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
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


end;
end.

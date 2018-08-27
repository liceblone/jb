unit UnitFrmGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, ComCtrls, DB, ADODB;

type
  TFrmGrid = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    btnCancel: TButton;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    LblMsg: TLabel;
    btnOk: TButton;
    procedure FormDblClick(Sender: TObject);
  private
    { Private declarations }
  public
  function  InitFrm(DbGridId:String;fParams:Variant):Boolean;
    { Public declarations }
  end;

var
  FrmGrid: TFrmGrid;

implementation
    uses datamodule,UnitCreateComponent;
{$R *.dfm}

function  TFrmGrid.InitFrm(DbGridId:String;fParams:Variant):Boolean;

begin

  FhlUser.SetDbGridAndDataSet(DbGrid1, DbGridId,fParams);


end;
procedure TFrmGrid.FormDblClick(Sender: TObject);
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

end.

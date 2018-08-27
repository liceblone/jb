unit UnitPickWareshouse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, DBCtrls, StdCtrls;

type
  TfrmPickWarehouse = class(TForm)
    DBLookupComboBox1: TDBLookupComboBox;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    Label1: TLabel;
    edtNote: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPickWarehouse: TfrmPickWarehouse;

implementation
      uses datamodule;
{$R *.dfm}

end.

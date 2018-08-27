unit UnitSysMaintain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids,datamodule, StdCtrls, DBCtrls, Mask;

type
  TForm1 = class(TForm)
    dbgrd1: TDBGrid;
    qry1: TADOQuery;
    qry1F01: TStringField;
    qry1F02: TBooleanField;
    qry1F03: TStringField;
    qry1F04: TStringField;
    qry1F07: TStringField;
    ifdqry1F5: TIntegerField;
    ifdqry1F6: TIntegerField;
    qry1F09: TStringField;
    ifdqry1F8: TIntegerField;
    qry1F10: TBooleanField;
    qry1F11: TStringField;
    qry1F12: TStringField;
    ifdqry1F13: TIntegerField;
    lbl1: TLabel;
    dbedt1: TDBEdit;
    ds2: TDataSource;
    dbchk1: TDBCheckBox;
    lbl2: TLabel;
    dbedt2: TDBEdit;
    lbl3: TLabel;
    dbedt3: TDBEdit;
    lbl4: TLabel;
    dbedt4: TDBEdit;
    lbl5: TLabel;
    dbedt5: TDBEdit;
    lbl6: TLabel;
    dbedt6: TDBEdit;
    lbl7: TLabel;
    dbedt7: TDBEdit;
    lbl8: TLabel;
    dbedt8: TDBEdit;
    dbchk2: TDBCheckBox;
    lbl9: TLabel;
    dbedt9: TDBEdit;
    lbl10: TLabel;
    dbedt10: TDBEdit;
    lbl11: TLabel;
    dbedt11: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.

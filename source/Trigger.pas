unit Trigger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB, StdCtrls, Mask, DBCtrls, ADODB, ExtCtrls,datamodule;

type
  TFrmTrigger = class(TForm)
    pgc1: TPageControl;
    ts1: TTabSheet;
    dsT207: TADODataSet;
    dsT207frmid: TStringField;
    dsT207Procname: TStringField;
    dsT207sysPrama: TStringField;
    dsT207UserPrama: TStringField;
    dsT207errHint: TStringField;
    lbl1: TLabel;
    dbedt1: TDBEdit;
    dsdsT207: TDataSource;
    lbl2: TLabel;
    dbedt2: TDBEdit;
    lbl3: TLabel;
    dbedt3: TDBEdit;
    lbl4: TLabel;
    dbedt4: TDBEdit;
    lbl5: TLabel;
    dbedt5: TDBEdit;
    dbnvgr1: TDBNavigator;
    edtFrmID: TEdit;
    btnOPenT207: TButton;
    TabSheet1: TTabSheet;
    ADODataSetT802: TADODataSet;
    ADODataSetT802f01: TIntegerField;
    ADODataSetT802F02: TIntegerField;
    ADODataSetT802F03: TStringField;
    ADODataSetT802F04: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBNavigator1: TDBNavigator;
    BtnOpenUserAct: TButton;
    procedure btnOPenT207Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsT207AfterInsert(DataSet: TDataSet);
    procedure BtnOpenUserActClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTrigger: TFrmTrigger;

implementation

{$R *.dfm}

procedure TFrmTrigger.btnOPenT207Click(Sender: TObject);
begin
    if self.edtFrmID.Text <>''then
    fhlknl1.Ds_OpenDataSet(dsT207,self.edtFrmID.Text )
    else
    fhlknl1.Ds_OpenDataSet(dsT207,'0' )
end;

procedure TFrmTrigger.FormCreate(Sender: TObject);
begin
dsT207.Connection :=fhlknl1.Connection ;
ADODataSetT802.Connection :=fhlknl1.Connection ;
end;

procedure TFrmTrigger.dsT207AfterInsert(DataSet: TDataSet);
begin
    DataSet.FieldByName('frmid').Value :=self.edtFrmID.Text ;
end;

procedure TFrmTrigger.BtnOpenUserActClick(Sender: TObject);
begin
    if self.edtFrmID.Text <>''then
    fhlknl1.Ds_OpenDataSet(ADODataSetT802,self.edtFrmID.Text )
    else
    fhlknl1.Ds_OpenDataSet(ADODataSetT802,'0' )
end;

end.

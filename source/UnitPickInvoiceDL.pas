unit UnitPickInvoiceDL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  ActnList;

type
  TFrmPickInvoiceDL = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    BtnConfirm: TButton;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    ActionList1: TActionList;
    MailAction1: TAction;
    PrintAction1: TAction;
    OpenAction1: TAction;
    NewAction1: TAction;
    RemoveAction1: TAction;
    CancelAction1: TAction;
    SaveAction1: TAction;
    CheckAction1: TAction;
    ImportAction1: TAction;
    AppendAction1: TAction;
    DeleteAction1: TAction;
    RefreshAction1: TAction;
    LocateAction1: TAction;
    CloseAction1: TAction;
    ActSELALL: TAction;
    ToolButton3: TToolButton;
    procedure CloseAction1Execute(Sender: TObject);
    procedure InitFrm(GridID: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPickInvoiceDL: TFrmPickInvoiceDL;

implementation

{$R *.dfm}

procedure TFrmPickInvoiceDL.CloseAction1Execute(Sender: TObject);
begin
self.Close;
end;

procedure TFrmPickInvoiceDL.InitFrm(GridID: string);
begin
//
end;

end.

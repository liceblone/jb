unit UnitPickSLOrderDL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  ActnList;

type
  TFrmPickSLOrderDL = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
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
    dlDataSet1: TADODataSet;
    procedure CloseAction1Execute(Sender: TObject);
    procedure InitFrm( GridID, billcode : string );
    procedure FormDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    FGridID:string;
  public
    { Public declarations }
  end;

var
  FrmPickSLOrderDL: TFrmPickSLOrderDL;

implementation
  uses datamodule, UnitCreateComponent;
{$R *.dfm}

procedure TFrmPickSLOrderDL.CloseAction1Execute(Sender: TObject);
begin
self.Close;
end;

procedure TFrmPickSLOrderDL.InitFrm( GridID, billcode : string );
begin
 // 808
    FGridID := GridID;
    FhlUser.SetDbGridAndDataSet( DBGrid1  ,GridID, billcode, true, true);
    
end;

procedure TFrmPickSLOrderDL.FormDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
    if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
    begin
    
        CrtCom:=TfrmCreateComponent.Create(self);

         CrtCom.TOPBoxId := inttostr( dlDataSet1.tag ) ;
        CrtCom.TopOrBtm:=true;
        CrtCom.mtDataSet1:=self.dlDataSet1 ;
        if self.DBGrid1<>nil then
        begin
            CrtCom.DlGridId := FGridID ;
            CrtCom.DLGrid :=self.DBGrid1 ;
        end;
        CrtCom.ShowModal ;
        CrtCom.Free ;
        {}
    end;
end;

procedure TFrmPickSLOrderDL.FormCreate(Sender: TObject);
begin
    self.DBGrid1.PopupMenu := dmfrm.DbGridPopupMenu1;
end;

procedure TFrmPickSLOrderDL.DBGrid1DblClick(Sender: TObject);
begin
    if dlDataSet1.Active then
    begin
        dlDataSet1.Edit ;
        dlDataSet1.FieldByName('qty').Value   :=1;// not dlDataSet1.FieldByName('IsSelected').AsBoolean;
           dlDataSet1.FieldByName('IsSelected').Value   :='1';// not dlDataSet1.FieldByName('IsSelected').AsBoolean;

        dlDataSet1.Post  ;
    end;
end;

end.

unit UnitBarCodePanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,DB,datamodule;

type
  TFrmPanelBarCodeList = class(TFrame)
    mmBarCodeList: TMemo;
    Label1: TLabel;
    procedure mmBarCodeListKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    dataset:tdataset;
  public
    procedure SetDataSet(pdataSet:Tdataset); 
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TFrmPanelBarCodeList.SetDataSet(pdataSet: Tdataset);
begin
self.dataset :=pdataset;
end;

procedure TFrmPanelBarCodeList.mmBarCodeListKeyPress(Sender: TObject; var Key: Char);
var
  i:integer;
begin

   if ( key=#13)and (mmBarCodeList.Lines.Count>0) then
 //  if mmBarCodeList.Lines[mmBarCodeList.Lines.Count-1]<>'' then
   begin
      try
        key:=#0;
        Screen.Cursor:=crHourGlass;

        FhlUser.DoExecProc(DataSet ,varArrayof([mmBarCodeList.Lines.CommaText]));

        FhlKnl1.Ds_RefreshDataSet(DataSet );
        Tmemo(Sender).SelectAll;
      finally
        Screen.Cursor:=crDefault;
      end;
  end;
 

  for i:= mmBarCodelist.Lines.Count-1 downto 0  do
     if (trim(mmBarCodelist.Lines[i])='') then
      mmBarCodeList.Lines.Delete(i);
end;

end.

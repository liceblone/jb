unit Downer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  TDownerFrm = class(TForm)
    Button1: TButton;
    HintLabel1: TLabel;
    mtDataSet2: TADODataSet;
    dlDataSet2: TADODataSet;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public
    fmtDataSet1,fdlDataSet1:TAdoDataSet;
  end;

var
  DownerFrm: TDownerFrm;

implementation
uses datamodule,splash;
{$R *.dfm}

procedure TDownerFrm.Button1Click(Sender: TObject);
begin
  TButton(Sender).Enabled:=False;
  if not dmFrm.ADOConnection2.Connected then
  begin
    with TsplashFrm.Create(Application) do
    begin
//      Show;
      WantConnStr('L',False);
      Free;
    end;
    with dmFrm.ADOConnection2 do
    begin
      ConnectionString:=LoginInfo.LastReceiveStr;
      try
        Connected:=true;
        DefaultDatabase:='jbhzdev';//dmFrm.ADOConnection1.DefaultDatabase
      except
        MessageDlg(#13#10'�Բ���,���ݿ�����ʧ��!   ',mtWarning,[mbOk],0);
        exit;
      end;
    end;
  end;
//  if not dmFrm.ADOConnection2.Connected then exit;
  dmFrm.ADOConnection2.BeginTrans;
  try
    with dlDataSet2 do
    begin
      CommandText:=fdlDataSet1.CommandText;
      Parameters.Assign(fdlDataSet1.Parameters);
      Open;
    end;
    with mtDataSet2 do
    begin
      CommandText:=fmtDataSet1.CommandText;
      Parameters.Assign(fmtDataSet1.Parameters);
      Open;
      if Not IsEmpty then
      begin
        if MessageDlg(#13#10'�����Ѵ�����ͬ���ŵ�����,�Ƿ񸲸�?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then
          Exception.Create('����ȡ�����β�����!')
        else begin
          FhlKnl1.Ds_ClearAllData(dlDataSet2);
          FhlKnl1.Ds_ClearAllData(mtDataSet2);
        end;
      end;
      FhlKnl1.Ds_CopyDataSet(fmtDataSet1,mtDataSet2);
      UpdateBatch;
    end;
    with dlDataSet2 do
    begin
      FhlKnl1.Ds_CopyDataSet(fdlDataSet1,dlDataSet2);
      UpdateBatch;
    end;
    dmFrm.ADOConnection2.CommitTrans;
    MessageDlg(#13#10'�ѳɹ����ݱ�������!',mtInformation,[mbOk],0);
  except
    on E: Exception do
    begin
      MessageDlg(#13#10+E.Message,mtError,[mbOk],0);
      dmFrm.ADOConnection2.RollbackTrans;
    end;
  end;
end;

end.

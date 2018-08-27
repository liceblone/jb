
unit fncarry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TfncarryFrm = class(TForm)
    RadioGroup1: TRadioGroup;
    HintLabel1: TLabel;
    Button1: TButton;
    Button2: TButton;
    DateTimePicker1: TDateTimePicker;
    procedure ShowHint(Str:String='');
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fncarryFrm: TfncarryFrm;

implementation
uses datamodule;
{$R *.dfm}

procedure TfncarryFrm.ShowHint(Str:String='');
begin
 with HintLabel1 do
 begin
   if Str='' then
     Caption:=Caption+'.'
   else
     Caption:=Str;
   Update;
 end;
end;

procedure TfncarryFrm.Button1Click(Sender: TObject);
var
  v:Variant;
  s:string;
  b:boolean;
begin
  v:=varArrayof([formatdatetime('yyyy"-"mm"-"dd',DateTimePicker1.DateTime),LoginInfo.EmpId]);
  dmFrm.ADOConnection1.BeginTrans;
  try
    ShowHint('����Ƿ���δ��˵ĵ���...');
    b:=dmFrm.ExecStoredProc('sys_carry_ischk',v);
    s:=dmFrm.FreeStoredProc1.Parameters.Items[1].Value;
    if s<>'' then MessageDlg(#13#10+s,mtError,[mbOk],0);
//    if Not b then Abort;
    if b then
    begin
    ShowHint('�ͻ��ʽ�ת...');
    dmFrm.ExecStoredProc('sys_carry_client',v);
    ShowHint('�����ʽ�ת...');
    dmFrm.ExecStoredProc('sys_carry_bank',v);
    ShowHint('����ת...');
    dmFrm.ExecStoredProc('sys_carry_stock',v);
    ShowHint('����ҵ������...');
    dmFrm.ExecStoredProc('sys_carry_export',v);
    ShowHint('�����ʷ����...');
    dmFrm.ExecStoredProc('sys_carry_clear',v);
    ShowHint('��ת�ɹ���');
    dmFrm.ADOConnection1.CommitTrans;
    end
    else
      dmFrm.ADOConnection1.RollbackTrans;
  except
    on e:Exception do
    begin
      dmFrm.ADOConnection1.RollbackTrans;
      MessageDlg(format('%s',[e.message]),mtError,[mbOk],0);
    end;
  end;
end;

procedure TfncarryFrm.Button2Click(Sender: TObject);
var
  v:Variant;
  s:string;
  b:boolean;
begin
  v:=varArrayof([formatdatetime('yyyy"-"mm"-"dd',DateTimePicker1.DateTime),LoginInfo.EmpId]);
  dmFrm.ADOConnection1.BeginTrans;
  try
    ShowHint('�ͻ��ʷ���ת...');
    dmFrm.ExecStoredProc('sys_carry_clientx',v);
    ShowHint('�����ʷ���ת...');
    dmFrm.ExecStoredProc('sys_carry_bankx',v);
    ShowHint('��淴��ת...');
    dmFrm.ExecStoredProc('sys_carry_stockx',v);
    ShowHint('����ҵ������...');
    dmFrm.ExecStoredProc('sys_carry_exportx',v);
    ShowHint('�����ʷ����...');
    dmFrm.ExecStoredProc('sys_carry_clearx',v);
    ShowHint('����ת�ɹ���');
    dmFrm.ADOConnection1.CommitTrans;
  except
    on e:Exception do
    begin
      dmFrm.ADOConnection1.RollbackTrans;
      MessageDlg(format('%s',[e.message]),mtError,[mbOk],0);
    end;
  end;
end;

end.

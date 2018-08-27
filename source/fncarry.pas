
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
    ShowHint('检查是否有未审核的单据...');
    b:=dmFrm.ExecStoredProc('sys_carry_ischk',v);
    s:=dmFrm.FreeStoredProc1.Parameters.Items[1].Value;
    if s<>'' then MessageDlg(#13#10+s,mtError,[mbOk],0);
//    if Not b then Abort;
    if b then
    begin
    ShowHint('客户帐结转...');
    dmFrm.ExecStoredProc('sys_carry_client',v);
    ShowHint('银行帐结转...');
    dmFrm.ExecStoredProc('sys_carry_bank',v);
    ShowHint('库存结转...');
    dmFrm.ExecStoredProc('sys_carry_stock',v);
    ShowHint('导出业务数据...');
    dmFrm.ExecStoredProc('sys_carry_export',v);
    ShowHint('清除历史数据...');
    dmFrm.ExecStoredProc('sys_carry_clear',v);
    ShowHint('结转成功！');
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
    ShowHint('客户帐反结转...');
    dmFrm.ExecStoredProc('sys_carry_clientx',v);
    ShowHint('银行帐反结转...');
    dmFrm.ExecStoredProc('sys_carry_bankx',v);
    ShowHint('库存反结转...');
    dmFrm.ExecStoredProc('sys_carry_stockx',v);
    ShowHint('导回业务数据...');
    dmFrm.ExecStoredProc('sys_carry_exportx',v);
    ShowHint('清除历史数据...');
    dmFrm.ExecStoredProc('sys_carry_clearx',v);
    ShowHint('反结转成功！');
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

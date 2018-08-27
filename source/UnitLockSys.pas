unit UnitLockSys;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,  datamodule,Login,

  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmLockSys = class(TForm)
    lbl1: TLabel;
    edtPassword: TEdit;
    lbl2: TLabel;
    tmr1: TTimer;
    btnOK: TButton;
    btnClear: TButton;
    bvl1: TBevel;
    BtnMinimize: TButton;
    btnExit: TButton;
    procedure tmr1Timer(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnMinimizeClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cnt:integer;
  end;



implementation

{$R *.dfm}

procedure TfrmLockSys.tmr1Timer(Sender: TObject);
begin
   cnt:=cnt+1;
   if (cnt mod 2=0 ) then lbl2.Visible :=true else lbl2.Visible :=false;   
   if cnt>100 then cnt:=0 ;
end;

procedure TfrmLockSys.btnClearClick(Sender: TObject);
begin
edtPassword.Clear ;
tmr1.Enabled :=false;
lbl2.Visible :=false;

end;

procedure TfrmLockSys.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if self.ModalResult = mrOk then
begin
      if   dmFrm.ExecStoredProc('sys_LoginUnLock',varArrayof([LoginInfo.LoginId ,edtPassword.Text] )) then
          close
      else
      begin
          self.tmr1.Enabled:=true;
          action :=  caNone;
      end;
end;

end;

procedure TfrmLockSys.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
self.btnOK.Click ;

    if   (shift   =   [ssAlt])   and   (key   =   vk_F4)   then
              begin
                  shift   :=   [];
                  key   :=   0;
              end;
end;

procedure TfrmLockSys.BtnMinimizeClick(Sender: TObject);
begin
application.Minimize ;
end;

procedure TfrmLockSys.btnExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

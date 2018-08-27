unit Mailer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, ExtCtrls, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, Menus;

type
  TMailerFrm = class(TForm)
    EdtTo1: TLabeledEdit;
    EdtSubject1: TLabeledEdit;
    BodyMemo1: TMemo;
    ListBox1: TListBox;
    Label1: TLabel;
    Button1: TButton;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    SMTP: TIdSMTP;
    MailMessage: TIdMessage;
    AttachmentDialog: TOpenDialog;
    StatusMemo1: TMemo;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    DelBtn1: TToolButton;
    ToolButton7: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SMTPStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure DelBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MailerFrm: TMailerFrm;

implementation
uses datamodule;
{$R *.dfm}

procedure TMailerFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TMailerFrm.SMTPStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: String);
begin
  StatusMemo1.Lines.Insert(0,'Status: ' + AStatusText);
end;

procedure TMailerFrm.ToolButton2Click(Sender: TObject);
var
  i:integer;
begin
  StatusMemo1.Clear;

  //setup SMTP
  SMTP.Host := LoginInfo.SmtpHost;
  SMTP.Port := LoginInfo.SmtpPort;
  SMTP.Username := LoginInfo.SmtpUser;
  SMTP.Password := LoginInfo.SmtpPass;
  SMTP.AuthenticationType := atLogin;
  //setup mail message
  MailMessage.From.Address := LoginInfo.SmtpFrom;
  MailMessage.Recipients.EMailAddresses := EdtTo1.Text;

  MailMessage.Subject := EdtSubject1.Text;
  MailMessage.Body.Text := BodyMemo1.Text;

  with ListBox1 do
    for i:=0 to Items.Count-1 do
      if FileExists(Items.Strings[i]) then
        TIdAttachment.Create(MailMessage.MessageParts, Items.Strings[i]);

  //send mail
  try
    try
      SMTP.Connect(1000);
      SMTP.Send(MailMessage);
    except on E:Exception do
      StatusMemo1.Lines.Insert(0, 'ERROR: ' + E.Message);
    end;
  finally
    if SMTP.Connected then SMTP.Disconnect;
  end;

end;

procedure TMailerFrm.ToolButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TMailerFrm.ToolButton5Click(Sender: TObject);
var
  s:TFileName;
begin
  with dmFrm.OpenDialog1 do
  begin
    Filter:='所有文件(*.*)|*.*';
    if Execute then
      s:=FileName
    else
      exit;
  end;
  ListBox1.Items.Append(s);
end;

procedure TMailerFrm.DelBtn1Click(Sender: TObject);
begin
  ListBox1.DeleteSelected;
end;

end.

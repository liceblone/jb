unit email;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Psock, NMsmtp;

type
  TemailFrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    mail_name: TLabeledEdit;
    mail_host: TLabeledEdit;
    mail_user: TLabeledEdit;
    mail_password: TLabeledEdit;
    mail_port: TLabeledEdit;
    GroupBox5: TGroupBox;
    mail_receiver: TLabeledEdit;
    Button2: TButton;
    Button7: TButton;
    Button1: TButton;
    NMSMTP1: TNMSMTP;
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  emailFrm: TemailFrm;

implementation

{$R *.dfm}

procedure TemailFrm.Button7Click(Sender: TObject);
begin
 NMSMTP1.Host:=mail_host.Text;
 NMSMTP1.UserID:=mail_user.text;
 NMSMTP1.Port:=strToint(mail_port.text);
 NMSMTP1.PostMessage.ToAddress.CommaText:=mail_receiver.Text;
 NMSMTP1.PostMessage.Subject:='xtjxc';
// NMSMTP1.PostMessage.Body.Append(server_ip.caption);
 NMSMTP1.PostMessage.FromName:=mail_name.text;
 NMSMTP1.PostMessage.FromAddress:='xtjxc';
 NMSMTP1.Connect;
 if NMSMTP1.Connected then
 NMSMTP1.SendMail
 else
 showMessage('¡¨Ω” ß∞‹');
  NMSMTP1.Disconnect;
end;

end.

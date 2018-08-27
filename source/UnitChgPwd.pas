unit UnitChgPwd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmChgPwd = class(TForm)
    edtOriPwd: TEdit;
    Label1: TLabel;
    edtNewPwd: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtConfirmPwd: TEdit;
    BtnOk: TButton;
    edtUserName: TEdit;
    Label4: TLabel;
    warningLabel: TLabel;
    procedure BtnOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmChgPwd: TFrmChgPwd;

implementation
uses datamodule ;
{$R *.dfm}


procedure TFrmChgPwd.BtnOkClick(Sender: TObject);
var

sql:string;
begin
try


    begin
       sql:='select * From sys_user where  loginid='  + quotedstr(edtUserName.Text) ;
       fhlknl1.Kl_GetUserQuery(sql);

       if  fhlknl1.User_Query.IsEmpty then
       begin
           self.warningLabel.Caption :='�û���������!';
           warningLabel.Visible :=true;
           exit;
       end;
       if  edtNewPwd.Text <>edtConfirmPwd.Text then
       begin
           self.warningLabel.Caption :='�����벻ƥ��!';
           warningLabel.Visible :=true;
           exit;
       end;

       if  length(edtNewPwd.Text )<6  then
       begin
           self.warningLabel.Caption :='���볤�Ȳ���С��6λ';
           warningLabel.Visible :=true;
           exit;
       end;

        

       sql:='select * From sys_user where  loginid='  + quotedstr(edtUserName.Text) +' and password='+quotedstr(edtOriPwd.Text );
       fhlknl1.Kl_GetUserQuery(sql);
       if  fhlknl1.User_Query.IsEmpty then
       begin
           self.warningLabel.Caption :='ԭ���벻��ȷ!';
           warningLabel.Visible :=true;
           exit;
       end;

       if  edtOriPwd.Text=edtNewPwd.Text then
       begin
           self.warningLabel.Caption :='�����벻��ԭ������ͬ!';
           warningLabel.Visible :=true;
           exit;
       end;
       try
           sql:='update sys_user set password= '+quotedstr(edtNewPwd.Text)   +' ,passwordx='+quotedstr(edtNewPwd.Text)   +'   where  loginid='  + quotedstr(edtUserName.Text) +' and password='+quotedstr(edtOriPwd.Text );
           fhlknl1.Kl_GetUserQuery(sql,false);
           showmessage(' �����޸ĳɹ�!');
           self.Close ;

           warningLabel.Visible :=false;
       except
            self.warningLabel.Caption :=' �����޸�ʧ��!';
       end;

      warningLabel.Left :=trunc(self.Width/2-warningLabel.Width /2)


    end;
finally
    FrmChgPwd.Free ;
end;

 end;
procedure TFrmChgPwd.FormKeyDown(Sender: TObject; var Key: Word;
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

end.

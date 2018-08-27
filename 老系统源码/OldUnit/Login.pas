unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,UnitPublicFunction,
  StdCtrls, ExtCtrls, Db,variants,Inifiles, ComCtrls;

type
  TLoginFrm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    pwEdit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Bevel2: TBevel;
    Label5: TLabel;
    userEdit1: TEdit;
    warningLabel: TLabel;
    Timer1: TTimer;
    Image1: TImage;
    Label6: TLabel;
    ydBox1: TComboBox;
    Label7: TLabel;
    placeBox1: TComboBox;
    Bevel3: TBevel;
    Label8: TLabel;
    tabBox1: TComboBox;
    chkRmberPsWd: TCheckBox;
    pb1: TProgressBar;
    BtnOldSystem: TButton;
    procedure Timer1Timer(Sender: TObject);
    procedure pwEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tabBox1Change(Sender: TObject);
    procedure ydBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pwEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    function gettimestamp(var Pcomputer:string;var PID:integer):string;
    function ThereIsSomeOnline:boolean;
    procedure BtnOldSystemClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    fTabs,fDbNames,fFiliales,fWhs:TStringList;
    fComputerName,fIpAddr:String;
    f:TIniFile;
  public
     ComputerName:string;
  end;

var
  LoginFrm: TLoginFrm;

implementation
uses datamodule;
{$R *.DFM}


procedure TLoginFrm.Timer1Timer(Sender: TObject);
begin
  warningLabel.Visible:=not warningLabel.Visible;
end;

procedure TLoginFrm.pwEdit1Change(Sender: TObject);
begin
  Timer1.Enabled:=false;
  warninglabel.visible:=false;
end;

procedure TLoginFrm.FormCreate(Sender: TObject);
begin



 fFiliales:=TStringList.Create;
 fTabs:=TStringList.Create;
 fDbNames:=TStringList.Create;
 fWhs:=TStringList.Create;
 f:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\cfg.ini');

 fComputerName:=FhlKnl1.Os_GetComputerName;
// fIpAddr:=FhlKnl1.Os_GetComputerIp;

 FhlKnl1.Kl_GetQuery2('select code,name from sys_filiale where IsUse=1');
 {杭州晶贝电子科技有限公司
温州市晶贝电子科技有限公司
杭州晶贝电子科技有限公司163号
温州市晶贝电子科技有限公司乐清分部
}
 with FhlKnl1.FreeQuery do
 begin
   while not eof do
   begin
     ydBox1.Items.Append(Fields[1].asString);
     fFiliales.Append(Fields[0].asString);
     Next;
   end;
   Close;
 end;

 userEdit1.Text:=f.ReadString('Login','LoginId','');
 ydBox1.ItemIndex:=f.ReadInteger('Login','YdIdx',0);
 ydBox1Change(ydBox1);
 tabBox1.ItemIndex:=f.ReadInteger('Login','TabIdx',0);
 tabBox1Change(tabBox1);
 placeBox1.ItemIndex:=f.ReadInteger('Login','WhIdx',0);

 if  f.ReadInteger('RmBerPsWd','RmBerPsWd',0)=1 then
 begin
   pwEdit1.Text :=FhlKnl1.St_Encrypt(f.ReadString ('PassWord','PassWord',''));//
   chkRmberPsWd.Checked :=true;
 end;

end;

procedure TLoginFrm.ydBox1Change(Sender: TObject);
begin
  tabBox1.Items.Clear;
  placeBox1.Items.Clear;
  fTabs.Clear;
  fDbNames.Clear;

  FhlKnl1.Kl_GetQuery2('select * from sys_tab where filialeid='''+fFiliales.Strings[ydBox1.ItemIndex]+'''');
  with FhlKnl1.FreeQuery do
  begin
   Button1.Enabled:=Not Isempty;
   if Isempty then
   begin
      MessageDlg(#13#10+'该分公司尚未有任何帐套,请创建新帐套.',mtInformation,[mbOk],0);
      Exit;
   end;
   while not eof do
   begin
      tabBox1.Items.Append(FieldByName('name').asString);
      fTabs.Append(FieldByName('code').asString);
      fDbNames.Append(FieldByName('db').asString);
      Next;
   end;
   Close;
  end;
  tabBox1.ItemIndex:=0;
  tabBox1Change(tabBox1);
end;

procedure TLoginFrm.tabBox1Change(Sender: TObject);
begin
  placeBox1.Items.Clear;
  fWhs.Clear;
  dmFrm.ADOConnection1.DefaultDatabase:=fDbNames.Strings[tabBox1.ItemIndex];
  FHLKNL1.GetUserDataBase(fDbNames.Strings[tabBox1.ItemIndex])  ;
  dmFrm.GetQuery1('select Code,Name from wh_warehouse');
  with dmfrm.freeQuery1 do
  begin
    if IsEmpty then  exit;
    while not eof do
    begin
      placeBox1.Items.Append(Fields[1].asString);
      fWhs.Append(Fields[0].asString);
      Next;
    end;
    Close;
  end;
  placeBox1.ItemIndex:=0;
end;

procedure TLoginFrm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  fEId,fLTime:String;
  FLockTime:integer;
begin
    if ModalResult=mrOk then
    begin
          //is anyone already online?
          if   not  ThereIsSomeOnline then
          begin

                if dmFrm.ExecStoredProc('sys_Login',varArrayof([fWhs.Strings[placeBox1.ItemIndex],userEdit1.Text,pwEdit1.Text,fComputerName,fIpAddr])) then
                begin
                    fEId:=dmFrm.FreeStoredProc1.Parameters.ParamValues['@EmpId'];
                    FLockTime:=dmFrm.FreeStoredProc1.Parameters.ParamValues['@LockTime'];
                    fLTime:=FormatDateTime('yyyy"-"mm"-"dd" "hh":"nn":"ss"."zzz',dmFrm.FreeStoredProc1.Parameters.ParamValues['@LoginTime']);

                    FhlUser.Logout('注消,并以'+userEdit1.Text+'重新登陆');
                    with LoginInfo do
                    begin
                          EmpId:=fEId;
                          LoginTime:=fLTime;
                          YdId:=fFiliales.Strings[ydBox1.ItemIndex];
                          TabId:=fTabs.Strings[tabBox1.ItemIndex];
                          WhId:=fWhs.Strings[placeBox1.ItemIndex];
                          LoginId:=userEdit1.Text;
                          LockTime:=FLockTime;
                    end;

                  FhlUser.SetDataSet(FhlKnl1.FreeQuery,'527',LoginInfo.YdId);
                  with FhlKnl1.FreeQuery do
                  begin
                        with LoginInfo do
                        begin
                              FirmCnName:=FieldByName('Name').asString;
                              FirmEnName:=FieldByName('eName').asString;
                              Address:=FieldByName('Addr').asString;
                              Zip:=FieldByName('Zip').asString;
                              Tel:=FieldByName('Tel').asString;
                              Fax:=FieldByName('Fax').asString;
                          {
                              SmtpHost:=FieldByName('SmtpHost').asString;
                              SmtpPort:=FieldByName('SmtpPort').asInteger;
                              SmtpUser:=FieldByName('SmtpUser').asString;
                              SmtpPass:=FieldByName('SmtpPass').asString;
                          }
                        end;
                        Close;
                  end;

                  Action:=caFree;
                  Application.MainForm.Caption:=Application.Title+' - '+ydBox1.Items.Strings[ydBox1.ItemIndex]+' - '+tabBox1.Items.Strings[tabBox1.ItemIndex];
                  f.WriteInteger('Login','YdIdx',ydbox1.ItemIndex);
                  f.WriteInteger('Login','TabIdx',tabbox1.ItemIndex);
                  f.WriteInteger('Login','WhIdx',placeBox1.ItemIndex);
                  f.WriteString('Login','LoginId',userEdit1.Text);
                  if chkRmberPsWd.Checked then
                  begin
                      f.Writeinteger('RmBerPsWd','RmBerPsWd',1);
                      f.WriteString('PassWord','PassWord',FhlKnl1.St_Encrypt(pwEdit1.Text));
                  end
                  else
                      f.Writeinteger('RmBerPsWd','RmBerPsWd',0);

                  FreeAndNil(f);
               end else
               begin
                     MessageDlg(#13#10+Format(dmFrm.FreeStoredProc1.Parameters.ParamValues['@ErrorMsg'],[userEdit1.Text,placeBox1.Items.Strings[placeBox1.ItemIndex]]),mtError,[mbOk],0);
                     Timer1.Enabled:=true;
                     Action:=caNone;
               end;
          end
         else
         begin
                 MessageDlg(#13#10+'已经有用户在计算机名为（ '+ComputerName+' ）的机子上使用该帐号',mtError,[mbOk],0);
                 Action:=caNone;
          end;

    end;
end;

procedure TLoginFrm.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  releasecapture;
  perform(wm_syscommand,sc_move+1,0);
end;

procedure TLoginFrm.pwEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (ssAlt in Shift) and (ssShift in Shift) and (Key=vk_F12) then
    ShowMessage(dmFrm.ADOConnection1.ConnectionString);
end;

function TLoginFrm.gettimestamp(var Pcomputer:string;var PID:integer): string;
var asql:string;

begin
// 当天最后一次非本机登录，且没正常退出

         asql:=' select  top 1 *  from sys_loginlog     '
              +' where loginid='+quotedstr(userEdit1.Text  )+'  and islogin=1   '
              +' and convert(char(10),intime,121)  =convert(char(10),getdate(),121) '
              +' and computer <> '+quotedstr(fComputerName)+' and outtime is  null order by intime desc '  ;

            dmFrm.GetQuery1(asql );
            with dmfrm.freeQuery1 do
            begin
                if  FieldByName('outtime').AsString ='' then
                begin
                   Pcomputer:= FieldByName('computer').AsString ;
                   PID:=FieldByName('id').AsInteger ;
                   result :=  FieldByName('online').asstring  ;
                end                                           
                else
                  result :=  '';
            end;
end;

function TLoginFrm.ThereIsSomeOnline: boolean;
  var timestamp1,timestamp2:string;
  var i,pmax:integer;
  var asql:string;
  var id1,id2:integer;
begin
self.Cursor := crsqlwait;

//result:=false;

{  }
           timestamp1:= self.gettimestamp (ComputerName,id1);
           if     timestamp1<>'' then
           begin
               if         messagedlg('系统检测到有人可能在使用你的帐号,需要约半分钟时间检查。'+chr(10)+chr(13)+' 如果需要知道哪台电脑在使用你的帐号请按yes,按no 直接进入系统.',mtConfirmation,[mbYes, mbNo] ,0)=mrno then
               begin
                result:=false;
                exit;
               end;
               self.Refresh;
               pmax:=50;
               self.pb1.Max :=pmax;

               for i:=1 to pmax do
               begin
                    self.pb1.Position :=i;
                    sleep(440);
               end;

               timestamp2:= self.gettimestamp (ComputerName,id2);
               if   timestamp2=timestamp1 then
               begin
                   asql:=' update  sys_loginlog     set outtime=getdate() '
                        +' where id='+ inttostr(id1);
                      dmFrm.GetQuery1(asql ,false);
                   result:=false;
               end
               else
                   result:=true;
           end
           else
               result:=false;



           self.Cursor := crdefault;
end;

procedure TLoginFrm.BtnOldSystemClick(Sender: TObject);
Var FileName,parameters:string;
begin
    filename:= 'OLdJBSysteam.exe ';
    parameters:= filename ;
    winexec(pchar(parameters ),0)  ;

end;

procedure TLoginFrm.FormActivate(Sender: TObject);
begin
self.Label1.Caption :=   Label1.Caption+ JbGetversion;
self.Label2.Caption :=   Label2.Caption+  JbGetversion;
end;

end.

unit desktop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, OleCtrls,  Menus, IniFiles,
  StdActns, ActnList, Buttons, DB, ADODB, FhlKnl, Sockets, AppEvnts,UnitDesignMainMenu,UnitLockSys;

type
  TDesktopFrm = class(TForm)           //TForm
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    Image1: TImage;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    OpenBill: TAction;
    OpenTreeEditor: TAction;
    OpenTreeGrid: TAction;
    OpenTabEditor: TAction;
    OpenTreeMgr: TAction;
    OpenMore2More: TAction;
    Navigate: TAction;
    OpenAnalyser: TAction;
    OpenEditor: TAction;
    LoginSystem: TAction;
    WindowCloseAll1: TAction;
    WindowClose1: TWindowClose;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowTileVertical1: TWindowTileVertical;
    WindowMinimizeAll1: TWindowMinimizeAll;
    WindowMaxmizeAll1: TAction;
    WindowSwitch1: TAction;
    Panel1: TPanel;
    NodeDataSet1: TADODataSet;
    ExecSql2: TAction;
    TcpClient1: TTcpClient;
    TcpServer1: TTcpServer;
    Action1: TAction;
    ToolButton1: TToolButton;
    ApplicationEvents1: TApplicationEvents;
    actOpenPickWindow: TAction;
    actLockSys: TAction;
    tmrLockSys: TTimer;
    tmr1: TTimer;
    OpenCrmForm: TAction;
    RunExe: TAction;
    ActDemo: TAction;
    OpenMainMenu: TAction;
    dsMainMenu: TADODataSet;
    dsMainMenuDBName: TStringField;
    OpenInvoice: TAction;
    OpenAnalyserProcedure: TAction;
    ActOpenWrTransformBill: TAction;
    ActWhOutEx: TAction;
    ActOpenBillEx: TAction;
    btn1: TToolButton;
    ActAnalysEX: TAction;
    ActOpenCostSystem: TAction;
    procedure InitMenu;
    procedure OpenBillExecute(Sender:TObject);
    procedure OpenTreeEditorExecute(Sender:Tobject);
    procedure OpenTreeGridExecute(Sender:Tobject);
    procedure OpenAnalyserExecute(Sender:TObject);
    procedure OpenTabEditorExecute(Sender: TObject);
    procedure OpenTreeMgrExecute(Sender: TObject);
    procedure actOpenPickWindowExecute(Sender: TObject);  //2006-7-4独立引入界面
    procedure LoginSystemExecute(Sender: TObject);
    procedure CloseMainFrmExecute(Sender: TObject);
    function  Reg:Boolean;
    procedure OpenRemind;
    procedure InitStatusbar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WindowCloseAll1Execute(Sender: TObject);
    procedure WindowMaxmizeAll1Execute(Sender: TObject);
    procedure WindowSwitch1Execute(Sender: TObject);
    function  DoMenuAction(MenuName:String):Boolean;
    procedure OpenMore2MoreExecute(Sender: TObject);
    procedure ExecSql2Execute(Sender: TObject);
    procedure OpenEditorExecute(Sender: TObject);
    procedure TcpServer1Accept(Sender: TObject;
      ClientSocket: TCustomIpClient);
    procedure Button3Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ToolBar1DblClick(Sender: TObject);
    procedure actLockSysExecute(Sender: TObject);
    procedure tmrLockSysTimer(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure OpenMainMenuExecute(Sender: TObject);
    procedure FrmActExecute(sender: Tobject);
    procedure ChangSubSysName(SubSysName:string);

    procedure OpenCrmFormExecute(Sender: TObject);
    procedure OpenInvoiceExecute(Sender: TObject);
    procedure ActOpenWrTransformBillExecute(Sender: TObject);
    procedure ActWhOutExExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActOpenBillExExecute(Sender: TObject);
    procedure ActAnalysEXExecute(Sender: TObject);
    procedure ActOpenCostSystemExecute(Sender: TObject);



  private

  public
    { Public declarations }
    lockP1,lockp2,lockp3:Tpoint;
    time:integer;
    frmLockSys:TfrmLockSys;


  end;

type
  TMgrThrd = class (TThread)
  protected
    procedure Execute; override;
  end;

var
  DesktopFrm: TDesktopFrm;

implementation
uses datamodule,Login,about, main,UnitUpdateHint;
{$R *.dfm}

procedure TMgrThrd.Execute;
begin
 if dmFrm.ConnectServer(desktopFrm.Caption) then DeskTopFrm.Reg;
end;

procedure TDesktopFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=caNone;
end;

procedure TDesktopFrm.InitMenu;
begin
  FhlUser.SetDataSet(self.DSMainMenu ,'526',LoginInfo.LoginId+','+logininfo.SysDBPubName );      //Sys_GetMainMenu 取得应该显示的菜单
  FhlKnl1.Cf_SetMainMenu('1',MainMenu1,ToolBar1,ActionList1,self.DSMainMenu );       //生成菜单
end;

function TDesktopFrm.DoMenuAction(MenuName:String):Boolean;
  var fItem:TMenuItem;
begin
  fItem:=FhlKnl1.Mn_FindMainMenuItem(MainMenu1,MenuName);
  if fItem<>nil then
     fItem.Click;
  Result:=fItem<>nil;
end;

procedure TDesktopFrm.OpenBillExecute(Sender:TObject);
var  Form:TForm;
begin
    if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
      FrmActExecute(Sender)  ;

    FhlUser.ShowBillFrm(intTostr((Sender As TComponent).Tag));
end;

procedure TDesktopFrm.OpenTreeEditorExecute(Sender:TObject);
begin
if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
  FrmActExecute(Sender)  ;
  FhlUser.ShowTreeEditorFrm(intTostr((Sender As TComponent).Tag));
//   showmessage((Sender As TComponent).Name );
end;

procedure TDesktopFrm.OpenTreeGridExecute(Sender:TObject);
begin

if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
   FrmActExecute(Sender)  ;
 FhlUser.ShowTreeGridFrm(intTostr((Sender As TComponent).Tag));
// showmessage((Sender As TComponent).Name );
end;

procedure TDesktopFrm.OpenAnalyserExecute(Sender:TObject);
begin
if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
  FrmActExecute(Sender)  ;
  FhlUser.ShowAnalyserFrm(intTostr((Sender As TComponent).Tag),null);
end;

procedure TDesktopFrm.OpenTabEditorExecute(Sender: TObject);
begin
if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
  FrmActExecute(Sender)  ;
 FhlUser.ShowTabEditorFrm(intTostr((Sender As TComponent).Tag),sOpenParamsVar,nil,False,crAppStart);
end;

procedure TDesktopFrm.OpenTreeMgrExecute(Sender: TObject);
begin
if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
  FrmActExecute(Sender)  ;
  FhlUser.ShowTreeMgrFrm(intTostr((Sender As TComponent).Tag));
end;

procedure TDesktopFrm.LoginSystemExecute(Sender: TObject);
begin
 WindowCloseAll1Execute(Sender);
   FrmActExecute(Sender)  ;
 Reg;
end;

procedure TDesktopFrm.OpenRemind;
begin

  if not logininfo.IsDev then
  begin
    fhlknl1.Kl_GetUserQuery('exec Pr_GetRemindInformation');
    if fhlknl1.User_Query.RecordCount >0 then
    begin
        if UpperCase( fhlknl1.Connection.DefaultDatabase ) <> UpperCase(dsMainMenu.FieldByName('SubSysDBName').AsString) then
        begin
           fhlknl1.Connection.DefaultDatabase:= 'jingbeiNewSys';//dsMainMenu.FieldByName('SubSysDBName').AsString   ;
           fhlknl1.CloseSysDataSet;
        end;
    end;

    FhlUser.ShowAnalyserExFrm('41' ,null, fsMDIForm );
  end;
end;

function TDesktopFrm.Reg:Boolean;
begin
 Result:=false;
 LoginFrm:=TLoginFrm.Create(Application);
 if LoginFrm.ShowModal=mrOk then
 begin
    InitMenu;
    InitStatusbar;
    dmfrm.ConfigMenu;  //设置菜单可用性
    if not FhlKnl1.SetTime then showmessage('设置时间失败!');

    OpenRemind;
    Result:=true;
 end;
 FreeAndNil(LoginFrm);

end;

procedure TDesktopFrm.InitStatusbar;
var Strvalues :Tstringlist;
var i:integer;
begin
    Strvalues :=Tstringlist.Create ;
    mainFrm.Statusbar1.Panels.Clear;
    FhlKnl1.Kl_GetQuery2('select * from T509 order by F04');

    with FhlKnl1.FreeQuery do
    begin
      while not eof do
      begin
            with mainFrm.Statusbar1.Panels.Add do
            begin
              Width:=FieldByName('F05').asInteger;
              Text:=FieldByName('F02').asString;//+FhlUser.GetSysParamVal(FieldByName('F03').asString);
              Strvalues.Add(FieldByName('F03').asString) ;
            end;
            Next;
      end;
      Close;
    end;
     for i:=0 to mainFrm.Statusbar1.Panels.Count -1 do
     begin
        mainFrm.Statusbar1.Panels[i].Text :=mainFrm.Statusbar1.Panels[i].Text + FhlUser.GetSysParamVal( Strvalues[i]);
     end;

    Strvalues.Free;

end;

procedure TDesktopFrm.CloseMainFrmExecute(Sender: TObject);
begin
 Application.MainForm.Close;
// Application.Terminate;
end;

procedure TDesktopFrm.WindowCloseAll1Execute(Sender: TObject);
 var i:integer;
begin
  with Application.MainForm do
    for i:=MDIChildCount-1 downto 0 do
      MDIChildren[i].Close;
end;

procedure TDesktopFrm.WindowMaxmizeAll1Execute(Sender: TObject);
 var i:integer;
begin
  with Application.MainForm do
  begin
    for i:=0 to MDIChildCount-1 do
    if  uppercase(MDIChildren[i].Name)='DESKTOPFRM' THEN
      MDIChildren[i].WindowState:=wsMaximized;

    for i:=0 to MDIChildCount-1 do
        if  uppercase(MDIChildren[i].Name)<>'DESKTOPFRM' THEN
      MDIChildren[i].WindowState:=wsMaximized;
  end;
end;

procedure TDesktopFrm.WindowSwitch1Execute(Sender: TObject);
begin
  with Application.MainForm do
   if MDIChildCount>1 then
      MDIChildren[MDIChildCount-1].show;
end;

procedure TDesktopFrm.OpenMore2MoreExecute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm(intTostr((Sender As TComponent).Tag),null);
end;

procedure TDesktopFrm.ExecSql2Execute(Sender: TObject);
begin
  FhlKnl1.Kl_GetQuery2(stringreplace(sOpenParamsVar[0],'%20',' ',[rfReplaceAll]),False);
end;

procedure TDesktopFrm.OpenEditorExecute(Sender: TObject);
begin
if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
  FrmActExecute(Sender)  ;
  FhlUser.ShowEditorFrm(intTostr((Sender As TComponent).Tag),null).ShowModal;
end;

procedure TDesktopFrm.TcpServer1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
begin
LoginInfo.LastReceiveStr:=FhlKnl1.St_Encrypt(ClientSocket.Receiveln());
//showmessage(caption);
{
 with TLoginFrm.Create(Application) do
 begin
   if ShowModal=mrOk then
   begin
  //  InitMenu;
    InitStatusbar;
  end;
  Free;
 end;
 }
end;

procedure TDesktopFrm.Button3Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TDesktopFrm.Action1Execute(Sender: TObject);
begin
  dmFrm.ADOConnection1.Connected:=False;
  MainMenu1.Items.Clear;
  
end;

procedure TDesktopFrm.FormCreate(Sender: TObject);
begin
dsMainMenu.Connection :=fhlknl1.UserConnection ;    

     {
  with TcpServer1 do
  begin
    LocalHost:=FhlKnl1.Os_GetComputerName;
    Randomize;
    LocalPort:=intTostr((random(10000)+1)*820605);//showmessage(LocalPort);
    Active:=True;
  end;
  }

  
end;

procedure TDesktopFrm.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  if E.Message='连接失败' then //) and (MessageDlg(#13#10'连接已中断,是否尝试新的连接?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
  begin
    with dmFrm.ADOConnection1 do
    begin
//      ShowMessage(ConnectionString);
      Connected:=False;
      Connected:=True;
    end;
    with FhlKnl1.Connection do
    begin
      Connected:=False;
      Connected:=True;
    end;
  end
  else
    MessageDlg(#13#10+E.Message,mtError,[mbOk],0);

end;

procedure TDesktopFrm.ToolBar1DblClick(Sender: TObject);
var frmDesignMainMenu:TfrmDesignMainMenu;
begin
   if (logininfo.LoginId ='chy') and (logininfo.EmpId ='000') then
   begin
     fhlknl1.Connection.DefaultDatabase :=      LoginInfo.SysDBPubName;
     frmDesignMainMenu:=TfrmDesignMainMenu.Create (nil);
     frmDesignMainMenu.ShowModal ;
     freeandnil(frmDesignMainMenu);
  end;
end;
procedure TDesktopFrm.actOpenPickWindowExecute(Sender: TObject);
begin
 FhlUser.ShowPickWindow(intTostr((Sender As TComponent).Tag));
end;

procedure TDesktopFrm.actLockSysExecute(Sender: TObject);
begin

    self.WindowMinimizeAll1.Execute ;
    self.tmrLockSys.Enabled :=false;
    frmLockSys:= TfrmLockSys.Create (self);
     frmLockSys.ShowModal;
    begin

        SetCursorPos(lockP1.X ,lockP1.Y +20);
        self.tmrLockSys.Enabled :=true;
        DesktopFrm.WindowMaxmizeAll1.Execute;
       
     
    end;
    
end;

procedure TDesktopFrm.tmrLockSysTimer(Sender: TObject);
var  vLastInputInfo: TLastInputInfo;
var  Seconds:Integer;
begin
  vLastInputInfo.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(vLastInputInfo);
  Seconds:=(GetTickCount - vLastInputInfo.dwTime) div 1000;

  Caption := Format('用户已经%d秒没有动键盘鼠标了', [Seconds]);

 if   LoginInfo.LockTime>0 then
  if (seconds >LoginInfo.LockTime ) then
     self.actLockSys.Execute ;
    {
if (not assigned(LoginFrm) ) and (LoginInfo.LoginId <>'' )then
begin
     lockP3.X :=lockP1.X;
     lockP3.Y :=lockP1.Y;


      GetCursorPos(lockP1);
   if time=LoginInfo.LockTime  then
      GetCursorPos(lockP2);

      time:=time+1;
      self.Caption :=' : '+inttostr(time);

   if (time>=LoginInfo.LockTime +1  ) or ( lockP3.X <>lockP1.X)  then
         time:=0;

   if (lockP1.X =lockP2.X) and (lockp1.Y =lockp2.Y ) then
   begin
             self.actLockSys.Execute ;
   end;

end;
     }
end;

procedure TDesktopFrm.tmr1Timer(Sender: TObject);
begin
// Delete this for improve performance
//if LoginInfo.LoginTime<>'' then
//   if not logininfo.IsTool then
//        dmFrm.GetQuery1('update sys_loginlog set  onlineflag='+quotedstr('')+' where  intime='+quotedstr(LoginInfo.LoginTime  ),false );
end;

procedure TDesktopFrm.OpenMainMenuExecute(Sender: TObject);
begin

logininfo.IsTool :=true;
   FhlUser.ShowMainMenuFrm(intTostr((Sender As TComponent).Tag));
end;

procedure TDesktopFrm.FrmActExecute(sender: Tobject);
var MenuName:string;
begin
       if desktopfrm.dsMainMenu.findField('subSysDBName')=nil then
       exit;

        MenuName:=Tcomponent(Sender).name;
        dsMainMenu.Locate('f01',Tcomponent(Sender).name ,[]);
        if  dsMainMenu.FieldByName('F15').AsBoolean  then
        begin
              logininfo.IsTool :=true;
              if     logininfo.PrivorUserDataBase =''  then
              logininfo.PrivorUserDataBase :=dmfrm.ADOConnection1.DefaultDatabase ;

              if fhlknl1.Connection.DefaultDatabase <> dsMainMenu.FieldByName('ToolSysDBName').AsString then
                 fhlknl1.Connection.DefaultDatabase:=dsMainMenu.FieldByName('ToolSysDBName').AsString ;  ;

              fhluser.changeUserDataBase (dsMainMenu.FieldByName('subSysDBName').AsString)   ;
        end
        else
        begin
            logininfo.IsTool :=false;
            if logininfo.PrivorUserDataBase <>'' then
             fhluser.changeUserDataBase ( logininfo.PrivorUserDataBase )   ;
            if UpperCase( fhlknl1.Connection.DefaultDatabase ) <> UpperCase(dsMainMenu.FieldByName('SubSysDBName').AsString) then
            begin
               fhlknl1.Connection.DefaultDatabase:=dsMainMenu.FieldByName('SubSysDBName').AsString   ;
               fhlknl1.CloseSysDataSet;
            end;

        end;
end;

procedure TDesktopFrm.OpenCrmFormExecute(Sender: TObject);
begin

if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
   FrmActExecute(Sender)  ;
   FhlUser.ShowCRMFrm(intTostr((Sender As TComponent).Tag));

end;

procedure TDesktopFrm.ChangSubSysName(SubSysName: string);
begin
        logininfo.IsTool :=false;
        if fhlknl1<>nil then
           if fhlknl1.Connection.DefaultDatabase <> SubSysName then
           begin
               fhlknl1.Connection.DefaultDatabase:=SubSysName   ;
               fhlknl1.CloseSysDataSet;
           end;
end;

procedure TDesktopFrm.OpenInvoiceExecute(Sender: TObject);
begin
     if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
      FrmActExecute(Sender)  ;
      FhlUser.ShowInvoiceFrm(intTostr((Sender As TComponent).Tag));

    //showmessage((Sender As TComponent).Name );    //
end;

procedure TDesktopFrm.ActOpenWrTransformBillExecute(Sender: TObject);
begin
    if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
      FrmActExecute(Sender)  ;
      FhlUser.ShowWrtransformBillFrm(intTostr((Sender As TComponent).Tag));
    //showmessage((Sender As TComponent).Name );    //
end;

procedure TDesktopFrm.ActWhOutExExecute(Sender: TObject);
begin
        if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
      FrmActExecute(Sender)  ;
      FhlUser.ShowBillWhOut (intTostr((Sender As TComponent).Tag));
    //showmessage((Sender As TComponent).Name );    //
end;

procedure TDesktopFrm.FormShow(Sender: TObject);
 var  FrmUpdateHint:TFrmUpdateHint;
 var  inif: TIniFile    ;

begin
    inif:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
    if  inif.ReadBool ('ApplicationConfig','ShowHint',true)    then
    begin
        FrmUpdateHint:=TFrmUpdateHint.Create (nil);
        FrmUpdateHint.ShowModal ;
        FrmUpdateHint.Free ;
    end;
    inif.Free ;
end;

procedure TDesktopFrm.ActOpenBillExExecute(Sender: TObject);
var
   TmpTableName:string;
begin
  if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
    FrmActExecute(Sender)  ;
    FhlUser.ShowBillFrmEx(intTostr((Sender As TComponent).Tag),'');
end;

procedure TDesktopFrm.ActAnalysEXExecute(Sender: TObject);
begin
if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
  FrmActExecute(Sender)  ;
  FhlUser.ShowAnalyserExFrm(intTostr((Sender As TComponent).Tag) ,fsMDIForm );
end;

procedure TDesktopFrm.ActOpenCostSystemExecute(Sender: TObject);
Var FileName,parameters:string;
begin
    filename:= 'costsystem/BSGManagement.exe ';
    parameters:= filename ;
    winexec(pchar(parameters ),0)  ;
end;


end.

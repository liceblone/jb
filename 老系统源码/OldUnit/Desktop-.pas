unit desktop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, OleCtrls, SHDocVw, Menus,
  StdActns, ActnList, Buttons, DB, ADODB, FhlKnl, Sockets;

type
  TDesktopFrm = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Image1: TImage;
    WebBrowser1: TWebBrowser;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
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
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    KeyEdit1: TEdit;
    SpeedButton1: TSpeedButton;
    NodeDataSet1: TADODataSet;
    Timer1: TTimer;
    ExecSql2: TAction;
    Button1: TButton;
    TcpClient1: TTcpClient;
    TcpServer1: TTcpServer;
    Action1: TAction;
    procedure InitMenu;
    procedure OpenBillExecute(Sender:TObject);
    procedure OpenTreeEditorExecute(Sender:Tobject);
    procedure OpenTreeGridExecute(Sender:Tobject);
    procedure OpenAnalyserExecute(Sender:TObject);
    procedure OpenTabEditorExecute(Sender: TObject);
    procedure OpenTreeMgrExecute(Sender: TObject);
    procedure LoginSystemExecute(Sender: TObject);
    procedure CloseMainFrmExecute(Sender: TObject);
    function  Reg:Boolean;
    procedure InitStatusbar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WebBrowser1BeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure WindowCloseAll1Execute(Sender: TObject);
    procedure WindowMaxmizeAll1Execute(Sender: TObject);
    procedure WindowSwitch1Execute(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    function  DoMenuAction(MenuName:String):Boolean;
    procedure KeyEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OpenMore2MoreExecute(Sender: TObject);
    procedure NavigateExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ExecSql2Execute(Sender: TObject);
    procedure OpenEditorExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TcpServer1Accept(Sender: TObject;
      ClientSocket: TCustomIpClient);
    procedure Button3Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private

  public
    { Public declarations }
  end;

type
  TMgrThrd = class (TThread)
  protected
    procedure Execute; override;
  end;

var
  DesktopFrm: TDesktopFrm;

implementation
uses datamodule,Login,about, main;
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
  FhlUser.SetDataSet(dmFrm.FreeDataSet1,'526',LoginInfo.LoginId);
  FhlKnl1.Cf_SetMainMenu('1',MainMenu1,ToolBar1,ActionList1,dmFrm.FreeDataSet1);
end;

procedure TDesktopFrm.WebBrowser1BeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
  var s:TStringList;
      a:String;
begin
     s:=TStringList.Create;
     FhlKnl1.St_Separate(copy(url,pos('?',url)+1,length(url)),'&',s);
     if s.Count>0 then
     begin
       a:=s.Names[0];
       if a='action' then
       begin
         a:=s.Values[a];
         if a='menu' then
            FhlKnl1.Mn_FindMainMenuItem(MainMenu1,s.Values[s.Names[1]]).Click
         else
         begin
           with ActionList1.Actions[strToint(a)] do
           begin
             a:=s.Names[1];
             if a='tag' then
               Tag:=strtoint(s.Values[a]);
             //打开参数
             sOpenParamsVar:=FhlKnl1.Vr_CommaStrToVarArray(s.Strings[2]);
             //默认值
             sDefaultVals:=s.Strings[3];
             Execute;
           end;
           WebBrowser1.Refresh;
         end;
         Cancel:=true;
       end;
     end;
     s.Free;
end;

function TDesktopFrm.DoMenuAction(MenuName:String):Boolean;
  var fItem:TMenuItem;
begin
  fItem:=FhlKnl1.Mn_FindMainMenuItem(MainMenu1,MenuName);
  if fItem<>nil then
     fItem.Click;
  Result:=fItem<>nil;
end;

procedure TDesktopFrm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  if NodeDataSet1.Locate('F01',TStrPointer(Node.Data)^,[]) then
    WebBrowser1.Navigate('http://'+FhlKnl1.St_GetTStringValues(dmFrm.ADOConnection1.ConnectionString,';','Data Source')[0]+'/'+NodeDataSet1.FieldByName('F05').asString+'LoginId='+LoginInfo.LoginId+'&TabId='+LoginInfo.TabId);
end;


procedure TDesktopFrm.OpenBillExecute(Sender:TObject);
begin
  FhlUser.ShowBillFrm(intTostr((Sender As TComponent).Tag));
end;

procedure TDesktopFrm.OpenTreeEditorExecute(Sender:TObject);
begin
  FhlUser.ShowTreeEditorFrm(intTostr((Sender As TComponent).Tag));
end;

procedure TDesktopFrm.OpenTreeGridExecute(Sender:TObject);
begin
 FhlUser.ShowTreeGridFrm(intTostr((Sender As TComponent).Tag));
end;

procedure TDesktopFrm.OpenAnalyserExecute(Sender:TObject);
begin
  FhlUser.ShowAnalyserFrm(intTostr((Sender As TComponent).Tag),null);
end;

procedure TDesktopFrm.OpenTabEditorExecute(Sender: TObject);
begin
 FhlUser.ShowTabEditorFrm(intTostr((Sender As TComponent).Tag),sOpenParamsVar,nil,False,crAppStart);
end;

procedure TDesktopFrm.OpenTreeMgrExecute(Sender: TObject);
begin
  FhlUser.ShowTreeMgrFrm(intTostr((Sender As TComponent).Tag));
end;

procedure TDesktopFrm.LoginSystemExecute(Sender: TObject);
begin
 WindowCloseAll1Execute(Sender);
 Reg;
end;

function TDesktopFrm.Reg:Boolean;
begin
 Result:=false;
 LoginFrm:=TLoginFrm.Create(Application);
 if LoginFrm.ShowModal=mrOk then
 begin
    InitMenu;
    InitStatusbar;

    TreeView1.Items.Clear;
    NodeDataSet1.Connection:=FhlKnl1.Connection;
    FhlKnl1.Cf_SetTreeView('9',TreeView1,NodeDataSet1);
    TreeView1.Items.GetFirstNode.Expand(True);
    FhlKnl1.Tv_FindNode(TreeView1,'0602').Selected:=True;

    Result:=true;
 end;
 FreeAndNil(LoginFrm);
end;

procedure TDesktopFrm.InitStatusbar;
begin
    mainFrm.Statusbar1.Panels.Clear;
    FhlKnl1.Kl_GetQuery2('select * from T509 order by F04');
    with FhlKnl1.FreeQuery do
    begin
      while not eof do
      begin
        with mainFrm.Statusbar1.Panels.Add do
        begin
          Width:=FieldByName('F05').asInteger;
          Text:=FieldByName('F02').asString+FhlUser.GetSysParamVal(FieldByName('F03').asString);
        end;
        Next;
      end;
      Close;
    end;
end;

procedure TDesktopFrm.CloseMainFrmExecute(Sender: TObject);
begin
 Application.MainForm.Close;
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
    for i:=0 to MDIChildCount-1 do
      MDIChildren[i].WindowState:=wsMaximized;
end;

procedure TDesktopFrm.WindowSwitch1Execute(Sender: TObject);
begin
  with Application.MainForm do
   if MDIChildCount>1 then
      MDIChildren[MDIChildCount-1].show;
end;

procedure TDesktopFrm.SpeedButton1Click(Sender: TObject);
begin
  DoMenuAction(KeyEdit1.Text);
end;

procedure TDesktopFrm.KeyEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
     DoMenuAction(KeyEdit1.Text);
end;

procedure TDesktopFrm.OpenMore2MoreExecute(Sender: TObject);
begin
  FhlUser.ShowMore2MoreFrm(intTostr((Sender As TComponent).Tag),null);
end;

procedure TDesktopFrm.NavigateExecute(Sender: TObject);
begin
  WebBrowser1.Navigate(sOpenParamsVar[0]+'&LoginId='+LoginInfo.LoginId);
end;

procedure TDesktopFrm.Timer1Timer(Sender: TObject);
begin
  if WebBrowser1.LocationURL<>'' then
  WebBrowser1.Refresh;
end;

procedure TDesktopFrm.ExecSql2Execute(Sender: TObject);
begin
  FhlKnl1.Kl_GetQuery2(stringreplace(sOpenParamsVar[0],'%20',' ',[rfReplaceAll]),False);
end;

procedure TDesktopFrm.OpenEditorExecute(Sender: TObject);
begin
  FhlUser.ShowEditorFrm(intTostr((Sender As TComponent).Tag),null).ShowModal;
end;

procedure TDesktopFrm.Button1Click(Sender: TObject);
begin
  with TcpClient1 do
  begin
   if Connect then
     if Sendln('GetConnStr')=-1 then showmessage('error');
   Disconnect;
  end; 
end;

procedure TDesktopFrm.TcpServer1Accept(Sender: TObject;
  ClientSocket: TCustomIpClient);
begin


LoginInfo.ConnStr:=ClientSocket.Receiveln();
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

end.

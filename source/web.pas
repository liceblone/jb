unit web;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ComCtrls, ToolWin, Menus, StdCtrls;

type
  TWebFrm = class(TForm)
    MainMenu1: TMainMenu;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    WebBrowser1: TWebBrowser;
    ComboBox1: TComboBox;
    F1: TMenuItem;
    E1: TMenuItem;
    V1: TMenuItem;
    N1: TMenuItem;
    T1: TMenuItem;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    goforwardbtn: TMenuItem;
    gobackbtn: TMenuItem;
    N4: TMenuItem;
    stopbtn: TMenuItem;
    refreshbtn: TMenuItem;
    gohomebtn: TMenuItem;
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gobackbtnClick(Sender: TObject);
    procedure goforwardbtnClick(Sender: TObject);
    procedure gohomebtnClick(Sender: TObject);
    procedure stopbtnClick(Sender: TObject);
    procedure refreshbtnClick(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebFrm: TWebFrm;

implementation
uses datamodule;
{$R *.dfm}

procedure TWebFrm.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=vk_return then
     WebBrowser1.Navigate(ComboBox1.Text);
end;

procedure TWebFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TWebFrm.gobackbtnClick(Sender: TObject);
begin
  WebBrowser1.GoBack;
end;

procedure TWebFrm.goforwardbtnClick(Sender: TObject);
begin
  WebBrowser1.GoForward;
end;

procedure TWebFrm.gohomebtnClick(Sender: TObject);
begin
  WebBrowser1.GoHome;
end;

procedure TWebFrm.stopbtnClick(Sender: TObject);
begin
  Webbrowser1.Stop;
end;

procedure TWebFrm.refreshbtnClick(Sender: TObject);
begin
  WebBrowser1.Refresh;
end;

procedure TWebFrm.ToolButton6Click(Sender: TObject);
begin
  Close;
end;

procedure TWebFrm.WebBrowser1BeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  Caption:=Url;
end;

end.

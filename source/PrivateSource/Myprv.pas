unit Myprv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, QRPrntr, ExtCtrls, QuickRpt, StdCtrls;

type
  TMyPreview = class(TForm)
    QRPreview1: TQRPreview;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
      FPageCount : integer;  // ���ɱ������ҳ��

    { Private declarations }
  public
    { Public declarations }
     CurRep : TQuickRep;    // ��Ԥ���ı���
procedure UpdatePanelShow;

  end;

var
  MyPreview: TMyPreview;

implementation

{$R *.dfm}

procedure TMyPreview.UpdatePanelShow;
begin
        Panel2.Caption := 
' �� '+inttostr(QRPreview1.PageNumber)+
   ' ҳ  �� '+inttostr(FPageCount)+' ҳ';

end;

procedure TMyPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      CurRep := nil;
     Action := caFree;

end;

procedure TMyPreview.Button1Click(Sender: TObject);
begin
self.QRPreview1.Width :=self.QRPreview1.Width -10;
end;

procedure TMyPreview.Button2Click(Sender: TObject);
begin
  QRPreview1.QRPrinter.PaperWidth :=200;
end;

procedure TMyPreview.Button3Click(Sender: TObject);
begin
self.CurRep.Width :=CurRep.Width-20;
end;

end.

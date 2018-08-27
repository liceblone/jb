unit UnitUpdateHint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,  IniFiles, UnitPublicFunction,
  StdCtrls, ComCtrls, ToolWin, ADODB, Db, DbCtrls, CheckLst, ImgList,  variants, datamodule,

  Mask, ActnList, FhlKnl,UnitModelFrm, ExtCtrls, Grids, DBGrids;

type
  TFrmUpdateHint = class(TForm)
    BtnClose: TButton;
    chkDontHintAgain: TCheckBox;
    MemUpdateInfo: TMemo;
    Label1: TLabel;
    procedure BtnCloseClick(Sender: TObject);
    procedure chkDontHintAgainClick(Sender: TObject);
 
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUpdateHint: TFrmUpdateHint;

implementation
        uses UnitCreateComponent  ,about ;
{$R *.dfm}

procedure TFrmUpdateHint.BtnCloseClick(Sender: TObject);
begin
self.Close;
end;

procedure TFrmUpdateHint.chkDontHintAgainClick(Sender: TObject);
 var  inif: TIniFile    ;
begin
    inif:=TIniFile.Create(ExtractFileDir(Application.ExeName)+'\Config.ini');
    inif.WriteBool  ('ApplicationConfig','ShowHint',false)   ;
    inif.free;

end;

procedure TFrmUpdateHint.FormShow(Sender: TObject);
 var
    aboutFrm:TaboutFrm;
    i:integer;
begin
     self.Caption :=    Caption+'   Ŀǰ�汾 '+JBgetversion;
     aboutFrm:=TaboutFrm.Create (self);
     for i:=0 to   aboutFrm.Memo1.Lines.Count-1do
     begin
     if    aboutFrm.Memo1.Lines[i]<>'' then
        MemUpdateInfo.Lines.Add( aboutFrm.Memo1.Lines[i] )
     else
        break;


     end;
end;

end.

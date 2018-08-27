unit UnitFrmSelDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TFrmSelDate = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    BtnCancel: TButton;
    BtnConfirm: TButton;
    CmbDate: TComboBox;
    Label1: TLabel;
  private
    { Private declarations }

  public
    procedure iniFrm(Commortext:string;LblCaption:string);
    { Public declarations }
  end;

var
  FrmSelDate: TFrmSelDate;

implementation

{$R *.dfm}

{ TFrmSelDate }

procedure TFrmSelDate.iniFrm(Commortext, LblCaption: string);
begin
self.CmbDate.Items.CommaText :=Commortext;
Label1.Caption := LblCaption;
end;

end.

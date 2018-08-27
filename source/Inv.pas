unit Inv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TInvFrm = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    Edit4: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InvFrm: TInvFrm;

implementation

{$R *.dfm}

procedure TInvFrm.FormCreate(Sender: TObject);
begin
  Edit2.Text:=FormatDateTime('yyyy"-"mm"-"dd',Now);
end;

end.

unit UnitModelFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFrmModel = class(TForm)
  private
    { Private declarations }
    FSubSysName:string;
    FwinID: string;
    procedure SetFwinID(const Value: string);
  public
    { Public declarations }
    procedure Active(sender:Tobject);
    procedure SetSubSysName(PSubSysName:string);
        property FWindowsFID:string read FwinID write SetFwinID;
    constructor Create(owner:Tcomponent);override;
  end;

var
  FrmModel: TFrmModel;

implementation
   uses datamodule,desktop;
{$R *.dfm}

{ TFrmModel }

procedure TFrmModel.Active(sender: Tobject);
begin
if self.FSubSysName <>'' then
    desktopfrm.ChangSubSysName (self.FSubSysName );
end;

constructor TFrmModel.Create(owner: Tcomponent);
begin
self.OnActivate :=self.Active;

inherited create(owner);
end;

procedure TFrmModel.SetFwinID(const Value: string);
begin
  FwinID := Value;
end;

procedure TFrmModel.SetSubSysName(PSubSysName: string);
begin
self.FSubSysName :=PSubSysName;
end;

end.

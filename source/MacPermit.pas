unit MacPermit;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TMacPermitFrm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label2: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    ComboCategory: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MacPermitFrm: TMacPermitFrm;

implementation

{$R *.dfm}

end.

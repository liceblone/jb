unit ClientProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TClientPropFrm = class(TForm)
    PageControl1: TPageControl;
    Button2: TButton;
    Button1: TButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ClientPropFrm: TClientPropFrm;

implementation

{$R *.dfm}

end.

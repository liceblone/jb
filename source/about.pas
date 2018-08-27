unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ADODB, Grids, DBGrids,FhlKnl, ComCtrls;

type
  TaboutFrm = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  aboutFrm: TaboutFrm;

implementation
uses datamodule;
{$R *.dfm}
end.



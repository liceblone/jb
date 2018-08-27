unit UnitExpressPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TFrmExpressPrint = class(TQuickRep)
    DetailBand1: TQRBand;
  private

  public

  end;

var
  FrmExpressPrint: TFrmExpressPrint;

implementation

{$R *.DFM}

end.

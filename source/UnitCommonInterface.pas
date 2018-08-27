unit UnitCommonInterface;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB;

  type IParentSearch=interface
     procedure  BarCodeSearch(BarCodeList:TStringList);
     procedure  AppendRecord(fdataSet:TdataSet);
     function   AddBarCode :boolean;
     function   RemoveBarCode :boolean;
     procedure  EnableDsCaculation(enabled:boolean) ;

  end;

implementation

end.

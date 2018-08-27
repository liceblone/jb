unit UnitChyDataSet;


interface
 uses adodb;

type
  TChyDataSet = class(TADODataSet)
  public
    function GetCurrentRow:integer;//read FcurrentRow:integer;
    function GetActiveRow:integer ;
  end;
implementation

{ TChyDataSet }

function TChyDataSet.GetActiveRow: integer;
begin
  result:= self.ActiveRecord ;
end;

function TChyDataSet.GetCurrentRow: integer;
begin
  result:=self.CurrentRecord ;
end;

end.

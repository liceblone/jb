unit UnitChyGrid;

interface
       uses dbgrids,classes,db,adodb,StrUtils;

type
    TChyDbGrid = class( TDBGrid)
       private

       public
       constructor create(aowner:Tcomponent);override;
          function CurrentRow: Longint ;//read FRow ;
          procedure TitleClick(Column: TColumn);

    end;
implementation
           uses UPublicCtrl;
{ TChyGrid }

constructor TChyDbGrid.create(aowner: Tcomponent);
begin
  inherited;
self.OnTitleClick :=TitleClick ;
end;

function TChyDbGrid.CurrentRow: Longint;
begin
    result:= self.Row ;
end;

procedure TChyDbGrid.TitleClick(Column: TColumn);

var fieldname,strtmp,OriCaption:string;
    i:integer;
begin
  if self.DataSource=nil then exit;
  if not self.DataSource.DataSet.Active then exit;
  if Column.Field=nil then exit;

  strtmp:=Column.Title.Caption;
  fieldname:= Column.FieldName;
  if (Column.Field.FieldKind  =  fkLookup ) then
   fieldname:= Column.Field.LookupKeyFields  ;

  if (Column.Field.FieldKind  =  fkCalculated ) then
    if  Tadodataset( self.DataSource.DataSet).FindField (leftstr( fieldname,length(fieldName)-3))<>nil then
        fieldname:=leftstr( fieldname,length(fieldName)-3)
    else
       exit;    

        if  Tadodataset( self.DataSource.DataSet).FindField ( fieldname)<>nil then
    if  TChyColumn(Column ).isAsc     then
    begin
     Tadodataset( self.DataSource.DataSet).Sort :=fieldname +' ASC';
    end
    else
    begin
        Tadodataset( self.DataSource.DataSet).Sort :=fieldname+' DESC';
    end   ;
       TChyColumn(Column ).isAsc  :=not   TChyColumn(Column ).isAsc     ;


end;

end.

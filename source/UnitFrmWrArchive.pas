unit UnitFrmWrArchive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Buttons, ExtCtrls, DB, ADODB, Grids, DBGrids , UnitGrid;

type
  TFrmWrArchive = class(TFrame)
    dlAdoDataSet1: TADODataSet;
    dlDataSource1: TDataSource;
    mtADODataSet1: TADODataSet;
    mtADODataSet1IntegerField111: TIntegerField;
    mtDataSource1: TDataSource;
    TopPanel1: TPanel;
    OpnDlDsBtn1: TSpeedButton; 
    procedure TopPanel1DblClick(Sender: TObject);
    procedure InitFrm( AmtParams:Variant);
    procedure SetDataSet(pdataSet:Tdataset);
    procedure DsAfterScroll(Sender: TDataSet);
    procedure dlAdoDataSet1AfterPost(DataSet: TDataSet);
  private 
    TopBoxId :string;
    ParentDataset:tdataset;
    DbGrid1: TModelDbGrid  ;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses UnitCreateComponent , datamodule,repgrid,colProp,repset,bill, RepBill,
 Inv,TabGrid,UnitFrmGrid ,Sort ,UPublicFunction ;


{$R *.dfm}

{ TFrmWrArchive }

procedure TFrmWrArchive.DsAfterScroll(Sender: TDataSet);
var fParams:variant;
var  abortstr, WarningStr, sDefaultVals:string;
begin
    sDefaultVals:='';
    sDefaultVals:=   sDefaultVals+  'moveF_ID='+self.ParentDataset.FieldByName('moveF_ID').AsString +',';
    FhlKnl1.Ds_AssignDefaultVals(mtAdoDataSet1, sDefaultVals, false);

    with mtAdoDataSet1 do
    begin
        if (State=dsInsert) or (State=dsEdit) then  //update parameter getvalue
        begin
          UpdateRecord;
          Post;
        end;
    end;

    fParams:=FhlKnl1.Ds_GetFieldsValue(ParentDataset, 'moveF_ID' , false);

    if Not VarIsNull(fParams) then
    begin
         FhlKnl1.Ds_OpenDataSet( DBGrid1.DataSource.DataSet  ,fParams);
         FhlKnl1.SetColFormat( DBGrid1 );
    end;
end;

procedure TFrmWrArchive.InitFrm(  AmtParams: Variant);
begin
  DbGrid1:= TModelDbGrid.create(self);
  DbGrid1.Parent :=  self ;
  DbGrid1.Align := alclient;
  DbGrid1.SetLoginInfo( logininfo);
  DbGrid1.SetPopupMenu( dmFrm.DbGridPopupMenu1 ) ;
  DbGrid1.DataSource :=  dlDataSource1;
  DbGrid1.Tag := 837;

  self.TopBoxId := '457' ;
  FhlUser.SetDataSet(mtAdoDataSet1, inttostr(self.mtADODataSet1.tag), AmtParams);
  FhlUser.SetDbGridAndDataSet(DbGrid1, inttostr(self.DBGrid1.Tag), null, false);
  if mtAdoDataSet1.Active then
  begin
      FhlUser.AssignDefault(mtAdoDataSet1);
      if mtAdoDataSet1.IsEmpty then
      begin
          mtAdoDataSet1.Append;
      end;
  end;

  if (self.TopBoxId<>'-1') and (self.TopBoxId<>'' ) then      //top or buttom      create label and dbcontrol
    FhlKnl1.Cf_SetBox(self.TopBoxId,mtDataSource1,TopPanel1,dmFrm.dbCtrlActionList1);


   {
  if fDict.IsOpen then
  begin
    if mtAdoDataSet1.Active then
      OpnDlDsBtn1.Click         //≤È—Ø
    else
      dlAdoDataSet1.Open;
  end;
  }

end;

procedure TFrmWrArchive.SetDataSet(pdataSet: Tdataset);
begin
    self.ParentDataset := pdataset;
    self.ParentDataset.AfterScroll := self.DsAfterScroll;
end;

procedure TFrmWrArchive.TopPanel1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent ;
begin
  // modeltpe:=Bill;
   try
    if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
    begin
      CrtCom:=TfrmCreateComponent.Create(self);
      CrtCom.Hide;
      //CrtCom.fAnalyserDict:=  fdict;
      CrtCom.TopOrBtm :=true;

      CrtCom.mtDataSet1:= mtADODataSet1;
      CrtCom.mtDataSetId :=inttostr(self.mtADODataSet1.Tag );
 
      CrtCom.TOPBoxId  := self.TopBoxId ;
      CrtCom.DlGridId  := inttostr(self.DBGrid1.tag );
      CrtCom.DLGrid    := self.DBGrid1 ;
      //CrtCom.FormId := FormId;
       CrtCom.Show;
    end;


   
  finally

  end;
end;
procedure TFrmWrArchive.dlAdoDataSet1AfterPost(DataSet: TDataSet);
var i, Cnt :integer;
var BookMark: TBookMark;
begin
   dlAdoDataSet1.DisableControls;
   Cnt := 0;
   BookMark := self.dlAdoDataSet1.GetBookMark;
   dlAdoDataSet1.First;
   for i:= 0 to dlAdoDataSet1.RecordCount -1 do
   begin
       Cnt := Cnt + dlAdoDataSet1.FieldByName('Qty').AsInteger  ;
       dlAdoDataSet1.Next ;
   end;
   self.ParentDataset.Edit;
   self.ParentDataset.FieldByName('ConfirmedQty').Value := Cnt;
   self.ParentDataset.Post;
   self.dlAdoDataSet1.GotoBookmark( BookMark  ) ;
   dlAdoDataSet1.EnableControls;
   dmFrm.AfterPostAction1Execute (dataset);
end;

end.

unit UnitFrmWrQrchive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Buttons, ExtCtrls, DB, ADODB, Grids, DBGrids;

type
  TFrmWrArchive = class(TFrame)
    DBGrid1: TDBGrid;
    dlAdoDataSet1: TADODataSet;
    dlDataSource1: TDataSource;
    mtADODataSet1: TADODataSet;
    mtADODataSet1IntegerField111: TIntegerField;
    mtDataSource1: TDataSource;
    TopPanel1: TPanel;
    OpnDlDsBtn1: TSpeedButton; 
    procedure TopPanel1DblClick(Sender: TObject);
    procedure InitFrm(AFrmId:String;AmtParams:Variant);
    procedure SetDataSet(pdataSet:Tdataset); 
  private 
    TopBoxId :string;
    dataset:tdataset;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
       uses UnitCreateComponent , datamodule,repgrid,colProp,repset,bill, RepBill, Inv,TabGrid,UnitFrmGrid ,Sort ,UPublicFunction ;


{$R *.dfm}

{ TFrmWrArchive }

procedure TFrmWrArchive.InitFrm(AFrmId: String; AmtParams: Variant);
begin
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
self.dataset :=pdataset;
end;

procedure TFrmWrArchive.TopPanel1DblClick(Sender: TObject);

var CrtCom:TfrmCreateComponent    ;

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
end.

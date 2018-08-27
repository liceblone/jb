unit UnitInOrSaleRefs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, ComCtrls,upublic, DB, ADODB;

type
  TFrmNewOldRefs = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Image1: TImage;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Button2: TButton;
    Button1: TButton;
    GrpBox: TGroupBox;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    procedure FormDblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
     FGridID:string;
     FParams:string;
     
  public
    { Public declarations }
        ComboxNewOldDBs:  TComboxNewOldDBs;
        procedure SetFGridID(FGridID:string);
        procedure SetFParams(FParams: string);
        procedure InitFrm;
        Procedure Select(Sender:Tobject);
  end;

var
  FrmNewOldRefs: TFrmNewOldRefs;

implementation

uses datamodule,UnitCreateComponent;

{$R *.dfm}

{ TFrmNewOldRefs }

procedure TFrmNewOldRefs.InitFrm;
var Sql:string;
i:integer;
begin

     ComboxNewOldDBs:=TComboxNewOldDBs.create (GrpBox);
     ComboxNewOldDBs.Parent :=   GrpBox;
     ComboxNewOldDBs.Top :=10;
     ComboxNewOldDBs.Left :=10;
     ComboxNewOldDBs.Width :=300;


     ComboxNewOldDBs.setFFhlKnl(fhlknl1);
     ComboxNewOldDBs.IniNewOldDbs(dmfrm.ADOConnection1.DefaultDatabase );
     ComboxNewOldDBs.OnSelect :=self.Select;

end;

procedure TFrmNewOldRefs.Select(Sender: Tobject);
var TmpParam :string;
begin
   TmpParam:=FParams+','+self.ComboxNewOldDBs.FDBnames[ComboxNewOldDBs.itemindex];
   FhlUser.SetDbGridAndDataSet(DbGrid1,FGridID,TmpParam,true);
end;

procedure TFrmNewOldRefs.SetFGridID(FGridID: string);
begin
self.FGridID :=  FGridID;
end;

procedure TFrmNewOldRefs.SetFParams(FParams: string);
begin
self.FParams :=FParams;
end;

procedure TFrmNewOldRefs.FormDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin

        if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
        begin
          CrtCom:=TfrmCreateComponent.Create(self);
         CrtCom.DLGrid :=self.DBGrid1 ;
          CrtCom.DlGridId :=inttostr(self.DBGrid1.Tag );

          CrtCom.mtDataSet1 :=self.ADODataSet1 ;
          CrtCom.mtDataSetId :=inttostr(ADODataSet1.Tag );
          try
              CrtCom.Show;
          finally

          end;
        end;


end;
procedure TFrmNewOldRefs.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if DbGrid1.DataSource.DataSet.IsEmpty then exit;
  if ADODataSet1.FindField('FntClr') =nil then exit;
  
  if ADODataSet1.FieldByName('FntClr').AsString<>'' then
  begin
  DbGrid1.Canvas.Font.Color:=StringToColor(ADODataSet1.FieldByName('FntClr').AsString);
  FhlKnl1.Dg_DrawLineFont(Sender,Rect,DataCol,Column,State,DbGrid1.Canvas.Font);
  end;
end;

end.

unit UnitDeliveryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, ExtCtrls, ComCtrls,
  ToolWin, ActnList, jpeg;

type
  TFrmDeliveryReport = class(TForm)
    grpReport: TGroupBox;
    DataSourceType: TDataSource;
    GridReportType: TDBGrid;
    DatasetReport: TADODataSet;
    grpLayout: TGroupBox;
    grpFields: TGroupBox;
    pnlLeft: TPanel;
    gridFields: TDBGrid;
    ActionList1: TActionList;
    AddAction: TAction;
    CopyAction: TAction;
    EditAction: TAction;
    DeleteAction: TAction;
    SaveAction: TAction;
    CancelAction: TAction;
    FirstAction: TAction;
    PriorAction: TAction;
    NextAction: TAction;
    LastAction: TAction;
    CloseAction: TAction;
    PrintAction: TAction;
    ToolBar1: TToolBar;
    PrintBtn: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton12: TToolButton;
    ExtBtn: TToolButton;
    dataSourceFields: TDataSource;
    DataSetFields: TADODataSet;
    Image1: TImage;
    imgBackgroup: TImage;
    toolButtonSaveReportCfg: TToolButton;
    toolButtonPreview: TToolButton;
    ToolButton4: TToolButton;
    StatusBarPrintCfg: TStatusBar;
    procedure grpReportDblClick(Sender: TObject);
    procedure grpFieldsDblClick(Sender: TObject);
    procedure DatasetReportAfterScroll(DataSet: TDataSet);
    procedure LoadReportControl(reportID : string; ctrlParent:TGroupbox);
    procedure ClearControls(ctrlParent:Twincontrol);
    procedure imgBackgroupDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure imgBackgroupDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure imgtopDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure gridFieldsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure toolButtonSaveReportCfgClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure toolButtonPreviewClick(Sender: TObject);
    procedure Ctrl_MouseMove(Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FDsFields:TDataSource ;

  public
    { Public declarations }
    procedure InitFrm(pDsFields:TDataSource);

  end;

var
  FrmDeliveryReport: TFrmDeliveryReport;

implementation

uses datamodule, RepCard, UnitCreateComponent,UPublic;

{$R *.dfm}

{ TFrmDeliveryReport }

procedure TFrmDeliveryReport.InitFrm(pDsFields:TDataSource);
begin
  FDsFields := pDsFields;
  FhlUser.SetDbGridAndDataSet(self.GridReportType, '816',null);
  FhlUser.SetDbGridAndDataSet(self.gridFields ,'817',null);
  
end;

procedure TFrmDeliveryReport.grpReportDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);

    CrtCom.TopOrBtm :=true;

    CrtCom.mtDataSet1:= self.DatasetReport;
    CrtCom.mtDataSetId :=inttostr(self.DatasetReport.Tag );
    CrtCom.DlGridId  := inttostr(self.GridReportType.tag );
    CrtCom.DLGrid    := self.GridReportType ;
    try
    CrtCom.Show;
    finally

    end;
  end;


end;

procedure TFrmDeliveryReport.grpFieldsDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);

    CrtCom.TopOrBtm :=true;


    CrtCom.mtDataSet1:= TAdoDataSet( gridFields.DataSource.DataSet );
    CrtCom.mtDataSetId :=inttostr(gridFields.DataSource.DataSet.Tag );
    CrtCom.DlGridId  := inttostr(self.gridFields.tag );
    CrtCom.DLGrid    := self.gridFields ;
    try
    CrtCom.Show;
    finally

    end;
  end;


end;

procedure TFrmDeliveryReport.DatasetReportAfterScroll(DataSet: TDataSet);
var filename:string;
begin
    filename:= ExtractFileDir(Application.ExeName)+'\PrintingBackgroud\' + DatasetReport.fieldbyname('FBackgroundPic').AsString;
    self.imgBackgroup.Picture.LoadFromFile(fileName);

    ClearControls(self.grpLayout);
    LoadReportControl(self.DatasetReport.fieldbyname('f_id').AsString  , self.grpLayout );
end;

procedure TFrmDeliveryReport.LoadReportControl(reportID : string; ctrlParent:TGroupbox);
 var l,t,w:Integer;Fnt:TFont;
 var sql:string;
 var fDictDataSet: Tadoquery;
begin
  t:=0;
  Fnt:=TFont.Create;
  Fnt.Assign(grpLayout.Font);
  //fDictDataSet.First;

  fDictDataSet:=Tadoquery.Create (nil);
  fDictDataSet.Connection :=FhlKnl1.Connection;
  sql:='select r.*,f.F02,f.f09 as FText from T506 r left outer join T102 f on r.F16=f.F01 where r.F18=1 and r.F02='+ quotedstr( reportID ) +'  order by r.f13' ;
  fDictDataSet.SQL.Clear ;
  fDictDataSet.SQL.Add(sql);
  fDictDataSet.Open ;

  //select r.*,f.F02 as F99 from T506 r left outer join T102 f on r.F16=f.F01 where r.F02=:BoxId and r.F18=1 order by r.f13

  While not fDictDataSet.Eof do
  begin
   l:=fDictDataSet.FieldByName('F12').asInteger;
   t:=fDictDataSet.FieldByName('F13').asInteger;
   Fnt.Size:=fDictDataSet.FieldByName('F07').asInteger;
   Fnt.Name:=fDictDataSet.FieldByName('F08').asString;
   w:=fDictDataSet.FieldByName('F14').asInteger;
   if fDictDataSet.FieldByName('F10').asBoolean then
     Fnt.Style:=Fnt.Style+[fsUnderLine]
   else
     Fnt.Style:=Fnt.Style-[fsUnderLine];
   if fDictDataSet.FieldByName('F09').asBoolean then
     Fnt.Style:=Fnt.Style+[fsBold]
   else
     Fnt.Style:=Fnt.Style-[fsBold];

   case fDictDataSet.FieldByName('F17').asInteger of
      0:with Tlabel_mtn.Create( ctrlParent ) do
        begin
          Parent:= ctrlParent;
          Left:=l;
          Top:=t;
          Caption:=fDictDataSet.FieldByName('F04').asString;
          Font.Assign(Fnt);
          KeyValue := fDictDataSet.FieldByName('F01').AsInteger ;
 
          //OnDblClick :=DblClick_Ex;
        end;
      1:with TEdit_mtn.Create( ctrlParent ) do
        begin
          Parent:=ctrlParent;
          Left:=l;
          top:=t;
          AutoSize:=False;
          width:=w;

          Font.Assign(Fnt);
          KeyValue := fDictDataSet.FieldByName('F01').AsInteger ;
          FieldID   := fDictDataSet.FieldByName('f16').Value ;
          //text:=fDictDataSet.FieldByName('f99').asString;
          text:=fDictDataSet.FieldByName('fText').asString;
        end;

   end;
   fDictDataSet.Next;
  end;
  //TabEditorReport.Height:=t+30;
  fDictDataSet.Close;
  Fnt.Free;
end;

procedure TFrmDeliveryReport.imgBackgroupDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     if  Source is tdbgrid then
        Accept:=true;
end;

procedure TFrmDeliveryReport.imgBackgroupDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
    imgtopDragDrop(Sender, Source, X, Y );
end;


procedure TFrmDeliveryReport.imgtopDragDrop(Sender, Source: TObject; X, Y: Integer);
var lbl:Tlabel_Mtn;
var CTRL:Tedit_Mtn;
var FieldType:integer;
var FieldKind :string;
var picklist:string;
var name:string;
var grpSoruceParent:TWinControl;

begin
grpSoruceParent :=   TWinControl( Timage(Sender).Parent) ;
      if    Source is   tdbgrid then
      begin

            if datasetFields.Fieldbyname('CtrlType').AsString ='Label'then
            begin
                lbl:=Tlabel_Mtn.Create(grpSoruceParent);
                lbl.Parent :=grpSoruceParent;
                lbl.Left :=x;
                lbl.Top :=y;
               // name:=Tlistbox (Source).Items.Names [Tlistbox (Source).ItemIndex];
                lbl.Caption := datasetFields.Fieldbyname('label').AsString;
               // lbl.OnDblClick := DblClick_Ex;
                lbl.Visible :=true;
                lbl.Hint :='0'         ;
                lbl.Font.Name :='宋体';
                lbl.Font.Size:=10;

            end
            else
            begin
                CTRL:=Tedit_Mtn.Create (grpSoruceParent);
                CTRL.Parent :=grpSoruceParent;

                CTRL.Left :=x +10;    // +lbl.Width
                CTRL.Top :=y ;
                CTRL.ShowHint :=true;
                CTRL.Hint :=  datasetFields.Fieldbyname('fldid').AsString+',-1,-1,-1';
                CTRL.Text :=  datasetFields.Fieldbyname('label').AsString;
                CTRL.Visible :=true;

               // CTRL.OnDblClick := DblClick_Ex;
                CTRL.FieldID :=  datasetFields.Fieldbyname('fldid').asinteger;

                FieldType:=datasetFields.FieldValues ['typeid'];
                FieldKind:=datasetFields.Fieldbyname ('kindid').AsString ;
                picklist:=datasetFields.Fieldbyname ('picklist').AsString ;

                case FieldType of
                0:begin
                       if  trim(FieldKind)='l' then
                         CTRL.Tag :=5;

                        if picklist<>'' then
                        begin
                          CTRL.Tag:=12;
                        end
                        else
                         CTRL.Tag :=1;
                  end;
                4,5,10:        CTRL.Tag :=1;
                1,2  :         CTRL.Tag :=9;
                3:             CTRL.Tag :=7;
                6:             CTRL.Tag :=6;
                7 :            CTRL.Tag :=13;
                end;
            end;
      end;
end;
procedure TFrmDeliveryReport.gridFieldsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if shift= [ssLeft] then
   gridFields.BeginDrag(true);
end;

procedure TFrmDeliveryReport.ClearControls(ctrlParent:Twincontrol);
var i:integer;
begin
  
  for i:=0 to ctrlParent.ComponentCount-1   do
  begin
        ctrlParent.Components [0].Free ;
  end;

end;

procedure TFrmDeliveryReport.toolButtonSaveReportCfgClick(Sender: TObject);
 
var i, MaxF01:integer;
var grpbox:Tgroupbox;
var Lst:Tstringlist;
var qry:Tadoquery ;
var sql, reportID :string;
begin
    Lst:=Tstringlist.Create ;
    grpbox:=grpLayout ;

    reportID:= self.DatasetReport.fieldbyname('f_id').AsString  ;

    try
        for i:=0 to grpbox.controlcount-1 do
        begin
              if (grpbox.controls[i] is  tedit_mtn  ) or (grpbox.controls[i] is  tlabel_mtn) then
              begin
                  if (grpbox.controls[i] is  tedit_mtn )then
                      MaxF01  := (grpbox.controls[i] as tedit_mtn  ).KeyValue ;
                  if (grpbox.controls[i] is  tlabel_mtn)then
                      MaxF01  := (grpbox.controls[i] as tlabel_mtn  ).KeyValue ;

                  qry:=Tadoquery.Create (nil);
                  qry.Connection :=FhlKnl1.Connection;
                  sql:='select * from T506  where f01='+ inttostr(MaxF01)+' and f02= '+quotedstr( reportID ) ;
                  qry.SQL.Clear ;
                  qry.SQL.Add(sql);
                  qry.Open;

                  if not qry.IsEmpty then
                      qry.Edit
                  else
                  begin
                      qry.Append;

                      FhlKnl1.Kl_GetQuery2(' select isnull((select MAX(f01)+1 from T506)  ,0) ') ;
                      MaxF01 := Fhlknl1.FreeQuery.Fields[0].AsInteger ;
                      //(grpbox.controls[i] as tcontrol).Tag := MaxF01;
                  end;
                  qry.FieldByName('f01').Value := MaxF01  ;
                  qry.FieldByName('f02').Value := reportID ;

                  if (grpbox.controls[i] is  Tedit_Mtn) then
                  begin

                        qry.FieldByName('f07').Value := (grpbox.controls[i] as Tedit_Mtn).Font.Size ;
                        qry.FieldByName('f08').Value := (grpbox.controls[i] as Tedit_Mtn).Font.Name ;
                        qry.FieldByName('f12').Value := (grpbox.controls[i] as Tedit_Mtn).Left  ;
                        qry.FieldByName('f13').Value := (grpbox.controls[i] as Tedit_Mtn).Top   ;
                        qry.FieldByName('f14').Value := (grpbox.controls[i] as Tedit_Mtn).Width   ;
                        qry.FieldByName('f16').Value := (grpbox.controls[i] as Tedit_Mtn).FieldID   ;
                        qry.FieldByName('f17').Value :=1;
                  end;

                  if  (grpbox.controls[i] is Tlabel) then
                  begin
                        qry.FieldByName('f04').Value := (grpbox.controls[i] as Tlabel).Caption ;
                        qry.FieldByName('f07').Value := (grpbox.controls[i] as Tlabel).Font.Size ;
                        qry.FieldByName('f08').Value := (grpbox.controls[i] as Tlabel).Font.Name ;

                        qry.FieldByName('f12').Value := (grpbox.controls[i] as Tlabel).Left  ;
                        qry.FieldByName('f13').Value := (grpbox.controls[i] as Tlabel).Top   ;
                        qry.FieldByName('f14').Value := (grpbox.controls[i] as Tlabel).Width  ;
                    
                        qry.FieldByName('f17').Value :=0;
                  end;

                  qry.Post;
                  freeandnil(qry);
              end;
        end;

        self.Caption := self.Caption +'控键  保存成功';
    except
        dmFrm.ADOConnection1.RollbackTrans ;
    end;
end;

procedure TFrmDeliveryReport.PrintBtnClick(Sender: TObject);
begin
  FhlKnl1.Rp_ExpressPrint( DatasetReport.fieldbyname('f_id').AsString  ,FDsFields.DataSet);
end;

procedure TFrmDeliveryReport.toolButtonPreviewClick(Sender: TObject);
begin
 FhlKnl1.Rp_ExpressPrint( DatasetReport.fieldbyname('f_id').AsString  ,FDsFields.DataSet , false);

end;

procedure TFrmDeliveryReport.Ctrl_MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
//
end;

end.

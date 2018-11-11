unit Editor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,   StrUtils ,
  StdCtrls, ComCtrls, ToolWin, ADODB, Db, DbCtrls, CheckLst, ImgList,UnitCreateComponent, variants,
  Mask, ActnList, FhlKnl,UnitModelFrm, ExtCtrls, Grids, DBGrids, FR_Class, FR_View, UnitHoushengLabel2;


type
  TEditorFrm = class(TFrmModel)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    SavBtn: TToolButton;
    DataSource1: TDataSource;
    CelBtn: TToolButton;
    ToolButton3: TToolButton;
    AddBtn: TToolButton;
    CpyBtn: TToolButton;
    DelBtn: TToolButton;
    ToolButton7: TToolButton;
    FirstBtn: TToolButton;
    NextBtn: TToolButton;
    PriorBtn: TToolButton;
    LastBtn: TToolButton;
    ToolButton12: TToolButton;
    ExtBtn: TToolButton;
    PageControl1: TPageControl;
    PrintBtn: TToolButton;
    ToolButton2: TToolButton;
    ChgBtn: TToolButton;
    ADODataSet1: TADODataSet;
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
    SetCaptionAction: TAction;
    actInputTaxAmt: TAction;
    Splitter1: TSplitter;
    PnlItem: TPanel;
    ActDeliveryCfg: TAction;
    ActPrintDeliveryBill: TAction;
    ActHouShengLabel: TAction;
    ActShowBackgroundPic: TAction;
    frReport1: TfrReport;
    ActHouShengLableQrpt: TAction;
    //procedure InitFrm(EditorId:String;fOpenParams:Variant;fDataSet:TDataSet;ParamGrid:Tdbgrid=nil);
    procedure InitFrm(EditorId:String;fOpenParams:Variant;fDataSet:TDataSet;PparentGrid:Tdbgrid=nil;POpenFlds:String='');overload;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetEditState(CanEdit:Boolean);
    procedure AddActionExecute(Sender: TObject);
    procedure CopyActionExecute(Sender: TObject);
    procedure EditActionExecute(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    function  GetPraValues():string;
    procedure FirstActionExecute(Sender: TObject);
    procedure PriorActionExecute(Sender: TObject);
    procedure NextActionExecute(Sender: TObject);
    procedure LastActionExecute(Sender: TObject);
    procedure CloseActionExecute(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
    procedure SetCaptionActionExecute(Sender: TObject);
    procedure PrintActionExecute(Sender: TObject);
    procedure ToolBar1DblClick(Sender: TObject);
    procedure actInputTaxAmtExecute(Sender: TObject);
    procedure ADODataSet1BeforePost(DataSet: TDataSet);
    procedure ActDeliveryCfgExecute(Sender: TObject);
    procedure ActPrintDeliveryBillExecute(Sender: TObject);
    procedure UpdateSysFields;
    procedure FormCreate(Sender: TObject);
    procedure ActShowBackgroundPicExecute(Sender: TObject);
    procedure ActHouShengLabelExecute(Sender: TObject);
    procedure DrawBarCode(left,top,Ratio,barcodeHeight:integer; value:string; img:TImage);
    procedure AddPage(report: TfrReport; fileName: string);
    procedure ActHouShengLableQrptExecute(Sender: TObject);
  private
    ImgBackground:TImage;   
  public
       F_ParamGrid:TDBGrid;
       F_ParamFlds :string;
       fDict:TEditorDict;
       pageTopMargin, pageLeftMargin:integer;
  end;

var
  EditorFrm: TEditorFrm;

implementation

{$R *.DFM}
uses datamodule, RepCard, UnitDeliveryReport, barcode;

//procedure TEditorFrm.InitFrm(EditorId:string;fOpenParams:Variant;fDataSet:TDataSet;ParamGrid:Tdbgrid=nil);
procedure TEditorFrm.InitFrm(EditorId:String;fOpenParams:Variant;fDataSet:TDataSet;PparentGrid:Tdbgrid=nil;POpenFlds:String='') ;
var
  ftabs:TStringList;
  i:integer;
begin
  if Not FhlKnl1.Cf_GetDict_Editor(EditorId,fdict) then Close;


      //2006-7-26加toolbutton
  if (trim(fDict.Actions)<>''  ) and  (trim(fDict.Actions)<>'-1' )then
    // FhlKnl1.Tb_CreateActionBtns(ToolBar1,self.ActionList1 ,fDict.Actions,false);
      FhlKnl1.Tb_CreateActionBtns_Ex(ToolBar1,self.ActionList1 ,fDict.Actions,logininfo.EmpId,self.FWindowsFID )   ;

     
  width:=fDict.Width;
  height:=fDict.Height;
  Caption:=fDict.Caption;

  if CpyBtn<>nil then
    CpyBtn.Visible:=Not (fDict.CpyFlds='');
  if (fDataSet<>nil) and ((fDict.DataSetId ='-1' )or (trim(fDict.DataSetId) ='')) then
    DataSource1.DataSet:=fDataSet
  else
  begin
    FhlUser.SetDataSet(AdoDataSet1,fDict.DataSetId,fOpenParams);
    F_ParamGrid:= PparentGrid;
    F_ParamFlds:= POpenFlds;
  end;

  ftabs:=TStringList.Create;
  ftabs.CommaText:=fDict.BoxIds;
  for i:=0 to ftabs.Count-1 do
      FhlKnl1.Cf_SetBox(ftabs.Strings[i],DataSource1,FhlKnl1.Pc_CreateTabSheet(PageControl1),dmFrm.DbCtrlActionList1);
  ftabs.Free;
  SetEditState(false);


end;

procedure TEditorFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if (DataSource1.State=dsEdit) or (DataSource1.State=dsInsert) then
    case MessageDlg(fsDbChanged,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
         mrYes:begin
                 SaveActionExecute(SavBtn);
                 Action:=caHide;
               end;
         mrNo:begin
                 CancelActionExecute(celBtn);
                 Action:=caHide;
              end;
         else begin
                 Action:=caNone;
              end;
    end;
    freeandnil( ImgBackground  );
end;

procedure TEditorFrm.SetEditState(CanEdit:Boolean);
  var i:integer;bkColor:TColor;
begin
     CancelAction.Enabled:=CanEdit;
     SaveAction.Enabled:=CancelAction.Enabled;
     FirstAction.Enabled:=Not CanEdit;
     PriorAction.Enabled:=FirstAction.Enabled;
     NextAction.Enabled:=FirstAction.Enabled;
     LastAction.Enabled:=FirstAction.Enabled;
     CloseAction.Enabled:=FirstAction.Enabled;
        AddAction.Enabled:=FirstAction.Enabled;
        CopyAction.Enabled:=FirstAction.Enabled;
        EditAction.Enabled:=FirstAction.Enabled;
        DeleteAction.Enabled:=FirstAction.Enabled;
        PrintAction.Enabled:=FirstAction.Enabled;

     if CanEdit then
        bkColor:=clWhite
    else
        bkColor:=clcream;//$00F6F6F6;
        {;}
     For i:=0 to PageControl1.PageCount-1 do
     begin
         FhlKnl1.Vl_SetCtrlStyle(bkColor,PageControl1.Pages[i],CanEdit);
         
     end;
     //dmFrm.SetDataSetStyle(DataSource1.DataSet,Not CanEdit);
end;

procedure TEditorFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if SaveAction.Enabled then
 begin
   case Key of
     vk_Return:begin
               if ssCtrl in Shift then
                  SavBtn.Click
               else if Not (ActiveControl is TDbMemo) then
                  FhlKnl1.Vl_DoBoxEnter(ActiveControl)
               end;
     vk_Escape:begin
              CelBtn.Click;
             end;
   end;
 end else
 begin
   case Key of
     vk_Escape:begin
             ExtBtn.Click;
             end;
     vk_Insert:begin
              if ssCtrl in Shift then
                 ChgBtn.Click
              else
                 AddBtn.Click;
             end;
     vk_Delete:begin
                 DelBtn.Click;
             end;
     vk_Home:firstBtn.Click;
     vk_End:lastBtn.Click;
     vk_Prior:priorBtn.Click;
     vk_Next:nextBtn.Click;
     vk_Print:printBtn.Click;
   end;
 end;

end;

procedure TEditorFrm.AddActionExecute(Sender: TObject);
begin


SetEditState(True);
  FhlUser.AssignDefault(DataSource1.DataSet,false);
if not (DataSource1.DataSet.State in [dsinsert] ) then
 DataSource1.DataSet.Append;




 FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TEditorFrm.CopyActionExecute(Sender: TObject);
begin
//  if fDict.CpyFlds='' then exit;
  SetEditState(true);
  FhlKnl1.Ds_AssignValues(DataSource1.DataSet,FhlKnl1.Vr_CommaStrToVarArray(fDict.CpyFlds),FhlKnl1.Ds_GetFieldsValue(DataSource1.DataSet,fDict.CpyFlds),True,False);
  FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TEditorFrm.EditActionExecute(Sender: TObject);
begin
  if DataSource1.DataSet.IsEmpty then Exit;
  SetEditState(true);
  DataSource1.DataSet.Edit;
  FhlKnl1.Vl_FocueACtrl(PageControl1.ActivePage);
end;

procedure TEditorFrm.DeleteActionExecute(Sender: TObject);
begin
    FhlUser.CheckRight(self.fDict.deleteRit );
    if DataSource1.DataSet.IsEmpty then Exit;
   try
       if not  assigned( DataSource1.DataSet.BeforeDelete) then
       begin
         if MessageDlg('真的要删除?',mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then
         begin
           DataSource1.DataSet.Delete;
         end
         else
           Abort ;
       end
       else
       begin
           DataSource1.DataSet.Delete;
       end;
   except
       on err: exception     do
       begin
            showmessage('失败！'+err.Message  );
       end;
   end;
end;

function  TEditorFrm.GetPraValues():string;
var fldNames:TStrings;
var fldValues:string;
var i:integer;
begin
      fldNames:=TStringlist.Create ;
      fldNames.CommaText :=F_ParamFlds;

      for i:=0 to  fldNames.Count -1 do
      begin
      if i=0 then
         fldValues:= F_ParamGrid.DataSource.DataSet.fieldbyname(fldNames[i]).asstring
      else
         fldValues:=fldValues+','+  F_ParamGrid.DataSource.DataSet.fieldbyname(fldNames[i]).asstring;
      end;
      result:= fldValues;
end;

procedure TEditorFrm.FirstActionExecute(Sender: TObject);
begin
      if F_ParamGrid=nil    then
         DataSource1.DataSet.First
      else
      begin
         F_ParamGrid.DataSource.DataSet.First;

         FhlKnl1.Ds_OpenDataSet( DataSource1.DataSet,GetPraValues());
      end;
end;

procedure TEditorFrm.PriorActionExecute(Sender: TObject);
begin

      if F_ParamGrid=nil    then
         DataSource1.DataSet.Prior
      else
      begin
         F_ParamGrid.DataSource.DataSet.Prior;

         FhlKnl1.Ds_OpenDataSet( DataSource1.DataSet,GetPraValues());
      end;
end;


procedure TEditorFrm.NextActionExecute(Sender: TObject);
begin

      if F_ParamGrid=nil    then
         DataSource1.DataSet.Next
      else
      begin
         F_ParamGrid.DataSource.DataSet.Next;

//                  self.FParams:=  FhlKnl1.Vr_MergeVarArray (self.FParams,GetParamterValues);
         if DataSource1.DataSet.Active then DataSource1.DataSet.Close;
         FhlKnl1.Ds_OpenDataSet( DataSource1.DataSet,GetPraValues());
      end;
end;

procedure TEditorFrm.LastActionExecute(Sender: TObject);
begin

      if F_ParamGrid=nil    then
         DataSource1.DataSet.Last
      else
      begin
         F_ParamGrid.DataSource.DataSet.Last;
         GetPraValues();
         FhlKnl1.Ds_OpenDataSet( DataSource1.DataSet,GetPraValues());
      end;
end;

procedure TEditorFrm.CloseActionExecute(Sender: TObject);
begin
Close;
end;

procedure TEditorFrm.SaveActionExecute(Sender: TObject);
begin
    Screen.Cursor:=crSqlwait;
    try
      FhlUser.CheckRight(self.fDict.editRitID );
      UpdateSysFields();
      DataSource1.DataSet.Post;

      SetEditState(DataSource1.DataSet.State<>dsBrowse);
    finally
      Screen.Cursor:=crDefault;
    end;
end;

procedure TEditorFrm.CancelActionExecute(Sender: TObject);
begin
DataSource1.DataSet.Cancel;
SetEditState(false);
end;

procedure TEditorFrm.SetCaptionActionExecute(Sender: TObject);
begin


Caption:=fDict.Caption+' '+intTostr(DataSource1.DataSet.RecNo)+'/'+intTostr(DataSource1.DataSet.RecordCount);
end;

procedure TEditorFrm.PrintActionExecute(Sender: TObject);
begin
  FhlUser.CheckRight(fDict.PrintRitId);
  FhlKnl1.Rp_Card(intTostr(PageControl1.Pages[0].Tag),DataSource1.DataSet);
end;

procedure TEditorFrm.ToolBar1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);

    CrtCom.TopOrBtm :=true;
    CrtCom.TOPBoxId :=inttostr(self.PageControl1.ActivePage.tag);

    CrtCom.FEditorDict  :=  fdict;
    CrtCom.ModelType :=Modeleditor;
    CrtCom.mtDataSet1:=Tadodataset(DataSource1.DataSet);
    try
    CrtCom.Show;
    finally

    end;
  end;


end;

procedure TEditorFrm.actInputTaxAmtExecute(Sender: TObject);
var frmtax:   TEditorFrm;
begin
//23          24


  Screen.Cursor:=crHourGlass;
  try
    frmtax:=TEditorFrm.Create(nil);
    sDefaultVals:='';
    sDefaultVals:=sDefaultVals+'AutoPK='+self.ADODataSet1.fieldbyname('pk').AsString +',';
   sDefaultVals:=sDefaultVals+'payfund='+self.ADODataSet1.fieldbyname('Diffamt').AsString ;




    if self.ADODataSet1.FieldByName('Diffamt').AsCurrency >0 then
    begin
        TEditorFrm(frmtax).InitFrm('31',self.ADODataSet1.fieldbyname('pk').AsString,nil);
    end
    else
    begin
        TEditorFrm(frmtax).InitFrm('24',null,nil);
    end;
       // frmtax.Hide;
       // frmtax.AddBtn.Click;
        frmtax.ShowModal ;
        freeandnil(frmtax)   ;

  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TEditorFrm.ADODataSet1BeforePost(DataSet: TDataSet);
begin
showmessage('');
end;

procedure TEditorFrm.ActDeliveryCfgExecute(Sender: TObject);
var frm:TFrmDeliveryReport;
var F_firmCode:String;
begin
  FhlUser.CheckRight(fDict.PrintRitId);
  try
    F_firmCode :=  DataSource1.DataSet.fieldbyName('F_firmCode').AsString  ;
    frm:= TFrmDeliveryReport.Create(nil);
    frm.InitFrm(self.DataSource1);
    if frm.DatasetReport.Active then
      frm.DatasetReport.Locate('F_firmCode',F_firmCode,[]) ;
    frm.ShowModal ;
  finally
    freeandnil(frm);
  end;

end;

procedure TEditorFrm.ActPrintDeliveryBillExecute(Sender: TObject);
var reportGUID:String;
begin
  if (DataSource1.DataSet.fieldbyName('F_firmCode').AsString <>'' ) then
  begin
      FhlUser.CheckRight(fDict.PrintRitId);
      reportGUID := FhlUser.GetReportGUID( DataSource1.DataSet.fieldbyName('F_firmCode').AsString );
      FhlKnl1.Rp_ExpressPrint( reportGUID ,DataSource1.DataSet);
  end;
end;

procedure TEditorFrm.UpdateSysFields;
begin
  if  DataSource1.DataSet.FindField  ('FLstEditEmp') <>nil then
       DataSource1.DataSet.FieldByName ('FLstEditEmp').AsString  :=  trim(logininfo.EmpId) ;
   if  DataSource1.DataSet.FindField  ('FlstEditTime') <>nil then
       DataSource1.DataSet.FieldByName ('FlstEditTime').Value :=now;

end;

procedure TEditorFrm.FormCreate(Sender: TObject);
begin

ImgBackground:=TImage.Create(nil);
end;

procedure TEditorFrm.ActShowBackgroundPicExecute(Sender: TObject);
begin
 ImgBackground.Picture.LoadFromFile('PrintingBackgroud\HoushengLabelBackground.bmp');
 ImgBackground.Parent :=  PageControl1.Pages[0];
 ImgBackground.Top :=0 ;
 ImgBackground.Left :=0;
 ImgBackground.Width := ImgBackground.Parent.Width ;
 ImgBackground.Height := ImgBackground.Parent.Height ; 
end;

procedure TEditorFrm.ActHouShengLabelExecute(Sender: TObject);
var img:Timage; control:TControl; font:Tfont;
i:integer;     Barcode1 : TAsBarcode; imgBarCode:Timage;
ctrlFBottomBarCode , ctrlFPesistorPartNo :TControl;
TopLeft1FontName, TopLeft2FontName, ContentFontName, sql, PicFileName:string;
TopLeft1FontSize, TopLeft2FontSize, ContentFontSize, fontstyleBold , barcodeHeight  :integer;
TopLeft1Bold, TopLeft2Bold ,contentBold:boolean;
begin
  try
    ActShowBackgroundPicExecute(self);

    sql:='select  isnull(FParamValue,''黑体'') from TParamsAndValues where FParamCode like ''%020204%'' and FParamDescription=''TopLeft1FontName'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    TopLeft1FontName:=fhlknl1.User_Query.fields[0].AsString ;

    sql:='select  isnull(FParamValue,''黑体'') from TParamsAndValues where FParamCode like ''%020204%'' and FParamDescription=''TopLeft2FontName'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    TopLeft2FontName:=fhlknl1.User_Query.fields[0].AsString ;

    sql:='select  isnull(FParamValue,''黑体'') from TParamsAndValues where FParamCode like ''%020204%'' and FParamDescription=''ContentFontName'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    ContentFontName:=fhlknl1.User_Query.fields[0].AsString ;

    sql:='select  isnull(FParamValue,8) from TParamsAndValues where  FParamCode like ''%020204%'' and FParamDescription=''TopLeft1Bold'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    TopLeft1Bold:=fhlknl1.User_Query.fields[0].AsInteger =1 ;
   
    sql:='select  isnull(FParamValue,8) from TParamsAndValues where  FParamCode like ''%020204%'' and FParamDescription=''TopLeft2Bold'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    TopLeft2Bold:=fhlknl1.User_Query.fields[0].AsInteger =1 ;

    sql:='select  isnull(FParamValue,8) from TParamsAndValues where  FParamCode like ''%020204%'' and FParamDescription=''ContentBold'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    contentBold:=fhlknl1.User_Query.fields[0].AsInteger =1 ;

    sql:='select  isnull(FParamValue,8) from TParamsAndValues where  FParamCode like ''%020204%'' and FParamDescription=''TopLeft1FontSize'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    TopLeft1FontSize:=fhlknl1.User_Query.fields[0].AsInteger ;

    sql:='select  isnull(FParamValue,8) from TParamsAndValues where  FParamCode like ''%020204%'' and FParamDescription=''TopLeft2FontSize'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    TopLeft2FontSize:=fhlknl1.User_Query.fields[0].AsInteger ;

    sql:='select  isnull(FParamValue,8) from TParamsAndValues where  FParamCode like ''%020204%'' and FParamDescription=''ContentFontSize'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    ContentFontSize:=fhlknl1.User_Query.fields[0].AsInteger ;

    sql:='select  isnull(FParamValue,8) from TParamsAndValues where  FParamCode like ''%020204%'' and FParamDescription=''barcodeHeight'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    barcodeHeight:=fhlknl1.User_Query.fields[0].AsInteger ;

    sql:='select  isnull(FParamValue,8) from TParamsAndValues where  FParamCode like ''%020204%'' and FParamDescription=''pageTopMargin'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    pageTopMargin:=fhlknl1.User_Query.fields[0].AsInteger ;

    sql:='select  isnull(FParamValue,8) from TParamsAndValues where  FParamCode like ''%020204%'' and FParamDescription=''pageleftMargin'' ';
    fhlknl1.Kl_GetUserQuery(sql);
    pageleftMargin:=fhlknl1.User_Query.fields[0].AsInteger ;




    font:= Tfont.Create;
    Barcode1 := TAsBarcode.Create(nil);
    font.Name :=ContentFontName;

    img:=Timage.Create(nil);

    img.Width :=  220 ;
    img.Height  :=  160 ;

    img.Canvas.Draw(  pageLeftMargin,  pageTopMargin, self.ImgBackground.Picture.Graphic  );
    img.Canvas.Font.Assign(font);

    for i:=0 to PageControl1.Pages[0].Controlcount -1 do
    begin
      control :=  PageControl1.Pages[0].Controls[i] ;
      if  control is TfhldbEdit then
      begin
          if ( control as TfhldbEdit).Field.FieldName ='FPesistorPartNo' then
            ctrlFPesistorPartNo :=  PageControl1.Pages[0].Controls[i] ;
          if ( control as TfhldbEdit).Field.FieldName ='FBottomBarCode' then
            ctrlFBottomBarCode :=  PageControl1.Pages[0].Controls[i] ;
      end;
    end;

    for i:=0 to PageControl1.Pages[0].Controlcount -1 do
    begin
      control :=  PageControl1.Pages[0].Controls[i] ;    if  control is TfhldbEdit then
      if  control is TfhldbEdit then
      begin
        if ( control as TfhldbEdit).Field.FieldName ='FPesistorPartNo' then
           DrawBarCode ( ctrlFBottomBarCode.Left-2 +pageLeftMargin, ctrlFPesistorPartNo.Top +pageTopMargin + 15 , 2, barcodeHeight, DataSource1.DataSet.fieldbyname('FPesistorPartNo').AsString, img);
        if ( control as TfhldbEdit).Field.FieldName ='FBottomBarCode' then
           DrawBarCode ( ctrlFBottomBarCode.Left-2 +pageLeftMargin, ctrlFBottomBarCode.Top +pageTopMargin + 15 , 3, barcodeHeight, DataSource1.DataSet.fieldbyname('FBottomBarCode').AsString, img);
      end;
    end;

     for i:=0 to PageControl1.Pages[0].Controlcount -1 do
    begin
      control :=  PageControl1.Pages[0].Controls[i] ;
      img.Canvas.Font.Size :=ContentFontSize;
      

      if  control is TfhldbEdit then
      begin
        if (control as TfhldbEdit ).Field.FieldName = 'FLeftTop1'  then
        begin
            if TopLeft1Bold  then
              img.Canvas.font.Style :=font.Style + [fsBold]
            else
              img.Canvas.font.Style :=font.Style - [fsBold];

          img.Canvas.Font.Size :=TopLeft1FontSize;
        end
        else
        if (control as TfhldbEdit ).Field.FieldName = 'FLeftTop2'  then
        begin
           if TopLeft2Bold  then
              img.Canvas.font.Style :=font.Style + [fsBold]
            else
              img.Canvas.font.Style :=font.Style - [fsBold];

          img.Canvas.Font.Size :=TopLeft2FontSize;
        end
        else
            if contentBold  then
              img.Canvas.font.Style :=font.Style + [fsBold]
            else
              img.Canvas.font.Style :=font.Style - [fsBold];

        img.Canvas.TextOut( control.left+ pageLeftMargin, control.top+pageTopMargin, (control as TfhldbEdit).Text );
      end;
       if  control is Tlabel then
      begin
        if contentBold  then
          img.Canvas.font.Style :=font.Style + [fsBold]
        else
          img.Canvas.font.Style :=font.Style - [fsBold];

        img.Canvas.TextOut( control.left+pageLeftMargin, control.top+pageTopMargin, (control as Tlabel).Caption  );
      end;
    end;
    PicFileName:=  'barcodeImages\'+DataSource1.DataSet.fieldbyname('F_ID').AsString +'.bmp' ;
    img.Picture.SaveToFile( PicFileName );

    frReport1.LoadFromFile('barcode.frf');

    AddPage( self.frReport1, PicFileName );
    frReport1.Pages.Delete(0);
  
    //frReport1.Pages[0].Width :=10;
    //frReport1.Pages[0].Height :=5;

    //frReport1.PreviewButtons := [pbZoom, pbLoad, pbSave, pbPrint, pbHelp, pbExit] ;
    frReport1.PrepareReport;
    frReport1.ShowReport;
  finally
    freeandnil(img);
    freeandnil(font);
    freeandnil(Barcode1);
  end;
end;
procedure TEditorFrm.AddPage(report: TfrReport; fileName: string);
var picview,t1,t0:TfrPictureView;
var newpage:TfrPage;
begin
  t0:=TfrPictureView(report.Pages[0].FindObject('Picture1'));
  
  report.Pages.Add;

  newpage:= report.Pages[report.Pages.Count -1]  ;
  newpage.pgWidth:=report.Pages[0].pgWidth;
  newpage.pgHeight:=report.Pages[0].pgHeight;
  newpage.pgSize := report.Pages[0].pgSize;

  picview:= TfrPictureView.Create;
  picview.Assign(t0);
  picview.ParentPage :=newpage;

  newpage.Objects.Add( picview );

  t1:=TfrPictureView(newpage.FindObject('Picture1'));
   //pageTopMargin, pageLeftMargin:integer;
  
  if t1<>nil then
  begin
    t1.Picture.loadfromfile(fileName);
   // t1.Selected := true;
  end;
end;
procedure TEditorFrm.DrawBarCode(left,top,Ratio, barcodeHeight:integer; value:string; img:TImage);
var Barcode1 :TAsBarcode ;
var imgBarCode:Timage;
begin
  try
    Barcode1 := TAsBarcode.create(nil) ;
    imgBarCode:= Timage.Create(nil);
    imgBarCode.Height := barcodeHeight ;
    imgBarCode.Width  := img.Width -50 ;

    Barcode1.ShowText :=TBarcodeOption(2) ;
    Barcode1.Left := 1 ;
    Barcode1.Typ :=  TBarcodeType(5);
    Barcode1.Modul := 1;
    Barcode1.Ratio := Ratio;
    Barcode1.Height := imgBarCode.Height ;
    Barcode1.Text:= value ;
    Barcode1.DrawBarcode(imgBarCode.Canvas  );
    img.Canvas.Draw(  Left , top , imgBarCode.Picture.Graphic  );

  finally
    freeandnil(imgBarCode);
    freeandnil(Barcode1);
  end;
end;

procedure TEditorFrm.ActHouShengLableQrptExecute(Sender: TObject);
var frm:TQrptHoushengLabel;
begin
  try
   frm:= TQrptHoushengLabel.Create(nil);
   frm.Prepare;
   frm.PreviewModal ;
  finally
   frm.Free ;
  end;
end;

end.

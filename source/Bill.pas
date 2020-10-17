unit Bill;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, Db, Grids, DBGrids, StdCtrls, ImgList, ExtCtrls,ComCtrls, ToolWin,
  variants,BillOpenDlg,pick, ActnList, Menus,FhlKnl,UnitCreateComponent,PickWindowUniveral,
  DBCtrls,UnitModelFrm;

type
  TBillFrm = class(TFrmModel)
    mtDataSource1: TDataSource;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    NewBtn: TToolButton;
    RemoveBtn: TToolButton;
    OpenBtn: TToolButton;
    Panel1: TPanel;
    ToolButton1: TToolButton;
    ExtBtn: TToolButton;
    SavBtn: TToolButton;
    ToolButton4: TToolButton;
    chkBtn: TToolButton;
    DlDataSource1: TDataSource;
    CelBtn: TToolButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    Refreshbtn: TToolButton;
    ToolButton5: TToolButton;
    AddBtn: TToolButton;
    DelBtn: TToolButton;
    HelpBtn: TToolButton;
    linkBtn: TToolButton;
    PrintBtn: TToolButton;
    ToolButton3: TToolButton;
    importBtn: TToolButton;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    TitleLabel: TLabel;
    dlDataSet1: TADODataSet;
    mtDataSet1: TADODataSet;
    Image1: TImage;
    Image2: TImage;
    ActionList1: TActionList;
    MailAction1: TAction;
    PrintAction1: TAction;
    OpenAction1: TAction;
    NewAction1: TAction;
    CopyAction1: TAction;
    RemoveAction1: TAction;
    CancelAction1: TAction;
    SaveAction1: TAction;
    CheckAction1: TAction;
    LinkAction1: TAction;
    ImportAction1: TAction;
    AppendAction1: TAction;
    DeleteAction1: TAction;
    RefreshAction1: TAction;
    LocateAction1: TAction;
    DownAction1: TAction;
    CloseAction1: TAction;
    HelpAction1: TAction;
    FirstAction1: TAction;
    PriorAction1: TAction;
    NextAction1: TAction;
    LastAction1: TAction;
    MainMenu1: TMainMenu;
    FaxAction1: TAction;
    btn2: TToolButton;
    actAftSaveBill: TAction;
    ActFormalInvoice: TAction;
    ActInvAdjfnshldin: TAction;
    ActInvAdjfnshldout: TAction;
    ActFnShldIn: TAction;
    ActFnShldOut: TAction;
    ToolButton2: TToolButton;
    BtnLock: TToolButton;
    ActLock: TAction;
    ActPrint2: TAction;
    PrintBtn2: TToolButton;
    Action1: TAction;
    procedure InitFrm(FrmId:String);
    procedure CloseBill;
    procedure SetRitBtn;
    procedure EditPostAfter(IsEnabled:Boolean);
    procedure OpenCloseAfter(IsOpened:Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DlDataSource1StateChange(Sender: TObject);
    procedure mtDataSource1StateChange(Sender: TObject);
    procedure ScrollBox1CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure dlDataSet1CalcFields(DataSet: TDataSet);
    procedure OpenBill(fCode:String);

    procedure CpyBtnClick(Sender: TObject);
    procedure SetBtmBoxHeight(Sender: TObject);
    procedure SetBillStyle(fReadOnly:Boolean);
    procedure SetCtrlStyle(fEnabled:Boolean);
    procedure SetCheckStyle(IsChecked:Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrintAction1Execute(Sender: TObject);
    procedure OpenAction1Execute(Sender: TObject);
    procedure NewAction1Execute(Sender: TObject);
    procedure RemoveAction1Execute(Sender: TObject);
    procedure CancelAction1Execute(Sender: TObject);
    procedure SaveAction1Execute(Sender: TObject);
    procedure CheckAction1Execute(Sender: TObject);
    procedure LinkAction1Execute(Sender: TObject);
    procedure ImportAction1Execute(Sender: TObject);
    procedure AppendAction1Execute(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure RefreshAction1Execute(Sender: TObject);
    procedure CloseAction1Execute(Sender: TObject);
    procedure MailAction1Execute(Sender: TObject);
    procedure FaxAction1Execute(Sender: TObject);
    procedure DownAction1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrollBox1DblClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure ScrollBox2DblClick(Sender: TObject);
    procedure dlDataSet1AfterPost(DataSet: TDataSet);

    procedure ActFormalInvoiceExecute(Sender: TObject);
    procedure iniuserBtns;
    function  IsValideBill:boolean;
    procedure ActInvAdjfnshldinExecute(Sender: TObject);
    procedure ActInvAdjfnshldoutExecute(Sender: TObject);
    procedure ActFnShldInExecute(Sender: TObject);
    procedure ActFnShldOutExecute(Sender: TObject);
    function AftSaveBillExecute:boolean;
    procedure ActLockExecute(Sender: TObject);
    procedure  SetLock(lock:boolean);
    procedure ActPrint2Execute(Sender: TObject);
    procedure HidePriceAmtFields(hide:boolean);
    procedure SetIsPrinted;
  private

    fBtmBoxMaxHeight,fBtmBoxMinHeight:Integer;
    fDbGridColsColor:Variant;
    fbilldict:TBillDict;
    fBillOpenDlgFrm:TBillOpenDlgFrm;
    fPickFrm,fBillPickFrm:TPickFrm;
    FrmPickUniversal: TFrmPickUniversal;    //2006-8
  public

  end;

const
  cBillManId='BillManId';
  cIsChk='IsChk';
  cChkTime='ChkTime';

var
  BillFrm: TBillFrm;
  FormId:integer;
implementation
uses editor,RepBill,datamodule,TabGrid,Mailer,Downer, desktop,
  UnitSearchBarCode;
{$R *.DFM}

procedure TBillFrm.InitFrm(FrmId:String);
 var i:integer;
begin
   FormId:=strtoint( FrmId);
  if Not FhlKnl1.Cf_GetDict_Bill(FrmId,fbilldict) then Close;     //etDict_Bill
  if  FrmId='52' then self.dlDataSet1.AutoCalcFields :=false;
  //
  Caption:=fbilldict.BillCnName;
  TitleLabel.Caption:='  '+Caption+'  ';
  TitleLabel.Font.Color:=StringToColor(fbilldict.TitleLabelFontColor);
  TitleLabel.Font.Size:=fbilldict.TitleLabelFontSize;
  TitleLabel.Font.Name:=fbilldict.TitleLabelFontName;

  FhlUser.SetDataSet(mtDataSet1,fbilldict.mtDataSetId,Null,false);

  if (fbilldict.TopBoxId)<>'-1' then      //top or buttom      create label and dbcontrol
  FhlKnl1.Cf_SetBox(fbilldict.TopBoxId,MtDataSource1,ScrollBox1,dmFrm.dbCtrlActionList1);

  if (fbilldict.BtmBoxId)<>'-1' then
  FhlKnl1.Cf_SetBox(fbilldict.BtmBoxId,MtDataSource1,ScrollBox2,dmFrm.dbCtrlActionList1);

  FhlUser.SetDbGridAndDataSet(DbGrid1,fbilldict.dlGridId,Null,false);

  fDbGridColsColor:=VarArrayCreate([0,DbGrid1.Columns.Count-1],varVariant);
  for i:=0 to dbGrid1.Columns.Count-1 do
     fDbGridColsColor[i]:=DbGrid1.Columns[i].Color;

  OpenCloseAfter(false);
  fBtmBoxMaxHeight:=210;
  fBtmBoxMinHeight:=ScrollBox2.Height;
  self.OnActivate:=SetBtmBoxHeight;
  self.OnDeactivate:=SetBtmBoxHeight;
  //  FhlInitor.SetMainMenu('2',MainMenu1,ToolBar1,ActionList1);

  iniuserBtns;
           { }
end;

procedure TBillFrm.OpenBill(fCode:String);
begin
   fbilldict.BillCode:=fCode;
   FhlKnl1.Ds_OpenDataSet(mtDataSet1,varArrayof([fbilldict.BillCode]));
   if (mtDataSet1.RecordCount<>1) and (fbilldict.BillCode<>'fangheling') then
   begin
     MessageDlg(#13#10+'没有找到编号为"'+fbilldict.BillCode+'"的单据记录.',mtInformation,[MbYes],0);
     CloseBill;
     Exit;
   end;
   FhlKnl1.Ds_OpenDataSet(dlDataSet1,varArrayof([fbilldict.BillCode]));
   OpenCloseAfter(True);
end;



procedure TBillFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if SaveAction1.Enabled then
    case MessageDlg(fsDbChanged,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
         mrYes:SaveAction1Execute(SavBtn);
         mrCancel:begin
                   Action:=caNone;
                   Abort;
                  end;
    end;
  fPickFrm.Free;
  fBillPickFrm.Free;
  fBillOpenDlgFrm.Free;
  Action:=caFree	;

end;

procedure TBillFrm.DlDataSource1StateChange(Sender: TObject);
begin
  if (DlDataSource1.State=dsEdit) or (DlDataSource1.State=dsInsert) then begin
     DbGrid1.Options:=DbGrid1.Options-[dgColumnResize];
     EditPostAfter(false);
  end
  else
     DbGrid1.Options:=DbGrid1.Options+[dgColumnResize];
end;

procedure TBillFrm.mtDataSource1StateChange(Sender: TObject);
begin
  if (MtDataSource1.State=dsEdit) or (MtDataSource1.State=dsInsert) then
     EditPostAfter(false);
end;

procedure TBillFrm.ScrollBox1CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize:=NewHeight>50;
end;

procedure TBillFrm.SetBtmBoxHeight(Sender: TObject);
begin
  if ((fPickFrm<>nil) and (fPickFrm.Visible)) or ((fBillPickFrm<>nil) and (fBillPickFrm.Visible)) or ((FrmPickUniversal<>nil) and (FrmPickUniversal.Visible)) then
  begin
     ScrollBox2.Height:=fBtmBoxMaxHeight ;
     if assigned(fPickFrm) then
        fPickFrm.Top :=ScrollBox2.Top  +self.ToolBar1.Height+20 ;
     if assigned(FrmPickUniversal) then
        FrmPickUniversal.Top :=ScrollBox2.Top  +self.ToolBar1.Height+20 ;

  end
  else
     ScrollBox2.Height:=fBtmBoxMinHeight;
end;

procedure TBillFrm.dlDataSet1CalcFields(DataSet: TDataSet);
begin

   if dataset.FindField('MyIndex')<>nil then
      begin
            with DataSet do
            begin
              if  FieldByName('MyIndex').asInteger<>Abs(RecNo) then
                   FieldByName('MyIndex').asInteger:=Abs(RecNo);//Is fkCalculated
              if ((FindField('Price')<>nil )and (FindField('Fund')<>nil) and (FindField('Qty')<>nil) )then
                 if   FieldByName('Fund').asCurrency<>FieldByName('Qty').asFloat*FieldByName('Price').asFloat then
                      FieldByName('Fund').asCurrency:=FieldByName('Qty').asFloat*FieldByName('Price').asFloat;
            end;
      end;

 {
      begin
          with DataSet do
          begin //2006-12-16
                   if (FindField('amt')<>nil ) and (FindField('Qty')<>nil )  and (FindField('Price')<>nil )  then
                      FieldByName('amt').asCurrency:=FieldByName('Qty').asFloat*FieldByName('Price').asFloat;
           end;
      end;}
end;

procedure TBillFrm.CloseBill;
begin
   mtDataSet1.Close;
   dlDataSet1.Close;
   OpenCloseAfter(false);
end;

procedure TBillFrm.SetRitBtn;
begin
    PrintAction1.Enabled:=true;
    ActPrint2.Enabled:=PrintAction1.Enabled;
    MailAction1.Enabled:=true;
    FaxAction1.Enabled:=true;
    DownAction1.Enabled:=true;
    NewAction1.Enabled:=true;
    CopyAction1.Enabled:=true;
    RemoveAction1.Enabled:=true;
    CheckAction1.Enabled:=true;
    SetCheckStyle(mtDataSet1.FieldByName(cIsChk).AsBoolean);
end;

procedure TBillFrm.OpenCloseAfter(IsOpened:Boolean);
begin
if (self.mtDataSet1.LockType = ltReadOnly ) and (self.dlDataSet1.locktype=ltReadOnly)   then
  begin
    NewAction1.Enabled:=false;
    CloseAction1.Enabled:=true;
    exit;
  end;


  if IsOpened then
     SetRitBtn
  else begin
    PrintAction1.Enabled:=IsOpened;
    ActPrint2.Enabled:=PrintAction1.Enabled;
    DownAction1.Enabled:=IsOpened;
    MailAction1.Enabled:=IsOpened;
    FaxAction1.Enabled:=IsOpened;
    CopyAction1.Enabled:=IsOpened;
    RemoveAction1.Enabled:=IsOpened;
    CheckAction1.Enabled:=IsOpened;
    AppendAction1.Enabled:=IsOpened;
    DeleteAction1.Enabled:=IsOpened;
    linkAction1.Enabled:=IsOpened;
    ImportAction1.Enabled:=IsOpened;
  end;
  NewAction1.Enabled:=true;
  RefreshAction1.Enabled:=IsOpened;
  FirstAction1.Enabled:=IsOpened;
  PriorAction1.Enabled:=IsOpened;
  NextAction1.Enabled:=IsOpened;
  LastAction1.Enabled:=IsOpened;
  LocateAction1.Enabled:=IsOpened;
  SaveAction1.Enabled:=false;
  CancelAction1.Enabled:=false;
  OpenAction1.Enabled:=true;
  CloseAction1.Enabled:=true;
  DbGrid1.Enabled:=IsOpened;
  if not IsOpened then
     SetCtrlStyle(false);
end;

procedure TBillFrm.EditPostAfter(IsEnabled:Boolean);
begin
    if IsEnabled then
       SetRitBtn
    else begin
     NewAction1.Enabled:=IsEnabled;
     CopyAction1.Enabled:=IsEnabled;
     RemoveAction1.Enabled:=IsEnabled;
     CheckAction1.Enabled:=IsEnabled;
    end;
     OpenAction1.Enabled:=IsEnabled;
     RefreshAction1.Enabled:=IsEnabled;
  FirstAction1.Enabled:=IsEnabled;
  PriorAction1.Enabled:=IsEnabled;
  NextAction1.Enabled:=IsEnabled;
  LastAction1.Enabled:=IsEnabled;
     CloseAction1.Enabled:=IsEnabled;
     PrintAction1.Enabled:=IsEnabled;
     ActPrint2.Enabled:=PrintAction1.Enabled;
     DownAction1.Enabled:=IsEnabled;
     MailAction1.Enabled:=IsEnabled;
     FaxAction1.Enabled:=IsEnabled;
     SaveAction1.Enabled:=Not IsEnabled;
     CancelAction1.Enabled:=Not IsEnabled;
end;

procedure TBillFrm.CpyBtnClick(Sender: TObject);
// var f,code:wideString;
begin
{ code:=mtDataSet1.FieldByName(mkeyfld).asString;
 OpenBill('fangheling');
 with FreeQuery1 do begin
      Close;
      Sql.Clear;
      Sql.Append('select * from '+mtbl+' where '+mkeyfld+'='''+Code+'''');
      Open;
 end;
 f:=BillDict.FieldByName('CopyMasterFields').asString;
 dmFrm.CopyValues(FreeQuery1,mtDataSet1,f,f);
 f:=BillDict.FieldByName('CopyDetailFields').asString;
 with FreeQuery1 do begin
      Close;
      Sql.Clear;
      Sql.Append('select * from '+ftbl+' where '+fkeyfld+'='''+Code+'''');
      Open;
      while not eof do begin
        dmFrm.CopyValues(FreeQuery1,dlDataSet1,f,f);
        next;
      end;
 end;}
end;

procedure TBillFrm.SetBillStyle(fReadOnly:Boolean);
begin
 //set btn.enabled to false
 LinkAction1.Enabled:=Not fReadOnly;
 ImportAction1.Enabled:=Not fReadOnly;
 AppendAction1.Enabled:=Not fReadOnly;
 DeleteAction1.Enabled:=Not fReadOnly;
 SetCtrlStyle(Not fReadOnly);
end;

procedure TBillFrm.SetCtrlStyle(fEnabled:Boolean);
 var bkColor:TColor;
begin
// dmFrm.SetDataSetStyle(mtDataSet1,fReadOnly);
 if fEnabled then
    bkColor:=clWhite
 else
    bkColor:=clCream;
 FhlKnl1.Vl_SetCtrlStyle(bkColor,ScrollBox1,fEnabled);
 FhlKnl1.Vl_SetCtrlStyle(bkColor,ScrollBox2,fEnabled);
 FhlKnl1.Dg_SetDbGridStyle(DbGrid1,Not fEnabled,bkColor,fDbGridColsColor);
end;

procedure TBillFrm.SetCheckStyle(IsChecked:Boolean);
begin
  self.BtnLock.Enabled := not IsChecked;
  
  if IsChecked then begin
     SetBillStyle(IsChecked);
     ChkBtn.Caption:='弃审';
     RemoveAction1.Enabled:=false;
  end
  else begin
    // if (frit[0] or frit[1]) then
       SetBillStyle(false);
     {else
       SetBillStyle(true,clCream);}
     ChkBtn.Caption:='审核';
     RemoveAction1.Enabled:=true;//frit[2];
  end;
  Image1.Visible:=IsChecked;
  Image2.Visible:=not Image1.Visible;
end;

procedure TBillFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{A.浏览状态下
  1.Ctrl+p: 打印单据
  2.Ctrl+o: 打开单据
  3.Insert: 新建单据
  4.Ctrl+Alt+C: 复制单据
  5.Delete: 删除单据
  6.Ctrl+Insert: 弃审
  7.Esc: 关闭窗体
  8.F5: 刷新
B.编辑模式下
  1.Enter: 焦点转移到下一编辑框
  3.Esc: 放弃保存
  2:Ctrl+Enter: 保存数据
  4.Ctrl+': 引用
  5.Ctrl+<-: 导入
  6.Ctrl+Delete: 删行}
  if ssCtrl in Shift then
  begin
      case Key of
        //p
        80:PrintBtn.Click;
        //o
        79:Openbtn.Click;
        //'
        222:LinkBtn.Click;
        //<-
        8:ImportBtn.Click;
        vk_Insert:chkBtn.Click;
        vk_Delete:RemoveBtn.Click;
        vk_Return:SavBtn.Click;
        67:begin
             if ssAlt in Shift then
                showmessage('copy');
           end;
      end;
  end else
  begin
    case Key of
      vk_Insert:NewBtn.Click;
      vk_F5:RefreshBtn.Click;
      vk_Escape:begin
                  if SavBtn.Enabled then
                     CelBtn.Click
                  else
                     ExtBtn.Click;  
                end;
     vk_Return:begin
                 if Not (ActiveControl is TDbGrid) then
                   FhlKnl1.Vl_DoBoxEnter(ActiveControl)
                 else
                    with TDBGrid(ActiveControl) do
                    begin
                        if FhlKnl1.Dg_SetSelectedIndex(TDbGrid(ActiveControl),False) then
                        begin
                          if (fPickFrm<>nil) and (fPickFrm.Visible) then
                              fPickFrm.ComboBox1.SetFocus
                          else
                              DataSource.DataSet.Append;
                        end;
                    end;
              end;
    end;
  end;
end;

procedure TBillFrm.PrintAction1Execute(Sender: TObject);
var
  bk:TBookmark;
begin
  FhlUser.CheckRight(fbilldict.PrintRitId);
  Screen.Cursor:=crSqlWait;
  bk:=dlDataSet1.GetBookmark;
  dlDataSet1.DisableControls;

  try
    //hide field
    RepBillFrm:=TRepBillFrm.Create(Application);
    SetIsPrinted;
    RepBillFrm.SetBillRep(fbilldict.TopBoxId,fbilldict.BtmBoxId,mtDataSet1,DbGrid1);
    RepBillFrm.PreviewModal;//Preview;
  finally
    FreeAndNil(RepBillFrm);
    dlDataSet1.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  dlDataSet1.GotoBookmark(bk);
    //restore field
    
end;

procedure TBillFrm.OpenAction1Execute(Sender: TObject);
begin

  FhlUser.CheckRight(fbilldict.ReadRitId);
  if fBillOpenDlgFrm=nil then
  begin
    Screen.Cursor:=crSqlwait;
    try
      fBillOpenDlgFrm:=TBillOpenDlgFrm.Create(self);
      fBillOpenDlgFrm.InitOneBill(TitleLabel.Caption,fbilldict.mtGridId,fbilldict.mkeyfld);
    finally
      Screen.Cursor:=crDefault;
    end;
  end
  else
    with fBillOpenDlgFrm.ADODataSet1 do
    begin
      Screen.Cursor:=crSqlWait;
      try
      Close;
      Open;
      finally
      Screen.Cursor:=crDefault;
      end;
      Locate(fbilldict.mkeyfld,fbilldict.BillCode,[]);
    end;
    
 if fBillOpenDlgFrm.ShowModal=mrOk then  
     self.OpenBill(fBillOpenDlgFrm.FileNameComboBox.Text);
   {}
end;

procedure TBillFrm.NewAction1Execute(Sender: TObject);
begin
      if    not (mtDataSet1.LockType = ltReadOnly) then
      begin

        OpenBill('fangheling');
        mtDataSet1.Append;
        FhlKnl1.Vl_FocueACtrl(ScrollBox1);
      end;
end;

procedure TBillFrm.RemoveAction1Execute(Sender: TObject);
var sql:string;
begin
    if self.mtDataSet1.FindField('FisSys')<>nil then
      if mtDataSet1.FieldByName ('FisSys').AsBoolean then
      begin
        showmessage('系统生成的单据不能删除！');
        exit;
      end;
    if self.mtDataSet1.FindField('islock')<>nil then
        if  mtDataSet1.FieldByName('islock').AsBoolean  then
        begin
             showmessage('请先解锁！' );
             exit;
        end;

    sql:='delete from Tbarcode where   FbillCode='+quotedstr(fbilldict.BillCode);//+'  or FoutpackageBarCode ='+quotedstr(fbilldict.BillCode);

    if mtDataSet1.State in [dsinsert,dsedit] then
      mtDataSet1.Cancel;

    if    not (mtDataSet1.LockType = ltReadOnly) then
    begin
      if MessageDlg(#13#10+'警告! 所有本单的数据将被删除且无法恢复,您确定吗?   ',mtWarning,mbOkCancel,0)=mrOk then
      begin
      Screen.Cursor:=CrSqlWait;
        try
          try
              dmfrm.ADOConnection1.BeginTrans    ;
              FhlUser.DoExecProc(mtDataSet1,null);
              fhlknl1.Kl_GetUserQuery(sql,false);

          
              dmfrm.ADOConnection1.CommitTrans;
          except
              on err:exception do
              begin
                  dmfrm.ADOConnection1.RollbackTrans ;
                   showmessage('弃单失败！'+err.Message  );
                  exit;
              end;
          end;

          CloseBill;

        finally
         Screen.Cursor:=crDefault;
        end;
      end;
    end;

end;

procedure TBillFrm.CancelAction1Execute(Sender: TObject);
begin
 if MessageDlg(fsDbCancel,mtConfirmation,[mbYes,mbNo],0)=mrYes then
 begin
   { if self.mtDataSet1.State in [dsinsert,dsedit] then
       mtDataSet1.Cancel ;
    if self.dlDataSet1.State in [dsinsert,dsedit] then
       dlDataSet1.Cancel ;
   }
    if fbilldict.BillCode='fangheling' then
       CloseBill
    else
       OpenBill(fbilldict.BillCode);
      
    if assigned(FrmPickUniversal) then FrmPickUniversal.Close ;

 end;
end;

procedure TBillFrm.SaveAction1Execute(Sender: TObject);
var
  //istmp:Boolean;
  s,ss,f:widestring;
var i:integer;
var DlgMsg:string;

begin
  Screen.Cursor:=CrSqlWait;
  try
       FhlUser.CheckRight(fbilldict.WriteRitId);
       //
       if mtDataSet1.FieldByName(cBillManId).AsString<>LoginInfo.EmpId then
       begin
         MessageDlg(#13#10'只有制单人才有相应单据的修改权限!',mtWarning,[mbOk],0);
         Abort;
       end;

       for i:=0 to self.ScrollBox1.ComponentCount-1 do
       begin
            if   self.ScrollBox1.Components [i] is TDBCheckBox then
                 if   uppercase(TDBCheckBox (self.ScrollBox1.Components [i] ).Field.FieldName) ='ISTAX' then
                      if   TDBCheckBox (self.ScrollBox1.Components [i] ).Field.Value <>null then
                      begin
                            if  not TDBCheckBox (self.ScrollBox1.Components [i] ).Checked   then
                                DlgMsg:=   '确定不含税吗?'
                            else
                                DlgMsg:=   '确定含税吗?';

                             if Messagedlg(DlgMsg,  mtWarning,[mbYes, mbNo],0) = mrNO then
                             begin
                                 exit;
                             end
                             else
                                 break;
                       end;
       end;
{       if (self.mtDataSet1.FindField('Istax')<>nil )and (self.mtDataSet1.FieldByName('IsTax').Value <>null)then
       if  self.mtDataSet1.FieldByName('IsTax'). =true  then
       if MessageBox(0, '确定不含税吗?', '', MB_YESNO + MB_ICONQUESTION) = IDNO then
       begin
           exit;
       end;
       }

      //  // 做到存储过程里去吧
      //  select isbill from sys_id where tblid='385'
      dmFrm.GetQuery1('select * from sys_id where tblid='+fbilldict.mttblid);

    if not dmFrm.FreeQuery1.IsEmpty then
       begin

            if desktopfrm.dsMainMenu.findField('subSysDBName')=nil then
            begin
                if not IsValideBill then begin
                    Screen.Cursor:=crDefault;
                    exit;
                end;
            end
            else
            begin
                if dmFrm.FreeQuery1.FieldByName('Isbill').AsBoolean then
                if strToint(fBillDict.Id)<>23 then
                if not IsValideBill then begin
                    Screen.Cursor:=crDefault;
                    exit;
                end;
            end;
       end
      else
       begin
         MessageBox(0, '单号前缀错误?', '', MB_OK + MB_ICONQUESTION);
         exit;
       end;



     if strToint(fBillDict.Id) in [3,19] then//零售和发货单
     begin
           //开始售价检测
           with dlDataSet1 do
           begin
               DisableControls;
               First;
               while not eof do
               begin
                   if FieldByName('WareId').Value <>null then
                   begin
                         dmFrm.GetQuery1('select cost as price   from wr_ware where Id='+FieldByName('WareId').AsString);
                         if not dmFrm.FreeQuery1.IsEmpty then
                           if FieldByName('Price').AsCurrency<dmFrm.FreeQuery1.Fields[0].AsCurrency then
                           begin
                               f:=#13#10+intTostr(RecNo)+'. '+FieldByName('PartNo').AsString+' '+FieldByName('Brand').AsString+' '+FieldByName('Price').AsString+'<'+dmFrm.FreeQuery1.Fields[0].AsString;
                               s:=s+f;
                               if FieldByName('Price').AsCurrency<dmFrm.FreeQuery1.Fields[0].AsCurrency*0.8 then
                                 ss:=ss+f;
                           end;
                         next;
                   end
                   else
                   delete ;
             end;
             First;
             EnableControls;
       end;
       if (s<>'') then
       begin
           f:=#13#10'请注意!  以下货品的售价比进价还要低:'#13#10#13#10+s+#13#10#13#10;
           if ss<>'' then
           begin
               f:=f+'其中部份货品的售价比进价的80%还要低,详见如下:'#13#10+ss+#13#10#13#10'系统不允许保存!';
               MessageDlg(f,mtWarning,[mbOk],0);
               Abort;
           end
           else begin
               f:=f+'确定继续保存吗?';
               if (MessageDlg(f,mtWarning,[mbOk,mbCancel],0)<>mrOk) then
                 Abort;
           end;
       end;
       //结束售价检测
       if strToint(fBillDict.Id)=19 then
         with mtDataSet1 do
         begin
             if (FieldByName('PayFund').AsFloat<0) or
               (FieldByName('OtherFund').AsFloat<0) then
             begin
                  MessageDlg(#13#10'[本单收款]及[其它收款]不能小于零,保存失败!',mtInformation,[mbOk],0);
                  DbGrid1.SetFocus;
                  Abort;
             end;
         end;
   end;


   fbilldict.BillCode:=trim(mtDataSet1.FieldByName(fbilldict.mkeyfld).asString);
   //   if fbilldict.BillCode='' then fbilldict.BillCode:=dmFrm.GetMyId(fbilldict.mttblid);
   if fbilldict.BillCode='' then fbilldict.BillCode:=dmFrm.GetMyIdWithOutTran(fbilldict.mttblid);

  if  fbilldict.BillCode<>'' then
   begin
         if  not        dlDataSet1.IsEmpty then
         begin
             FhlKnl1.Ds_AssignValues(mtDataSet1,varArrayof([fbilldict.mkeyfld]),varArrayof([fbilldict.BillCode]),False,False);
             FhlKnl1.Ds_UpdateAllRecs(dlDataSet1,varArrayof([fbilldict.fkeyfld]),varArrayof([fbilldict.BillCode]));

                      try
                          dmfrm.ADOConnection1.BeginTrans    ;
                          mtDataSet1.UpdateBatch;
                          dlDataSet1.UpdateBatch;

                          if not   self.AftSaveBillExecute  then
                          begin
                              dmfrm.ADOConnection1.RollbackTrans ;
                               abort;
                          end;
                      except
                              on err:exception do
                              begin
                                  dmfrm.ADOConnection1.RollbackTrans ;
                                   showmessage('保存失败！'+err.Message  );
                                  exit;
                              end;
                      end;
                     dmfrm.ADOConnection1.CommitTrans ;
                     EditPostAfter(True);
                     OpenBill(fbilldict.BillCode);

       end
       else
       MessageBox(0, '请先加明细', '', MB_OK + MB_ICONQUESTION);
   end
   else
        showmessage('单号为空');
 finally
    Screen.Cursor:=crDefault;
    if assigned(fPickFrm) then
    fPickFrm.Hide;

 end;



end;

procedure TBillFrm.CheckAction1Execute(Sender: TObject);
var
  i:integer;
  s: widestring;
  frm:TTabGridFrm;
  Msg:string;
begin
  if chkbtn.Caption='审核' then
  begin
    if MessageDlg('确定要审核吗?',mtConfirmation,[mbYes, mbNo],0)=mrno  then exit;
    if fbilldict.Id='19' then
    begin
      i:=0;
      Screen.Cursor:=CrSqlWait;
      try
        FhlUser.CheckRight(fbilldict.CheckRitId);
        FhlUser.SetDataSet(dmFrm.FreeDataSet1,'657',varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]),True);
        if Not dmFrm.FreeDataSet1.IsEmpty then
        begin
          with dmFrm.FreeDataSet1 do
          begin
            while not eof do
            begin
                if FieldByName('myStok').AsFloat<FieldByName('Qty').AsFloat then
                    i:=i+1
                else begin
                    Edit;
                    FieldByName('SndQty').AsFloat:=FieldByName('Qty').AsFloat;
                    Post;
                end;
                next;
            end;
            First;
          end;
          if Not ((i=0) and (MessageDlg(#13#10'提示: 本单所有的产品库存均足够,是否根据发货单一次出库?',mtInformation,[mbYes,mbNo],0)=mrYes)) then
          begin
            frm:=TTabGridFrm.Create(Application);
            with frm do
            begin
                Label1.Caption:='提示: 至少有 '+intTostr(i)+' 种商品的库存不够发货,请输入本次发货量:';
                DataSource1.DataSet:=dmFrm.FreeDataSet1;
                FhlUser.SetDbGrid('480',DbGrid1);
                hide;
                if ShowModal<>mrOk then
                begin
                   Free;
                   Abort;
                end;
            end;
            frm.Tag:=0;
            while frm.Tag=0 do
            begin
                s:='';
                with dmFrm.FreeDataSet1 do
                begin
                    First;
                    while not eof do
                    begin
                        if FieldByName('SndQty').AsString='' then
                          s:='提示:本次发货数量不能为空,如果本次没有发货则必须在相应栏填入0.'
                        else if FieldByName('SndQty').AsFloat<0 then
                          s:='提示:本次发货数量不能小于0,请按 确定 重新录入'
                        else if (FieldByName('SndQty').AsFloat>FieldByName('myStok').AsFloat) then
                          s:='提示:本次发货数量不能大于库存数量.'
                        else if (FieldByName('SndQty').AsFloat>FieldByName('Qty').AsFloat) then
                          s:='提示:本次发货数量不能大于本单总的发货数量.';
                        if s<>'' then break;
                        next;
                     end;
                 end;
                  if s<>'' then
                  begin
                      MessageDlg(#13#10+s,mtWarning,[mbOk],0);
                      if frm.ShowModal<>mrOk then
                      begin
                       FreeAndNil(frm);
                       Abort;
                      end;
                  end
                  else
                      frm.Tag:=1;
            end;
            freeandnil(frm);
          end;
          //
        dmFrm.FreeDataSet1.UpdateBatch();
        if not  dmFrm.ExecStoredProc('sl_invoice_out',varArrayof([LoginInfo.WhId,fbilldict.billcode,LoginInfo.EmpId])) then
        begin
              if dmFrm.FreeStoredProc1.Parameters.Items[1].Direction  =pdOutput then
              begin
              Msg:=dmFrm.FreeStoredProc1.Parameters.Items[1].Value;
              MessageDlg(#13#10+Msg,mtError,[mbOk],0);
              Abort;
              end;
        end;


       end;
      finally
          dmFrm.FreeDataSet1.Close;
          OpenBill(fbilldict.BillCode);
          Screen.Cursor:=crDefault;
      end;
    end
    else begin
        Screen.Cursor:=CrSqlWait;
        try
          FhlUser.CheckRight(fbilldict.CheckRitId);
          dmFrm.ExecStoredProc(fbilldict.chkproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
          OpenBill(fbilldict.BillCode);
        finally
         Screen.Cursor:=crDefault;
         end;
    end;
  end
  else begin
     if MessageDlg('确定要弃审吗?',mtConfirmation,[mbYes, mbNo],0)=mrno  then exit;
    Screen.Cursor:=CrSqlWait;
    try
      FhlUser.CheckRight(fbilldict.UnChkRitId);
      dmFrm.ExecStoredProc(fbilldict.unchkproc,varArrayof([fbilldict.billcode,LoginInfo.EmpId,LoginInfo.LoginId]));
      OpenBill(fbilldict.BillCode);
    finally
     Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TBillFrm.LinkAction1Execute(Sender: TObject);
  var i:integer;
begin
 BillOpenDlgFrm:=TBillOpenDlgFrm.Create(Application);
 try
   if BillOpenDlgFrm.InitRefers(fbilldict.Id) then
   begin
     if BillOpenDlgFrm.ShowModal=mrOk then
     begin
       i:=BillOpenDlgFrm.FileTypeComboBox.ItemIndex;
       if fBillPickFrm=nil then
       begin
         fBillPickFrm:=TPickFrm.Create(Application);
         fBillPickFrm.ComboBox1.Visible:=false;
       end;
       fBillPickFrm.InitFrm(BillOpenDlgFrm.RefersDict.PickIds[i],dbGrid1,mtDataSet1);
       fBillPickFrm.OpenDataSet(varArrayof([BillOpenDlgFrm.FileNameComboBox.Text,LoginInfo.WhId]));
       if fBillPickFrm.AdoDataSet1.IsEmpty then
       begin
         fBillPickFrm.Close;
         MessageDlg(#13#10+'该单据没有可被引用的数据',mtInformation,[mbOk],0);
       end else
       begin
         FhlKnl1.Ds_CopyValues(BillOpenDlgFrm.AdoDataSet1,self.mtDataSet1,BillOpenDlgFrm.RefersDict.FMastFlds[i],BillOpenDlgFrm.RefersDict.TMastFlds[i],False,False);
         fBillPickFrm.Show;
       end;
     end;
   end;
 finally
   BillOpenDlgFrm.Free;
 end;
end;

procedure TBillFrm.ImportAction1Execute(Sender: TObject);
begin

if fbilldict.pickid<>'' then
begin
    if fPickFrm=nil then
    begin
          Screen.Cursor:=crSqlwait;
          try
            fPickFrm:=TPickFrm.Create(Application);
            fpickFrm.BillCodeField:=fbilldict.mkeyfld;
            fPickFrm.InitFrm(fbilldict.pickid,dbGrid1,mtDataSet1);
           
          finally
            Screen.Cursor:=crDefault;
          end;
    end;                                    
//fPickFrm.Top :=ScrollBox2.Top ;//+self.Top -self.ToolBar1.Height ;
fPickFrm.Show;
end;


if fbilldict.PickIDMulPage <>'' then
begin
    if FrmPickUniversal=nil then
    begin
        Screen.Cursor:=crSqlwait;
        try
          FrmPickUniversal:= TFrmPickUniversal.Create (self);
          FrmPickUniversal.InitFrm(fbilldict.PickIDMulPage,dbGrid1,mtDataSet1);
        finally
          Screen.Cursor:=crDefault;
        end;
    end;
    FrmPickUniversal.Show;
    //FrmPickUniversal.Dock(ScrollBox2,FrmPickUniversal.ClientRect );
end;



//  fPickFrm.BorderStyle :=bsSizeable;
{
//----
  else begin
     with dmFrm.OpenDialog1 do begin
      Filter:='FHL数据文件(*.fhl)|*.fhl';
      if Execute then
         dmFrm.FreeQuery1.LoadFromFile(FileName)
      else
         Exit;
     end;
     with dmFrm.FreeQuery1 do begin
          while not eof do begin
           FhlDataSetor.CopyValues(dmFrm.FreeQuery1,dlDataSet1,'wareid,xsize,color,qty,xfund','wareid,xsize,color,qty,fund');
           next;
          end;
          Close;
     end;
  end;
{ with TFontDialog.Create(self) do begin
      Font.Assign(TitleLabel.Font);
      if ExeCute then begin
         TitleLabel.Font.Assign(Font);
         with BillDict do begin
              Edit;
              FieldByName('TitleFontName').asString:=Font.Name;
              FieldByName('TitleFontColor').asString:=ColorToString(Font.Color);
              FieldByName('TitleFontSize').asInteger:=Font.Size;
              Post;
         end;
      end;
      Free;
 end; }

end;

procedure TBillFrm.AppendAction1Execute(Sender: TObject);
begin
if    not (dlDataSet1.LockType = ltReadOnly) then
 dlDataSet1.Append;
end;

procedure TBillFrm.DeleteAction1Execute(Sender: TObject);
begin
if    not (dlDataSet1.LockType = ltReadOnly) then
begin
         if    not dlDataSet1.IsEmpty then
         begin
             dlDataSet1.Delete;
             EditPostAfter(false);
         end;
         dlDataSet1AfterPost(self.dlDataSet1); 

end;

end;

procedure TBillFrm.RefreshAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_RefreshLkpFld(mtDataSet1);
  FhlKnl1.Ds_RefreshLkpFld(dlDataSet1);
  OpenBill(fbilldict.BillCode);
end;

procedure TBillFrm.CloseAction1Execute(Sender: TObject);
begin
 Close;
end;

procedure TBillFrm.MailAction1Execute(Sender: TObject);
var
  t:TStringList;
  s,ss:string;
  i:integer;
begin
  t:=TStringList.Create;
  with Self.dlDataSet1 do
  begin
    if Active then
    begin
      DisableControls;
      First;
      While not eof do
      begin
        t.Append(' ');
        with Self.DBGrid1 do
          for i:=0 to Columns.Count-1 do
            if Columns[i].Visible then
              with t do
              begin
                if t.Count>1 then
                  s:=Columns[i].Field.AsString
                else
                  s:=Columns[i].Title.Caption;
                ss:=FhlKnl1.St_Repeat(' ',Round(Columns[i].Width/8)-Length(s));
                if Columns[i].Alignment=taLeftJustify then
                  s:=s+ss
                else
                  s:=ss+s;
                Strings[Count-1]:=Strings[Count-1]+s;
            end;
        Next;
      end;
      First;
      EnableControls;
    end;
  end;

  with TMailerFrm.Create(Application) do
  begin
    EdtSubject1.Text:=fBillDict.BillCnName;
    BodyMemo1.Lines.Assign(t);
    Show;
//    ShowModal;
//    Free;
  end;
  FreeAndNil(t);
end;

procedure TBillFrm.FaxAction1Execute(Sender: TObject);
begin
showmessage('传真功能暂未开发!');
end;

procedure TBillFrm.DownAction1Execute(Sender: TObject);
begin
  with TDownerFrm.Create(Application) do
  begin
    with HintLabel1 do Caption:=format(Caption,[fBillDict.BillCode,fBillDict.BillCnName]);
    fmtDataSet1:=Self.mtDataSet1;
    fdlDataSet1:=Self.dlDataSet1;
    ShowModal;
    Free;
  end;
end;

procedure TBillFrm.FormCreate(Sender: TObject);
begin
  DownAction1.Visible:=Not LoginInfo.IsLocalServer;
  
end;

procedure TBillFrm.ScrollBox1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
 try
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.ModelType :=ModelFrmBill;

    CrtCom.TopOrBtm :=true;
    CrtCom.Show;
  end;


    
finally

end;

end;

procedure TBillFrm.DBGrid1DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.dlDataSet1  ;
    CrtCom.DLGrid  :=self.DBGrid1 ;
    CrtCom.ModelType :=ModelFrmBill;
    try
    CrtCom.Show;
    finally

    end;
  end;



end;

procedure TBillFrm.ScrollBox2DblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;
    CrtCom.fbilldict:=  fbilldict;
    CrtCom.mtDataSet1:= self.mtDataSet1 ;
    CrtCom.ModelType :=ModelFrmBill;

    CrtCom.TopOrBtm :=false;
    try
    CrtCom.Show;
    finally

    end;
  end;



end;

procedure TBillFrm.dlDataSet1AfterPost(DataSet: TDataSet);
begin

    FhlKnl1.Ds_AssignValues(mtDataSet1,fBillDict.mtSumFlds,FhlKnl1.Ds_SumFlds(DataSet,fBillDict.dlSumFlds),false,false);

    if self.mtDataSet1.FindField('IsTax')<>nil then
      if self.mtDataSet1.Fieldbyname('IsTax').AsBoolean  then
         dmfrm.actCalcExecute(self.mtDataSet1 );

end;

procedure TBillFrm.ActFormalInvoiceExecute(Sender: TObject);
var    fFrmId,fcode,PreCode:string;
var sql:string;
var CpySourceFlds,CpyDestFlds:string;
var FormalInvoice:TBillFrm;
begin

    if  self.mtDataSet1.IsEmpty then
    begin
       showmessage('请先选择单据');
       exit;
    end;
    if chkBtn.Caption ='审核' then
    begin
       showmessage('请先审核单据');
       exit;
    end;

  //  0301052101
    FhlUser.CheckRight('0301052101')   ;//正式开票权限

    Screen.Cursor:=crAppStart;
    fFrmId:='54';
    PreCode:=self.mtDataSet1.FieldByName(self.fbilldict.mkeyfld ).AsString ;

     try
      if FhlKnl1.Vl_FindChildFrm('BillFrm'+fFrmId)=nil then   // if find then form then show the form
      begin
        FormalInvoice:=TBillFrm.Create(self);
        with FormalInvoice do
        begin
          FormalInvoice.dlDataSet1.AutoCalcFields :=false;
          formstyle:=fsnormal;
          hide;
          windowState:=wsNormal;
          position:=poMainFormCenter;
          Label2.Visible :=false;
          linkBtn.Visible :=false;
          importBtn.Visible := false;
          NewBtn.Visible :=false;
          ScrollBox1.Color :=   clwhite;
          ScrollBox2.Color :=   clwhite;

          InitFrm(fFrmId);
          Name:='BillFrm'+fFrmId;

          sql:='select * from TFormalInvoiceM   where PreInvoiceCode='+quotedstr(PreCode);
          dmfrm.GetQuery1(sql);

          if not  dmfrm.FreeQuery1.IsEmpty then
          begin
              fcode:= dmfrm.FreeQuery1.fieldbyname('code').AsString ;
              if fCode<>'' then
              begin
                  OpenBill(fCode);
                  sql:=' select b.clientID,B.ClientName,B.clientName,B.Amt,B.InvFund,B.code,  '
                      +' A.taxid,A.Bank,A.bankid,A.addr,A.tel   '
                      +' from crm_client  A    '
                      +' join TInvoicemsg B on A.Code=B.ClientID and B.code='+quotedstr(self.mtDataSet1.fieldbyname('code').AsString  )     ;

                  dmfrm.GetQuery1(sql);
                //  CpySourceFlds:='clientID,ClientName,clientName,InvFund,code,  taxid,Bank,bankid,addr,tel';
                //  CpyDestFlds:=  'clientID,ClientName,InvName,PreInvFund,PreInvoiceCode,  taxid,Bank,bankid,addr,tel';
                //  FhlKnl1.Ds_CopyValues(dmfrm.FreeQuery1 ,  mtDataSet1, CpySourceFlds,CpyDestFlds,false,false);
              end;
          end
          else
          begin
              OpenBill('fangheling');

            //  B.InvFund,
              sql:=' select b.clientID,B.ClientName,B.clientName,B.Amt,B.code,B.InvFUnd,  '
                  +' A.taxid,A.Bank,A.bankid,A.addr,A.tel   '
                  +' from crm_client  A    '
                  +' join TInvoicemsg B on A.Code=B.ClientID and B.code='+quotedstr(self.mtDataSet1.fieldbyname('code').AsString  )     ;

              dmfrm.GetQuery1(sql);                           //InvFund ,  Amt  ,
              CpySourceFlds:='clientID,ClientName,clientName,InvFund,code,  taxid,Bank,bankid,addr,tel';
              CpyDestFlds:=  'clientID,ClientName,   InvName,PreInvFund,PreInvoiceCode,  taxid,Bank,bankid,addr,tel';

              FhlKnl1.Ds_CopyValues(dmfrm.FreeQuery1 ,  mtDataSet1, CpySourceFlds,CpyDestFlds,true,false);


              sql:='select frompk ,code,itemtablename,itemtablebillcode,dlid,wareid,partno, qty, price,qty* price as Fund,warefund,taxamt,TaxRate,note '
                  +'From TInvoicemsgDL where  code='+quotedstr(self.mtDataSet1.fieldbyname('code').AsString  )     ;
              //dmfrm.GetQuery1(sql);
              dmfrm.GetDataSet1(sql);
                                                                                                    //
              CpySourceFlds:='partno,frompk   ,code,itemtablename,itemtablebillcode,dlid,wareid,partno, qty,price,fund,warefund,taxamt,TaxRate,note ';
              CpyDestFlds:=  'warename,frompk ,code,itemtablename,itemtablebillcode,dlid,wareid,partno,qty, price,fund,warefund,taxamt,TaxRate,note';
              FhlKnl1.Ds_CopyValues(true,  dmfrm.FreeDataSet1  ,  dlDataSet1, CpySourceFlds,CpyDestFlds,true,true) //多选
          end;
          showmodal;
        end;
      end;
     finally
      FormalInvoice.Free ;
      Screen.Cursor:=crDefault;
     end;


end;

procedure TBillFrm.iniuserBtns;
var sql,Actions:string;
var I:integer;
begin
    if desktopfrm.dsMainMenu.findField('subSysDBName')=nil then exit;
    sql:='select * from T820 where f01='+self.fbilldict.Id ;
    fhlknl1.Kl_GetQuery2(sql);

    if  not   fhlknl1.FreeQuery.IsEmpty then
    begin
          for i:=0 to fhlknl1.FreeQuery.RecordCount -1 do
          begin
              if fhlknl1.FreeQuery.RecordCount -1 =i then
                  Actions:=fhlknl1.FreeQuery.fieldbyname('F02').AsString
              else
                  Actions:=fhlknl1.FreeQuery.fieldbyname('F02').AsString +',' ;
          end;

          FhlKnl1.Tb_CreateActionBtns(ToolBar1,ActionList1,Actions,false);
    end;

end;

function TBillFrm.IsValideBill: boolean;
begin
                   with dlDataSet1 do
                   begin
                         DisableControls;
                         //Qty
                         First;
                         while not Eof do
                         begin
                               if FieldByName(fbilldict.QtyFld).asFloat<=0 then
                               begin
                                    MessageDlg(#13#10'明细中[数量]的值必须大于零,保存中止!  ',mtInformation,[mbOk],0);
                                    EnableControls;
                                    DbGrid1.SetFocus;
                                    Result:=false;
                                    exit;
                               end;
                               Next;
                         end;
                         //Price
                         First;
                         if FindField('Price')<>nil then
                         while not Eof do
                         begin
                             if FieldByName('Price').asFloat<=0  then
                             begin
                                  MessageDlg(#13#10'明细中[单价]的值必须大于零,保存中止!  ',mtInformation,[mbOk],0);
                                      
                                  EnableControls;
                                  DbGrid1.SetFocus;
                                  Result:=false;
                                  exit;
                             end;
                             Next;
                         end;
                        EnableControls;
                        Result:=true;
                  end;
end;

procedure TBillFrm.ActInvAdjfnshldinExecute(Sender: TObject);
begin
  FhlUser.ShowEditorFrm('39',null).ShowModal;

end;

procedure TBillFrm.ActInvAdjfnshldoutExecute(Sender: TObject);
begin
FhlUser.ShowEditorFrm('40',null).ShowModal;

end;

procedure TBillFrm.ActFnShldInExecute(Sender: TObject);
begin
FhlUser.ShowEditorFrm('23',null).ShowModal;

end;

procedure TBillFrm.ActFnShldOutExecute(Sender: TObject);
begin
FhlUser.ShowEditorFrm('24',null).ShowModal;
end;

function TBillFrm.AftSaveBillExecute: boolean;
 var TrAfterSave:      TTrAfterSave;
begin
    result:=true;

    if  FhlKnl1.Cf_GetDict_afterSave(fbilldict.Id , TrAfterSave) then
    begin
          if Not dmFrm.ExecStoredProc(TrAfterSave.ProcName,FhlKnl1.Vr_MergeVarArray(FhlUser.GetSysParamsVal(TrAfterSave.sysPrama   ),FhlKnl1.Ds_GetFieldsValue(self.dlDataSet1 ,TrAfterSave.UserPrama))) then
          begin
              result:=false;
              MessageDlg(#13#10+TrAfterSave.ErrHint ,mtError,[mbOk],0);
              abort;
         end;

    end;
end;

procedure TBillFrm.ActLockExecute(Sender: TObject);
begin
    if   mtDataSet1.State in [dsinsert,dsedit] then
    begin
        exit;
    end;

    if self.mtDataSet1.IsEmpty then
    begin
        showmessage('请先打开单据2!');
        exit;
    end;
    if self.mtDataSet1.FindField('islock')<>nil then
    begin
        if not mtDataSet1.FieldByName('islock').AsBoolean  then
         FhlUser.CheckRight(fbilldict.lockRgt )
        else
         FhlUser.CheckRight(fbilldict.unlockRgt);

        fhlknl1.Kl_GetUserQuery( 'exec   '+  fbilldict.lockProc +'   '+quotedstr(self.fbilldict.BillCode)    ,false);

        self.mtDataSet1.Close ;
        self.mtDataSet1.Open ;
        SetLock  (mtDataSet1.FieldByName('islock').AsBoolean);
    end;
end;
procedure TBillFrm.SetLock(lock:boolean);
begin
      self.ScrollBox1.Enabled :=not lock;
      self.ScrollBox2.Enabled :=not lock;
      self.DBGrid1.ReadOnly  :=  lock;
end;

procedure TBillFrm.ActPrint2Execute(Sender: TObject);
var
  bk:TBookmark;
begin
  FhlUser.CheckRight(fbilldict.PrintRitId);
  Screen.Cursor:=crSqlWait;
  bk:=dlDataSet1.GetBookmark;
  dlDataSet1.DisableControls; 
  try
     //hide field
    RepBillFrm:=TRepBillFrm.Create(Application);
    SetIsPrinted;
    HidePriceAmtFields(true);
    RepBillFrm.SetBillRep(fbilldict.TopBoxId,'145',mtDataSet1,DbGrid1);
    RepBillFrm.PreviewModal;//Preview;

    HidePriceAmtFields(false);
  finally
    FreeAndNil(RepBillFrm);
    dlDataSet1.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  dlDataSet1.GotoBookmark(bk);
   
end;

procedure TBillFrm.HidePriceAmtFields(  hide:boolean);
var i:integer;
begin
  for i:=0  to   DBGrid1.Columns.Count-1 do
  begin
       if  ( (dbgrid1.Columns[i].FieldName ='Price' ) or ( dbgrid1.Columns[i].FieldName ='Fund') ) then
       begin
          dbgrid1.Columns[i].Visible := not hide;
       end
  end;
end;

procedure TBillFrm.SetIsPrinted;
var msg:string;
begin
    if  mtDataSet1.Active  and ( mtDataSet1.FindField('isprinted')<>nil ) then
    begin
       if   mtdataset1.FindField('isprinted' )<>nil then
       begin
            if (mtdataset1.FieldByName('isprinted').Value <> null) and  (MessageDlg('该单据已经打印，确定需要再次打印？',mtConfirmation,[mbYes,mbNo],0)=mrNo)   then
              abort;
              
            if not  dmFrm.ExecStoredProc('Pr_sl_invoice_Print',varArrayof([LoginInfo.WhId, fbilldict.BillCode,LoginInfo.EmpId])) then
            begin
                  if dmFrm.FreeStoredProc1.Parameters.Items[1].Direction  =pdOutput then
                  begin
                    Msg:=dmFrm.FreeStoredProc1.Parameters.Items[1].Value;
                    MessageDlg(#13#10+Msg,mtError,[mbOk],0);
                    Abort;
                  end;
            end;
            // fhlknl1.Kl_GetUserQuery('update   sl_invoice set isprinted= 1 where code ='+quotedstr(self.fBillex.BillCode), false);
       end;
    end;
end;

end.




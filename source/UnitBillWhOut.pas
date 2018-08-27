unit UnitBillWhOut;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, Db, Grids, DBGrids, StdCtrls, ImgList, ExtCtrls,ComCtrls, ToolWin,
  variants,BillOpenDlg,pick, ActnList, Menus,FhlKnl,UnitCreateComponent,PickWindowUniveral,
  DBCtrls,UnitModelFrm;

type
  TFrmBillWhOut = class(TFrmModel)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    ScrollBox1: TScrollBox;
    Label2: TLabel;
    Label3: TLabel;
    TitleLabel: TLabel;
    Image1: TImage;
    Image2: TImage;
    ScrollBox2: TScrollBox;
    DBGrid1: TDBGrid;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    DownBtn: TToolButton;
    MailBtn: TToolButton;
    FaxBtn: TToolButton;
    PrintBtn: TToolButton;
    ToolButton3: TToolButton;
    OpenBtn: TToolButton;
    NewBtn: TToolButton;
    RemoveBtn: TToolButton;
    ToolButton4: TToolButton;
    CelBtn: TToolButton;
    ToolButton2: TToolButton;
    SavBtn: TToolButton;
    BtnLock: TToolButton;
    chkBtn: TToolButton;
    Refreshbtn: TToolButton;
    ToolButton1: TToolButton;
    linkBtn: TToolButton;
    importBtn: TToolButton;
    AddBtn: TToolButton;
    DelBtn: TToolButton;
    ToolButton5: TToolButton;
    ExtBtn: TToolButton;
    btn2: TToolButton;
    HelpBtn: TToolButton;
    mtDataSource1: TDataSource;
    DlDataSource1: TDataSource;
    dlDataSet1: TADODataSet;
    mtDataSet1: TADODataSet;
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
    FaxAction1: TAction;
    actAftSaveBill: TAction;
    ActFormalInvoice: TAction;
    ActInvAdjfnshldin: TAction;
    ActInvAdjfnshldout: TAction;
    ActFnShldIn: TAction;
    ActFnShldOut: TAction;
    ActIsLock: TAction;
    MainMenu1: TMainMenu;
    procedure MailAction1Execute(Sender: TObject);
    procedure PrintAction1Execute(Sender: TObject);
    procedure   OpenAction1Execute(Sender: TObject);
    procedure  iniuserBtns;
    procedure  InitFrm(FrmId:String);
    procedure  SetBtmBoxHeight(Sender: TObject);
    procedure   OpenBill(fCode:String);
    procedure  CloseBill;
    procedure  OpenCloseAfter(IsOpened:Boolean);
    procedure  SetRitBtn;
    procedure  SetBillStyle(fReadOnly:Boolean);
    procedure  SetCtrlStyle(fEnabled:Boolean);
    procedure  SetCheckStyle(IsChecked:Boolean);
    function  IsValideBill: boolean;
    procedure  EditPostAfter(IsEnabled:Boolean);
    procedure  CancelAction1Execute(Sender: TObject);
    procedure NewAction1Execute(Sender: TObject);
    procedure RemoveAction1Execute(Sender: TObject);

    procedure SaveAction1Execute(Sender: TObject);
    procedure CheckAction1Execute(Sender: TObject);
    procedure ImportAction1Execute(Sender: TObject);
    procedure AppendAction1Execute(Sender: TObject);
    procedure ActIsLockExecute(Sender: TObject);
    procedure SetLock(lock:boolean);
    procedure ScrollBox1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mtDataSource1StateChange(Sender: TObject);
    procedure DlDataSource1StateChange(Sender: TObject);
    procedure RefreshAction1Execute(Sender: TObject);
    procedure DeleteAction1Execute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dlDataSet1CalcFields(DataSet: TDataSet);
    procedure dlDataSet1AfterPost(DataSet: TDataSet);
  private
    { Private declarations }
      FormId:integer;
       fBtmBoxMaxHeight,fBtmBoxMinHeight:Integer;
    fDbGridColsColor:Variant;
    fbilldict:TBillDict;
    fBillOpenDlgFrm:TBillOpenDlgFrm;
    fPickFrm,fBillPickFrm:TPickFrm;
    FrmPickUniversal: TFrmPickUniversal;    //2006-8

  public
    { Public declarations }
  end;

 const
  cBillManId='BillManId';
  cIsChk='IsChk';
  cChkTime='ChkTime';

var
  FrmBillWhOut: TFrmBillWhOut;

implementation
       uses editor,RepBill,datamodule,TabGrid,Mailer,Downer, desktop;
{$R *.dfm}

procedure TFrmBillWhOut.InitFrm(FrmId:String);
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

  //
  fDbGridColsColor:=VarArrayCreate([0,DbGrid1.Columns.Count-1],varVariant);
  for i:=0 to dbGrid1.Columns.Count-1 do
     fDbGridColsColor[i]:=DbGrid1.Columns[i].Color;
  //
  OpenCloseAfter(false);
  fBtmBoxMaxHeight:=210;
  fBtmBoxMinHeight:=ScrollBox2.Height;
  self.OnActivate:=SetBtmBoxHeight;
  self.OnDeactivate:=SetBtmBoxHeight;
//  FhlInitor.SetMainMenu('2',MainMenu1,ToolBar1,ActionList1);

  iniuserBtns;

end;
procedure TFrmBillWhOut.iniuserBtns;
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

procedure TFrmBillWhOut.SetBtmBoxHeight(Sender: TObject);
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

procedure TFrmBillWhOut.MailAction1Execute(Sender: TObject);
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
procedure TFrmBillWhOut.PrintAction1Execute(Sender: TObject);
var
  bk:TBookmark;
begin
  FhlUser.CheckRight(fbilldict.PrintRitId);
  Screen.Cursor:=crSqlWait;
  bk:=dlDataSet1.GetBookmark;
  dlDataSet1.DisableControls;

  //hide field
  RepBillFrm:=TRepBillFrm.Create(Application);
  try
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

procedure TFrmBillWhOut.SetRitBtn;
begin
    PrintAction1.Enabled:=true;
    MailAction1.Enabled:=true;
    FaxAction1.Enabled:=true;
    DownAction1.Enabled:=true;
    NewAction1.Enabled:=true;
    CopyAction1.Enabled:=true;
    RemoveAction1.Enabled:=true;
    CheckAction1.Enabled:=true;
    SetCheckStyle(mtDataSet1.FieldByName(cIsChk).AsBoolean);
end;
procedure TFrmBillWhOut.SetBillStyle(fReadOnly:Boolean);
begin
 //set btn.enabled to false
 LinkAction1.Enabled:=Not fReadOnly;
 ImportAction1.Enabled:=Not fReadOnly;
 AppendAction1.Enabled:=Not fReadOnly;
 DeleteAction1.Enabled:=Not fReadOnly;
 SetCtrlStyle(Not fReadOnly);
end;
procedure TFrmBillWhOut.SetCtrlStyle(fEnabled:Boolean);
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
procedure TFrmBillWhOut.SetCheckStyle(IsChecked:Boolean);
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
procedure TFrmBillWhOut.OpenCloseAfter(IsOpened:Boolean);
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
procedure TFrmBillWhOut.CloseBill;
begin
   mtDataSet1.Close;
   dlDataSet1.Close;
   OpenCloseAfter(false);
end;
procedure TFrmBillWhOut.OpenBill(fCode:String);
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

procedure TFrmBillWhOut.OpenAction1Execute(Sender: TObject);
begin

  FhlUser.CheckRight(fbilldict.ReadRitId);
  if fBillOpenDlgFrm=nil then
  begin
    Screen.Cursor:=crSqlwait;
    try
      fBillOpenDlgFrm:=TBillOpenDlgFrm.Create(Application);
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
  begin
     self.OpenBill(fBillOpenDlgFrm.FileNameComboBox.Text);
     SetLock  (mtDataSet1.FieldByName('islock').AsBoolean);
  end;
end;
procedure TFrmBillWhOut.AppendAction1Execute(Sender: TObject);
begin
if    not (dlDataSet1.LockType = ltReadOnly) then
 dlDataSet1.Append;

end;
procedure TFrmBillWhOut.NewAction1Execute(Sender: TObject);
begin
      if    not (mtDataSet1.LockType = ltReadOnly) then
      begin

        OpenBill('fangheling');
        mtDataSet1.Append;
        FhlKnl1.Vl_FocueACtrl(ScrollBox1);
      end;
end;

procedure TFrmBillWhOut.RemoveAction1Execute(Sender: TObject);
begin

if mtDataSet1.State in [dsinsert,dsedit] then
mtDataSet1.Cancel;

if    not (mtDataSet1.LockType = ltReadOnly) then
begin
  if MessageDlg(#13#10+'警告! 所有本单的数据将被删除且无法恢复,您确定吗?   ',mtWarning,mbOkCancel,0)=mrOk then
  begin
     Screen.Cursor:=CrSqlWait;
    try
      FhlUser.DoExecProc(mtDataSet1,null);
      CloseBill;

      
    finally
     Screen.Cursor:=crDefault;
    end;
  end;
end;
end;

procedure TFrmBillWhOut.CancelAction1Execute(Sender: TObject);
begin
 if MessageDlg(fsDbCancel,mtConfirmation,[mbYes,mbNo],0)=mrYes then begin
    if fbilldict.BillCode='fangheling' then
       CloseBill
    else
       OpenBill(fbilldict.BillCode);

    if assigned(FrmPickUniversal) then FrmPickUniversal.Close ;
 end;
end;
function TFrmBillWhOut.IsValideBill: boolean;
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
procedure TFrmBillWhOut.EditPostAfter(IsEnabled:Boolean);
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
     DownAction1.Enabled:=IsEnabled;
     MailAction1.Enabled:=IsEnabled;
     FaxAction1.Enabled:=IsEnabled;
     SaveAction1.Enabled:=Not IsEnabled;
     CancelAction1.Enabled:=Not IsEnabled;
end;
procedure TFrmBillWhOut.SaveAction1Execute(Sender: TObject);
var
  //istmp:Boolean;
  s,ss,f:widestring;
var i:integer;
var DlgMsg:string;

begin
  Screen.Cursor:=CrSqlWait;
  try

       FhlUser.CheckRight(fbilldict.WriteRitId);
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
                if   dmFrm.FreeQuery1.FieldByName('Isbill').AsBoolean then
                if not IsValideBill then begin
                    Screen.Cursor:=crDefault;
                    exit;
                end;
            end;
              {if   dmFrm.FreeQuery1.FieldByName('Isbill').AsBoolean then
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
                                  Abort;
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
                                Abort;
                           end;
                           Next;
                       end;
                      EnableControls;
                  end;

              end;}
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
                            //  dmfrm.ADOConnection1.BeginTrans    ;
                            mtDataSet1.UpdateBatch;
                            dlDataSet1.UpdateBatch;
                            if (fPickFrm<>nil) and (fPickFrm.ADODataSet2.Active) then
                               fPickFrm.AdoDataSet2.UpdateBatch;

                            self.actAftSaveBill.Execute ;
                            //   dmfrm.ADOConnection1.CommitTrans ;
                      except
                              on err:exception do
                              begin
                                // dmfrm.ADOConnection1.RollbackTrans ;
                                  //showmessage(err.Message );
                                  exit;
                              end;
                      end;
              
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

procedure TFrmBillWhOut.CheckAction1Execute(Sender: TObject);
var
  i:integer;
  s: widestring;
  frm:TTabGridFrm;
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
        dmFrm.ExecStoredProc('sl_invoice_out',varArrayof([LoginInfo.WhId,fbilldict.billcode,LoginInfo.EmpId]));
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

procedure TFrmBillWhOut.ImportAction1Execute(Sender: TObject);
begin


if fbilldict.pickid<>'' then
begin
    if fPickFrm=nil then
    begin
          Screen.Cursor:=crSqlwait;
          try
            fPickFrm:=TPickFrm.Create(Application);
            fPickFrm.InitFrm(fbilldict.pickid,dbGrid1,mtDataSet1);

          finally
            Screen.Cursor:=crDefault;
          end;
    end;                                    
//fPickFrm.Top :=ScrollBox2.Top ;//+self.Top -self.ToolBar1.Height ;
fPickFrm.Show;
end;
end;
procedure TFrmBillWhOut.ActIsLockExecute(Sender: TObject);
begin
  inherited;
      if self.mtDataSet1.IsEmpty then
    begin
    showmessage('请先打开单据2!');
    exit;
    end;
    if self.mtDataSet1.FindField('islock')<>nil then
    begin

        if not mtDataSet1.FieldByName('islock').AsBoolean  then
         FhlUser.CheckRight('0301030306')
        else
         FhlUser.CheckRight('0301030307');

        fhlknl1.Kl_GetUserQuery( 'exec pr_LockBill '+quotedstr(self.fbilldict.BillCode) +','+quotedstr('1')  ,false);


        self.mtDataSet1.Close ;
        self.mtDataSet1.Open ;
        SetLock  (mtDataSet1.FieldByName('islock').AsBoolean);
    end;
end;
procedure TFrmBillWhOut.SetLock(lock:boolean);
begin
      self.ScrollBox1.Enabled :=not lock;
      self.ScrollBox2.Enabled :=not lock;
      self.DBGrid1.ReadOnly  :=  lock;
end;

procedure TFrmBillWhOut.ScrollBox1DblClick(Sender: TObject);
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

    CrtCom.TopOrBtm :=true;
     try
    CrtCom.Show;
    finally

    end;
  end;



end;

procedure TFrmBillWhOut.FormClose(Sender: TObject;
  var Action: TCloseAction);
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
  Action:=caFree;
end;

procedure TFrmBillWhOut.mtDataSource1StateChange(Sender: TObject);
begin
  if (MtDataSource1.State=dsEdit) or (MtDataSource1.State=dsInsert) then
     EditPostAfter(false);

end;

procedure TFrmBillWhOut.DlDataSource1StateChange(Sender: TObject);
begin
  if (DlDataSource1.State=dsEdit) or (DlDataSource1.State=dsInsert) then begin
     DbGrid1.Options:=DbGrid1.Options-[dgColumnResize];
     EditPostAfter(false);
  end
  else
     DbGrid1.Options:=DbGrid1.Options+[dgColumnResize];

end;

procedure TFrmBillWhOut.RefreshAction1Execute(Sender: TObject);
begin
  FhlKnl1.Ds_RefreshLkpFld(mtDataSet1);
  FhlKnl1.Ds_RefreshLkpFld(dlDataSet1);
  OpenBill(fbilldict.BillCode);

end;

procedure TFrmBillWhOut.DeleteAction1Execute(Sender: TObject);
begin
if    not (dlDataSet1.LockType = ltReadOnly) then
begin
         if    not dlDataSet1.IsEmpty then
         begin
             dlDataSet1.Delete;
             EditPostAfter(false);
         end;
end;

end;

procedure TFrmBillWhOut.FormKeyDown(Sender: TObject; var Key: Word;
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


procedure TFrmBillWhOut.dlDataSet1CalcFields(DataSet: TDataSet);
begin
   if dataset.FindField('MyIndex')<>nil then
      begin
            with DataSet do begin
                   FieldByName('MyIndex').asInteger:=Abs(RecNo);//Is fkCalculated
                   if FindField('Price')<>nil then
                      FieldByName('Fund').asCurrency:=FieldByName('Qty').asFloat*FieldByName('Price').asFloat;
            end;
      end;

end;

procedure TFrmBillWhOut.dlDataSet1AfterPost(DataSet: TDataSet);
begin

    FhlKnl1.Ds_AssignValues(mtDataSet1,fBillDict.mtSumFlds,FhlKnl1.Ds_SumFlds(DataSet,fBillDict.dlSumFlds),false,false);

    if self.mtDataSet1.FindField('IsTax')<>nil then
      if self.mtDataSet1.Fieldbyname('IsTax').AsBoolean  then
         dmfrm.actCalcExecute(self.mtDataSet1 );
end;

end.

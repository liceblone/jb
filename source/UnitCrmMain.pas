unit UnitCrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, Grids, DBGrids, Buttons, DB, ADODB,
  StdCtrls,FhlKnl, ActnList,UnitGrid,Editor, Menus,StrUtils,UnitAdoDataset,UnitModelFrm;

type TdbgridEx=class(Tdbgrid)
end;

type
  TFrmCrm = class(TfrmModel)
    splTreeLeft: TSplitter;
    pgcTree: TPageControl;
    actlstCRM: TActionList;
    ctrlbr1: TControlBar;
    tlb1: TToolBar;
    btnexit: TToolButton;
    btnReflash: TToolButton;
    btnTreeVisiable: TToolButton;
    tlbMain: TToolBar;
    actEditMain: TAction;
    btnQryScrollVisiable: TToolButton;
    btnSubVisiable: TToolButton;
    Filter: TAction;
    FavoriteM: TAction;
    FavoriteMgr: TAction;
    FavoriteContentMgr: TAction;
    PnlRight: TPanel;
    MtPnl: TPanel;
    MtScrollBox: TScrollBox;
    btnOpen: TSpeedButton;
    Label1: TLabel;
    pnlMainGrid: TPanel;
    pgcSubInterface: TPageControl;
    ScrollBoxDbCtrl: TScrollBox;
    pgcMainGrid: TPageControl;
    PnlItem: TPanel;
    BatchUpdate: TAction;
    Splitter1: TSplitter;
    Actsl_quote: TAction;
    ActFn_client_inout: TAction;
    procedure InitFrm(formid:string);
    procedure IniMain;
    procedure IniTree(Pdict:TCRMDict)  ;
    procedure IniSubInterface;
    procedure IniTreePgcPopupMenu;
    procedure IniSubInterfacePgcPopupMenu;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TreeClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);

    procedure MainDataSetAfterScroll(dataset:Tdataset);//maindataset AfterScroll
    procedure MtScrollBoxDblClick(Sender: TObject);
    procedure btnTreeVisiableClick(Sender: TObject);
    procedure btnexitClick(Sender: TObject);
    procedure actEditMainExecute(Sender: TObject);
    procedure btnReflashClick(Sender: TObject);
    procedure btnQryScrollVisiableClick(Sender: TObject);
    procedure btnSubVisiableClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actFilterExecute(Sender: TObject);
    procedure FilterExecute(Sender: TObject);
    procedure FavoriteMExecute(Sender: TObject);
    procedure FavoriteMgrExecute(Sender: TObject);
    procedure FavoriteContentMgrExecute(Sender: TObject);
    procedure BatchUpdateExecute(Sender: TObject);
    procedure pgcTreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure pgcTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure pgcSubInterfaceDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure pgcSubInterfaceDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure Actsl_quoteExecute(Sender: TObject);

  private

    { Private declarations }
  public
    { Public declarations }
    CurrentMainGridID:string;

    Mtdataset   :TAdoDataset;
    Mtdatasource:TdataSource;


    MainDBGrid:TModelDbGrid;
    MainGridPopupMenu:TPopupMenu;
    MainTreeGridEditorFrm:   TEditorFrm;
    MainDataSource:Tdatasource;
    Maindataset:TAdoDatasetColor;

    MainTreeGridDict:TTreeGridDict;
    fDict: TCRMDict;    //crmMainDict

    MainEditor:Tform;//����

  //  var  TabGrid:ModelTreeGridsheet;
//var TabEditor :ModelEditorsheet;
//   SubInterFaceTab: array of TModelAbstractSheet;
  end;

var
  FrmCrm: TFrmCrm;

implementation

{$R *.dfm}
uses datamodule,UnitCreateComponent,Upublic,TreeEditor,TreeDlg, TabEditor,UnitActionsGrid,TreeGrid,
  desktop;

procedure TFrmCrm.InitFrm(formid: string);
begin
//iniTree();
//iniMainGrid or MainEditor
//iniSubInterface
  
  if not   fhlknl1.Cf_GetDict_CrmModel (Formid,fDict)     then
   exit;

  self.Caption :=fDict.FormCaption ;
  if (fDict.MainActions  <>'' ) and (fDict.MainActions <>'-1' )  then           //initoolbar
  begin
       FhlKnl1.Tb_CreateActionBtns(tlbMain,actlstCRM,fDict.MainActions);
     //  FhlKnl1.Act_ConfigRight (actlstCRM,logininfo);                //config  right
  end;

  IniMain;
  IniTree (fDict)  ;
  IniSubInterface;
  IniTreePgcPopupMenu;
  IniSubInterfacePgcPopupMenu;
end;

procedure TFrmCrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TFrmCrm.FormCreate(Sender: TObject);
begin
if logininfo.LoginId ='chy' then
logininfo.sys:=true;

 //if treeids <>'' then   ini  Trees
//if mainGridid <>'' then  Create DbCtrl   and    ini dsParam   (ParamDatasetId)
//
end;

procedure TFrmCrm.TreeClick(Sender: TObject);
begin
//if currentGrid<>sender.tag then  Gridid=sender.tag
//ini MainGrid (currentGrid)  and open

end;

procedure TFrmCrm.btnOpenClick(Sender: TObject);
  var fParams:variant;
begin
//if currentGrid<>MainGridID  then  Gridid=MainGridID
//ini MainGrid (currentGrid)  and open


  with self.Mtdataset  do
  begin
      if (State=dsInsert) or (State=dsEdit) then  //update parameter getvalue
      begin
        UpdateRecord;
        Post;
      end;
  end;

  fParams:=FhlKnl1.Ds_GetFieldsValue(self.Mtdataset ,fDict.MtParameters );


  if self.MainDBGrid =nil then
  begin
      //  if Not VarIsNull(fParams) then    //���������������С� FhlUser.SetDbGridAndDataSet (self.MainDBGrid,self.MainTreeGridDict.DbGridId ,fParams, true,dmfrm.DbGridEditBtnClickAction1 );
     //   begin
       //       FhlUser.SetDbGridAndDataSet (self.MainDBGrid,self.MainTreeGridDict.DbGridId ,fParams, true,dmfrm.DbGridEditBtnClickAction1 );
      //  end;
  end
  else
      FhlUser.SetDataSet(self.Maindataset,inttostr(self.Maindataset.Tag ),fParams)    ;


end;

procedure TFrmCrm.IniTree(Pdict: TCRMDict);
var i:integer;
var TreeTab:array of TmodelTreeSheet;

var treeview:array of  ModelTreeView;


var treeNodeDataset :array of Tadodataset;
begin
      setlength(TreeTab,pdict.CrmTreeCount );
      setlength(treeview,pdict.CrmTreeCount );

      self.pgcTree.Tag := strtoint(Pdict.CrmTreeIDs);
      for i:=0 to     Pdict.CrmTreeCount- 1 do
      begin
          TreeTab[i]:=TmodelTreeSheet.Create(self);
          TreeTab[i].ToolID :='59';
          TreeTab[i].LoginInfo :=LoginInfo;
          TreeTab[i].PageControl:=self.pgcTree;
          TreeTab[i].Caption :=pdict.CrmTree[i].Name ;
          TreeTab[i].SetFhlknl(fhlknl1);
          TreeTab[i].SetTreeID(  inttostr( pdict.CrmTree[i].treeID ));

          TreeTab[i].SetEditorParent(self.MtScrollBox);

          TreeTab[i].SetFDBGrid(self.MainDBGrid );
          TreeTab[i].setTreeGridIdField('TreeGridID');
          TreeTab[i].setEditorIDField('EditorID');
          TreeTab[i].SetFSubInterFaceID(pdict.CrmTree[i].SubInterFaceID );
          TreeTab[i].SetFhlUser(FhlUser)    ;
          TreeTab[i].SetActionList(dmfrm.DataSetActionList1 ) ;
          TreeTab[i].SetUserConnection(dmfrm.ADOConnection1 );
          TreeTab[i].SetGridEditBtnClick(dmfrm.DbGridEditBtnClickAction1 );

          TreeTab[i].TreeView.Images  :=dmfrm.ImageList1 ;
          TreeTab[i].TreeView.IniTree ;
          if TreeTab[i].TreeView.tag=0 then
             TreeTab[i].Free ;

      end;
end;

procedure TFrmCrm.IniMain;
var MainEditTab:TTAbsheet;

var i,j,UserMenuCont:integer;
var GridMenuItem: array of TMenuItem;
var sql:string;

var ModelDbGridPopupMenu  :TPopupMenu;
begin

      UserMenuCont:=0;
 //ini Main tree grid    ini MainGridPopupMenu
 // ini main editor
 //  ini mt dataset    mtparams   ini mtctrl


          //MainTreeGridID id valid
      if (fdict.MainTreeGridID <>'' ) and (fdict.MainTreeGridID<>'-1') then
      begin
          MainDataSource:=Tdatasource.Create (self);
          Maindataset:=TadodatasetColor.Create (self);
          MainDataSource.DataSet := Maindataset;
          Maindataset.Connection :=dmfrm.ADOConnection1 ;        //ini maindataset

          self.MainDBGrid :=TModelDbGrid.Create(self);
          MainDBGrid.setfhlknl(fhlknl1); 
          MainDBGrid.OnDblClick:=self.actEditMain.OnExecute ;    //dbclick
          MainDBGrid.Color1 :=clwhite;
          MainDBGrid.Color2 :=clCream;
          MainDBGrid.SetLoginInfo(logininfo);
                                                              //ini GridMenu
          ModelDbGridPopupMenu  :=TPopupMenu.Create (self);
          fhluser.MergeGridUserMenuAndSysCongfigMenu(ModelDbGridPopupMenu,dmfrm.DbGridPopupMenu1,self.fDict.MainGridUserMenuIDs ,self.actlstCRM  );
          MainDBGrid.SetPopupMenu ( ModelDbGridPopupMenu);


          MainDBGrid.Parent :=self.pgcMainGrid ;
          MainDBGrid.Align :=alClient;

          MainDBGrid.DataSource := MainDataSource;
          fhlknl1.Kl_GetQuery2('select * from T612 where f01='+quotedstr(self.fDict.MainTreeGridID ));
          MainTreeGridDict.DbGridId :=fhlknl1.FreeQuery.fieldbyname('f04').AsString ;
          MainTreeGridDict.EditorId :=fhlknl1.FreeQuery.fieldbyname('f05').AsString ;
          FhlUser.SetDbGridAndDataSet (self.MainDBGrid,MainTreeGridDict.DbGridId,'chy', true );
      end;

         // Maindataset.AfterOpen   :=self.MainDataSetAfterScroll ;

      //editorid  id valid
       if (fdict.MainEditorID  <>-1 )  then
      begin
          MainEditTab:=TTAbsheet.Create (pgcMainGrid);
          MainEditTab.PageControl :=pgcMainGrid;
          pgcTree.Visible :=false;
           self.MainEditor := FhlUser.ShowEditorFrm(  inttostr(FDict.MainEditorID ) ,null,nil,MainEditTab)   ;
           MainDataSource:= TEditorFrm( MainEditor).DataSource1 ;
           TADODataSet (Maindataset)   := TEditorFrm( MainEditor).ADODataSet1 ;

           MainEditTab.Font.Size :=8;
           TEditorFrm( MainEditor).ExtBtn.Visible :=false;
           pgcMainGrid.Height :=MainEditor.Height ;
           self.btnTreeVisiable.Visible :=false;
           MainEditor.Align :=alClient;
           MainEditor.Dock (  MainEditTab,MainEditor.ClientRect );
           MainEditor.Show;

           FhlUser.SetDataSet(self.Maindataset,inttostr(self.Maindataset.Tag ),null)    ;


      end;
      Maindataset.AfterScroll :=self.MainDataSetAfterScroll ;       //link main and item

      if (fdict.MtDatasetID  <>'' ) and (fdict.MtDatasetID  <>'-1') then
      begin
          Mtdataset   :=TAdoDataset.Create (self);
          Mtdatasource:=TdataSource.Create (self);
          Mtdataset.Connection :=dmfrm.ADOConnection1 ;
          Mtdatasource.DataSet :=Mtdataset;
          FhlUser.SetDataSet(Mtdataset,fDict.MtDatasetID ,null);
          if (fdict.MtBoxID  <>'' ) and (fdict.MtBoxID <>'-1') then
          begin
                FhlKnl1.Cf_SetBox(fDict.MtBoxID,Mtdatasource,MtScrollBox,dmFrm.DbCtrlActionList1);
          end;
      end;



end;

procedure TFrmCrm.MtScrollBoxDblClick(Sender: TObject);
var CrtCom:TfrmCreateComponent    ;

begin
 // modeltpe:=Bill;

  if LoginInfo.Sys  then  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;


    CrtCom.mtDataSet1:= self.Mtdataset ;
    CrtCom.mtDataSetId :=inttostr(self.Mtdataset.tag);
    CrtCom.TopOrBtm :=true;
    CrtCom.TOPBoxId  :=self.fDict.MtBoxID ;
    if self.MainDBGrid <>nil then
    CrtCom.DlGridId :=inttostr(self.MainDBGrid .Tag );
    try
    CrtCom.Show;
    finally

    end;
   
  end;


end;
procedure TFrmCrm.btnTreeVisiableClick(Sender: TObject);
begin
 pgcTree.Visible :=btnTreeVisiable.Down ;
end;

procedure TFrmCrm.btnexitClick(Sender: TObject);
begin
  close;
end;

procedure TFrmCrm.actEditMainExecute(Sender: TObject);
begin

      if self.Maindataset.IsEmpty then
      begin
        //  showmessage('��ѡ���¼�ٱ༭');
        //  exit;
      end;
      if MainTreeGridEditorFrm=nil then
      begin
               if self.MainTreeGridDict.EditorId <>'' then
               MainTreeGridEditorFrm:=TEditorFrm(FhlUser.ShowEditorFrm(self.MainTreeGridDict.EditorId ,null,self.Maindataset ))
               else
               showmessage ('self.MainTreeGridDict.EditorId ');
       end   ;


        if self.fDict.IsTreeGridEditorDock then
        begin
            MainTreeGridEditorFrm.Align  :=altop;
            MainTreeGridEditorFrm.Dock (  ScrollBoxDbCtrl,MainTreeGridEditorFrm.ClientRect );
            MainTreeGridEditorFrm.Show;
        end
        else
        begin
           self.pgcSubInterface.Dock(MainTreeGridEditorFrm.PnlItem ,pgcSubInterface.ClientRect );
           MainTreeGridEditorFrm.BorderStyle :=    bsSizeable;
           MainTreeGridEditorFrm.Height :=MainTreeGridEditorFrm.fDict.Height  +200;
           MainTreeGridEditorFrm.PnlItem.Height  := 200 ;
           MainTreeGridEditorFrm.Splitter1.Enabled  :=true;
           MainTreeGridEditorFrm.ShowModal ;
           self.pgcSubInterface.Dock(self.PnlItem  ,pgcSubInterface.ClientRect );
        end;


end;

procedure TFrmCrm.btnReflashClick(Sender: TObject);
begin
self.Refresh ;
end;

procedure TFrmCrm.IniSubInterface;
var i:integer;
var   TreeGridDict:  TTreeGridDict;
var   EditorDict  :TEditorDict;

var SubInterFaceTab: array of TModelAbstractSheet ;

begin
// create tabs
//open dataset

      setlength(SubInterFaceTab,self.fDict.SubInterFaceCount )  ;
      self.pgcSubInterface.Tag  :=strtoint(self.fDict.SubinterFaceID );
      for i:=0 to self.fDict.SubInterFaceCount  -1 do
      begin
             case    self.fDict.SubInterFace [i].ModeltypeID of
               0:
               begin
                     if Not FhlKnl1.Cf_GetDict_TreeGrid(self.fDict.SubInterFace [i].TreeGridID ,TreeGridDict) then
                     begin
                      showmessage('SubInterFace treegrid'+inttostr(i)+'treeGridID ��Ч');
                      exit;
                     end
                     else
                     begin
                       SubInterFaceTab[i]:= ModelTreeGridsheet.Create(self.pgcSubInterface );
                       SubInterFaceTab[i].PageControl :=self.pgcSubInterface ;
                       SubInterFaceTab[i].setUserConnection(dmfrm.ADOConnection1 );
                       SubInterFaceTab[i].SetGridEditBtnClick(dmfrm.DbGridEditBtnClickAction1 );
                       SubInterFaceTab[i].SetFhlknl(fhlknl1);
                       SubInterFaceTab[i].SetFhlUser(Fhluser);
                       SubInterFaceTab[i].setActionLst(self.actlstCRM );
                       ModelTreeGridsheet(SubInterFaceTab[i]).SetDict(TreeGridDict);
                       SubInterFaceTab[i].SetLoginInfo(logininfo);
                       SubInterFaceTab[i].IniSheet ;
                       SubInterFaceTab[i].setFMainDataset(self.Maindataset );
                       SubInterFaceTab[i].SetPopupMenu (dmfrm.DbGridPopupMenu1 );

                       SubInterFaceTab[i].OpenDataSet ;

                     end;
               end;
               1:
               begin
                      if Not FhlKnl1.Cf_GetDict_Editor(self.fDict.SubInterFace [i].EditorID ,EditorDict)  then
                     begin
                      showmessage('SubInterFace Ediotr '+inttostr(i)+'EditorId ��Ч');
                      exit;
                     end
                     else
                     begin
                          SubInterFaceTab[i] :=ModelEditorsheet.Create (self.pgcSubInterface );
                          SubInterFaceTab[i].PageControl :=self.pgcSubInterface ;
                          SubInterFaceTab[i].SetFhlknl(fhlknl1);
                          SubInterFaceTab[i].SetFhlUser(fhluser);
                          SubInterFaceTab[i].SetFmainDataset(self.Maindataset );
                          ModelEditorsheet(SubInterFaceTab[i]).SetDict(EditorDict);
                          SubInterFaceTab[i].OpenDataSet ;
                     end;

               end;

             end;
      end;

end;


procedure TFrmCrm.MainDataSetAfterScroll(dataset:Tdataset);
var i:integer;
begin
//
    Label1.Caption  :='   '+intTostr(MainDataSet.RecNo)+'/'+intTostr(MainDataSet.RecordCount);
    for i:=0 to self.pgcSubInterface.PageCount -1 do
    begin
         TModelAbstractSheet(pgcSubInterface.Pages [i]).OpenDataSet ;
    end;

end;

procedure TFrmCrm.btnQryScrollVisiableClick(Sender: TObject);
begin
 MtPnl.Visible :=btnQryScrollVisiable.Down ;
if  (not  pgcSubInterface.Visible )then
begin
  if    (  not MtScrollBox.Visible)  then
  pgcMainGrid.Height :=self.ClientHeight -self.tlbMain.Height -12
  else
  pgcMainGrid.Height :=self.ClientHeight -self.MtScrollBox.Height -  tlbMain.Height -16;
end;

end;

procedure TFrmCrm.btnSubVisiableClick(Sender: TObject);
begin
 PnlItem.Visible :=  btnSubVisiable.Down ;
//if not  pgcSubInterface.Visible then   pgcMainGrid.Height :=self.ClientHeight -self.tlbMain.Height -self.MtScrollBox.Height -10 else  pgcMainGrid.Height :=220;
end;

procedure TFrmCrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
     vk_Return:begin
                  FhlKnl1.Vl_DoBoxEnter(ActiveControl);
               end;
   end;
end;

procedure TFrmCrm.actFilterExecute(Sender: TObject);
begin
  FhlKnl1.Ds_Filter(self.Maindataset );
end;

procedure TFrmCrm.IniTreePgcPopupMenu;
var     fieldname,sql:string;

var TreePgcMenu:Tpopupmenu;
var ConfigTrees:Tmenuitem;
begin
    if  (logininfo.Sys ) then
    begin
        TreePgcMenu:=Tpopupmenu.Create (self);
        ConfigTrees:=Tmenuitem.Create (TreePgcMenu)  ;
        ConfigTrees.Caption :='ConfigTrees';
        ConfigTrees.OnClick :=dmfrm.actCRMTreeIDSGrid.OnExecute     ;//(Sender);
        TreePgcMenu.Items.Add(ConfigTrees);
        self.pgcTree.PopupMenu := TreePgcMenu;
    end;

end;

procedure TFrmCrm.IniSubInterfacePgcPopupMenu;
var SubInterfacePgc:Tpopupmenu;
var ConfigSubInterface:Tmenuitem;
begin
    if  (logininfo.Sys ) then
    begin
        SubInterfacePgc:=Tpopupmenu.Create (self);
        ConfigSubInterface:=Tmenuitem.Create (SubInterfacePgc)  ;
        ConfigSubInterface.Caption :='ConfigSubInterface';
        ConfigSubInterface.OnClick :=dmfrm.actCRMSubInterFace.OnExecute     ;//(Sender);
        SubInterfacePgc.Items.Add(ConfigSubInterface);
        self.pgcSubInterface.PopupMenu := SubInterfacePgc;
    end;

end;

procedure TFrmCrm.FilterExecute(Sender: TObject);
var PopDbgrid:Tdbgrid;

begin

       

      if sender is Tmenuitem then
      begin
        PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
        FhlKnl1.Ds_Filter(PopDbgrid.DataSource.DataSet );       //-
      end
      else
       FhlKnl1.Ds_Filter(nil,self.MainDBGrid);       //-
end;

procedure TFrmCrm.FavoriteMExecute(Sender: TObject);
var
  TreeDlgFrm: TTreeDlgFrm;
var
  i,F_MID: integer;
  TempBookmark: TBookMark;
begin
 
         if not self.Maindataset.IsEmpty then
         begin
               TreeDlgFrm:= TTreeDlgFrm.Create (nil);
               TreeDlgFrm.InitFrm('931',null,true,'F_code','F_Name',false);
               TreeDlgFrm.Caption :='��ӵ��ղؼ�';
               if TreeDlgFrm.ShowModal =mrok then
               begin
                    F_MID:=TreeDlgFrm.ADODataSet1.fieldbyname('F_ID').AsInteger ;
                    dmfrm.GetQuery1('select top 0 * from T_favoriteDL');

                    if   dgMultiselect in self.MainDBGrid.Options then      //2006-7-26������ȹ���
                    begin
                             MainDBGrid.SelectedRows.CurrentRowSelected:=true;
                              if Maindataset.Active then
                              with MainDBGrid.SelectedRows do
                                  if Count <> 0 then
                                  begin
                                      TempBookmark:= Maindataset.GetBookmark;
                                      for i:= 0 to Count - 1 do
                                      begin
                                        if IndexOf(Items[i]) > -1 then
                                        begin
                                          Maindataset.Bookmark:= Items[i];

                                          dmfrm.FreeQuery1.Append ;
                                          dmfrm.FreeQuery1.FieldByName('F_MID').AsInteger :=F_MID;
                                          dmfrm.FreeQuery1.FieldByName('F_Code').AsString :=Maindataset.FieldByName ('F_CltCode').AsString ;
                                          dmfrm.FreeQuery1.Post ;
//                                               Amt:=Amt+self.dlAdoDataSet1.fieldbyname('Amt').AsCurrency;
                                        end;
                                      end;
                                  end;
                              Maindataset.GotoBookmark(TempBookmark);
                              Maindataset.FreeBookmark(TempBookmark);
                    end;

               end;
               TreeDlgFrm.Free ;
         end
         else
         showmessage('��ѡ��ͻ����ղ� ');

end;

procedure TFrmCrm.FavoriteMgrExecute(Sender: TObject);
var FrmFavorite:Tform;
var i:integer;
var BtnConFirm,BtnCanCel:Tbutton;
begin

         FrmFavorite:= FhlUser.ShowModelTreeEditorFrm('26',null,true);
         FrmFavorite.Position :=poScreenCenter;
         FrmFavorite.BorderStyle :=  bsDialog;
         TTreeEditorFrm(FrmFavorite).SetBtn.Visible :=false;
         TTreeEditorFrm(FrmFavorite).prtBtn.Visible :=false;
         TTreeEditorFrm(FrmFavorite).preBtn.Visible :=false;
         TTreeEditorFrm(FrmFavorite).expBtn.Visible :=false;
         TTreeEditorFrm(FrmFavorite).btnSubAdd.Visible :=false;
         TTreeEditorFrm(FrmFavorite).hlpBtn.Visible :=false;
         TTreeEditorFrm(FrmFavorite).TreeView1.Width:= 160;
         FrmFavorite.Width :=440;
         FrmFavorite.Caption :='�ղع���';
         FrmFavorite.ShowModal  ;
         begin
             for i:=0 to self.pgcTree.PageCount -1 do
                self.pgcTree.Pages[0].Free ;
             self.IniTree(self.fDict );
         end;
         FrmFavorite.Free;


end;

procedure TFrmCrm.FavoriteContentMgrExecute(Sender: TObject);
var FrmFavConMgr: Tform;
begin
    FrmFavConMgr:=  fhluser.ShowModalTreeGridFrm('54',null,true);
   FrmFavConMgr.Caption :='�ղؼ�����';
   TTreeGridFrm(FrmFavConMgr).myBar1.Buttons[0].Caption :='�Ƴ�';
   TTreeGridFrm(FrmFavConMgr).DeleteAction1.Caption  :='�Ƴ�';
   FrmFavConMgr.ShowModal ;
end;

procedure TFrmCrm.BatchUpdateExecute(Sender: TObject);
var
  i: integer;
  TempBookmark: TBookMark;          //multiselect

var TabEditorFrm:TTabEditorFrm;
var GrpBatchUpdate:TGrpQueryRecord   ;
var labelV:TLabel;
begin
    if self.Maindataset.IsEmpty then
    begin
        showmessage('����ѡ���¼');
        exit;
    end;
    labelV:=TLabel.Create(self);
    labelV.Caption :='�ֶ�ֵ:';
    TabEditorFrm:=TTabEditorFrm.Create (nil);

    FhlKnl1.Pc_CreateTabSheet(TabEditorFrm.PageControl1);
    TabEditorFrm.CheckBox1.Visible :=false;
    TabEditorFrm.Caption :='�����޸�';
    GrpBatchUpdate:=TGrpQueryRecord.create(self);
    labelV.Parent  := GrpBatchUpdate;
    GrpBatchUpdate.LabelName.Left :=40;

    GrpBatchUpdate.DragMode :=   dmManual;
    GrpBatchUpdate.Parent :=TabEditorFrm.PageControl1.ActivePage ;
    GrpBatchUpdate.Align :=alClient;
    GrpBatchUpdate.IniQuickQuery(self.MainDBGrid ,true) ;
    GrpBatchUpdate.LabelName.Caption  :='�ֶ���:';
    GrpBatchUpdate.OptCombobox.Visible :=false;
    GrpBatchUpdate.ValGroupBox.Left :=GrpBatchUpdate.ComBoxFieldCname.Left ;

    GrpBatchUpdate.ValGroupBox.Top := GrpBatchUpdate.ComBoxFieldCname.Top +GrpBatchUpdate.ComBoxFieldCname.Height   +30;
    labelV.Left := GrpBatchUpdate.LabelName.Left ;
    labelV.Top :=  GrpBatchUpdate.ValGroupBox.Top+10;
    if  TabEditorFrm.ShowModal =mrok then
    begin
         GrpBatchUpdate.GetSqlCon ;

          MainDBGrid.SelectedRows.CurrentRowSelected:=true;

          if self.MainDBGrid.DataSource.DataSet.Active then
          with MainDBGrid.SelectedRows do
              if Count <> 0 then
              begin
                  TempBookmark:= MainDBGrid.Datasource.Dataset.GetBookmark;
                  for i:= 0 to Count - 1 do
                  begin
                    if IndexOf(Items[i]) > -1 then
                    begin
                       MainDBGrid.Datasource.Dataset.Bookmark:= Items[i];


                       MainDBGrid.DataSource.DataSet.Edit ;
                       MainDBGrid.DataSource.DataSet.FieldByName(GrpBatchUpdate.fldName ).Value :=GrpBatchUpdate.fldval ;
                       MainDBGrid.DataSource.DataSet.Post ;
                    end;
                  end;
             end;

          MainDBGrid.Datasource.Dataset.GotoBookmark(TempBookmark);
          MainDBGrid.Datasource.Dataset.FreeBookmark(TempBookmark);

    end;
    TabEditorFrm.Free;

end;

procedure TFrmCrm.pgcTreeDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
if source is Tdbgrid then
   Accept:=true;

end;

procedure TFrmCrm.pgcTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var MainTable,ForeignTable,foreignTableCname:string;
Var MainField ,ForeignField:string;
var ForeignNameField:string;

var TreeDataserID,GridID,TreeGridID,SubInterFaceID:string;
begin
       if not logininfo.Sys then exit;

        self.Caption :=inttostr(pgcTree.Tag );
        MainField:= TdbgridEx(Source).Columns [TdbgridEx(  Source).col-1].FieldName;

        
        MainTable:=fhluser.GetTableName(inttostr(self.Maindataset.Tag ));

        if  MainTable<>'' then
        begin
              fhlknl1.Kl_GetQuery2('select *From '+logininfo.SysDBPubName +'.dbo.TFkReference  where  TableEname='+quotedstr(MainTable)+' and FieldEName='+quotedstr(MainField));
              if not fhlknl1.FreeQuery.IsEmpty then
                 ForeignTable:=fhlknl1.FreeQuery.fieldbyname('ReferenceOnTable').AsString ;
                 ForeignField:=fhlknl1.FreeQuery.fieldbyname('ReferenceOnField').AsString ;

              if  ForeignTable<>'' then
              begin
                  fhlknl1.Kl_GetQuery2('select CodeField,NameField,TableCname From '+logininfo.SysDBPubName +'.dbo.Tallusertable where TableEName='+quotedstr(ForeignTable));
                  if not fhlknl1.FreeQuery.IsEmpty then
                     ForeignNameField:=fhlknl1.FreeQuery.fieldbyname('NameField').AsString ;
                     foreignTableCname:=fhlknl1.FreeQuery.fieldbyname('TableCname').AsString ;
              end
              else
              exit;


              TreeDataserID:=fhlUser.AddDataSet('Crm '+foreignTableCname+'ѡ��',ForeignTable,'select *from '+ForeignTable);
              SubInterFaceID:=fhlknl1.GetMaxCode ('T701','SubInterfaceID');//sub inter fave id

              fhlknl1.Kl_GetQuery2('select top 0 * from T703 ',true,true);
              fhlknl1.FreeQuery.Append ;
              fhlknl1.FreeQuery.FieldByName('f02').Value :='CRM '+ foreignTableCname+' ѡ��';

              fhlknl1.FreeQuery.FieldByName('f05').Value :='ȫ��';
              fhlknl1.FreeQuery.FieldByName('f06').Value :=6;
              fhlknl1.FreeQuery.FieldByName('f07').Value :=TreeDataserID;

              fhlknl1.FreeQuery.FieldByName('f08').Value :=ForeignNameField;
              fhlknl1.FreeQuery.FieldByName('f09').Value :=ForeignField ;

              fhlknl1.FreeQuery.FieldByName('f10').Value :=200;
              fhlknl1.FreeQuery.FieldByName('f11').Value :=self.pgcTree.Tag ;

                           fhlknl1.FreeQuery.FieldByName('f12').Value := SubInterFaceID;
              fhlknl1.FreeQuery.FieldByName('f13').Value :=true;
              fhlknl1.FreeQuery.FieldByName('f14').Value :=10;
              fhlknl1.FreeQuery.Post ;

              TreeDataserID:=fhlUser.AddDataSet('Crm '+foreignTableCname+'ѡ��',MainTable,'select *from '+MainTable+' where '+ForeignField+' like :'+ForeignField);
              GridID       :=fhlUser.AddGrid  ('Crm '+foreignTableCname+'ѡ��',TreeDataserID);
              TreeGridID   :=fhlUser.AddTreeGrid('Crm '+foreignTableCname+'ѡ��',GridID,'-1','-1',-1);
              fhlUser.AddSubInterFace('Crm '+foreignTableCname+'ѡ��',SubInterFaceID,'0',TreeGridID,'');

              showmessage( MainField+' '+MainTable+' '+ForeignTable+' '+ForeignField+' '+ForeignNameField+' '+foreignTableCname);
        end
        else
        exit;


end;

procedure TFrmCrm.pgcSubInterfaceDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var MainField,MainTable:string;
var SubTableEName,SubFieldEName,SubTableCName:string;
var SubDataSetID,SubGridID,SubTreeGridID:string;
var FrmActions:TFrmActions;

var sql:string;
begin
     if not logininfo.Sys then exit;

      MainField:= TdbgridEx(Source).Columns [TdbgridEx(  Source).col-1].FieldName;
      MainTable:=fhluser.GetTableName(inttostr(self.Maindataset.Tag ));

      if  MainTable<>'' then
      begin
            sql:='select A.TableEname,A.FieldEname,B.TableCname      '
                +'From '+logininfo.SysDBPubName +'.dbo.TFkReference  A    '
                +'join '+logininfo.SysDBPubName +'.dbo.Tallusertable B on A.TableEname=B.TableEname  '
                +'where ReferenceOnTable='+quotedstr(trim(MainTable))+' and ReferenceOnField='+quotedstr(trim(MainField));

            fhlknl1.Kl_GetQuery2(sql);
            
            if not fhlknl1.FreeQuery.IsEmpty then
            begin
                 FrmActions:=TFrmActions.Create(self);
                 FrmActions.ActionGrid.RowCount:= fhlknl1.FreeQuery.RecordCount ;
                 while(not fhlknl1.FreeQuery.Eof ) do
                 begin
                      FrmActions.ActionGrid.Cols[0].Append (fhlknl1.FreeQuery.fieldbyname('TableEname').AsString);
                      FrmActions.ActionGrid.Cols[1].Append(fhlknl1.FreeQuery.fieldbyname('TableCname').AsString);
                      FrmActions.ActionGrid.Cols[4].Append(fhlknl1.FreeQuery.fieldbyname('FieldEname').AsString);

                      fhlknl1.FreeQuery.Next ;
                 end;   {}
                 fhlknl1.FreeQuery.Close ;

                 if FrmActions.ShowModal =mrok then
                 begin
                       SubTableEName:=FrmActions.ActionGrid.Cells [0,FrmActions.ActionGrid.row];
                       SubTableCName:=FrmActions.ActionGrid.Cells [1,FrmActions.ActionGrid.row];

                       SubFieldEName:=FrmActions.ActionGrid.Cells [4,FrmActions.ActionGrid.row];

                 end;
                 FrmActions.Free ;



                 if SubTableEName<>'' then
                  begin
                      SubDataSetID :=fhlUser.AddDataSet('Crm '+SubTableCName+'�Ӳ�',SubTableEName,'select *from '+SubTableEName+' where '+SubFieldEName+' =:'+SubFieldEName,true,true);
                      SubGridID    :=fhlUser.AddGrid  ('Crm '+SubTableCName+'�Ӳ�',SubDataSetID);
                      SubTreeGridID:=fhlUser.AddTreeGrid('Crm '+SubTableCName+'�Ӳ�',SubGridID,'-1','-1',-1);
                      fhlUser.AddSubInterFace('Crm '+SubTableCName+'�Ӳ�',inttostr(pgcSubInterface.Tag ),'0',SubTreeGridID,'');
                  end;
            end
            else
               exit;

           showmessage(MainField+inttostr(pgcSubInterface.Tag )+' '+SubTableEName +' '+SubFieldEName+' '+SubTableCName);
      end;
end;

procedure TFrmCrm.pgcSubInterfaceDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   if source is Tdbgrid then
      Accept:=true;
end;

procedure TFrmCrm.Actsl_quoteExecute(Sender: TObject);
var PopDbgrid:Tdbgrid;
var Code:string;
begin

    PopDbgrid:=Tdbgrid( Tpopupmenu(  Tmenuitem(Sender).GetParentMenu ).PopupComponent ) ;
    if PopDbgrid.DataSource.DataSet.findField('Code')= nil then exit;
    Code:=PopDbgrid.DataSource.DataSet.Fieldbyname('Code').AsString ;

//    Sender.name='dSl0101';
   if desktopfrm.dsMainMenu.findField('subSysDBName')<>nil then
      desktopfrm.FrmActExecute(Sender)  ;
      FhlUser.ShowBillFrm('15',Code);
end;

end.


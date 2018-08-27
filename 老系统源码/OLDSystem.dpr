
program OLDSystem;

uses
  Forms,
  Dialogs,
  about in '..\source\about.pas' {aboutFrm},
  datamodule in '..\source\datamodule.pas' {dmFrm: TDataModule},
  Editor in '..\source\Editor.pas' {EditorFrm},
  Finder in '..\source\finder.pas' {FinderFrm},
  Lookup in '..\source\lookup.pas' {LookupFrm},
  TabGrid in '..\source\TabGrid.pas' {TabGridFrm},
  analyser in '..\source\ANALYSER.PAS' {analyserFrm},
  BillOpenDlg in '..\source\BillOpenDlg.pas' {BillOpenDlgFrm},
  bill in '..\source\Bill.pas' {BillFrm},
  pick in '..\source\Pick.pas' {PickFrm},
  TreeEditor in '..\source\TreeEditor.pas' {TreeEditorFrm},
  TreeGrid in '..\source\TreeGrid.pas' {TreeGridFrm},
  TreeDlg in '..\source\TreeDlg.pas' {TreeDlgFrm},
  dsFinder in '..\source\dsFinder.pas' {dsFinderFrm},
  More2More in '..\source\More2More.pas' {More2MoreFrm},
  ClientProp in '..\source\ClientProp.pas' {ClientPropFrm},

  main in '..\source\MAIN.PAS' {mainFrm},
  WareProp in '..\source\WareProp.pas' {warePropFrm},
  TreeMgr in '..\source\TreeMgr.pas' {TreeMgrFrm},
  YdWareProp in '..\source\YdWareProp.pas' {YdWarePropFrm},
  TabEditor in '..\source\TabEditor.pas' {TabEditorFrm},
  RepBill in '..\source\RepBill.pas' {RepBillFrm: TQuickRep},
  fncarry in '..\source\fncarry.pas' {fncarryFrm},
  Mailer in '..\source\Mailer.pas' {MailerFrm},
  Downer in '..\source\Downer.pas' {DownerFrm},
  Inv in '..\source\Inv.pas' {InvFrm},
  MacPermit in '..\source\MacPermit.pas' {MacPermitFrm},
  FhlKnl in '..\source\FhlKnl.pas',
  arrange in '..\source\arrange.pas',
  colProp in '..\source\colProp.pas' {colPropFrm},
  ConnThrd in '..\source\ConnThrd.pas',
  Date in '..\source\Date.pas' {DateFrm},
  Filter in '..\source\Filter.pas' {FilterFrm},
  RepSet in '..\source\RepSet.pas' {RepSetFrm},
  RepCard in '..\source\RepCard.pas' {RepCardFrm},
  RepGrid in '..\source\RepGrid.pas' {RepGridFrm},
  memo in '..\source\memo.pas' {memoFrm},
  DirSelector in '..\source\DirSelector.pas' {DirSelectorFrm},
  Sort in '..\source\Sort.pas' {SortFrm},
  colShower in '..\source\colShower.pas' {colShowerFrm},
  UnitCreateComponent in '..\source\UnitCreateComponent.pas' {frmCreateComponent},
  UnitUpdateProerty in '..\source\UnitUpdateProerty.pas' {FrmUpdateProperty},
  UnitDesignMainMenu in '..\source\UnitDesignMainMenu.pas',
  UPublic in '..\source\UPublic.pas',
  UnitManageFrm in '..\source\UnitManageFrm.pas' {FrmManageFrm},
  UnitGetGridIDTreeID in '..\source\UnitGetGridIDTreeID.pas' {frmGetGridID},
  UUpdateImage in '..\source\UUpdateImage.pas' {FrmUpdateImage},
  UnitLockSys in '..\source\UnitLockSys.pas' {frmLockSys},
  PickWindowUniveral in '..\source\PickWindowUniveral.pas' {Form1},
  Trigger in '..\source\Trigger.pas' {FrmTrigger},
  UnitMainMenu in '..\source\UnitMainMenu.pas' {FrmMainMenu},
  UnitActionsGrid in '..\source\UnitActionsGrid.pas' {FrmActions},
  UnitCrmMain in '..\source\UnitCrmMain.pas' {FrmCrm},
  UnitGrid in '..\source\UnitGrid.pas',
  UnitAdoDataSet in '..\source\UnitAdoDataSet.pas',
  UnitPublicFunction in '..\source\UnitPublicFunction.pas',
  UnitDbimage in '..\source\UnitDbimage.pas',
  UnitInOrSaleRefs in '..\source\UnitInOrSaleRefs.pas',
  unitFrmSelDate in '..\source\unitFrmSelDate.pas',
  UnitModelFrm in '..\source\UnitModelFrm.pas' {FrmModel},
  UnitFrmGrid in '..\source\UnitFrmGrid.pas' {FrmGrid},
  UnitWrTransformBill in '..\source\UnitWrTransformBill.pas' {WrTransformBillFrm},
  UnitBillWhOut in '..\source\UnitBillWhOut.pas' {FrmBillWhOut},
  UnitUpdateHint in '..\source\UnitUpdateHint.pas' {FrmUpdateHint},
  Login in 'OldUnit\Login.pas' {LoginFrm1},
  splash in 'OldUnit\splash.pas',
  desktop in 'OldUnit\desktop.pas';

{$R *.res}
                                  
begin
  Application.Initialize;
  Application.ProcessMessages;
  SplashFrm:=TsplashFrm.Create(application);
  SplashFrm.Show;
  SplashFrm.Update;
  Application.ShowMainForm:=false;
  SplashFrm.ShowHint('���ڴ�������ģ��,���Ժ�...');
  Application.CreateForm(TdmFrm, dmFrm);
  SplashFrm.ShowHint('���ڴ���������,���Ժ�...');
  Application.CreateForm(TmainFrm, mainFrm);
  SplashFrm.ShowHint('���ڴ�����������,���Ժ�...');
  Application.CreateForm(TdesktopFrm, desktopFrm);


  SplashFrm.ShowHint('������������,���Ժ�...');

      if (SplashFrm.SetConnection) and (desktopFrm.Reg) then
     begin
        Application.ShowMainForm:=True;
        Application.Run;
     end
     else begin
        mainFrm.Close;
        Application.Run;
        Application.Terminate;
     end;

end.


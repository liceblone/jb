program jingbei;



uses
  Forms,
  Dialogs,
  about in 'source\about.pas' {aboutFrm},
  datamodule in 'source\datamodule.pas' {dmFrm: TDataModule},
  Editor in 'source\Editor.pas' {EditorFrm},
  Finder in 'source\finder.pas' {FinderFrm},
  Lookup in 'source\lookup.pas' {LookupFrm},
  TabGrid in 'source\TabGrid.pas' {TabGridFrm},
  analyser in 'source\ANALYSER.PAS' {analyserFrm},
  BillOpenDlg in 'source\BillOpenDlg.pas' {BillOpenDlgFrm},
  bill in 'source\Bill.pas' {BillFrm},
  pick in 'source\Pick.pas' {PickFrm},
  TreeEditor in 'source\TreeEditor.pas' {TreeEditorFrm},
  TreeGrid in 'source\TreeGrid.pas' {TreeGridFrm},
  TreeDlg in 'source\TreeDlg.pas' {TreeDlgFrm},
  dsFinder in 'source\dsFinder.pas' {dsFinderFrm},
  More2More in 'source\More2More.pas' {More2MoreFrm},
  ClientProp in 'source\ClientProp.pas' {ClientPropFrm},
  Login in 'source\Login.pas' {LoginFrm1},
  main in 'source\MAIN.PAS' {mainFrm},
  splash in 'source\SPLASH.PAS' {splashFrm},
  WareProp in 'source\WareProp.pas' {warePropFrm},
  TreeMgr in 'source\TreeMgr.pas' {TreeMgrFrm},
  YdWareProp in 'source\YdWareProp.pas' {YdWarePropFrm},
  desktop in 'source\Desktop.pas' {DesktopFrm},
  TabEditor in 'source\TabEditor.pas' {TabEditorFrm},
  RepBill in 'source\RepBill.pas' {RepBillFrm: TQuickRep},
  fncarry in 'source\fncarry.pas' {fncarryFrm},
  Mailer in 'source\Mailer.pas' {MailerFrm},
  Downer in 'source\Downer.pas' {DownerFrm},
  Inv in 'source\Inv.pas' {InvFrm},
  MacPermit in 'source\MacPermit.pas' {MacPermitFrm},
  FhlKnl in 'source\FhlKnl.pas',
  arrange in 'source\arrange.pas',
  colProp in 'source\colProp.pas' {colPropFrm},
  ConnThrd in 'source\ConnThrd.pas',
  Date in 'source\Date.pas' {DateFrm},
  Filter in 'source\Filter.pas' {FilterFrm},
  RepSet in 'source\RepSet.pas' {RepSetFrm},
  RepCard in 'source\RepCard.pas' {RepCardFrm},
  RepGrid in 'source\RepGrid.pas' {RepGridFrm},
  memo in 'source\memo.pas' {memoFrm},
  DirSelector in 'source\DirSelector.pas' {DirSelectorFrm},
  Sort in 'source\Sort.pas' {SortFrm},
  colShower in 'source\colShower.pas' {colShowerFrm},
  UnitCreateComponent in 'source\UnitCreateComponent.pas' {frmCreateComponent},
  UnitUpdateProerty in 'source\UnitUpdateProerty.pas' {FrmUpdateProperty},
  UnitDesignMainMenu in 'source\UnitDesignMainMenu.pas',
  UPublic in 'source\UPublic.pas',
  UnitManageFrm in 'source\UnitManageFrm.pas' {FrmManageFrm},
  UnitGetGridIDTreeID in 'source\UnitGetGridIDTreeID.pas' {frmGetGridID},
  UUpdateImage in 'source\UUpdateImage.pas' {FrmUpdateImage},
  UnitLockSys in 'source\UnitLockSys.pas' {frmLockSys},
  PickWindowUniveral in 'source\PickWindowUniveral.pas' {Form1},
  Trigger in 'source\Trigger.pas' {FrmTrigger},
  UnitMainMenu in 'source\UnitMainMenu.pas' {FrmMainMenu},
  UnitActionsGrid in 'source\UnitActionsGrid.pas' {FrmActions},
  UnitCrmMain in 'source\UnitCrmMain.pas' {FrmCrm},
  UnitGrid in 'source\UnitGrid.pas',
  UnitAdoDataSet in 'source\UnitAdoDataSet.pas',
  UnitPublicFunction in 'source\UnitPublicFunction.pas',
  UnitDbimage in 'source\UnitDbimage.pas',
  UnitInOrSaleRefs in 'source\UnitInOrSaleRefs.pas',
  unitFrmSelDate in 'source\unitFrmSelDate.pas',
  UnitModelFrm in 'source\UnitModelFrm.pas' {FrmModel},
  UnitFrmGrid in 'source\UnitFrmGrid.pas' {FrmGrid},
  UnitWrTransformBill in 'source\UnitWrTransformBill.pas' {WrTransformBillFrm},
  UnitBillWhOut in 'source\UnitBillWhOut.pas' {FrmBillWhOut},
  UnitUpdateHint in 'source\UnitUpdateHint.pas' {FrmUpdateHint},
  UnitChgPwd in 'source\UnitChgPwd.pas' {FrmChgPwd},
  UExportToExcel in 'source\UExportToExcel.pas',
  UnitFrmAnalyserEx in 'source\UnitFrmAnalyserEx.pas' {AnalyseEx},
  UPublicCtrl in 'source\controls\UPublicCtrl.pas',
  UPublicFunction in 'source\functions\UPublicFunction.pas',
  UnitBillEx in 'source\UnitBillEx.pas' {FrmBillEx},
  UnitLookUpImport in 'source\UnitLookUpImport.pas' {FrmLoopUpImPortEx},
  UnitMDLookupImport in 'source\UnitMDLookupImport.pas' {FrmMDLookupImport},
  Barcode in 'BarCode\Barcode.pas',
  Barcode2 in 'BarCode\Barcode2.pas',
  bcchksum in 'BarCode\bcchksum.pas',
  RepBarCode in 'source\RepBarCode.pas' {RepBarCodeFrm: TQuickRep},
  UnitBarCodeTest in 'source\UnitBarCodeTest.pas' {frmBarCodeTest},
  UnitSearchBarCode in 'source\UnitSearchBarCode.pas' {FrmSearchBarCode},
  UnitCommonInterface in 'source\UnitCommonInterface.pas',
  UnitSetBarCodeQty in 'source\UnitSetBarCodeQty.pas' {frmBarCodeQty},
  UnitBarCodeList in 'source\UnitBarCodeList.pas' {frmBarCodeList},
  UnitBarCodePanel in 'source\UnitBarCodePanel.pas' {FrmPanelBarCodeList: TFrame},
  UnitPrintBarCode in 'source\UnitPrintBarCode.pas' {FrmPrintBarCode},
  UnitPickWareshouse in 'source\UnitPickWareshouse.pas' {frmPickWarehouse},
  UnitExpressPrint in 'source\UnitExpressPrint.pas' {FrmExpressPrint: TQuickRep},
  UnitChyGrid in 'source\UnitChyGrid.pas',
  UnitPickSLOrderDL in 'source\UnitPickSLOrderDL.pas' {FrmPickSLOrderDL},
  UnitDeliveryReport in 'source\UnitDeliveryReport.pas' {FrmDeliveryReport},
  UnitPrintLabel in 'source\UnitPrintLabel.pas' {QrLabelPrinting: TQuickRep},
  UnitClientBarcodePrint in 'source\UnitClientBarcodePrint.pas' {QrClientBarCodePrint: TQuickRep},
  UnitFastReport in 'source\fastreport\UnitFastReport.pas' {frmFastReport},
  UnitBarcodePrintingProgress in 'source\UnitBarcodePrintingProgress.pas' {frmBarcodePrintingProgress},
  UnitHouShengLabel in 'source\UnitHouShengLabel.pas' {frmHouShengLabel},
  UnitHoushengLabel2 in 'source\UnitHoushengLabel2.pas' {QrptHoushengLabel: TQuickRep},
  UnitDeliveryLabel in 'source\UnitDeliveryLabel.pas' {DeliveryLabelPrint: TQuickRep},
  UnitMulPrintModule in 'source\UnitMulPrintModule.pas',
  UnitUserDefineRpt in 'source\UnitUserDefineRpt.pas',
  UnitUpdateQLabel in 'source\UnitUpdateQLabel.pas',
  UnitEditorReport in 'source\core\model\UnitEditorReport.pas',
  UnitUserQrRptEx in 'source\privatesource\UnitUserQrRptEx.pas',
  Myprv in 'source\privatesource\Myprv.pas',
  UnitChyFrReportView in 'source\privatesource\UnitChyFrReportView.pas',
  DelphiZXingQRCode in 'source\privatesource\DelphiZXingQRCode.pas',
  UnitBarcodeTemplate in 'source\UnitBarcodeTemplate.pas' {FrmBarCodeTemplate},
  UnitFrmWrArchive in 'source\UnitFrmWrArchive.pas' {FrmWrArchive: TFrame},
  Md5 in 'source\Md5.pas',
  UnitDes in 'source\UnitDes.pas'
  ;

//UnitFrmWrArchive in 'source\UnitFrmWrArchive.pas' {FrmWrArchive};

//UnitUserQrRptEx in 'source\UnitUserQrRptEx.pas' {FrmUserQrRptEx};

{$R *.res}

begin
  Application.Initialize;
  Application.ProcessMessages;
  SplashFrm:=TsplashFrm.Create(application);
  SplashFrm.Show;
  SplashFrm.Update;
  Application.ShowMainForm:=false;
  SplashFrm.ShowHint('正在创建数据模块,请稍候...');
  Application.CreateForm(TdmFrm, dmFrm);
  SplashFrm.ShowHint('正在创建主程序,请稍候...');
  Application.CreateForm(TmainFrm, mainFrm);
  SplashFrm.ShowHint('正在创建个人桌面,请稍候...');
  Application.CreateForm(TdesktopFrm, desktopFrm);

  SplashFrm.ShowHint('正在启动程序,请稍候...');

      if (SplashFrm.SetConnection)and (desktopFrm.Reg)
       then
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


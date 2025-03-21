unit UnitSearchBarCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB,UnitCommonInterface,strutils,UnitGrid,
   MMSystem,
  ExtCtrls;



type
  TFrmSearchBarCode = class(TForm)
    BarCodeDataSet: TADODataSet;
    DataSource1: TDataSource;
    PnlLeft: TPanel;
    Label1: TLabel;
    EdtHsBarCode: TEdit;
    BtnSearch: TButton;
    BtnImport: TButton;
    EdtJbLabelBarCode: TEdit;
    Label2: TLabel;
    procedure EdtHsBarCodeEnter(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BarCodeGridDblClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure PnlLeftDblClick(Sender: TObject);
    function  GetBarCodeList:TStringlist;
    procedure EdtHsBarCodeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BarCodeGridKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure EdtHsBarCodeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtJbLabelBarCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    private
    FBillCode:Variant;
    FParentSearch:  IParentSearch;
    FVerifyHSPartNo:integer;
    procedure Post;


    { Private declarations }
  public
    { Public declarations}
    FrmSearchBarCode: TFrmSearchBarCode;
    BarCodeGrid: TDBGrid;
    procedure  IniForm(parentSearch :IParentSearch;pBillCode: Variant);
    procedure  Save(pbillCOde:string);
    function   AddBarCode :boolean;
    procedure  RefreshBill;
    function   GetBarCodeInfo(barCode: string): Tdataset;
    procedure  OpenBill(billcode: string);
  end;




implementation
 uses datamodule , UnitCreateComponent;
{$R *.dfm}

procedure TFrmSearchBarCode.EdtHsBarCodeEnter(Sender: TObject);
begin
//
end;

procedure TFrmSearchBarCode.IniForm(parentSearch :IParentSearch;pBillCode :Variant);
begin
    self.FParentSearch:=parentSearch;
    FBillCode:=pBillCode;
    FhlUser.SetDbGridAndDataSet(self.BarCodeGrid,'767',pBillCode, true);
end;

procedure TFrmSearchBarCode.Save(pbillCOde:string);
var i:integer;
begin
    BarCodeDataSet.First;

    for i:=0 to BarCodeDataSet.RecordCount -1 do
    begin
      BarCodeDataSet.Edit;
      BarCodeDataSet.FieldByName('FBillCOde').Value:=pbillCOde;
      BarCodeDataSet.Next;
    end;
    self.BarCodeDataSet.UpdateBatch;
end;


procedure TFrmSearchBarCode.BtnSearchClick(Sender: TObject);
var list:Tstringlist;
var fileName :string;
begin
    try
        self.FParentSearch.EnableDsCaculation(false);
        fileName:='C:\Windows\Media\';
        if  self.FParentSearch.AddBarCode then
        begin
            FParentSearch.BarCodeSearch(nil)  ;
            fileName:=fileName+'Windows Ding.wav';
            //sndPlaySound(pchar( fileName),  SND_ASYNC  ) ;
        end  else
        begin
           fileName:=fileName+'tada.wav';
            sndPlaySound(pchar( fileName),  SND_ASYNC  ) ;
        end;
    finally
        self.FParentSearch.EnableDsCaculation(true);
    end;
end;

function  TFrmSearchBarCode.AddBarCode :boolean;
var resultset:tdataset;
begin
    if (length( EdtHsBarCode.Text)<9) then
      abort;

    EdtHsBarCode.Text :=trim(EdtHsBarCode.Text);
    resultset:= GetBarCodeInfo( EdtHsBarCode.Text );

   
end;

procedure TFrmSearchBarCode.BarCodeGridDblClick(Sender: TObject);
begin
    if not BarCodeDataSet.IsEmpty then
    Begin
         self.FParentSearch.RemoveBarCode;
     //    if not BarCodeDataSet.IsEmpty then
            self.FParentSearch.BarCodeSearch(GetBarCodeList) ;
    end;
end;

procedure TFrmSearchBarCode.BtnImportClick(Sender: TObject);
begin
   AddBarCode;
    FParentSearch.BarCodeSearch(self.GetBarCodeList);
   self.FParentSearch.AppendRecord(self.BarCodeDataSet);
end;

procedure TFrmSearchBarCode.PnlLeftDblClick(Sender: TObject);

var CrtCom:TfrmCreateComponent    ;
begin
// modeltpe:=Bill;
  if (LoginInfo.EmpId ='000') and (LoginInfo.LoginId ='chy') then
  begin
    CrtCom:=TfrmCreateComponent.Create(self);
    CrtCom.Hide;

    CrtCom.mtDataSet1:= self.BarCodeDataSet  ;
    CrtCom.DlGridId :=inttostr(self.BarCodeGrid.Tag);
    CrtCom.DLGrid  :=self.BarCodeGrid ;
    CrtCom.ModelType :=ModelFrmBill;
    try
    CrtCom.Show;
    finally

    end;
  end;
end;

function  TFrmSearchBarCode.GetBarCodeList;
var i:integer;
begin
  try
      result:= Tstringlist.Create;
      BarCodeDataSet.First;
      for  i:=1 to self.BarCodeDataSet.RecordCount do
      begin
          if (BarCodeDataSet.fieldbyname('FPackageBarCode').Value <>null) then
            result.Add(self.BarCodeDataSet.fieldbyname('FPackageBarCode').AsString);
          BarCodeDataSet.Next
      end;
      result.Add(self.EdtHsBarCode.Text);
   finally
   end;
end;

function TFrmSearchBarCode.GetBarCodeInfo(barCode: string): Tdataset;
var sql:string;
begin
//   sql:= 'select *   from  TBarcodeStorage where FBarCode = '+ quotedstr(barCode) +' or  FPackageBarCode ='+ quotedstr(leftstr(barCode,length(Barcode)-4));
   sql:= 'select top 1 stg.* , pti.FPesistorPartNo from TBarcodeStorage stg join TPesistorToInventory pti on stg.Wareid = pti.Wareid ';
   sql:= sql + ' where  stg.FPackageBarCode ='+ quotedstr(leftstr(barCode,length(Barcode)-4));
    sql:= sql + ' or stg.FBarCode = replace('+  quotedstr(leftstr(barCode,length(Barcode)-1)) +','' '',''0'')' ;

   fhlknl1.Kl_GetUserQuery(sql);

   result:=fhlknl1.User_Query;
end;

procedure TFrmSearchBarCode.RefreshBill;
begin
self.BarCodeDataSet.Close;
self.BarCodeDataSet.Open;
end;

procedure TFrmSearchBarCode.EdtHsBarCodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   case Key of
     vk_Return:
     begin
          //AddBarCode;
         // FParentSearch.BarCodeSearch(GetBarCodeList );
         if (FVerifyHSPartNo=0) then
         begin
           BtnSearchClick(sender);
           EdtHsBarCode.SetFocus;
           self.EdtHsBarCode.SelectAll;
         end;
         if (FVerifyHSPartNo<>0) then
         begin
           BtnSearchClick(sender);
           EdtJbLabelBarCode.SetFocus;
           self.EdtJbLabelBarCode.SelectAll;
         end;
     end;
   end;
end;


procedure TFrmSearchBarCode.BarCodeGridKeyUp(Sender: TObject;var Key: Word; Shift: TShiftState);
var list:Tstringlist;
begin
    if (BarCodeDataSet.Active and BarCodeDataSet.FieldByName('FPackageBarCode').Value<>'') then
    begin
        try
            list := Tstringlist.Create;
            list.Add( BarCodeDataSet.FieldByName('FPackageBarCode').Value);
            self.FParentSearch.BarCodeSearch(list) ;
        finally
            freeandnil(list);
        end;
    end;
end;

procedure TFrmSearchBarCode.EdtHsBarCodeChange(Sender: TObject);
begin
    EdtHsBarCode.Text :=    StringReplace(trim(EdtHsBarCode.Text) ,' ','-',[]);
end;

procedure TFrmSearchBarCode.FormCreate(Sender: TObject);
var sql,sqlformat:string;
var parentParamCode:string;
begin
    parentParamCode:=  quotedstr( '02030301' ) ;
    sqlformat := 'select  isnull(FParamValue,1) from TParamsAndValues where  FParamCode = %s  ';

    sql := format(sqlformat ,[parentParamCode , quotedstr('paperWidth') ]);;
    fhlknl1.Kl_GetUserQuery(sql);
    FVerifyHSPartNo :=fhlknl1.User_Query.fields[0].AsInteger;

    BarCodeGrid:=TModelDbGrid.create (self);
    BarCodeGrid.DataSource :=self.DataSource1  ;
    BarCodeGrid.Align :=alclient;
    BarCodeGrid.Parent :=self;
    BarCodeGrid.PopupMenu :=dmFrm.DbGridPopupMenu1 ;
    BarCodeGrid.OnDblClick :=BarCodeGridDblClick;
end;


procedure TFrmSearchBarCode.Post;
begin
end;

procedure TFrmSearchBarCode.OpenBill(billcode: string);
begin
 FhlKnl1.Ds_OpenDataSet(self.BarCodeDataSet,varArrayof([BillCode]));
end;

procedure TFrmSearchBarCode.EdtJbLabelBarCodeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   case Key of
     vk_Return:
     begin
     
         if (FVerifyHSPartNo<>0) then
         begin
           EdtHsBarCode.SetFocus ;
           self.EdtHsBarCode.SelectAll;

         end;

     end;
   end;
end;

end.

unit UUpdateImage;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, DB, ADODB, ComCtrls, Dialogs, Jpeg,ExtDlgs,datamodule;

type
  TFrmUpdateImage = class(TForm)
    pgc1: TPageControl;
    ts1: TTabSheet;
    btnCancelBtn: TButton;
    btnOKBtn: TButton;
    img1: TImage;
    ds1: TADODataSet;
    dlgOpenPic1: TOpenPictureDialog;
    btn1: TButton;
    procedure InitFrm(fld:Tfield);
    procedure btn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUpdateImage: TFrmUpdateImage;

implementation

{$R *.dfm}

procedure TFrmUpdateImage.btn1Click(Sender: TObject);
begin
 if  dlgOpenPic1.Execute then
    if dlgOpenPic1.FileName <>'' then
      img1.Picture.LoadFromFile(dlgOpenPic1.FileName);
end;

procedure TFrmUpdateImage.FormClose(Sender: TObject;
  var Action: TCloseAction);
var 
strm: TMemoryStream; 
ext: String; 
begin

      if self.ModalResult =mrOk then
      begin
              if dlgOpenPic1.Execute then
                      if   dlgOpenPic1.FileName <>'' then
                      begin
                          img1.Picture.LoadFromFile(dlgOpenPic1.FileName )  ;
                      end;
               strm := tmemorystream.Create ;
               img1.Picture.Graphic.SaveToStream(strm);

               strm.Position :=0;
               tblobfield(ds1.FieldByName('Fimage')).LoadFromStream(strm);

               
               strm.free;
      end;
end;

procedure TFrmUpdateImage.FormCreate(Sender: TObject);
var 
strm:tadoblobstream; 
jpegimage:tjpegimage;
bitmap:tbitmap;
begin
jpegimage:=tjpegimage.Create ;
strm := tadoblobstream.Create(tblobfield(ds1.fieldbyname('Fimage')),bmread);
jpegimage.LoadFromStream(strm) ;
img1.Picture.Graphic :=   jpegimage;

end;

procedure TFrmUpdateImage.InitFrm(fld: Tfield);
begin
//
end;

end.

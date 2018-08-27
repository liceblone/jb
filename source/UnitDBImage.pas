unit UnitDBImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, ExtDlgs, jpeg,DB, ADODB, ExtCtrls,Menus;
type TDBUnImage=class(TCustomControl)
     Private
        FStretch:boolean;
        FCenter :boolean;
        FAutoDisplay :boolean ;
        FBorderStyle: TBorderStyle;

        Fpicture:Tpicture;
        FOpenPictureDialog:TOpenPictureDialog;
        FSavePictureDialog:TSavePictureDialog;
        FPopupMenu:TPopupMenu;
        FMenuLoadPic:Tmenuitem;
        FMenuSavePic:Tmenuitem;
        FMenuClearPic:Tmenuitem;
        FDataLink: TFieldDataLink;

        procedure DataChange(Sender: TObject);
        procedure UpdateData(Sender: TObject);

        function  GetStretch: boolean;
        procedure SetStretch(const Value: boolean);
        function  GetPicture:Tpicture;
        Procedure SetPicture(PPicture:Tpicture);
        function  GetCenter: boolean;
        procedure SetCenter(const Value: boolean);
        function  GetAutoDisplay: boolean;
        function  GetBorderStyle: TBorderStyle;
        procedure SetAutoDisplay(const Value: boolean);
        procedure SetBorderStyle(const Value: TBorderStyle);
        Procedure LoadPicture(sender:Tobject);
        Procedure SavePicture(sender:Tobject);
        Procedure ClearPicture(sender:Tobject);
        function GetDataField: string;
        function GetDataSource: TDataSource;
        function GetField: TField;
        procedure SetDataField(const Value: string);
        procedure SetDataSource(const Value: TDataSource);
        Procedure Click(sender:Tobject);

     protected
             procedure Paint; override;

     public
             constructor create(AOwner: TComponent); override;
             destructor  Destroy;override;
             procedure   CMExit(var Message: TCMExit); message CM_EXIT;

    property Field: TField read GetField;
    published
            property DataField: string read GetDataField write SetDataField;
            property DataSource: TDataSource read GetDataSource write SetDataSource;
            property Picture:Tpicture read GetPicture write SetPicture;
            property Stretch:boolean  read GetStretch write SetStretch;
            property Center:boolean   read GetCenter write SetCenter;
            property BorderStyle :TBorderStyle read GetBorderStyle write SetBorderStyle;
            property AutoDisplay :boolean      read GetAutoDisplay write SetAutoDisplay;
            property OnDblClick;
            property OnClick;
            property OnExit;
            property ShowHint;
end;

implementation

{ TDBUnImage }

procedure TDBUnImage.ClearPicture(sender: Tobject);
begin
    IF Fpicture<>NIL THEN
    BEGIN
       
       SELF.FDataLink.Field.Value :=NULL;
       self.Refresh ;
    END;
end;

procedure TDBUnImage.Click(sender: Tobject);
var PP:Tpoint;
var strm: TADOBlobStream;

begin

      try
            strm := tadoblobstream.Create(tblobfield(self.FDataLink.DataSet.fieldbyname(SELF.DataField )),bmread);
            strm.position :=0;
            IF strm.Size >0 THEN
               self.FMenuSavePic.Enabled :=true
            else
               self.FMenuSavePic.Enabled :=false;

            getcursorpos(pp);
            IF SELF.FDataLink.DataSet.State  IN [DSINSERT,DSEDIT] THEN
            self.FPopupMenu.Popup(pp.X ,pp.Y );
      finally
           strm.Free ;

      end

end;

procedure TDBUnImage.CMExit(var Message: TCMExit);
begin
  try
    if Assigned(DataSource) and Assigned(DataSource.DataSet) and
       (DataSource.DataSet.State in [dsInsert, dsEdit]) then
      FDataLink.UpdateRecord;
  except
    raise;
  end;
  Invalidate; { Erase the focus marker }
  inherited;
end;

constructor TDBUnImage.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 105;
  Height := 105;
  TabStop := True;
  ParentColor := False;
  FPicture := TPicture.Create;
  self.FStretch :=true;
  FBorderStyle := bsSingle;
  FAutoDisplay := True;
  FCenter := True;
//  self.Hint :='双击选择图片';
 // self.ShowHint :=true;
  FOpenPictureDialog:=TOpenPictureDialog.Create(nil);
  self.OnDblClick :=self.LoadPicture;

  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FPopupMenu:=TPopupMenu.Create (nil);

  FMenuLoadPic:=Tmenuitem.Create(nil);
  FMenuLoadPic.Caption :='选择图片';
  FMenuLoadPic.OnClick :=self.LoadPicture;

  FMenuSavePic:=Tmenuitem.Create(nil);
  FMenuSavePic.Caption :='保存图片';
  FMenuSavePic.OnClick :=SavePicture;

  FMenuClearPic:=Tmenuitem.Create (nil);
  FMenuClearPic.Caption :='清除图片';
  FMenuClearPic.OnClick :=ClearPicture;

  FPopupMenu.Items.Add(FMenuLoadPic);
  FPopupMenu.Items.Add(FMenuSavePic);
  FPopupMenu.Items.Add(FMenuClearPic);

  FSavePictureDialog:=TSavePictureDialog.Create(nil);
//  self.PopupMenu :=self.FPopupMenu ;
  self.OnClick :=self.Click;
end;

procedure TDBUnImage.DataChange(Sender: TObject);
var
strm: TADOBlobStream;
JpegImage: TJpegImage;
//Bitmap: TBitmap;
begin

  strm := tadoblobstream.Create(tblobfield(self.FDataLink.DataSet.fieldbyname(SELF.DataField )),bmread);

  strm.position :=0;


  jpegimage := tjpegimage.Create ;
try
    IF     strm.Size >0 THEN
    BEGIN
      IF SELF.Picture<>NIL THEN
      SELF.Picture.Graphic := nil;
      try
         jpegimage.LoadFromStream(strm);
         SELF.Picture.Graphic := jpegimage;
      except
         SELF.Picture.Assign(self.FDataLink.DataSet.fieldbyname(SELF.DataField ))  ;
      end;

    END
    else
       SELF.Picture:=nil;

    self.Refresh ;
finally
  jpegimage.Free ;
  strm.Free ;
end;

end;

destructor TDBUnImage.Destroy;
begin
        Fpicture.Free ;
        FOpenPictureDialog.Free ;
        FSavePictureDialog.Free ;
        FMenuLoadPic.Free ;
        FMenuSavePic.Free ;
        FMenuClearPic.Free ;
        FPopupMenu.Free ;
        FDataLink.Free ;
        

    inherited;
end;

function TDBUnImage.GetAutoDisplay: boolean;
begin
    result:=self.FAutoDisplay ;
end;

function TDBUnImage.GetBorderStyle: TBorderStyle;
begin
    result:=self.FBorderStyle ;
end;

function TDBUnImage.GetCenter: boolean;
begin
result:=self.FCenter ;
end;

function TDBUnImage.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TDBUnImage.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TDBUnImage.GetField: TField;
begin
  Result := FDataLink.Field ;
end;

function TDBUnImage.GetPicture: Tpicture;
begin
    result:=self.Fpicture ;
end;

function TDBUnImage.GetStretch: boolean;
begin
    result:=FStretch;
end;

procedure TDBUnImage.LoadPicture(sender: Tobject);
begin
if assigned(self.FDataLink.DataSet) then
    if FOpenPictureDialog.Execute then
       if FOpenPictureDialog.FileName <>'' then
       begin
          if not ( self.FDataLink.DataSet.State in [dsinsert ,dsedit] ) then
          self.FDataLink.DataSet.Edit ;

          self.Fpicture.LoadFromFile(self.FOpenPictureDialog.FileName );
          self.Refresh ;
          self.UpdateData(self.Picture ); 
       end;

end;

procedure TDBUnImage.Paint;
var
//  Size: TSize;
  R: TRect;
//  S: string;
  DrawPict: TPicture;
  Form: TCustomForm;
  Pal: HPalette;
begin
  with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := Color;

    begin
      DrawPict := TPicture.Create;
      Pal := 0;
      try

          DrawPict.Assign(Picture);
          if Focused and (DrawPict.Graphic <> nil) and (DrawPict.Graphic.Palette <> 0) then
          begin { Control has focus, so realize the bitmap palette in foreground }
            Pal := SelectPalette(Handle, DrawPict.Graphic.Palette, False);
            RealizePalette(Handle);
          end;

        if Stretch then
          if (DrawPict.Graphic = nil) or DrawPict.Graphic.Empty then
            FillRect(ClientRect)
          else
            StretchDraw(ClientRect, DrawPict.Graphic)
        else
        begin
          SetRect(R, 0, 0, DrawPict.Width, DrawPict.Height);
          if Center then OffsetRect(R, (ClientWidth - DrawPict.Width) div 2,
            (ClientHeight - DrawPict.Height) div 2);
          StretchDraw(R, DrawPict.Graphic);
          ExcludeClipRect(Handle, R.Left, R.Top, R.Right, R.Bottom);
          FillRect(ClientRect);
          SelectClipRgn(Handle, 0);
        end;
      finally
        if Pal <> 0 then SelectPalette(Handle, Pal, True);
        DrawPict.Free;
      end;

    Form := GetParentForm(Self);
    if (Form <> nil)      then
    begin
      Brush.Color := clWindowFrame;
      FrameRect(ClientRect);
    end;
   end;
  end;
 inherited;

end;

procedure TDBUnImage.SavePicture(sender: Tobject);
begin
    if self.Fpicture<>nil then
      if self.FSavePictureDialog.Execute then
        self.Fpicture.SaveToFile (FSavePictureDialog.FileName );
end;

procedure TDBUnImage.SetAutoDisplay(const Value: boolean);
begin
    self.FAutoDisplay :=value;
end;

procedure TDBUnImage.SetBorderStyle(const Value: TBorderStyle);
begin
      self.FBorderStyle :=value;
end;

procedure TDBUnImage.SetCenter(const Value: boolean);
begin
    self.FCenter :=Value;
end;

procedure TDBUnImage.SetDataField(const Value: string);
begin
    FDataLink.FieldName:=  Value;
end;

procedure TDBUnImage.SetDataSource(const Value: TDataSource);
begin
    FDataLink.DataSource :=Value;
end;

procedure TDBUnImage.SetPicture(PPicture: Tpicture);
begin
     self.Fpicture.Assign(PPicture);
end;

procedure TDBUnImage.SetStretch(const Value: boolean);
begin
     FStretch:=Value;
end;

procedure TDBUnImage.UpdateData(Sender: TObject);
var
strm: TMemoryStream;
//ext: String;

VAR FBitMap:TBitMap;
var JPEG:TJPEGImage;

begin

  strm := tmemorystream.Create ;
  strm.Position :=0;

try
 {   if  (Picture.Graphic is TBitmap ) then
    begin
        FBitMap:=TBitMap.Create ;
        FBitMap.Assign(SELF.Picture.Graphic);
        JPEG:=TJPEGImage.Create ;
        JPEG.Assign(FBitMap) ;
        SELF.Picture.Assign (JPEG);

        FBitMap.Free ;
        JPEG.Free ;
     END;
     }
      if Picture.Graphic<>nil then
      begin
      FDataLink.Field.Assign(Picture.Graphic) ;
          //SELF.Picture.Graphic.SaveToStream(strm);
          //tblobfield(Tadodataset(self.FDataLink.DataSet ).FieldByName(SELF.DataField )).LoadFromStream(strm);
      end
      ELSE
        Tadodataset(self.FDataLink.DataSet ).FieldByName(SELF.DataField ).Value :=NULL;
finally

  strm.Free ; //笔者发现如strm采用tblobstream类，程序运行到该语句会出现问题
end;

end;

end.


object FrmUpdateImage: TFrmUpdateImage
  Left = 267
  Top = 200
  BorderStyle = bsDialog
  Caption = #27983#35272#22270#29255
  ClientHeight = 318
  ClientWidth = 455
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 355
    Height = 318
    ActivePage = ts1
    Align = alLeft
    TabOrder = 0
    object ts1: TTabSheet
      object img1: TImage
        Left = 16
        Top = 8
        Width = 297
        Height = 273
      end
    end
  end
  object btnCancelBtn: TButton
    Left = 367
    Top = 108
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 1
  end
  object btnOKBtn: TButton
    Left = 367
    Top = 68
    Width = 75
    Height = 25
    Caption = #20445#23384
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btn1: TButton
    Left = 368
    Top = 32
    Width = 75
    Height = 25
    Caption = #26356#25913#22270#29255
    TabOrder = 3
    OnClick = btn1Click
  end
  object ds1: TADODataSet
    Connection = dmFrm.ADOConnection1
    Parameters = <>
    Left = 192
  end
  object dlgOpenPic1: TOpenPictureDialog
    Left = 224
  end
end

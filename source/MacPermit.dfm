object MacPermitFrm: TMacPermitFrm
  Left = 297
  Top = 137
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 179
  ClientWidth = 395
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 281
    Height = 161
    Shape = bsFrame
  end
  object Label2: TLabel
    Left = 16
    Top = 88
    Width = 24
    Height = 13
    Caption = #35828#26126
  end
  object Label1: TLabel
    Left = 16
    Top = 56
    Width = 24
    Height = 13
    Caption = #20998#31867
  end
  object OKBtn: TButton
    Left = 300
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 300
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 56
    Top = 88
    Width = 225
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object CheckBox1: TCheckBox
    Left = 56
    Top = 24
    Width = 169
    Height = 17
    Caption = #20801#35768#35813#26426#22120#30331#38470
    TabOrder = 3
  end
  object ComboCategory: TComboBox
    Left = 56
    Top = 56
    Width = 225
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = #28201#24030
    Items.Strings = (
      #28201#24030
      #26477#24030
      #20048#28165
      #21271#20140)
  end
end

object FrmSelDate: TFrmSelDate
  Left = 415
  Top = 202
  ActiveControl = BtnConfirm
  BorderStyle = bsDialog
  Caption = #36873#25321#26085#26399
  ClientHeight = 106
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 201
    Height = 106
    ActivePage = TabSheet1
    Align = alLeft
    TabOrder = 0
    object TabSheet1: TTabSheet
      object Label1: TLabel
        Left = 120
        Top = 24
        Width = 32
        Height = 13
        Caption = 'Label1'
      end
      object CmbDate: TComboBox
        Left = 48
        Top = 24
        Width = 65
        Height = 21
        Style = csDropDownList
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          '1'
          '2'
          '2'
          '3')
      end
    end
  end
  object BtnCancel: TButton
    Left = 217
    Top = 56
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 1
  end
  object BtnConfirm: TButton
    Left = 217
    Top = 24
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 2
  end
end

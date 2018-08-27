object ClientPropFrm: TClientPropFrm
  Left = 223
  Top = 99
  BorderStyle = bsDialog
  Caption = #24448#26469#21333#20301'  '#23646#24615
  ClientHeight = 384
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 384
    Height = 345
    ActivePage = TabSheet1
    Align = alTop
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #24120#35268
    end
    object TabSheet2: TTabSheet
      Caption = #25253#20215
      ImageIndex = 1
    end
    object TabSheet3: TTabSheet
      Caption = #25104#20132
      ImageIndex = 2
    end
    object TabSheet4: TTabSheet
      Caption = #36130#21153
      ImageIndex = 3
    end
    object TabSheet5: TTabSheet
      Caption = #20854#23427
      ImageIndex = 4
    end
  end
  object Button2: TButton
    Left = 298
    Top = 355
    Width = 75
    Height = 21
    Caption = #24110#21161
    TabOrder = 1
  end
  object Button1: TButton
    Left = 213
    Top = 355
    Width = 75
    Height = 21
    Caption = #30830#23450'(&Y)'
    ModalResult = 1
    TabOrder = 2
  end
end

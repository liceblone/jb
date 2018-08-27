object colPropFrm: TcolPropFrm
  Left = 189
  Top = 97
  BorderStyle = bsDialog
  Caption = #21015#23646#24615
  ClientHeight = 378
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 415
    Height = 345
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    object TabSheet1: TTabSheet
      BorderWidth = 5
      Caption = ' '#24120#35268
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 397
        Height = 53
        Align = alTop
        Shape = bsBottomLine
      end
      object Label1: TLabel
        Left = 62
        Top = 19
        Width = 20
        Height = 13
        Caption = #21015':'
      end
      object Image1: TImage
        Left = 16
        Top = 10
        Width = 32
        Height = 32
        AutoSize = True
        Picture.Data = {
          055449636F6E0000010001002020100000000000E80200001600000028000000
          2000000040000000010004000000000000020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000000000000000000000000000000000008777777777777777777777
          0700000008FFFFFFFFFFFFFFFFFFFFFF70700000087777777777777777777777
          7070000008FFFFFFFFFFFFFFFFFFFFFF7070000008FFFFFFFFFFFFFFFFFFFFFF
          707000000877777777700777777777777070000008FFFFFFFFFF300FFFFFFFFF
          7070000008FFFFFFFFFFF3F008FFFFFF70700000087777777777773BF8000007
          7070000008FFFFFFFFFFFFF3FBF733307070000008FFFFFFFFFFFFFF3FBF7333
          00700000087777777777777773BBF7333400000008FFFFFFFFFFFFFFFF3FBB73
          3000000008FFFFFFFFFFFFFFFFF3FBF700000000087777777777777777773FB0
          0000400008FFFFFFFFFFFFFFFFFFF3000004440008FFFFFFFFFFFFFFFFFFFF0F
          004CC440087777777777777777777700F4C4CC4008FFFFFFFFFFFFFFFFFFFFF0
          0CCC4CC008FFFFFFFFFFFFFFFFFFFFFF4CBCC4C0087777777777777777777777
          4CCFCC4008FFFFFFFFFFFFFFFFFFFFFF74CCFCC008FFFFFFFFFFFFFFFFFFFFFF
          704CCBC00877777777777777777777777074CCF008FFFFFFFFFFFFFFFFFFFFFF
          70704CC008FFFFFFFFFFFFFFFFFFFFFF707004C008FFFFFFFFFFFFFFFFFFFFFF
          7070004008F0FF0FF0FF0FF0FF0FF0FF8070000008F0FF0FF0FF0FF0FF0FF0FF
          80700000008F88F88F88F88F88F88F88F8000000000000000000000000000000
          00000000E000003FC000001F8000000F8000000F8000000F8000000F8000000F
          8000000F8000000F8000000F8000000F8000000F8000000F8000000F80000007
          8000000380000001800000018000000180000001800000018000000180000001
          800000018000000180000001800000098000000D8000000F8000000FC000001F
          E492497F}
      end
      object Label11: TLabel
        Left = 267
        Top = 72
        Width = 33
        Height = 13
        Caption = #23485#24230':'
      end
      object Label5: TLabel
        Left = 22
        Top = 72
        Width = 46
        Height = 13
        Caption = #21487#35270#24615':'
      end
      object ComboBox1: TComboBox
        Left = 86
        Top = 16
        Width = 167
        Height = 19
        Style = csOwnerDrawFixed
        DropDownCount = 12
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox1Change
      end
      object GroupBox1: TGroupBox
        Left = 16
        Top = 102
        Width = 361
        Height = 76
        Caption = #21015#26631#39064
        TabOrder = 1
        object Label3: TLabel
          Left = 20
          Top = 21
          Width = 59
          Height = 13
          Caption = #32972#26223#39068#33394':'
        end
        object Label4: TLabel
          Left = 20
          Top = 47
          Width = 59
          Height = 13
          Caption = #23383#20307#39068#33394':'
        end
        object Label6: TLabel
          Left = 252
          Top = 46
          Width = 33
          Height = 13
          Caption = #22823#23567':'
        end
        object titleBgColorBox1: TColorBox
          Left = 83
          Top = 16
          Width = 147
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbPrettyNames]
          Ctl3D = True
          ItemHeight = 16
          ParentCtl3D = False
          TabOrder = 0
          OnChange = titleBgColorBox1Change
        end
        object titleFontColorBox1: TColorBox
          Left = 82
          Top = 42
          Width = 148
          Height = 22
          ItemHeight = 16
          TabOrder = 1
          OnChange = titleFontColorBox1Change
        end
        object titleFontSizeEdit1: TEdit
          Left = 288
          Top = 44
          Width = 61
          Height = 21
          TabOrder = 2
          OnChange = titleFontSizeEdit1Change
          OnKeyPress = widthEdit1KeyPress
        end
      end
      object GroupBox2: TGroupBox
        Left = 16
        Top = 195
        Width = 361
        Height = 99
        Caption = #21015#23454#20307
        TabOrder = 2
        object Label2: TLabel
          Left = 23
          Top = 17
          Width = 59
          Height = 13
          Caption = #23545#40784#26041#24335':'
        end
        object Label7: TLabel
          Left = 22
          Top = 42
          Width = 59
          Height = 13
          Caption = #32972#26223#39068#33394':'
        end
        object Label8: TLabel
          Left = 22
          Top = 69
          Width = 59
          Height = 13
          Caption = #23383#20307#39068#33394':'
        end
        object Label9: TLabel
          Left = 250
          Top = 68
          Width = 33
          Height = 13
          Caption = #22823#23567':'
        end
        object bgColorBox1: TColorBox
          Left = 82
          Top = 37
          Width = 207
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbPrettyNames]
          Ctl3D = True
          ItemHeight = 16
          ParentCtl3D = False
          TabOrder = 0
          OnChange = bgColorBox1Change
        end
        object fontColorBox1: TColorBox
          Left = 82
          Top = 64
          Width = 150
          Height = 22
          ItemHeight = 16
          TabOrder = 1
          OnChange = fontColorBox1Change
        end
        object RadioButton1: TRadioButton
          Left = 96
          Top = 16
          Width = 73
          Height = 17
          Caption = #24038#23545#40784
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = RadioButton1Click
        end
        object RadioButton2: TRadioButton
          Tag = 1
          Left = 164
          Top = 16
          Width = 63
          Height = 17
          Caption = #23621#20013
          TabOrder = 3
          OnClick = RadioButton1Click
        end
        object RadioButton3: TRadioButton
          Tag = 2
          Left = 220
          Top = 16
          Width = 68
          Height = 17
          Caption = #21491#23545#40784
          TabOrder = 4
          OnClick = RadioButton1Click
        end
        object fontSizeEdit1: TEdit
          Left = 287
          Top = 65
          Width = 63
          Height = 21
          TabOrder = 5
          OnChange = fontSizeEdit1Change
          OnKeyPress = widthEdit1KeyPress
        end
      end
      object widthEdit1: TEdit
        Left = 304
        Top = 69
        Width = 62
        Height = 21
        TabOrder = 3
        OnChange = widthEdit1Change
        OnKeyPress = widthEdit1KeyPress
      end
      object CheckBox1: TCheckBox
        Left = 263
        Top = 17
        Width = 97
        Height = 17
        Caption = #20165#26174#31034#21487#35270#21015
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object visRadioBtn1: TRadioButton
        Left = 78
        Top = 70
        Width = 49
        Height = 17
        Caption = #21487#35270
        TabOrder = 5
        OnClick = visRadioBtn1Click
      end
      object visRadioBtn2: TRadioButton
        Left = 142
        Top = 70
        Width = 73
        Height = 17
        Caption = #19981#21487#35270
        TabOrder = 6
        OnClick = visRadioBtn1Click
      end
    end
  end
  object Button1: TButton
    Left = 230
    Top = 353
    Width = 75
    Height = 21
    Caption = #30830#23450'(&Y)'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 315
    Top = 354
    Width = 75
    Height = 20
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 2
  end
end

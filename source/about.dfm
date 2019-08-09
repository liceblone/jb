object aboutFrm: TaboutFrm
  Left = 285
  Top = 194
  Width = 607
  Height = 329
  Caption = #20851#20110'...'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    599
    302)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 59
    Height = 13
    Caption = #29256#26412#35760#24405':'
  end
  object lblVersion: TLabel
    Left = 120
    Top = 16
    Width = 70
    Height = 13
    Caption = 'lblVersion'
  end
  object Memo1: TMemo
    Left = 16
    Top = 40
    Width = 572
    Height = 267
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      #29256#26412'5.0.6.10'
      #25171#24320#21457#31080#39044#24405#20837#20986#38169
      #25913#24050#20445#23384#21457#36135#21333#22791#27880#20986#38169
      ''
      '')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
end

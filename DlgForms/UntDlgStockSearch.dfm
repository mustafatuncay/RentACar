object FrmDlgStockSearch: TFrmDlgStockSearch
  Left = 281
  Top = 235
  BorderStyle = bsDialog
  Caption = 'FrmDlgStockSearch'
  ClientHeight = 317
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlCaption: TPanel
    Left = 0
    Top = 0
    Width = 494
    Height = 50
    Align = alTop
    BevelInner = bvLowered
    BorderWidth = 4
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Shape1: TShape
      Left = 6
      Top = 6
      Width = 482
      Height = 38
      Align = alClient
      Brush.Color = clGray
    end
    object CapImage: TImage
      Left = 6
      Top = 6
      Width = 50
      Height = 38
      Center = True
      Picture.Data = {
        07544269746D617036100000424D361000000000000036000000280000002000
        0000200000000100200000000000001000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008000
        0000FF000000FFFF0000FF00000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0080000000FF00
        0000FFFF0000FFFF0000FF00000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0080000000FF000000FFFF
        0000FFFF0000FF000000FF00000000000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0080000000FF000000FFFF0000FFFF
        0000FF000000FF00000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000080000000FF000000FFFF0000FFFF0000FF00
        0000FF000000000000000000000000000000000000000000000000000000FF00
        FF00808080000080800000808000008080000080800000808000008080000080
        8000008080000080800000808000008080000080800000808000008080000080
        8000008080000080800080000000FF000000FFFF0000FFFF0000FF000000FF00
        0000000000000080800000808000008080000080800000808000008080000000
        000080808000FFFFFF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF0080000000FF000000FFFF0000FFFF0000FF000000FF0000000000
        000000808000C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
        FF0080808000FF000000FFFF0000FFFF0000FF000000FF000000000000000080
        8000C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00008080000000
        000080808000FFFFFF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF008080
        8000C0C0C000FFFFFF00FFFF0000FF000000FF0000000000000000808000C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C000000000000000000000000000000000000000000080808000C0C0
        C000FFFFFF00C0C0C00080808000FF0000000000000000808000C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00008080000000
        000080808000FFFFFF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF000000
        0000000000008080000080800000808000008080000080800000000000000000
        0000C0C0C00080808000808080000000000000808000C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00C0C0C00000FFFF00C0C0C00000FFFF00808080008080
        0000C0C0C000FFFF0000C0C0C000FFFF0000C0C0C000FFFF0000808000008080
        000000000000808080000000000000808000C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00008080000000
        000080808000FFFFFF0000FFFF00C0C0C00000FFFF008080800080800000C0C0
        C000FFFF0000C0C0C000FFFF0000C0C0C000FFFF0000C0C0C000FFFF00008080
        0000808000000000000000808000C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00C0C0C00000FFFF00C0C0C00080808000C0C0C000FFFF
        0000FFFFFF00FFFF0000C0C0C000FFFF0000C0C0C000FFFF0000C0C0C000FFFF
        0000808000000000000080808000C0C0C000C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00008080000000
        000080808000FFFFFF0000FFFF00C0C0C00080808000C0C0C000FFFF0000FFFF
        FF00FFFF0000C0C0C000FFFF0000C0C0C000FFFF0000C0C0C000FFFF0000C0C0
        C000FFFF000080800000000000008080800000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00C0C0C00000FFFF0080808000FFFF0000FFFFFF00FFFF
        0000FFFFFF00FFFF0000C0C0C000FFFF0000C0C0C000FFFF0000C0C0C000FFFF
        0000C0C0C000808000000000000000808000C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00008080000000
        000080808000FFFFFF0000FFFF00C0C0C00080808000C0C0C000FFFF0000FFFF
        FF00FFFFFF00C0C0C000FFFF0000C0C0C000FFFF0000C0C0C000FFFF0000C0C0
        C000FFFF000080800000000000008080800000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00C0C0C00000FFFF0080808000FFFF0000FFFFFF00FFFF
        0000FFFFFF00FFFFFF00C0C0C000FFFF0000C0C0C000FFFF0000C0C0C000FFFF
        0000C0C0C000808000000000000000808000C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00008080000000
        000080808000FFFFFF0000FFFF00C0C0C00080808000C0C0C000FFFF0000FFFF
        FF00FFFFFF00FFFFFF00FFFF0000C0C0C000FFFF0000C0C0C000FFFF0000C0C0
        C000FFFF000080800000000000008080800000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00C0C0C00000FFFF00C0C0C00080808000FFFFFF00FFFF
        0000FFFFFF00FFFFFF00FFFFFF00FFFF0000C0C0C000FFFF0000C0C0C000FFFF
        0000C0C0C0000000000000808000C0C0C000C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00008080000000
        000080808000FFFFFF0000FFFF00C0C0C00000FFFF0080808000C0C0C000FFFF
        FF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000C0C0C000FFFF0000C0C0
        C000808000000000000000808000C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00C0C0C00000FFFF00C0C0C00000FFFF0080808000C0C0
        C000FFFFFF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF0000C0C0C0008080
        00000000000080808000C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00008080000000
        000080808000FFFFFF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF008080
        800080808000C0C0C000FFFF0000C0C0C000FFFF000080808000000000000000
        000080808000C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C0008080800080808000808080008080800000000000008080000080
        8000C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00008080000000
        000080808000FFFFFF0000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000008080000000
        000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF00
        FF0080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
        C000808080008080800080808000808080008080800080808000808080008080
        8000808080008080800080808000808080008080800080808000FF00FF00FF00
        FF00FF00FF0080808000FFFFFF0000FFFF00C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C0008080
        8000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0080808000FFFFFF0000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C00080808000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080808000FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF008080800080808000808080008080
        80008080800080808000808080008080800080808000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00}
      Transparent = True
    end
    object Label1: TLabel
      Left = 6
      Top = 6
      Width = 482
      Height = 38
      Align = alClient
      Alignment = taCenter
      Caption = 'Stok  Arama Formu'
      Color = clBtnFace
      Font.Charset = TURKISH_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 50
    Width = 494
    Height = 47
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object BtnAra: TSpeedButton
      Left = 407
      Top = 16
      Width = 70
      Height = 21
      Caption = 'Ara'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0080000000FFFF
        0000FF00000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000000000000000000080000000FFFF0000FF00
        0000FF0000000000000000000000000000000000000000000000FF00FF00FF00
        FF008080800080808000808080008080800080000000FFFF0000FF000000FF00
        0000C0C0C0008080800080808000808080000000000000000000FF00FF00FF00
        FF0080808000FFFFFF0000FFFF0080000000FFFF0000FF000000FF000000C0C0
        C00000FFFF00C0C0C00000FFFF00808080000000000000000000FF00FF008080
        8000000000000000000080808000C0C0C000FF000000FF000000C0C0C00000FF
        FF00C0C0C00000FFFF00C0C0C00000000000808080000000000080808000C0C0
        C000FFFF0000C0C0C000000000008080800080808000C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00080808000000000008080800000000000FFFFFF00FFFF
        0000C0C0C000FFFF0000C0C0C00000000000C0C0C00000FFFF00C0C0C00000FF
        FF00C0C0C00000FFFF0000000000808080008080800000000000FFFF0000FFFF
        FF00FFFF0000C0C0C000FFFF000000000000C0C0C000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF008080800000000000C0C0C0008080800000000000FFFFFF00FFFF
        0000FFFFFF00FFFF0000C0C0C00000000000C0C0C00080808000808080008080
        800080808000808080008080800000FFFF00808080000000000080808000FFFF
        FF00FFFF0000FFFFFF0000000000C0C0C00000FFFF00C0C0C00000FFFF00C0C0
        C00000FFFF00C0C0C00000FFFF00C0C0C0008080800000000000FF00FF008080
        80008080800000000000C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080800000000000FF00FF008080
        8000FFFFFF00C0C0C00000FFFF00C0C0C00000FFFF00C0C0C000FFFFFF008080
        80008080800080808000808080008080800080808000FF00FF00FF00FF00FF00
        FF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF008080800080808000808080008080800080808000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Margin = 5
      Transparent = False
      OnClick = BtnAraClick
    end
    object Label2: TLabel
      Left = 4
      Top = 4
      Width = 76
      Height = 13
      Caption = 'Arama T'#252'r'#252' : '
    end
    object Label3: TLabel
      Left = 180
      Top = 4
      Width = 41
      Height = 13
      Caption = 'Kriter : '
    end
    object cmbKriter: TComboBox
      Left = 4
      Top = 17
      Width = 173
      Height = 21
      Style = csDropDownList
      Ctl3D = False
      ItemHeight = 13
      ItemIndex = 0
      ParentCtl3D = False
      TabOrder = 1
      Text = #220'r'#252'n Ad'#305
      Items.Strings = (
        #220'r'#252'n Ad'#305
        #220'r'#252'n Stok Kodu'
        #220'r'#252'n Barkod')
    end
    object txtKiriter: TEdit
      Left = 180
      Top = 18
      Width = 221
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      OnKeyDown = txtKiriterKeyDown
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 291
    Width = 494
    Height = 26
    Align = alBottom
    AutoSize = True
    TabOrder = 2
    object btnTamam: TSpeedButton
      Left = 313
      Top = 1
      Width = 80
      Height = 24
      Caption = 'Tamam'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000080000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000800000008000000080000080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000080000000800000008000000080000080000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00008000000080000000800000008000000080000080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000800000008000008000000000FF0000008000000080000080000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00008000000080000080000000FF00FF0000FF000000800000008000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000FF00000080000080000000FF00FF00FF00FF0000FF0000008000000080
        000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FF00000080
        00000080000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FF
        0000008000000080000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000FF00000080000000800000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000FF000000800000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      Margin = 5
      Transparent = False
      OnClick = btnTamamClick
    end
    object Btniptal: TSpeedButton
      Left = 405
      Top = 1
      Width = 80
      Height = 24
      Caption = #304'ptal'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
        6666666666666666666666660000666668666666666666666666666666666666
        0000666608866666666666666686666666666666000066691086666688666666
        6888666666666666000066691088666008866666688866666886666600006669
        1108869110866666688886668888666600006666911089111066666666888868
        8888666600006666911191110666666666888888888666660000666669111110
        6666666666688888886666660000666666911108866666666666888886666666
        0000666666911110866666666666888888666666000066666911011088666666
        6668888888666666000066666910691108866666666888688886666600006666
        9106669110886666668886668888666600006666910666691108666666888666
        6888866600006666696666669106666666686666668886660000666666666666
        6966666666666666666866660000666666666666666666666666666666666666
        0000}
      Margin = 5
      NumGlyphs = 2
      Transparent = False
      OnClick = BtniptalClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 97
    Width = 494
    Height = 194
    Align = alClient
    DataSource = DSStokQuery
    TabOrder = 3
    TitleFont.Charset = TURKISH_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Color = 16777158
        Expanded = False
        FieldName = 'StockCode'
        ReadOnly = True
        Title.Caption = 'Stok Kod'
        Visible = True
      end
      item
        Color = 12320767
        Expanded = False
        FieldName = 'PartName'
        ReadOnly = True
        Title.Caption = #220'r'#252'n Ad'#305
        Width = 218
        Visible = True
      end
      item
        Color = 16777158
        Expanded = False
        FieldName = 'StockAmount'
        ReadOnly = True
        Title.Caption = 'Stok Miktar'#305
        Width = 110
        Visible = True
      end
      item
        Color = 12320767
        Expanded = False
        FieldName = 'Unit'
        Title.Caption = 'Birim'
        Visible = True
      end>
  end
  object StokQuery: TADOQuery
    Connection = Dm.ado1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'Select StockCode,PartName,StockAmount,Unit,BarCode,KDV from Stoc' +
        'k ')
    Left = 440
    Top = 12
  end
  object DSStokQuery: TDataSource
    DataSet = StokQuery
    Left = 400
    Top = 12
  end
end

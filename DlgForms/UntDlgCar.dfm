object FrmDlgCar: TFrmDlgCar
  Left = 610
  Top = 312
  ActiveControl = txtKiriter
  ClientHeight = 329
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 63
    Width = 481
    Height = 31
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object BtnAra: TSpeedButton
      Left = 408
      Top = 2
      Width = 57
      Height = 21
      Caption = 'Search'
      Margin = 5
      Transparent = False
      OnClick = BtnAraClick
    end
    object cmbKriter: TComboBox
      Left = 3
      Top = 4
      Width = 173
      Height = 21
      Style = csDropDownList
      Ctl3D = False
      ItemHeight = 13
      ItemIndex = 0
      ParentCtl3D = False
      TabOrder = 1
      Text = 'Car Model'
      Items.Strings = (
        'Car Model'
        'Reg No'
        'Car Group')
    end
    object txtKiriter: TEdit
      Left = 180
      Top = 4
      Width = 221
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      OnKeyDown = txtKiriterKeyDown
      OnKeyPress = txtKiriterKeyPress
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 303
    Width = 481
    Height = 26
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    object btnTamam: TSpeedButton
      Left = 313
      Top = 1
      Width = 80
      Height = 24
      Caption = 'Ok'
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
      Caption = 'Cancel'
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
    Top = 94
    Width = 481
    Height = 209
    Align = alClient
    DataSource = ds1
    TabOrder = 2
    TitleFont.Charset = TURKISH_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Sold'
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Model'
        ReadOnly = True
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RegNo'
        ReadOnly = True
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Grup'
        ReadOnly = True
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Type'
        ReadOnly = True
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sirano'
        Width = 50
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 481
    Height = 63
    Align = alTop
    Color = 15263976
    TabOrder = 3
    object Label7: TLabel
      Left = 70
      Top = 10
      Width = 202
      Height = 37
      Caption = 'CAR SEARCH'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = 6052956
      Font.Height = -32
      Font.Name = 'Franklin Gothic Heavy'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
  end
  object Qry1: TADOQuery
    Connection = Dm.cnn1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 448
    Top = 8
  end
  object ds1: TDataSource
    DataSet = Qry1
    Left = 416
    Top = 8
  end
end
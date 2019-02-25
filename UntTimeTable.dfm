object FrmTimeTable: TFrmTimeTable
  Left = 91
  Top = 50
  Caption = 'TIME TABLE'
  ClientHeight = 684
  ClientWidth = 1237
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 1237
    Height = 684
    ActivePage = TabGroups
    Align = alClient
    TabOrder = 0
    TabPosition = tpBottom
    OnChange = PageControlChange
    object TabGroups: TTabSheet
      Caption = 'Groups'
      object AdvListe: TAdvStringGrid
        Left = 0
        Top = 50
        Width = 1229
        Height = 608
        Cursor = crDefault
        Align = alClient
        ColCount = 10
        DefaultColWidth = 90
        DefaultRowHeight = 30
        FixedRows = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing]
        ParentFont = False
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ScrollBars = ssBoth
        ShowHint = True
        TabOrder = 0
        HoverRowCells = [hcNormal, hcSelected]
        OnGetAlignment = AdvListeGetAlignment
        OnGridHint = AdvListeGridHint
        OnCanEditCell = AdvListeCanEditCell
        OnSelectionChanged = AdvListeSelectionChanged
        HintShowLargeText = True
        HintShowSizing = True
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'MS Sans Serif'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = clSilver
        CellNode.TreeColor = clSilver
        ControlLook.FixedGradientFrom = clWhite
        ControlLook.FixedGradientTo = clBtnFace
        ControlLook.FixedGradientHoverFrom = 13619409
        ControlLook.FixedGradientHoverTo = 12502728
        ControlLook.FixedGradientHoverMirrorFrom = 12502728
        ControlLook.FixedGradientHoverMirrorTo = 11254975
        ControlLook.FixedGradientHoverBorder = 12033927
        ControlLook.FixedGradientDownFrom = 8816520
        ControlLook.FixedGradientDownTo = 7568510
        ControlLook.FixedGradientDownMirrorFrom = 7568510
        ControlLook.FixedGradientDownMirrorTo = 6452086
        ControlLook.FixedGradientDownBorder = 14007466
        ControlLook.ControlStyle = csWinXP
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Clear')
        FixedColWidth = 110
        FixedRowHeight = 30
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Navigation.AllowClipboardAlways = True
        PrintSettings.Time = ppTopRight
        PrintSettings.Date = ppTopRight
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.PageNr = ppBottomRight
        PrintSettings.Title = ppTopCenter
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'MS Sans Serif'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -19
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = [fsBold]
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Orientation = poLandscape
        PrintSettings.UseFixedHeight = True
        PrintSettings.UseFixedWidth = True
        PrintSettings.PageNumSep = '/'
        PrintSettings.NoAutoSize = True
        PrintSettings.NoAutoSizeRow = True
        PrintSettings.PrintGraphics = True
        SearchFooter.ColorTo = 15790320
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SelectionColor = clSilver
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.Column = 0
        SortSettings.HeaderColorTo = 16579058
        SortSettings.HeaderMirrorColor = 16380385
        SortSettings.HeaderMirrorColorTo = 16182488
        Version = '7.8.7.0'
        ColWidths = (
          110
          90
          90
          90
          90
          90
          90
          90
          90
          90)
        RowHeights = (
          30
          30
          30
          30
          30
          30
          30
          30
          30
          30)
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1229
        Height = 30
        Align = alTop
        Color = 15263976
        ParentBackground = False
        TabOrder = 1
        object SpeedButton3: TSpeedButton
          Left = 893
          Top = 3
          Width = 25
          Height = 23
          Hint = 'Al'#305'nan Sipari'#351' Bilgilerini Excel'#39'e Aktar'
          Glyph.Data = {
            26040000424D2604000000000000360000002800000012000000120000000100
            180000000000F003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF0080008080800080008080
            8000800080808000800080808000800080808000800080808000800080808000
            8000808080FFFFFF0000FFFFFF80808000800080808000800080808000800080
            8080008000808080008000808080008000808080008000808080008000FFFFFF
            0000FFFFFF008000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008000808080FFFFFF0000FFFFFF808080
            008000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8080800080008080
            80008000808080808080008000FFFFFF0000FFFFFF008000808080FFFFFF0080
            00808080008000808080008000808080008000FFFFFF00800080808000800000
            8000808080FFFFFF0000FFFFFF808080008000FFFFFF80808000800080808000
            8000808080008000FFFFFF008000808080008000FFFFFF808080008000FFFFFF
            0000FFFFFF008000808080FFFFFF008000808080008000808080008000FFFFFF
            008000808080008000808080FFFFFF008000808080FFFFFF0000FFFFFF808080
            008000FFFFFFFFFFFF008000808080008000FFFFFF0080008080800080008080
            80008000FFFFFF808080008000FFFFFF0000FFFFFF008000808080FFFFFFFFFF
            FFFFFFFF008000FFFFFF008000808080008000808080FFFFFFFFFFFFFFFFFF00
            8000808080FFFFFF0000FFFFFF808080008000FFFFFFFFFFFF008000FFFFFF00
            8000808080008000808080008000808080FFFFFFFFFFFF808080008000FFFFFF
            0000FFFFFF008000808080FFFFFF008000FFFFFF008000808080008000808080
            008000808080008000808080FFFFFF008000808080FFFFFF0000FFFFFF808080
            008000FFFFFF808080008000808080008000808080FFFFFF8080800080008080
            80008000FFFFFF808080008000FFFFFF0000FFFFFF008000808080FFFFFF0080
            00808080008000808080FFFFFFFFFFFFFFFFFF808080008000808080FFFFFF00
            8000808080FFFFFF0000FFFFFF808080008000FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080008000FFFFFF
            0000FFFFFF008000808080008000808080008000808080008000808080008000
            808080008000808080008000808080008000808080FFFFFF0000FFFFFF808080
            0080008080800080008080800080008080800080008080800080008080800080
            00808080008000808080008000FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000}
          ParentShowHint = False
          ShowHint = True
          Visible = False
          OnClick = SpeedButton3Click
        end
        object Label1: TLabel
          Left = 71
          Top = 8
          Width = 35
          Height = 13
          Caption = 'Dates :'
        end
        object BtnList: TSpeedButton
          Left = 1
          Top = 4
          Width = 64
          Height = 22
          Caption = 'List'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            888800000000000088880FFFFFFFFFF088880F00F00000F088880FFFFFFFFFF0
            88880F00F00000F088880FFFFFFFFFF088880FFFFFFF0FF088880F00FFF080F0
            88880F080F08080008440FF08080808880440000080808888844888880808888
            8844888888088888804488888880000008448888888888888888}
          OnClick = BtnListClick
        end
        object Label2: TLabel
          Left = 953
          Top = 7
          Width = 33
          Height = 13
          Caption = 'Zoom :'
        end
        object SpeedButton8: TSpeedButton
          Left = 922
          Top = 3
          Width = 25
          Height = 23
          Glyph.Data = {
            26050000424D26050000000000003604000028000000100000000F0000000100
            080000000000F000000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
            A400000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
            0707070707070707070707070000000000000000000000070707070007070707
            0707070707000700070700000000000000000000000000070007000707070707
            07FBFBFB07070000000700070707070707101010070700070007000000000000
            0000000000000007070000070707070707070707070007000700070000000000
            00000000000700070000070700FFFFFFFFFFFFFFFF000700070007070700FF00
            00000000FF000000000707070700FFFFFFFFFFFFFFFF000707070707070700FF
            0000000000FF000707070707070700FFFFFFFFFFFFFFFF000707070707070700
            00000000000000000707}
          OnClick = SpeedButton8Click
        end
        object CmbColWidth: TComboBox
          Left = 1070
          Top = 3
          Width = 74
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 6
          TabOrder = 0
          Text = '%115'
          Visible = False
          OnChange = CmbColWidthCange
          Items.Strings = (
            '%10'
            '%25'
            '%50'
            '%75'
            '%100'
            '%110'
            '%115'
            '%120'
            '%125'
            '%150'
            '%200')
        end
        object CmbColWidth2: TComboBox
          Left = 992
          Top = 3
          Width = 73
          Height = 21
          ItemHeight = 13
          ItemIndex = 6
          TabOrder = 1
          Text = '19'
          Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '15'
            '17'
            '19'
            '20'
            '30'
            '40'
            '45'
            '50')
        end
        object Dt1: TDateTimePicker
          Left = 109
          Top = 5
          Width = 82
          Height = 21
          BevelInner = bvNone
          Date = 39719.955682523150000000
          Time = 39719.955682523150000000
          Color = 13303807
          TabOrder = 2
        end
        object Dt2: TDateTimePicker
          Left = 194
          Top = 5
          Width = 81
          Height = 21
          BevelInner = bvNone
          Date = 39719.955682581020000000
          Time = 39719.955682581020000000
          Color = 11202802
          TabOrder = 3
        end
        object CmbCustName: TComboBox
          Left = 638
          Top = 5
          Width = 120
          Height = 21
          Style = csDropDownList
          Color = 13303807
          ItemHeight = 13
          TabOrder = 4
          Visible = False
          OnChange = CmbCustNameChange
        end
        object CmbCustSurname: TComboBox
          Left = 760
          Top = 5
          Width = 122
          Height = 21
          Style = csDropDownList
          Color = 13303807
          ItemHeight = 13
          TabOrder = 5
          Visible = False
          OnChange = CmbCustSurnameChange
        end
        object ChkCust: TCheckBox
          Left = 583
          Top = 7
          Width = 16
          Height = 17
          TabOrder = 6
        end
        object Button1: TButton
          Left = 1126
          Top = -1
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 7
          Visible = False
          OnClick = Button1Click
        end
        object ChkCar: TCheckBox
          Left = 294
          Top = 8
          Width = 16
          Height = 17
          TabOrder = 8
        end
        object CmbCarKriter: TComboBox
          Left = 312
          Top = 5
          Width = 89
          Height = 21
          Style = csDropDownList
          Color = clWhite
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 9
          Text = 'Car Reg No'
          Items.Strings = (
            'Car Reg No'
            'Car Model')
        end
        object TxtCarKriter: TEdit
          Left = 402
          Top = 5
          Width = 121
          Height = 21
          TabOrder = 10
        end
        object Button3: TButton
          Left = 550
          Top = 3
          Width = 75
          Height = 25
          Caption = 'Reports'
          TabOrder = 11
          OnClick = Button3Click
        end
      end
      object Panel10: TPanel
        Left = 0
        Top = 30
        Width = 1229
        Height = 20
        Align = alTop
        Color = 15263976
        TabOrder = 2
        object RbGroup1: TRadioButton
          Left = 5
          Top = 2
          Width = 63
          Height = 17
          Caption = 'Group 1'
          Checked = True
          TabOrder = 0
          TabStop = True
        end
        object RbGroup2: TRadioButton
          Left = 71
          Top = 2
          Width = 66
          Height = 17
          Caption = 'Group 2'
          TabOrder = 1
        end
        object RbGroup3: TRadioButton
          Left = 141
          Top = 2
          Width = 66
          Height = 17
          Caption = 'Group 3'
          TabOrder = 2
        end
        object RbGroup4: TRadioButton
          Left = 207
          Top = 2
          Width = 66
          Height = 17
          Caption = 'Group 4'
          TabOrder = 3
        end
        object RbGroup5: TRadioButton
          Left = 279
          Top = 2
          Width = 66
          Height = 17
          Caption = 'Group 5'
          TabOrder = 4
        end
        object RbGroup6: TRadioButton
          Left = 351
          Top = 2
          Width = 66
          Height = 17
          Caption = 'Group 6'
          TabOrder = 5
        end
        object RbEmptyCars: TRadioButton
          Left = 527
          Top = 2
          Width = 90
          Height = 17
          Caption = 'Empty Cars'
          TabOrder = 6
          Visible = False
        end
        object RbGroup7: TRadioButton
          Left = 423
          Top = 2
          Width = 66
          Height = 17
          Caption = 'Group 7'
          TabOrder = 7
        end
      end
    end
    object TabJobReport: TTabSheet
      Caption = 'Daily Job Report'
      ImageIndex = 6
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 1229
        Height = 37
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          1229
          37)
        object SpeedButton4: TSpeedButton
          Left = 471
          Top = 6
          Width = 25
          Height = 25
          Anchors = []
          Glyph.Data = {
            26050000424D26050000000000003604000028000000100000000F0000000100
            080000000000F000000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
            A400000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
            0707070707070707070707070000000000000000000000070707070007070707
            0707070707000700070700000000000000000000000000070007000707070707
            07FBFBFB07070000000700070707070707101010070700070007000000000000
            0000000000000007070000070707070707070707070007000700070000000000
            00000000000700070000070700FFFFFFFFFFFFFFFF000700070007070700FF00
            00000000FF000000000707070700FFFFFFFFFFFFFFFF000707070707070700FF
            0000000000FF000707070707070700FFFFFFFFFFFFFFFF000707070707070700
            00000000000000000707}
          OnClick = SpeedButton4Click
          ExplicitLeft = 403
        end
        object Label16: TLabel
          Left = 41
          Top = 11
          Width = 30
          Height = 13
          Caption = 'Date :'
        end
        object BtnList8: TSpeedButton
          Left = 224
          Top = 9
          Width = 64
          Height = 22
          Caption = 'List'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            888800000000000088880FFFFFFFFFF088880F00F00000F088880FFFFFFFFFF0
            88880F00F00000F088880FFFFFFFFFF088880FFFFFFF0FF088880F00FFF080F0
            88880F080F08080008440FF08080808880440000080808888844888880808888
            8844888888088888804488888880000008448888888888888888}
          OnClick = BtnList8Click
        end
        object SpeedButton2: TSpeedButton
          Left = 507
          Top = 5
          Width = 25
          Height = 25
          Hint = 'Al'#305'nan Sipari'#351' Bilgilerini Excel'#39'e Aktar'
          Anchors = []
          Glyph.Data = {
            26040000424D2604000000000000360000002800000012000000120000000100
            180000000000F003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF0080008080800080008080
            8000800080808000800080808000800080808000800080808000800080808000
            8000808080FFFFFF0000FFFFFF80808000800080808000800080808000800080
            8080008000808080008000808080008000808080008000808080008000FFFFFF
            0000FFFFFF008000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008000808080FFFFFF0000FFFFFF808080
            008000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8080800080008080
            80008000808080808080008000FFFFFF0000FFFFFF008000808080FFFFFF0080
            00808080008000808080008000808080008000FFFFFF00800080808000800000
            8000808080FFFFFF0000FFFFFF808080008000FFFFFF80808000800080808000
            8000808080008000FFFFFF008000808080008000FFFFFF808080008000FFFFFF
            0000FFFFFF008000808080FFFFFF008000808080008000808080008000FFFFFF
            008000808080008000808080FFFFFF008000808080FFFFFF0000FFFFFF808080
            008000FFFFFFFFFFFF008000808080008000FFFFFF0080008080800080008080
            80008000FFFFFF808080008000FFFFFF0000FFFFFF008000808080FFFFFFFFFF
            FFFFFFFF008000FFFFFF008000808080008000808080FFFFFFFFFFFFFFFFFF00
            8000808080FFFFFF0000FFFFFF808080008000FFFFFFFFFFFF008000FFFFFF00
            8000808080008000808080008000808080FFFFFFFFFFFF808080008000FFFFFF
            0000FFFFFF008000808080FFFFFF008000FFFFFF008000808080008000808080
            008000808080008000808080FFFFFF008000808080FFFFFF0000FFFFFF808080
            008000FFFFFF808080008000808080008000808080FFFFFF8080800080008080
            80008000FFFFFF808080008000FFFFFF0000FFFFFF008000808080FFFFFF0080
            00808080008000808080FFFFFFFFFFFFFFFFFF808080008000808080FFFFFF00
            8000808080FFFFFF0000FFFFFF808080008000FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080008000FFFFFF
            0000FFFFFF008000808080008000808080008000808080008000808080008000
            808080008000808080008000808080008000808080FFFFFF0000FFFFFF808080
            0080008080800080008080800080008080800080008080800080008080800080
            00808080008000808080008000FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton2Click
          ExplicitLeft = 434
        end
        object Dt81: TDateTimePicker
          Left = 74
          Top = 10
          Width = 97
          Height = 21
          BevelInner = bvNone
          Date = 39719.955682673610000000
          Time = 39719.955682673610000000
          Color = 13303807
          TabOrder = 0
        end
      end
      object AdvListe8: TAdvStringGrid
        Left = 0
        Top = 37
        Width = 1229
        Height = 621
        Cursor = crDefault
        Align = alClient
        ColCount = 15
        Ctl3D = True
        DefaultColWidth = 40
        DefaultRowHeight = 28
        FixedCols = 0
        RowCount = 2
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ScrollBars = ssBoth
        ShowHint = True
        TabOrder = 1
        HoverRowCells = [hcNormal, hcSelected]
        OnGetAlignment = AdvListe8GetAlignment
        OnCanEditCell = AdvListe8CanEditCell
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'MS Sans Serif'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = 15387318
        CellNode.TreeColor = clSilver
        ColumnHeaders.Strings = (
          'TIME'
          'REG NO'
          'DELIVER TO'
          'T. DAYS'
          'PETROL'
          'OUTS. BALANCE'
          'END DATE'
          'NAME - SURNAME'
          'FLIGHT NO'
          'NOTE'
          'AGENCY'
          'BABY S.'
          'BOOSTER S.'
          'TEL NO')
        ControlLook.FixedGradientFrom = clWhite
        ControlLook.FixedGradientTo = clSilver
        ControlLook.FixedGradientHoverFrom = 13619409
        ControlLook.FixedGradientHoverTo = 12502728
        ControlLook.FixedGradientHoverMirrorFrom = 12502728
        ControlLook.FixedGradientHoverMirrorTo = 11254975
        ControlLook.FixedGradientDownFrom = 8816520
        ControlLook.FixedGradientDownTo = 7568510
        ControlLook.FixedGradientDownMirrorFrom = 7568510
        ControlLook.FixedGradientDownMirrorTo = 6452086
        ControlLook.FixedGradientDownBorder = 14007466
        ControlLook.ControlStyle = csWinXP
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Clear')
        FixedColWidth = 46
        FixedRowHeight = 28
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Look = glTMS
        Navigation.AllowClipboardAlways = True
        PrintSettings.Time = ppTopRight
        PrintSettings.Date = ppTopRight
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Title = ppTopCenter
        PrintSettings.TitleLines.Strings = (
          'JOB REPORT')
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'MS Sans Serif'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = TURKISH_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -19
        PrintSettings.HeaderFont.Name = 'Arial'
        PrintSettings.HeaderFont.Style = [fsBold]
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Orientation = poLandscape
        PrintSettings.PageNumSep = '/'
        PrintSettings.NoAutoSize = True
        PrintSettings.NoAutoSizeRow = True
        PrintSettings.PrintGraphics = True
        PrintSettings.UseDisplayFont = False
        ScrollWidth = 30
        SearchFooter.ColorTo = 15790320
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.Column = 0
        SortSettings.HeaderColorTo = 16579058
        SortSettings.HeaderMirrorColor = 16380385
        SortSettings.HeaderMirrorColorTo = 16182488
        Version = '7.8.7.0'
        ColWidths = (
          46
          58
          82
          61
          60
          103
          71
          114
          76
          46
          61
          60
          82
          55
          20)
        RowHeights = (
          28
          28)
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Daily Transfers Report'
      ImageIndex = 2
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1229
        Height = 44
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object SpeedButton5: TSpeedButton
          Left = 8
          Top = 16
          Width = 64
          Height = 22
          Caption = 'List'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            888800000000000088880FFFFFFFFFF088880F00F00000F088880FFFFFFFFFF0
            88880F00F00000F088880FFFFFFFFFF088880FFFFFFF0FF088880F00FFF080F0
            88880F080F08080008440FF08080808880440000080808888844888880808888
            8844888888088888804488888880000008448888888888888888}
          OnClick = SpeedButton5Click
        end
        object SpeedButton1: TSpeedButton
          Left = 317
          Top = 15
          Width = 25
          Height = 25
          Glyph.Data = {
            26050000424D26050000000000003604000028000000100000000F0000000100
            080000000000F000000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
            A400000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
            0707070707070707070707070000000000000000000000070707070007070707
            0707070707000700070700000000000000000000000000070007000707070707
            07FBFBFB07070000000700070707070707101010070700070007000000000000
            0000000000000007070000070707070707070707070007000700070000000000
            00000000000700070000070700FFFFFFFFFFFFFFFF000700070007070700FF00
            00000000FF000000000707070700FFFFFFFFFFFFFFFF000707070707070700FF
            0000000000FF000707070707070700FFFFFFFFFFFFFFFF000707070707070700
            00000000000000000707}
          OnClick = SpeedButton1Click
        end
        object SpeedButton7: TSpeedButton
          Left = 348
          Top = 15
          Width = 25
          Height = 25
          Hint = 'Al'#305'nan Sipari'#351' Bilgilerini Excel'#39'e Aktar'
          Glyph.Data = {
            26040000424D2604000000000000360000002800000012000000120000000100
            180000000000F003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFF0080008080800080008080
            8000800080808000800080808000800080808000800080808000800080808000
            8000808080FFFFFF0000FFFFFF80808000800080808000800080808000800080
            8080008000808080008000808080008000808080008000808080008000FFFFFF
            0000FFFFFF008000808080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008000808080FFFFFF0000FFFFFF808080
            008000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8080800080008080
            80008000808080808080008000FFFFFF0000FFFFFF008000808080FFFFFF0080
            00808080008000808080008000808080008000FFFFFF00800080808000800000
            8000808080FFFFFF0000FFFFFF808080008000FFFFFF80808000800080808000
            8000808080008000FFFFFF008000808080008000FFFFFF808080008000FFFFFF
            0000FFFFFF008000808080FFFFFF008000808080008000808080008000FFFFFF
            008000808080008000808080FFFFFF008000808080FFFFFF0000FFFFFF808080
            008000FFFFFFFFFFFF008000808080008000FFFFFF0080008080800080008080
            80008000FFFFFF808080008000FFFFFF0000FFFFFF008000808080FFFFFFFFFF
            FFFFFFFF008000FFFFFF008000808080008000808080FFFFFFFFFFFFFFFFFF00
            8000808080FFFFFF0000FFFFFF808080008000FFFFFFFFFFFF008000FFFFFF00
            8000808080008000808080008000808080FFFFFFFFFFFF808080008000FFFFFF
            0000FFFFFF008000808080FFFFFF008000FFFFFF008000808080008000808080
            008000808080008000808080FFFFFF008000808080FFFFFF0000FFFFFF808080
            008000FFFFFF808080008000808080008000808080FFFFFF8080800080008080
            80008000FFFFFF808080008000FFFFFF0000FFFFFF008000808080FFFFFF0080
            00808080008000808080FFFFFFFFFFFFFFFFFF808080008000808080FFFFFF00
            8000808080FFFFFF0000FFFFFF808080008000FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080008000FFFFFF
            0000FFFFFF008000808080008000808080008000808080008000808080008000
            808080008000808080008000808080008000808080FFFFFF0000FFFFFF808080
            0080008080800080008080800080008080800080008080800080008080800080
            00808080008000808080008000FFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFF0000}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton7Click
        end
        object ChkDate: TCheckBox
          Left = 78
          Top = 21
          Width = 45
          Height = 17
          Caption = 'Date'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = ChkDateClick
        end
        object DtTransfer: TDateTimePicker
          Left = 126
          Top = 19
          Width = 93
          Height = 21
          BevelInner = bvNone
          Date = 39719.955682847220000000
          Time = 39719.955682847220000000
          Color = 13303807
          TabOrder = 1
        end
        object Button2: TButton
          Left = 541
          Top = 13
          Width = 116
          Height = 25
          Caption = 'Eski Kod Silinecek'
          TabOrder = 2
          Visible = False
          OnClick = Button2Click
        end
      end
      object AdvListe2: TAdvStringGrid
        Left = 0
        Top = 44
        Width = 1229
        Height = 614
        Cursor = crDefault
        Align = alClient
        ColCount = 15
        Ctl3D = True
        DefaultColWidth = 40
        DefaultRowHeight = 28
        FixedCols = 0
        RowCount = 11
        Font.Charset = TURKISH_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ScrollBars = ssBoth
        ShowHint = True
        TabOrder = 1
        HoverRowCells = [hcNormal, hcSelected]
        OnGetAlignment = AdvListe2GetAlignment
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'MS Sans Serif'
        ActiveCellFont.Style = [fsBold]
        ActiveCellColor = 15387318
        CellNode.TreeColor = clSilver
        ControlLook.FixedGradientFrom = clWhite
        ControlLook.FixedGradientTo = clSilver
        ControlLook.FixedGradientHoverFrom = 13619409
        ControlLook.FixedGradientHoverTo = 12502728
        ControlLook.FixedGradientHoverMirrorFrom = 12502728
        ControlLook.FixedGradientHoverMirrorTo = 11254975
        ControlLook.FixedGradientDownFrom = 8816520
        ControlLook.FixedGradientDownTo = 7568510
        ControlLook.FixedGradientDownMirrorFrom = 7568510
        ControlLook.FixedGradientDownMirrorTo = 6452086
        ControlLook.FixedGradientDownBorder = 14007466
        ControlLook.ControlStyle = csWinXP
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Clear')
        FixedColWidth = 77
        FixedRowHeight = 28
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Look = glTMS
        Navigation.AllowClipboardAlways = True
        PrintSettings.Time = ppTopRight
        PrintSettings.Date = ppTopRight
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Title = ppTopCenter
        PrintSettings.TitleLines.Strings = (
          'TRANSFER REPORT')
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -13
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'MS Sans Serif'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = TURKISH_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -24
        PrintSettings.HeaderFont.Name = 'Arial'
        PrintSettings.HeaderFont.Style = [fsBold]
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Orientation = poLandscape
        PrintSettings.FitToPage = fpShrink
        PrintSettings.PageNumSep = '/'
        PrintSettings.NoAutoSizeRow = True
        PrintSettings.PrintGraphics = True
        PrintSettings.UseDisplayFont = False
        ScrollWidth = 30
        SearchFooter.ColorTo = 15790320
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.Column = 0
        SortSettings.HeaderColorTo = 16579058
        SortSettings.HeaderMirrorColor = 16380385
        SortSettings.HeaderMirrorColorTo = 16182488
        Version = '7.8.7.0'
        ColWidths = (
          77
          72
          64
          86
          73
          93
          86
          85
          80
          80
          75
          123
          75
          55
          72)
        RowHeights = (
          28
          28
          28
          28
          28
          28
          28
          28
          28
          28
          28)
        object Image1: TImage
          Left = 982
          Top = 366
          Width = 96
          Height = 37
          Cursor = crHandPoint
          AutoSize = True
          Picture.Data = {
            0A544A504547496D616765EE120000FFD8FFE000104A46494600010200006400
            640000FFEC00114475636B7900010004000000500000FFE20C584943435F5052
            4F46494C4500010100000C484C696E6F021000006D6E74725247422058595A20
            07CE00020009000600310000616373704D534654000000004945432073524742
            0000000000000000000000000000F6D6000100000000D32D4850202000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000116370727400000150000000336465736300000184
            0000006C77747074000001F000000014626B707400000204000000147258595A
            00000218000000146758595A0000022C000000146258595A0000024000000014
            646D6E640000025400000070646D6464000002C400000088767565640000034C
            0000008676696577000003D4000000246C756D69000003F8000000146D656173
            0000040C0000002474656368000004300000000C725452430000043C0000080C
            675452430000043C0000080C625452430000043C0000080C7465787400000000
            436F70797269676874202863292031393938204865776C6574742D5061636B61
            726420436F6D70616E7900006465736300000000000000127352474220494543
            36313936362D322E310000000000000000000000127352474220494543363139
            36362D322E310000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000058595A2000000000
            0000F35100010000000116CC58595A2000000000000000000000000000000000
            58595A200000000000006FA2000038F50000039058595A200000000000006299
            0000B785000018DA58595A2000000000000024A000000F840000B6CF64657363
            000000000000001649454320687474703A2F2F7777772E6965632E6368000000
            00000000000000001649454320687474703A2F2F7777772E6965632E63680000
            0000000000000000000000000000000000000000000000000000000000000000
            00000000000000000000000064657363000000000000002E4945432036313936
            362D322E312044656661756C742052474220636F6C6F7572207370616365202D
            207352474200000000000000000000002E4945432036313936362D322E312044
            656661756C742052474220636F6C6F7572207370616365202D20735247420000
            000000000000000000000000000000000000000064657363000000000000002C
            5265666572656E63652056696577696E6720436F6E646974696F6E20696E2049
            454336313936362D322E3100000000000000000000002C5265666572656E6365
            2056696577696E6720436F6E646974696F6E20696E2049454336313936362D32
            2E31000000000000000000000000000000000000000000000000000076696577
            000000000013A4FE00145F2E0010CF140003EDCC0004130B00035C9E00000001
            58595A2000000000004C09560050000000571FE76D6561730000000000000001
            000000000000000000000000000000000000028F000000027369672000000000
            4352542063757276000000000000040000000005000A000F00140019001E0023
            0028002D00320037003B00400045004A004F00540059005E00630068006D0072
            0077007C00810086008B00900095009A009F00A400A900AE00B200B700BC00C1
            00C600CB00D000D500DB00E000E500EB00F000F600FB01010107010D01130119
            011F0125012B01320138013E0145014C0152015901600167016E0175017C0183
            018B0192019A01A101A901B101B901C101C901D101D901E101E901F201FA0203
            020C0214021D0226022F02380241024B0254025D02670271027A0284028E0298
            02A202AC02B602C102CB02D502E002EB02F50300030B03160321032D03380343
            034F035A03660372037E038A039603A203AE03BA03C703D303E003EC03F90406
            04130420042D043B0448045504630471047E048C049A04A804B604C404D304E1
            04F004FE050D051C052B053A05490558056705770586059605A605B505C505D5
            05E505F6060606160627063706480659066A067B068C069D06AF06C006D106E3
            06F507070719072B073D074F076107740786079907AC07BF07D207E507F8080B
            081F08320846085A086E0882089608AA08BE08D208E708FB09100925093A094F
            09640979098F09A409BA09CF09E509FB0A110A270A3D0A540A6A0A810A980AAE
            0AC50ADC0AF30B0B0B220B390B510B690B800B980BB00BC80BE10BF90C120C2A
            0C430C5C0C750C8E0CA70CC00CD90CF30D0D0D260D400D5A0D740D8E0DA90DC3
            0DDE0DF80E130E2E0E490E640E7F0E9B0EB60ED20EEE0F090F250F410F5E0F7A
            0F960FB30FCF0FEC1009102610431061107E109B10B910D710F511131131114F
            116D118C11AA11C911E81207122612451264128412A312C312E3130313231343
            1363138313A413C513E5140614271449146A148B14AD14CE14F0151215341556
            1578159B15BD15E0160316261649166C168F16B216D616FA171D174117651789
            17AE17D217F7181B18401865188A18AF18D518FA19201945196B199119B719DD
            1A041A2A1A511A771A9E1AC51AEC1B141B3B1B631B8A1BB21BDA1C021C2A1C52
            1C7B1CA31CCC1CF51D1E1D471D701D991DC31DEC1E161E401E6A1E941EBE1EE9
            1F131F3E1F691F941FBF1FEA20152041206C209820C420F0211C2148217521A1
            21CE21FB22272255228222AF22DD230A23382366239423C223F0241F244D247C
            24AB24DA250925382568259725C725F726272657268726B726E827182749277A
            27AB27DC280D283F287128A228D429062938296B299D29D02A022A352A682A9B
            2ACF2B022B362B692B9D2BD12C052C392C6E2CA22CD72D0C2D412D762DAB2DE1
            2E162E4C2E822EB72EEE2F242F5A2F912FC72FFE3035306C30A430DB3112314A
            318231BA31F2322A3263329B32D4330D3346337F33B833F1342B3465349E34D8
            3513354D358735C235FD3637367236AE36E937243760379C37D738143850388C
            38C839053942397F39BC39F93A363A743AB23AEF3B2D3B6B3BAA3BE83C273C65
            3CA43CE33D223D613DA13DE03E203E603EA03EE03F213F613FA23FE240234064
            40A640E74129416A41AC41EE4230427242B542F7433A437D43C044034447448A
            44CE45124555459A45DE4622466746AB46F04735477B47C04805484B489148D7
            491D496349A949F04A374A7D4AC44B0C4B534B9A4BE24C2A4C724CBA4D024D4A
            4D934DDC4E254E6E4EB74F004F494F934FDD5027507150BB51065150519B51E6
            5231527C52C75313535F53AA53F65442548F54DB5528557555C2560F565C56A9
            56F75744579257E0582F587D58CB591A596959B85A075A565AA65AF55B455B95
            5BE55C355C865CD65D275D785DC95E1A5E6C5EBD5F0F5F615FB36005605760AA
            60FC614F61A261F56249629C62F06343639763EB6440649464E9653D659265E7
            663D669266E8673D679367E9683F689668EC6943699A69F16A486A9F6AF76B4F
            6BA76BFF6C576CAF6D086D606DB96E126E6B6EC46F1E6F786FD1702B708670E0
            713A719571F0724B72A67301735D73B87414747074CC7528758575E1763E769B
            76F8775677B37811786E78CC792A798979E77A467AA57B047B637BC27C217C81
            7CE17D417DA17E017E627EC27F237F847FE5804780A8810A816B81CD82308292
            82F4835783BA841D848084E3854785AB860E867286D7873B879F8804886988CE
            8933899989FE8A648ACA8B308B968BFC8C638CCA8D318D988DFF8E668ECE8F36
            8F9E9006906E90D6913F91A89211927A92E3934D93B69420948A94F4955F95C9
            9634969F970A977597E0984C98B89924999099FC9A689AD59B429BAF9C1C9C89
            9CF79D649DD29E409EAE9F1D9F8B9FFAA069A0D8A147A1B6A226A296A306A376
            A3E6A456A4C7A538A5A9A61AA68BA6FDA76EA7E0A852A8C4A937A9A9AA1CAA8F
            AB02AB75ABE9AC5CACD0AD44ADB8AE2DAEA1AF16AF8BB000B075B0EAB160B1D6
            B24BB2C2B338B3AEB425B49CB513B58AB601B679B6F0B768B7E0B859B8D1B94A
            B9C2BA3BBAB5BB2EBBA7BC21BC9BBD15BD8FBE0ABE84BEFFBF7ABFF5C070C0EC
            C167C1E3C25FC2DBC358C3D4C451C4CEC54BC5C8C646C6C3C741C7BFC83DC8BC
            C93AC9B9CA38CAB7CB36CBB6CC35CCB5CD35CDB5CE36CEB6CF37CFB8D039D0BA
            D13CD1BED23FD2C1D344D3C6D449D4CBD54ED5D1D655D6D8D75CD7E0D864D8E8
            D96CD9F1DA76DAFBDB80DC05DC8ADD10DD96DE1CDEA2DF29DFAFE036E0BDE144
            E1CCE253E2DBE363E3EBE473E4FCE584E60DE696E71FE7A9E832E8BCE946E9D0
            EA5BEAE5EB70EBFBEC86ED11ED9CEE28EEB4EF40EFCCF058F0E5F172F1FFF28C
            F319F3A7F434F4C2F550F5DEF66DF6FBF78AF819F8A8F938F9C7FA57FAE7FB77
            FC07FC98FD29FDBAFE4BFEDCFF6DFFFFFFEE002641646F62650064C000000001
            0300150403060A0D00000F5300001069000011B0000012ECFFDB008400020202
            0202020202020203020202030403020203040504040404040506050505050505
            060607070807070609090A0A09090C0C0C0C0C0C0C0C0C0C0C0C0C0C0C010303
            03050405090606090D0B090B0D0F0E0E0E0E0F0F0C0C0C0C0C0F0F0C0C0C0C0C
            0C0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CFFC2
            0011080025006003011100021101031101FFC400BD0001000300030000000000
            0000000000000005060701040801010101010101000000000000000000000006
            0405030710000104020201030500000000000000000003040515021430243213
            3306011112343511000004060102050500000000000000000001020391D13292
            0435113112304172B2742151B122231200020202020203000000000000000000
            00013132F0023081217111411213000201020603000301000000000000000001
            11F0F130213141C1D15171916181A1B1FFDA000C03010002110311000001D53E
            73F4FAEE1E80000000DE2CA1BCF915790F8F70000000DE2DA071E95B088C7B80
            000006EF6D0356F2F680C7B80000039369A693B5F638BD10000000590FFFDA00
            08010100010502959A92FAC85C4A9712A5C4A9712A5C4A9712A5C4A9712A5C4A
            9712A7C5A41CBD6D23FD0E2F86F8C87EFF0017C37C64A156C9E523B291D948EC
            A476523B291D948ECA476523B291D9F1B619314D6D5FCBA674CE99D33A674CE9
            9D33A674C6FE97DBFFDA000801020001050272E94F5369536953695369536953
            69536953695369536952396C94C5C7B9C515E2E3DCE28AF15E372CB3AB50AB50
            AB50AB50AB50AB50AB50AB50AB50AB5066DBD0C793FFDA00080103000105026A
            CD2F4B51135113511351135113511351135113511351124D0C53CDB7B5C531E4
            DBDAE298F26F2986185BA45BA45BA45BA45BA45BA45BA45BA45BA45BA43E75B1
            9727FFDA0008010202063F027E4B32CCB32CCB32CCB32CCB32CC7FA36F6F8F63
            6F6F8F61BD5C928944A25128944A251289479E5FFFDA0008010302063F02D7E5
            7D15455154551545515455154550BF3F66BE971EA6BE971EA2D764FC10F3B21E
            7643CEC879D90F3B21E7643CEC879D90F3B21E76788E5FFFDA0008010101063F
            02CB4B796E32DB4EA9B6D0D9F697093E3C86C322F31B0C8BCC6C322F31B0C8BC
            C6C322F31B0C8BCC6C322F31B0C8BCC6C322F31B0C8BCC3E9CA70DD532B22438
            7D7832F319DF21CF71F8797EA4FE0677C873DC7E1E5FA921F75A5A7B5D59AF85
            73D4FEBF615371390A9B89C854DC4E42A6E27215371390A9B89C854DC4E42A6E
            27215371390A9B89C839DEAEE5BA7CAB8E83F6EBE1FF0031FFDA000801010301
            3F2175D34A87D7F26E24A2F928BE4A2F928BE4A2F928BE4A2F928BE4A2F928BE
            4CF2AE0BCA86DE1AC40CF975CB13353FC33460F41A6C964DBE19B366CD9B366C
            D9B369242DDA12509293393F83DDFC5D9EEFE2ECF77F1767BBF8BB3DDFC5D9EE
            FE2ECF77F1767BBF8BB3DDFC5D8BF37F1767A03FFFDA0008010203013F2186A7
            4936B2CB4C8B81702E05C0B81702E05C0B817025A4C32BDE70FF00B115EF387F
            D88564869CE77FD32FAFA2FAFA2FAFA2FAFA2FAFA2FAFA2FAFA2FAFA2FAFA2FA
            FA1AC4D2DFCC5FFFDA0008010303013F219825B68DB79EB99624589162458916
            24589162458916245890EC48869B15EF0B0FF9195EF0B0FF0091939024651B7B
            68B6A16D42DA85B50B6A16D42DA85B50B6A16D41296908BF78BFFFDA000C0301
            0002110311000010D24924921400000002C00000006324924907800000024FFF
            DA0008010103013F107BCDEB4834CB513739BF10B0FB76EDDBB76EDDBB7676C5
            8654DD6621BCF389C90CDB5EADAF0E629D939B15092DF2AFAD6EF255A9387961
            3B76EDDBB76EDDBB4D706D8C4615A9D2226F56DB697AC85CC4A59C2764184184
            1841841841841841841824D44C0CBCA76649727FFFDA0008010203013F108FED
            899A433D9AB712E7FC2EFECBBFB2EFECBBFB2EFECBBFB2EFECBBFB2EFECBBFB1
            48C7524DEB0D68DEF1E75291E78750F0CA479E1D43C325E9106469B4B5948A74
            D30F1E3C78F1E3C78F1E35156E5C68850929CDFB85EB17FFDA0008010303013F
            104517C84D2AB76894C24BFD2A6E0A9B82A6E0A9B82A6E0A9B82A6E0A9B82A6E
            0A9B813AD58DA6E4E252DA6745965894A9DE56252A7794426C26AC9A484F309C
            253AE1922448912244891224D9B04A6252E5B71296D94BD35CF17FFFD9}
          Visible = False
          OnClick = Image1Click
        end
        object Label4: TLabel
          Left = 989
          Top = 374
          Width = 80
          Height = 16
          Cursor = crHandPoint
          Caption = 'Add Transfer'
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Visible = False
          OnClick = Image1Click
        end
        object cmbDriver: TComboBox
          Left = 813
          Top = 377
          Width = 84
          Height = 23
          BevelKind = bkSoft
          Color = 13303807
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ItemHeight = 15
          ParentFont = False
          TabOrder = 3
          Visible = False
          Items.Strings = (
            'Company'
            'V'#305'p')
        end
        object ChkDriver: TCheckBox
          Left = 831
          Top = 362
          Width = 66
          Height = 14
          Align = alCustom
          Alignment = taLeftJustify
          Caption = 'Driver'
          TabOrder = 4
          Visible = False
          OnClick = ChkFromDateClick
        end
        object cmbPaidTo: TComboBox
          Left = 716
          Top = 377
          Width = 84
          Height = 23
          BevelKind = bkSoft
          Color = 13303807
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ItemHeight = 15
          ParentFont = False
          TabOrder = 5
          Visible = False
          Items.Strings = (
            'Company'
            'V'#305'p')
        end
        object ChkPaidTo: TCheckBox
          Left = 734
          Top = 362
          Width = 66
          Height = 14
          Align = alCustom
          Alignment = taLeftJustify
          Caption = 'Paid To'
          TabOrder = 6
          Visible = False
          OnClick = ChkFromDateClick
        end
        object CmbAgency: TComboBox
          Left = 579
          Top = 377
          Width = 131
          Height = 22
          BevelKind = bkFlat
          Style = csDropDownList
          Color = 13303807
          ItemHeight = 14
          TabOrder = 7
          Visible = False
        end
        object ChkAgency: TCheckBox
          Left = 644
          Top = 362
          Width = 66
          Height = 14
          Align = alCustom
          Alignment = taLeftJustify
          Caption = 'Agency'
          TabOrder = 8
          Visible = False
          OnClick = ChkFromDateClick
        end
        object DtToDate: TDateTimePicker
          Left = 372
          Top = 376
          Width = 86
          Height = 23
          BevelInner = bvNone
          BevelOuter = bvNone
          Date = 39719.955683125000000000
          Time = 39719.955683125000000000
          Color = 13303807
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          Visible = False
        end
        object ChkToDate: TCheckBox
          Left = 389
          Top = 362
          Width = 69
          Height = 14
          Align = alCustom
          Alignment = taLeftJustify
          Caption = 'To Date'
          TabOrder = 10
          Visible = False
          OnClick = ChkToDateClick
        end
        object DtFromDate: TDateTimePicker
          Left = 261
          Top = 377
          Width = 86
          Height = 23
          BevelInner = bvNone
          BevelOuter = bvNone
          Date = 39719.955683356480000000
          Time = 39719.955683356480000000
          Color = 13303807
          Font.Charset = TURKISH_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 11
          Visible = False
        end
        object ChkFromDate: TCheckBox
          Left = 264
          Top = 363
          Width = 81
          Height = 14
          Align = alCustom
          Alignment = taLeftJustify
          Caption = 'From Date'
          TabOrder = 12
          Visible = False
          OnClick = ChkFromDateClick
        end
        object ChkPrice: TCheckBox
          Left = 469
          Top = 381
          Width = 97
          Height = 17
          Caption = 'Price Enabled'
          Checked = True
          State = cbChecked
          TabOrder = 13
          Visible = False
        end
      end
    end
  end
  object Qry1: TADOQuery
    Connection = Dm.cnn1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 512
    Top = 316
  end
  object PopupMenu1: TPopupMenu
    Left = 888
    Top = 286
    object Reservation1: TMenuItem
      Caption = 'Reservation'
      OnClick = Reservation1Click
    end
    object Uzatma1: TMenuItem
      Caption = 'Uzatma'
      Visible = False
      OnClick = Uzatma1Click
    end
    object Copy1: TMenuItem
      Caption = 'Copy'
      OnClick = Copy1Click
    end
    object Paste1: TMenuItem
      Caption = 'Paste'
      OnClick = Paste1Click
    end
    object Renklendirme1: TMenuItem
      Caption = 'Color Settings'
      object CarFontColor1: TMenuItem
        Caption = 'Car Font Color'
        OnClick = CarFontColor1Click
      end
      object cArBackColor1: TMenuItem
        Caption = 'Car Back Color'
        OnClick = cArBackColor1Click
      end
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Excel Dosyas'#305'|*.xls'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofEnableSizing]
    Left = 688
    Top = 283
  end
  object AdvGridExcelIO1: TAdvGridExcelIO
    AdvStringGrid = AdvListe8
    Options.ImportCellProperties = True
    Options.ImportLockedCellsAsReadonly = True
    Options.ExportOverwrite = omWarn
    Options.ExportOverwriteMessage = 'File %s already exists'#13'Ok to overwrite ?'
    Options.ExportHiddenColumns = True
    Options.ExportReadonlyCellsAsLocked = True
    Options.ExportWordWrapped = True
    Options.ExportRawRTF = False
    Options.ExportHardBorders = True
    Options.ExportSummaryRowsBelowDetail = True
    Options.ExportCellMargins = True
    UseUnicode = False
    Version = '3.13'
    Left = 984
    Top = 280
  end
  object AdvPreview: TAdvPreviewDialog
    CloseAfterPrint = True
    DialogCaption = 'Preview'
    DialogPrevBtn = 'Previous'
    DialogNextBtn = 'Next'
    DialogPrintBtn = 'Print'
    DialogCloseBtn = 'Close'
    Grid = AdvListe
    PreviewFast = False
    PreviewWidth = 1288
    PreviewHeight = 778
    PreviewLeft = -4
    PreviewTop = -4
    PreviewCenter = False
    Left = 768
    Top = 253
  end
  object XPManifest1: TXPManifest
    Left = 824
    Top = 248
  end
  object qry2: TADOQuery
    Connection = Dm.cnn1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 608
    Top = 308
  end
  object ColorDialog1: TColorDialog
    Left = 448
    Top = 329
  end
  object DataSource1: TDataSource
    DataSet = Qry1
    Left = 260
    Top = 246
  end
end

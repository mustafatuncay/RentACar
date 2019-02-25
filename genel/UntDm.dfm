object Dm: TDm
  OldCreateOrder = False
  Height = 309
  Width = 497
  object cnn1: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB.1'
    Left = 384
    Top = 80
  end
  object Qrylist: TADOQuery
    Connection = cnn1
    CursorType = ctStatic
    Parameters = <>
    Left = 424
    Top = 136
  end
  object Qrylist2: TADOQuery
    Connection = cnn1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select id,adi,aciklama from DersKayitlari')
    Left = 384
    Top = 136
  end
  object QryArama: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select id,adi,aciklama from DersKayitlari')
    Left = 384
    Top = 192
  end
end

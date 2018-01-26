object fOrganize: TfOrganize
  Left = 530
  Top = 192
  Width = 1015
  Height = 663
  ActiveControl = tv
  BorderStyle = bsSizeToolWin
  Caption = 'Organize favorites'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnl_btns: TPanel
    Left = 835
    Top = 0
    Width = 172
    Height = 636
    Align = alRight
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    DesignSize = (
      172
      636)
    object btn_add: TSpeedButton
      Left = 8
      Top = 8
      Width = 161
      Height = 25
      Action = act_add_script
    end
    object btn_sep: TSpeedButton
      Left = 8
      Top = 72
      Width = 161
      Height = 25
      Action = act_separator
    end
    object btn_remove: TSpeedButton
      Left = 8
      Top = 104
      Width = 161
      Height = 25
      Action = act_remove
    end
    object btn_grp: TSpeedButton
      Left = 8
      Top = 40
      Width = 161
      Height = 25
      Action = act_add_group
    end
    object btn_export: TSpeedButton
      Left = 8
      Top = 523
      Width = 161
      Height = 25
      Action = act_export
      Anchors = [akLeft, akBottom]
    end
    object btn_import: TSpeedButton
      Left = 8
      Top = 555
      Width = 161
      Height = 25
      Action = act_open_settings
      Anchors = [akLeft, akBottom]
    end
    object lbl1: TLabel
      Left = 8
      Top = 459
      Width = 55
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Menu name'
    end
    object lbl2: TLabel
      Left = 8
      Top = 419
      Width = 69
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'To the right of'
    end
    object btn_save: TSpeedButton
      Left = 8
      Top = 603
      Width = 161
      Height = 25
      Action = act_save_and_close
      Anchors = [akLeft, akBottom]
      NumGlyphs = 2
    end
    object chk_use_rel_path: TCheckBox
      Left = 8
      Top = 499
      Width = 105
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = 'Use relative path'
      TabOrder = 0
    end
    object edtMenuName: TEdit
      Left = 8
      Top = 475
      Width = 161
      Height = 21
      Anchors = [akLeft, akBottom]
      TabOrder = 1
      Text = 'edtMenuName'
    end
    object cbb_after_menu: TComboBox
      Left = 8
      Top = 435
      Width = 161
      Height = 21
      Anchors = [akLeft, akBottom]
      ItemHeight = 13
      TabOrder = 2
      Text = 'cbb_after_menu'
    end
  end
  object pnl_structure: TPanel
    Left = 0
    Top = 0
    Width = 835
    Height = 636
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnl_structure'
    TabOrder = 1
    object pnl_editor: TPanel
      Left = 0
      Top = 610
      Width = 835
      Height = 26
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      DesignSize = (
        835
        26)
      object lbl_script_file: TLabel
        Left = 8
        Top = 0
        Width = 67
        Height = 13
        Caption = 'Script location'
      end
      object btn_script_select: TSpeedButton
        Left = 801
        Top = 0
        Width = 23
        Height = 22
        Action = act_change_script
        AllowAllUp = True
        Anchors = [akTop, akRight]
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000
          0000008484000084840000848400008484000084840000848400008484000084
          84000084840000000000FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          FF00000000000084840000848400008484000084840000848400008484000084
          8400008484000084840000000000FF00FF00FF00FF00FF00FF0000000000FFFF
          FF0000FFFF000000000000848400008484000084840000848400008484000084
          840000848400008484000084840000000000FF00FF00FF00FF000000000000FF
          FF00FFFFFF0000FFFF0000000000008484000084840000848400008484000084
          84000084840000848400008484000084840000000000FF00FF0000000000FFFF
          FF0000FFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000000000FF
          FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
          FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFF
          FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFF
          FF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000FF
          FF00FFFFFF0000FFFF0000000000000000000000000000000000000000000000
          000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00000000000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FF00
          FF00FF00FF00FF00FF0000000000FF00FF0000000000FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
          00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
          FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      end
      object lbl_open_in: TLabel
        Left = 480
        Top = 0
        Width = 37
        Height = 13
        Caption = 'Open in'
        Visible = False
      end
      object edt_script_file: TEdit
        Left = 96
        Top = 0
        Width = 708
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object cbb_open_in: TComboBox
        Left = 568
        Top = 0
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        Visible = False
        Items.Strings = (
          'Default'
          'SQL Window'
          'Test Window'
          'Command Window'
          'Program Window')
      end
    end
    object tv: TTreeView
      Left = 0
      Top = 0
      Width = 835
      Height = 610
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BevelKind = bkSoft
      BevelWidth = 20
      DragMode = dmAutomatic
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      HideSelection = False
      Images = il_tv
      Indent = 19
      ParentFont = False
      TabOrder = 1
      OnChange = tvChange
      OnChanging = tvChanging
      OnDragDrop = tvDragDrop
      OnDragOver = tvDragOver
      OnEdited = tvEdited
      OnEditing = tvEditing
      Items.Data = {
        02000000270000000000000000000000FFFFFFFFFFFFFFFF0000000002000000
        0E4372656469742073637269707473200000000100000001000000FFFFFFFFFF
        FFFFFF00000000000000000753637269707431200000000100000001000000FF
        FFFFFFFFFFFFFF00000000000000000753637269707432220000000000000000
        000000FFFFFFFFFFFFFFFF00000000020000000950726F636573736573200000
        000100000001000000FFFFFFFFFFFFFFFF000000000000000007536372697074
        31200000000100000001000000FFFFFFFFFFFFFFFF0000000000000000075363
        7269707432}
    end
  end
  object il1: TImageList
    Left = 248
    Top = 104
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004040400040404000404040004040
      4000404040004040400040404000404040004040400040404000404040004040
      4000404040004040400040404000202020000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000BFBFBF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDFDF00DFDF
      DF00DFDFDF00DFDFDF00CFCFCF00404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000BFBFBF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00BFBFBF007F7F7F00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00DFDFDF00404040000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000848400008484000084840000848400008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000BFBFBF00FFFFFF00FFFF
      FF00FFFFFF00308F8F00305050003F5F5F00005F5F006F6F6F0000404000BFBF
      BF00FFFFFF00FFFFFF00DFDFDF00404040000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000FFFF00000000000084
      8400008484000084840000848400008484000084840000848400008484000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000BFBFBF00FFFFFF00FFFF
      FF009F9F9F00009F9F00005F5F00008080006F8F8F00007F7F006FAFAF003F3F
      3F00EFEFEF00FFFFFF00DFDFDF004040400000000000FFFFFF0000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      84000084840000000000000000000000000000000000FFFFFF0000FFFF000000
      0000008484000084840000848400008484000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000BFBFBF00FFFFFF00FFFF
      FF0000404000006060007FDFDF003F7F7F003F7F7F0030AFAF00005F5F000080
      80007F7F7F00FFFFFF00DFDFDF00404040000000000000FFFF00FFFFFF0000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000084840000848400008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000BFBFBF00FFFFFF00FFFF
      FF003F9F9F003F9F9F007FBFBF00BFBFBF0090909000204040006FEFEF003F7F
      7F00BFBFBF00FFFFFF00DFDFDF004040400000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000BFBFBF00FFFFFF00FFFF
      FF00FFFFFF003F7F7F007FFFFF00BFBFBF00909090003F5F5F003FDFDF007F7F
      7F00FFFFFF00FFFFFF00DFDFDF00404040000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000BFBFBF00FFFFFF00FFFF
      FF00FFFFFF00BFDFDF009FBFBF00AFAFAF00AFAFAF005F5F5F009FBFBF00FFFF
      FF00FFFFFF00FFFFFF00DFDFDF004040400000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000BFBFBF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DFDFDF00BFBFBF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00DFDFDF00404040000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A0009F9F9F00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF00BFBFBF00404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000A0606000A0606000A060
      6000A0606000A0606000A0606000A0606000A0606000A0606000806060006060
      6000606060006060600060606000404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A00080000000800000008000
      0000800000008000000080000000800000008000000080000000A06060006060
      6000C0C0C0006060600060606000404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000A0606000A0606000A060
      6000A0606000A0606000A0606000A0606000A0606000A0606000A0606000A060
      6000A0606000A0606000A0606000404040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004040400040404000404040004040
      4000404040004040400040404000404040004040400040404000404040004040
      4000404040004040400040404000202020000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF00000000FFFFFFFF0000
      0000001F001F00000000000F000F000000000007000700000000000300030000
      000000010001000000000000000000000000001F001F00000000001F001F0000
      0000001F001F000000008FF18FF100000000FFF9FFF900000000FF75FF750000
      0000FF8FFF8F00000000FFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object actlst1: TActionList
    Images = il1
    Left = 296
    Top = 104
    object act_settings: TAction
      Caption = 'Settings'
      ImageIndex = 0
      Visible = False
    end
    object act_add_script: TAction
      Caption = 'Add Script'
      OnExecute = act_add_scriptExecute
    end
    object act_change_script: TAction
      ImageIndex = 1
      OnExecute = act_change_scriptExecute
    end
    object act_add_group: TAction
      Caption = 'Add group'
      OnExecute = act_add_groupExecute
    end
    object act_separator: TAction
      Caption = 'Separator'
      OnExecute = act_separatorExecute
    end
    object act_remove: TAction
      Caption = 'Remove'
      OnExecute = act_removeExecute
    end
    object act_export: TAction
      Caption = 'Export'
      OnExecute = act_exportExecute
    end
    object act_open_settings: TAction
      Caption = 'Open settings'
      OnExecute = act_open_settingsExecute
    end
    object act_apply: TAction
      Caption = 'Apply'
    end
    object act_save_and_close: TAction
      Caption = 'Save and close'
      OnExecute = act_save_and_closeExecute
    end
  end
  object il_tv: TImageList
    Left = 128
    Top = 160
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000002020000040
      4000004040000040400000404000004040000040400000404000004040000020
      200000000000000000000000000000000000000000000000000000000000B7B7
      B700ADADAD00BABABA00C8C8C800D2D2D2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F0060DF
      DF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF000080
      8000002020000000000000000000000000000000000000000000CEC3C000A4A4
      9E008484800070706E006C6C6C00767676008484840092929200A4A4A400C8C8
      C800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F0060DF
      DF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF000080
      80000080800000202000000000000000000000000000C0787800CECAB600F2F4
      E900F2F4E900F3F5EB00F4F5EC00C9CAC400C1C1BD00A5A6A300939392009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F0060DF
      DF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF000080
      80000080800000404000000000000000000000000000C0787800D4CCBC00F2F4
      E9007F7F7E00BDBDBB00F4F6EC00F7F8F100FAFBF700FDFDFC00FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F0060DF
      DF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF000080
      80000080800000404000000000000000000000000000C0787800D9CEC100F2F4
      E900F2F4E900F2F4E900F4F6EC00F7F8F100FAFBF700FDFDFC00FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F0060DF
      DF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF0060DFDF000080
      80000080800000404000000000000000000000000000C0787800D8CABF00F2F4
      E9007F7F7E007F7F7E007F7F7E007F7F7E00BDBDBB00FFFFFF00FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00AFEF
      EF00AFEFEF00AFEFEF00AFEFEF00AFEFEF00AFEFEF00AFEFEF00AFEFEF000080
      80000080800000404000000000000000000000000000C0787800D4CDBE00F2F4
      E900F2F4E900F2F4E900F4F6EC00F7F8F100FAFBF700FDFDFC00FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000202020007FBFBF005F9F
      9F007FBFBF007FBFBF007FBFBF007FBFBF007FBFBF007FBFBF007FBFBF000020
      20000060600000404000000000000000000000000000C0787800D1D0BE00F2F4
      E9007F7F7E007F7F7E007F7F7E007F7F7E00BDBDBB00FFFFFF00FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DFDFDF00FFFFFF00DFDF
      DF00DFDFDF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000040
      40000060600000202000000000000000000000000000C0787800D5CDBF00F2F4
      E900F2F4E900F2F4E900F4F6EC00F7F8F100FAFBF700FDFDFC00FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003F3F3F00FFFFFF00FFFF
      FF009F9F9F007F7F7F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBFBF003F5F
      5F000080800000404000000000000000000000000000C0787800D5CEBF00F2F4
      E9007F7F7E007F7F7E007F7F7E00BDBDBB00FAFBF700FDFDFC00FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003F3F3F003F3F
      3F00000000003F3F3F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF003F5F5F003F5F5F003F3F3F000000000000000000C0787800D6CFC100F2F4
      E900F2F4E900F2F4E900F4F6EC00F7F8F100FAFBF700FDFDFC00FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009F9F9F00BFBFBF00BFBFBF00BFBFBF00BFBFBF00BFBF
      BF00BFBFBF00BFBFBF007F7F7F000000000000000000C0787800D0CDBB00F2F4
      E900F2F4E900F2F4E900F4F6EC00F7F8F100FAFBF700FDFDFC00FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F7F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000C0787800E2C6C4004269
      8600F2F4E90042698600F4F6EC0042698600FAFBF70042698600FFFFFF007171
      7100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003F3F3F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F000000000000000000E7CDCD00C1787800C178
      7800316B900091AABC006F798D00D3B6B9006F90A900BAB4BE005D829D00A8A8
      A800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004F9CBE004BBF
      D400316B90003E86A5004BBFD400637E94004BBFD4006D6E84005D829D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BBD5E100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00C00FE0FFFFFF0000C007C00FFFFF0000
      C003800FFFFF0000C003800FFFFF0000C003800FFFFF0000C003800FFFFF0000
      C003800FFFFF00008003800F000100000003800F000000008001800F80000000
      C001800FFFFF0000F800800FFFFF0000FC00800FFFFF0000FC00800FFFFF0000
      FFFFC01FFFFF0000FFFFFFBFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object flpn_script: TOpenDialog
    Filter = 'SQL scripts(*.sql)|*.sql|Test scripts(*.tst)|*.tst|All files|*.*'
    Options = [ofEnableSizing]
    Title = 'Select script'
    Left = 88
    Top = 216
  end
  object dlgSave_settings: TSaveDialog
    DefaultExt = '*.svfav'
    Filter = 'SV Favorite files|*.svfav'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 152
    Top = 216
  end
  object dlgOpen_settings: TOpenDialog
    DefaultExt = '*.svfav'
    Filter = 'SV Favorite files|*.svfav'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 152
    Top = 264
  end
  object tmr_show: TTimer
    OnTimer = tmr_showTimer
    Left = 200
    Top = 80
  end
end
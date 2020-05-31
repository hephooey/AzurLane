/* Free to use, Free for life.
	Made by panex0845 
*/ 
Version := 1001
VersionUrl := "https://raw.githubusercontent.com/panex0845/AzurLane/master/ChangeLog.md"
SettingName := "settings.ini"
Global SettingName
;@Ahk2Exe-SetName AzurLane Helper
;@Ahk2Exe-SetDescription AzurLane Helper
;@Ahk2Exe-SetVersion 1.0.0.1
;@Ahk2Exe-SetMainIcon img\01.ico
Loop, %0%  ; For each parameter:
{
	param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
	params .= A_Space . param
}
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"
if not A_IsAdmin
{
	If A_IsCompiled
	   DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
	Else
	   DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
	ExitApp
}
if FileExist("ChangeLog.md") 
	FileMove, ChangeLog.md, ChangeLog.txt, 1
if FileExist("README.md") 
	FileDelete, README.md

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance, force
#include Gdip.dll
#include Textfiles.dll
If !pToken := Gdip_Startup() {
   MsgBox "Gdiplus failed to start. Please ensure you have gdiplus on your system"
   ExitApp
}

Coordmode, pixel, window
CoordMode, Mouse, window
DetectHiddenWindows, On
DetectHiddenText, On
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_WorkingDir%  ; Ensures a consistent starting directory.
SetControlDelay, -1
SetBatchLines, 1000ms
SetTitleMatchMode, 3
Menu, Tray, NoStandard
Menu, tray, add, &顯示介面, Showsub
Menu, tray, add,  , 
Menu, tray, add, 檢查更新, IsUpdate2
Menu, tray, add,  , 
Menu, Tray, Default, &顯示介面
Menu, tray, add, 結束, Exitsub
Menu, Tray, Icon , img\01.ico,,, 1
Gui, font, s11 cFFFFFF, 新細明體

Run, %comspec% /c powercfg /change /monitor-timeout-ac 0,, Hide ;關閉螢幕省電模式

RegRead, ldplayer, HKEY_CURRENT_USER, Software\Changzhi\dnplayer-tw, InstallDir ; Ldplayer 3.76以下版本
if (ldplayer="") {
	RegRead, ldplayer, HKEY_CURRENT_USER, Software\Changzhi\LDPlayer, InstallDir ; Ldplayer 3.77以上版本
	if (ldplayer="") {
		RegRead, ldplayer, HKEY_CURRENT_USER, Software\XuanZhi\LDPlayer, InstallDir ; Ldplayer 4.0+ version
		if (ldplayer="") {
			MsgBox, 16, 設定精靈, 未能偵測到雷電模擬器的安裝路徑，請嘗試：`n`n1. 重新安裝模擬器。`n`n2. 手動指定路徑： Win+R → Regedit `n　HKEY_CURRENT_USER, Software\Changzhi\LDPlayer `n　底下新增 InstallDir
			MsgBox 0x21, 設定精靈, 未能找到到雷電模擬器路徑，是否繼續設定？
			IfMsgBox OK, {
				;////do notthing////////
			} Else IfMsgBox Cancel, {
				ExitApp
			}
		} else {
			MsgBox, 16, 設定精靈, 雷電模擬器4.0僅供測試使用，`n`n如遇到任何問題，建議更換3.x版本。
		}
	}
}
Global ldplayer

IniRead, title, %SettingName%, emulator, title, 
Global title
if (title="") or (title="ERROR") {
    InputBox, title, 設定精靈, `n`n　　　　　　　請輸入模擬器標題,, 400, 200,,,,, 雷電模擬器
    if ErrorLevel {
        Exitapp
    }
    else if  (title="") {
          Msgbox, 16, 設定精靈, 未輸入任何資訊。
          reload
    }
}
;~ Gui, Add, Picture, x0 y0 +0x4000000 ,img\WH.jpg
IniRead, azur_x, %SettingName%, Winposition, azur_x, 0
IniRead, azur_y, %SettingName%, Winposition, azur_y, 0
if azur_x=
	azur_x := 0
if azur_y=
	azur_y := 0
Try
{
	Gui, PicShow: +OwnDialogs +LastFound +HwndPicShowHwnd 
	gui, PicShow:add, text, x0 y0 w925 h500 ,  
	gui, PicShow:add, picture, x0 y0 w925 h500 , img\cover.jpg
	Gui, +OwnDialogs +LastFound +HwndMainHwnd +OwnerPicShow 
}
iniread, SetGuiBGcolor, %SettingName%, OtherSub, SetGuiBGcolor, 0
Iniread, SetGuiBGcolor2, %SettingName%, OtherSub, SetGuiBGcolor2, FFD2D2
iniread, SwitchGuiColor, %SettingName%, OtherSub, SwitchGuiColor, 深色
if (SetGuiBGcolor) {
	Gui, font, s11 c000000, 新細明體
	Gui, Color, %SetGuiBGcolor2%, %SetGuiBGcolor2%
} else {
	if (SwitchGuiColor="深色") {
		Gui, Color, 050505, 050505
	}
	else {
		if (SwitchGuiColor="淺色") {
			Gui, Color, F0F0F0, F0F0F0 
		} else if (SwitchGuiColor="粉色") {
			Gui, Color, FFD2D2, FFD2D2 
		} else if (SwitchGuiColor="紫色") {
			Gui, Color, F0C2EA, F0C2EA 
		} else if (SwitchGuiColor="黃色") {
			Gui, Color, FFFDBB, FFFDBB 
		} else if (SwitchGuiColor="藍色") {
			Gui, Color, BADDFF, BADDFF
		} else if (SwitchGuiColor="綠色") {
			Gui, Color, B9FFB6, B9FFB6
		}
		Gui, font, s11 c000000, 新細明體
	}
}
Gui Add, Text,  x15 y20 w100 h20 , 模擬器標題：
Gui Add, Edit, x110 y17 w100 h21 vtitle ginisettings , %title%
Gui, Add, Button, x20 y470 w100 h20 gstart vstart , 開始
Gui, Add, Button, x+20 y470 w100 h20 greload vreload, 停止
Gui, Add, Button, x+20 y470 w100 h20 gReAnchorSub vReAnchorSub, 再次出擊
Gui, Add, Button, x510 y470 w100 h20 gReSizeWindowSub vReSizeWindowSub, 調整視窗
Guicontrol, disable, start
Gui, Add, button, x810 y470 w100 h20 gexitsub, 結束 
Gui, Add, text, x513 y20 w400 h20 vstarttext, 
iniread, AnchorTimes, %SettingName%, Anchor, AnchorTimes, 0
iniread, AnchorFailedTimes, %SettingName%, Anchor, AnchorFailedTimes, 0
rate := Round(AnchorFailedTimes/AnchorTimes*100, 2)
Gui, Add, text, x513 y50 w420 h20 gResetAnchorTimes vAnchorTimesText, 出擊次數：%AnchorTimes% 次 ｜ 全軍覆沒：%AnchorFailedTimes% 次 ｜ 翻船機率： %rate%`%
Gui, Add, ListBox, x510 y74 w400 h393 ReadOnly vListBoxLog
Iniread, IsSwitchGuicolor, %SettingName%, OtherSub, IsSwitchGuicolor
if (IsSwitchGuicolor=1) {
	Gui,Add,Tab3, x10 y50 w490 h405 gTabFunc, 出　擊|出擊２|出擊３|學　院|後　宅|科　研|任　務|其　他||
	message = 更換主題：%SwitchGuiColor%。
	LogShow(message)
	Iniwrite, 0, %SettingName%, OtherSub, IsSwitchGuicolor
	
} else {
	Gui,Add,Tab3, x10 y50 w490 h405 gTabFunc, 出　擊||出擊２|出擊３|學　院|後　宅|科　研|任　務|其　他|
}
;///////////////////     GUI Right Side  Start  ///////////////////

Gui, Tab, 出　擊
Tab1_Y := 90
iniread, AnchorSub, %SettingName%, Battle, AnchorSub
Gui, Add, CheckBox, x30 y%Tab1_Y% w150 h20 gAnchorsettings vAnchorSub checked%AnchorSub% +cFF0044, 啟動自動出擊
Tab1_Y += 30
Gui, Add, text, x30 y%Tab1_Y% w80 h20  , 選擇地圖：
Tab1_Y -= 5
iniread, AnchorMode, %SettingName%, Battle, AnchorMode, 普通
AnchorModeList = 普通|困難|停用|
Gui, Add, DropDownList, x110 y%Tab1_Y% w60 h100 vAnchorMode gAnchorsettings, % MenuList(AnchorModeList, AnchorMode)
iniread, CH_AnchorChapter, %SettingName%, Battle, CH_AnchorChapter,1
iniread, AnchorChapter2, %SettingName%, Battle, AnchorChapter2
Tab1_Y += 5
Gui, Add, text, x180 y%Tab1_Y% w20 h20  , 第
Tab1_Y -= 5

AnchorChapterList = 1|2|3|4|5|6|7|8|9|10|凜冬1|凜冬2|紅染1|紅染2|希望1|異色1|異色2|墜落1|墜落2|光榮1|墨染1|墨染2|鳶尾1|鳶尾2|
StringReplace, AnchorChapterListSR, AnchorChapterList,%CH_AnchorChapter%,%CH_AnchorChapter%|
Gui, Add, DropDownList,  x200 y%Tab1_Y% w60 gAnchorsettings vAnchorChapter, %AnchorChapterListSR%

Tab1_Y += 5
Gui, Add, text, x270 y%Tab1_Y% w40 h20  , 章 第
Gui, Add, DropDownList, x310 y115 w40 h100 vAnchorChapter2 gAnchorsettings Choose%AnchorChapter2% , 1||2|3|4|
Gui, Add, text, x360 y%Tab1_Y% w20 h20  , 節


Tab1_Y += 35
Gui, Add, text, x30 y%Tab1_Y% w80 h20  , 出擊艦隊：
Tab1_Y -= 5
iniread, ChooseParty1, %SettingName%, Battle, ChooseParty1, 第一艦隊
ChooseParty1List = 第一艦隊|第二艦隊|第三艦隊|第四艦隊|第五艦隊|第六艦隊|
Gui, Add, DropDownList, x110 y%Tab1_Y% w90 h150 vChooseParty1 gAnchorsettings, % MenuList(ChooseParty1List, ChooseParty1)
Tab1_Y += 5
Gui, Add, text, x210 y%Tab1_Y% w15 h20  , 、
Tab1_Y -= 5
iniread, ChooseParty2, %SettingName%, Battle, ChooseParty2, 不使用
ChooseParty2List = 第一艦隊|第二艦隊|第三艦隊|第四艦隊|第五艦隊|第六艦隊|不使用|
Gui, Add, DropDownList, x230 y%Tab1_Y% w90 h150 vChooseParty2 gAnchorsettings, % MenuList(ChooseParty2List, ChooseParty2)
Tab1_Y += 32
iniread, SwitchPartyAtFirstTime, %SettingName%, Battle, SwitchPartyAtFirstTime
Gui, Add, CheckBox, x110 y%Tab1_Y% w190 h20 gAnchorsettings vSwitchPartyAtFirstTime checked%SwitchPartyAtFirstTime% , 進入地圖時交換隊伍順序
iniread, WeekMode, %SettingName%, Battle, WeekMode
Gui, Add, CheckBox, x310 y%Tab1_Y% w80 h20 gAnchorsettings vWeekMode checked%WeekMode% , 周回模式

Tab1_Y += 33
Gui, Add, text, x30 y%Tab1_Y% w80 h20, 偵查目標：
Tab1_Y += 25
Gui, Add, text, x30 y%Tab1_Y% w80 h20, (優先順序)
Tab1_Y -= 28 ;  Y = 207
iniread, Item_Bullet, %SettingName%, Battle, Item_Bullet, 1
iniread, Item_Quest, %SettingName%, Battle, Item_Quest, 1
iniread, Ship_Target1, %SettingName%, Battle, Ship_Target1, 1
iniread, Ship_Target2, %SettingName%, Battle, Ship_Target2, 1
iniread, Ship_Target3, %SettingName%, Battle, Ship_Target3, 1
iniread, Ship_Target4, %SettingName%, Battle, Ship_Target4, 1
iniread, Plane_Target1, %SettingName%, Battle, Plane_Target1, 0
iniread, Ship_TargetElite, %SettingName%, Battle, Ship_TargetElite, 0

iniread, Ship_Target1_S, %SettingName%, Battle, Ship_Target1_S, 1
iniread, Ship_Target2_S, %SettingName%, Battle, Ship_Target2_S, 2
iniread, Ship_Target3_S, %SettingName%, Battle, Ship_Target3_S, 3
iniread, Ship_Target4_S, %SettingName%, Battle, Ship_Target4_S, 4
iniread, Ship_TargetE_S, %SettingName%, Battle, Ship_TargetE_S, 5
iniread, Ship_TargetP_S, %SettingName%, Battle, Ship_TargetP_S, 6

Gui, Add, CheckBox, x110 y%Tab1_Y% w80 h20 gAnchorsettings vItem_Bullet checked%Item_Bullet% , 子彈補給
Gui, Add, CheckBox, x+10 y%Tab1_Y% w80 h20 gAnchorsettings vItem_Quest checked%Item_Quest% , 神秘物資
Tab1_Y += 30
Gui, Add, CheckBox, x110 y%Tab1_Y% w80 h20 gAnchorsettings vShip_Target1 checked%Ship_Target1% , 航空艦隊
Tab1_Y -= 3
Gui, Add, DropDownList, x+10 y%Tab1_Y% w30 h200 gAnchorsettings vShip_Target1_S Choose%Ship_Target1_S% , 1||2|3|4|5|6|
Tab1_Y += 3
Gui, Add, CheckBox, x+10 y%Tab1_Y% w80 h20 gAnchorsettings vShip_Target2 checked%Ship_Target2% , 運輸艦隊
Tab1_Y -= 3
Gui, Add, DropDownList, x+10 y%Tab1_Y% w30 h200 gAnchorsettings vShip_Target2_S Choose%Ship_Target2_S% , 1||2|3|4|5|6|
Tab1_Y += 3
Gui, Add, CheckBox, x+10 y%Tab1_Y% w80 h20 gAnchorsettings vShip_Target3 checked%Ship_Target3% , 主力艦隊
Tab1_Y -= 3
Gui, Add, DropDownList, x+10 y%Tab1_Y% w30 h200 gAnchorsettings vShip_Target3_S Choose%Ship_Target3_S% , 1||2|3|4|5|6|
Tab1_Y += 3
Tab1_Y += 30
Gui, Add, CheckBox, x110 y%Tab1_Y% w80 h20 gAnchorsettings vShip_Target4 checked%Ship_Target4% , 偵查艦隊
Tab1_Y -= 3
Gui, Add, DropDownList, x+10 y%Tab1_Y% w30 h200 gAnchorsettings vShip_Target4_S Choose%Ship_Target4_S% , 1||2|3|4|5|6|
Tab1_Y += 3
Gui, Add, CheckBox, x+10 y%Tab1_Y% w80 h20 gAnchorsettings vShip_TargetElite checked%Ship_TargetElite% , 賽任艦隊
Tab1_Y -= 3
Gui, Add, DropDownList, x+10 y%Tab1_Y% w30 h200 gAnchorsettings vShip_TargetE_S Choose%Ship_TargetE_S% , 1||2|3|4|5|6|
Tab1_Y += 3
Gui, Add, CheckBox, x+10 y%Tab1_Y% w80 h20 gAnchorsettings vPlane_Target1 checked%Plane_Target1% , 航空器
Tab1_Y -= 3
Gui, Add, DropDownList, x+10 y%Tab1_Y% w30 h200 gAnchorsettings vShip_TargetP_S Choose%Ship_TargetP_S% , 1||2|3|4|5|6|
Tab1_Y += 3
Tab1_Y += 33
Gui, Add, text, x30 y%Tab1_Y% w80 h20  , 受到伏擊：
iniread, Assault, %SettingName%, Battle, Assault, 規避
Tab1_Y -= 5
AssaultList = 規避|迎擊|
Gui, Add, DropDownList, x110 y%Tab1_Y% w60 h100 vAssault gAnchorsettings, % MenuList(AssaultList, Assault)
Tab1_Y += 5
Gui, Add, text, x+27 y%Tab1_Y% w80 h20  , 自律模式：
Tab1_Y -= 5
iniread, Autobattle, %SettingName%, Battle, Autobattle, 自動
AutobattleList = 自動|半自動|關閉|
	Gui, Add, DropDownList, x+8 y%Tab1_Y% w80 h100 vAutobattle gAnchorsettings, % MenuList(AutobattleList, Autobattle)

Tab1_Y += 35
Gui, Add, text, x30 y%Tab1_Y% w80 h20  , 遇到BOSS：
Tab1_Y -= 5
iniread, BossAction, %SettingName%, Battle, BossAction, 隨緣攻擊－當前隊伍
BossActionList = 隨緣攻擊－當前隊伍|隨緣攻擊－切換隊伍|優先攻擊－當前隊伍|優先攻擊－切換隊伍|能不攻擊就不攻擊|撤退|
Gui, Add, DropDownList, x110 y%Tab1_Y% w155 h150 vBossAction gAnchorsettings, % MenuList(BossActionList, BossAction)
Tab1_Y += 35
Gui, Add, text, x30 y%Tab1_Y% w80 h20  , 心情低落：
Tab1_Y -= 5
iniread, mood, %SettingName%, Battle, mood, 強制出戰
moodList = 強制出戰|不再出擊|休息1小時|休息2小時|休息3小時|休息5小時|
Gui, Add, DropDownList, x110 y%Tab1_Y% w90 h150 vmood gAnchorsettings, % MenuList(moodList, mood)
Tab1_Y += 35
iniread, Use_FixKit, %SettingName%, Battle, Use_FixKit
iniread, AlignCenter, %SettingName%, Battle, AlignCenter
Gui, Add, CheckBox, x30 y%Tab1_Y% w120 h20 gAnchorsettings vUse_FixKit checked%Use_FixKit% , 使用維修工具
Gui, Add, CheckBox, x160 y%Tab1_Y% w160 h20 gAnchorsettings vAlignCenter checked%AlignCenter% , 偵查時嘗試置中地圖

Tab1_Y += 28
iniread, BattleTimes, %SettingName%, Battle, BattleTimes, 0
Gui, Add, CheckBox, x30 y%Tab1_Y% w50 h20 gAnchorsettings vBattleTimes checked%BattleTimes% , 出擊
IniRead, BattleTimes2, %SettingName%, Battle, BattleTimes2, 20
Gui Add, Edit, x82 y%Tab1_Y% w40 h20 vBattleTimes2 gAnchorsettings Number Limit4, %BattleTimes2%
Tab1_Y += 3
Gui Add, Text,  x128 y%Tab1_Y% w90 h20 , 輪，強制休息
Tab1_Y -= 3
IniRead, TimetoBattle, %SettingName%, Battle, TimetoBattle, 0
Gui, Add, CheckBox, x230 y%Tab1_Y% w30 h20 gAnchorsettings vTimetoBattle checked%TimetoBattle% , 於 
IniRead, TimetoBattle1, %SettingName%, Battle, TimetoBattle1, 1302
IniRead, TimetoBattle2, %SettingName%, Battle, TimetoBattle2, 0102
Gui Add, Edit, x270 y%Tab1_Y% w40 h20 vTimetoBattle1 gAnchorsettings Number Limit4, %TimetoBattle1% ;指定的重新出擊時間 (24小時制)
Gui Add, Edit, x320 y%Tab1_Y% w40 h20 vTimetoBattle2 gAnchorsettings Number Limit4, %TimetoBattle2% ;指定的重新出擊時間(24小時制)
Tab1_Y += 3
Gui Add, Text,  x370 y%Tab1_Y% w90 h20 , 時，重新出擊
;~ Gui, Add, CheckBox, x30 y%Tab1_Y% w60 h20  checked%BattleTimes% , TEST

Gui, Tab, 出擊２
Tab2_Y := 90
Gui, Add, text, x30 y%Tab2_Y% w150 h20, 船䲧已滿：
Tab2_Y-=3
iniread, Shipsfull, %SettingName%, Battle, Shipsfull, 停止出擊
ShipsfullList = 整理船䲧|停止出擊|關閉遊戲|
Gui, Add, DropDownList, x110 y%Tab2_Y% w100 h100 vShipsfull gAnchorsettings, % MenuList(ShipsfullList, Shipsfull)

Tab2_Y+=3
Gui, Add, text, x220 y%Tab2_Y% w180 h20, 如整理，要退役的角色：
iniread, IndexAll, %SettingName%, Battle, IndexAll, 1 ;全部
iniread, Index1, %SettingName%, Battle, Index1 ;前排先鋒
iniread, Index2, %SettingName%, Battle, Index2 ;後排主力
iniread, Index3, %SettingName%, Battle, Index3 ;驅逐
iniread, Index4, %SettingName%, Battle, Index4 ;輕巡
iniread, Index5, %SettingName%, Battle, Index5 ;重巡
iniread, Index6, %SettingName%, Battle, Index6 ;戰列
iniread, Index7, %SettingName%, Battle, Index7 ;航母
iniread, Index8, %SettingName%, Battle, Index8 ;維修
iniread, Index9, %SettingName%, Battle, Index9 ;其他
Tab2_Y+=30
Gui, Add, text, x30 y%Tab2_Y% w50 h20  , 索　引
Tab2_Y-=3
Gui, Add, CheckBox, x80 y%Tab2_Y% w50 h20 gAnchorsettings vIndexAll checked%IndexAll% , 全部
Guicontrol, disable, IndexAll
Gui, Add, CheckBox, x130 y%Tab2_Y% w80 h20 gAnchorsettings vIndex1 checked%Index1% , 前排先鋒
Gui, Add, CheckBox, x210 y%Tab2_Y% w80 h20 gAnchorsettings vIndex2 checked%Index2% , 後排主力
Gui, Add, CheckBox, x290 y%Tab2_Y% w50 h20 gAnchorsettings vIndex3 checked%Index3% , 驅逐
Gui, Add, CheckBox, x340 y%Tab2_Y% w50 h20 gAnchorsettings vIndex4 checked%Index4% , 輕巡
Gui, Add, CheckBox, x390 y%Tab2_Y% w50 h20 gAnchorsettings vIndex5 checked%Index5% , 重巡
Tab2_Y+=25
Gui, Add, CheckBox, x80 y%Tab2_Y% w50 h20 gAnchorsettings vIndex6 checked%Index6% , 戰列
Gui, Add, CheckBox, x130 y%Tab2_Y% w50 h20 gAnchorsettings vIndex7 checked%Index7% , 航母
Gui, Add, CheckBox, x180 y%Tab2_Y% w50 h20 gAnchorsettings vIndex8 checked%Index8% , 維修
Gui, Add, CheckBox, x230 y%Tab2_Y% w50 h20 gAnchorsettings vIndex9 checked%Index9% , 其他

iniread, CampAll, %SettingName%, Battle, CampAll, 1 ;全部
iniread, Camp1, %SettingName%, Battle, Camp1 ;白鷹
iniread, Camp2, %SettingName%, Battle, Camp2 ;皇家
iniread, Camp3, %SettingName%, Battle, Camp3 ;重櫻
iniread, Camp4, %SettingName%, Battle, Camp4 ;鐵血
iniread, Camp5, %SettingName%, Battle, Camp5 ;東煌
iniread, Camp6, %SettingName%, Battle, Camp6 ;北方聯合
iniread, Camp7, %SettingName%, Battle, Camp7 ;其他
Tab2_Y+=30
Gui, Add, text, x30 y%Tab2_Y% w50 h20  , 陣　營
Tab2_Y-=3
Gui, Add, CheckBox, x80 y%Tab2_Y% w50 h20 gAnchorsettings vCampAll checked%CampAll% , 全部
Guicontrol, disable, CampAll
Gui, Add, CheckBox, x130 y%Tab2_Y% w50 h20 gAnchorsettings vCamp1 checked%Camp1% , 白鷹
Gui, Add, CheckBox, x180 y%Tab2_Y% w50 h20 gAnchorsettings vCamp2 checked%Camp2% , 皇家
Gui, Add, CheckBox, x230 y%Tab2_Y% w50 h20 gAnchorsettings vCamp3 checked%Camp3% , 重櫻
Gui, Add, CheckBox, x280 y%Tab2_Y% w50 h20 gAnchorsettings vCamp4 checked%Camp4% , 鐵血
Gui, Add, CheckBox, x330 y%Tab2_Y% w50 h20 gAnchorsettings vCamp5 checked%Camp5% , 東煌

Gui, Add, CheckBox, x380 y%Tab2_Y% w50 h20 gAnchorsettings vCamp6 checked%Camp6% , 北方
Gui, Add, CheckBox, x430 y%Tab2_Y% w50 h20 gAnchorsettings vCamp7 checked%Camp7% , 其他

iniread, RarityAll, %SettingName%, Battle, RarityAll, 1 ;全部
iniread, Rarity1, %SettingName%, Battle, Rarity1, 1 ;普通
iniread, Rarity2, %SettingName%, Battle, Rarity2, 1 ;稀有
iniread, Rarity3, %SettingName%, Battle, Rarity3, 0 ;精銳
iniread, Rarity4, %SettingName%, Battle, Rarity4, 0 ;超稀有
Tab2_Y+=30
Gui, Add, text, x30 y%Tab2_Y% w75 h20  , 稀有度：
Tab2_Y-=3
Gui, Add, CheckBox, x80 y%Tab2_Y% w50 h20 gAnchorsettings vRarityAll checked%RarityAll% , 全部
Guicontrol, disable, RarityAll
Gui, Add, CheckBox, x130 y%Tab2_Y% w50 h20 gAnchorsettings vRarity1 checked%Rarity1% , 普通
Gui, Add, CheckBox, x180 y%Tab2_Y% w50 h20 gAnchorsettings vRarity2 checked%Rarity2% , 稀有
Gui, Add, CheckBox, x230 y%Tab2_Y% w50 h20 gAnchorsettings vRarity3 checked%Rarity3% , 精銳
Gui, Add, CheckBox, x280 y%Tab2_Y% w75 h20 gAnchorsettings vRarity4 checked%Rarity4% , 超稀有
Guicontrol, disable, Rarity4

iniread, DailyGoalSub, %SettingName%, Battle, DailyGoalSub
Tab2_Y+=33 ;270
Gui, Add, CheckBox, x30 y%Tab2_Y% w200 h20 gAnchorsettings vDailyGoalSub checked%DailyGoalSub% , 自動執行每日任務：指派：
Tab2_Y-=2 ;268
iniread, DailyParty, %SettingName%, Battle, DailyParty, 第一艦隊
DailyPartyList = 第一艦隊|第二艦隊|第三艦隊|第四艦隊|第五艦隊|
Gui, Add, DropDownList, x240 y%Tab2_Y% w90 h150 vDailyParty gAnchorsettings, % MenuList(DailyPartyList, DailyParty)
iniread, DailyGoalRed, %SettingName%, Battle, DailyGoalRed, 1
iniread, DailyGoalRedAction, %SettingName%, Battle, DailyGoalRedAction
Tab2_Y+=30
Gui, Add, CheckBox, x50 y%Tab2_Y% w110 h20 gAnchorsettings vDailyGoalRed checked%DailyGoalRed% , 斬首行動：第
Tab2_Y-=2
Gui, Add, DropDownList, x+5 y%Tab2_Y% w40 h100 vDailyGoalRedAction gAnchorsettings Choose%DailyGoalRedAction% , 1||2|3|4|
Tab2_Y+=5
Gui, Add, text, x+5 y%Tab2_Y% w40 h20  , 關。
iniread, DailyGoalGreen, %SettingName%, Battle, DailyGoalGreen, 1
iniread, DailyGoalGreenAction, %SettingName%, Battle, DailyGoalGreenAction
Tab2_Y-=2
Gui, Add, CheckBox, x+10 y%Tab2_Y% w110 h20 gAnchorsettings vDailyGoalGreen checked%DailyGoalGreen% , 海域突進：第
Tab2_Y-=2
Gui, Add, DropDownList, x+5 y%Tab2_Y% w40 h100 vDailyGoalGreenAction gAnchorsettings Choose%DailyGoalGreenAction% , 1||2|3|4|
Tab2_Y+=5
Gui, Add, text, x+5 y%Tab2_Y% w40 h20  , 關。
iniread, DailyGoalBlue, %SettingName%, Battle, DailyGoalBlue, 1
iniread, DailyGoalBlueAction, %SettingName%, Battle, DailyGoalBlueAction
Tab2_Y+=23
Gui, Add, CheckBox, x50 y%Tab2_Y% w110 h20 gAnchorsettings vDailyGoalBlue checked%DailyGoalBlue% , 商船護衛：第
Tab2_Y-=2
Gui, Add, DropDownList, x+5 y%Tab2_Y% w40 h100 vDailyGoalBlueAction gAnchorsettings Choose%DailyGoalBlueAction% , 1||2|3|4|
Tab2_Y+=5
Gui, Add, text, x+5 y%Tab2_Y% w40 h20  , 關。
Tab2_Y-=3
iniread, DailyGoalSunday, %SettingName%, Battle, DailyGoalSunday, 1
Gui, Add, CheckBox, x+10 y%Tab2_Y% w140 h20 gAnchorsettings vDailyGoalSunday checked%DailyGoalSunday% , 禮拜日執行全部
Tab2_Y+=27
iniread, DailyHardMap, %SettingName%, Battle, DailyHardMap, 0
iniread, DailyHardMap2, %SettingName%, Battle, DailyHardMap2, 1
iniread, DailyHardMap3, %SettingName%, Battle, DailyHardMap3, 1
Gui, Add, CheckBox, x50 y%Tab2_Y% w110 h20 gAnchorsettings vDailyHardMap checked%DailyHardMap% , 困難地圖：第
Tab2_Y-=2
Gui, Add, DropDownList, x+5 y%Tab2_Y% w40 h170  gAnchorsettings vDailyHardMap2 Choose%DailyHardMap2% , 1||2|3|4|5|6|7|8|9|
Tab2_Y+=5
Gui, Add, text, x+5 y%Tab2_Y% w40 h20  , 章 第
Tab2_Y-=5
Gui, Add, DropDownList, x+5 y%Tab2_Y% w40 h170  gAnchorsettings vDailyHardMap3 Choose%DailyHardMap3% , 1||2|3|4|
Tab2_Y+=5
Gui, Add, text, x+10 y%Tab2_Y% w40 h20  , 節。
Tab2_Y-=3
iniread, OperationSub, %SettingName%, Battle, OperationSub
Tab2_Y+=33
Gui, Add, CheckBox, x30 y%Tab2_Y% w230 h20 gAnchorsettings vOperationSub checked%OperationSub% , 自動執行演習，選擇敵方艦隊：
Tab2_Y-=2
iniread, Operationenemy, %SettingName%, Battle, Operationenemy, 隨機的
OperationenemyList = 隨機的|最弱的|最左邊|最右邊|
Gui, Add, DropDownList, x260 y%Tab2_Y% w70 h150 vOperationenemy gAnchorsettings, % MenuList(OperationenemyList, Operationenemy)

Tab2_Y-=2
Gui, Add, button, x355 y%Tab2_Y% w100 h24 gResetOperationSub vResetOperation, 重置演習 

Tab2_Y+=30
IniRead, ResetOperationTime, %SettingName%, Battle, ResetOperationTime, 0
IniRead, ResetOperationTime2, %SettingName%, Battle, ResetOperationTime2, 1201, 1801, 0001
Gui, Add, CheckBox, x50 y%Tab2_Y% w120 h20 gAnchorsettings vResetOperationTime checked%ResetOperationTime% , 指定重置時間
Gui, Add, Edit, x170 y%Tab2_Y% w285 h20 gAnchorsettings vResetOperationTime2 , %ResetOperationTime2%
Tab2_Y+=28
IniRead, Operation_Only, %SettingName%, Battle, Operation_Only, 0
IniRead, Operation_OnlyNum, %SettingName%, Battle, Operation_OnlyNum, 5
Gui, Add, CheckBox, x70 y%Tab2_Y% w100 h20 gAnchorsettings vOperation_Only checked%Operation_Only% , 每次只執行
Tab2_Y-=2
Gui, Add, DropDownList, x+5 y%Tab2_Y% w40 h200 gAnchorsettings vOperation_OnlyNum choose%Operation_OnlyNum%, 1|2|3|4|5|6|7|8|9|
Tab2_Y+=5
Gui, Add, Text, x+10 y%Tab2_Y% w20 h20, 場
Tab2_Y-=3
IniRead, Operation_ReLogin, %SettingName%, Battle, Operation_ReLogin, 0
Gui, Add, CheckBox, x+10 y%Tab2_Y% w120 h20 gAnchorsettings vOperation_ReLogin checked%Operation_ReLogin% , 執行前先重登


Tab2_Y+=25
iniread, Leave_Operatio, %SettingName%, Battle, Leave_Operatio
Gui, Add, CheckBox, x50 y%Tab2_Y% w100 h20 gAnchorsettings vLeave_Operatio checked%Leave_Operatio% , 我方血量＜
IniRead, OperatioMyHpBar, %SettingName%, Battle, OperatioMyHpBar, 25
Gui, Add, Slider, x140 y%Tab2_Y% w50 h30 gAnchorsettings vOperatioMyHpBar range20-50 +ToolTip , %OperatioMyHpBar%
Tab2_Y+=2
Gui, Add, Text, x190 y%Tab2_Y% w20 h20 vOperatioMyHpBarUpdate , %OperatioMyHpBar% 
Gui, Add, Text, x210 y%Tab2_Y% w110 h20 vOperatioMyHpBarPercent, `%，敵艦血量＞
Tab2_Y-=2
IniRead, OperatioEnHpBar, %SettingName%, Battle, OperatioEnHpBar, 30
Gui, Add, Slider, x310 y%Tab2_Y% w50 h30 gAnchorsettings vOperatioEnHpBar range10-50 +ToolTip , %OperatioEnHpBar%
Tab2_Y+=2
Gui, Add, Text, x360 y%Tab2_Y% w20 h20 vOperatioEnHpBarUpdate , %OperatioEnHpBar% 
Gui, Add, Text, x380 y%Tab2_Y% w15 h20 vOperatioEnHpBarPercent, `%
Tab2_Y -= 3
iniread, Leave_OperatioDo, %SettingName%, Battle, Leave_OperatioDo, 更換對手
Leave_OperatioDoList = 更換對手|原隊重試|原隊重試2|原隊重試3|
Gui, Add, DropDownList, x+5 y%Tab2_Y% w90 h150 vLeave_OperatioDo gAnchorsettings, % MenuList(Leave_OperatioDoList, Leave_OperatioDo)




Gui, Tab, 出擊３
Tab_Y := 90
iniread, FightRoundsDo, %SettingName%, Battle, FightRoundsDo, 0
iniread, FightRoundsDo2, %SettingName%, Battle, FightRoundsDo2, 或沒子彈
iniread, FightRoundsDo3, %SettingName%, Battle, FightRoundsDo3, 更換艦隊Ｂ
Gui, Add, CheckBox, x30 y%Tab_Y% w120 h20 gAnchor3settings vFightRoundsDo checked%FightRoundsDo%, 艦隊Ａ每出擊
Tab_Y -= 2
FightRoundsDo2List = 1|2|3|4|5|6|7|8|9|10|或沒子彈|
Gui, Add, DropDownList, x150 y%Tab_Y% w85 h200 gAnchor3settings vFightRoundsDo2, % MenuList(FightRoundsDo2List, FightRoundsDo2)

Tab_Y +=5
Gui, Add, Text, x250 y%Tab_Y% w40 h20 , 次：
Tab_Y -=5
FightRoundsDo3List = 更換艦隊Ｂ|撤退|
	Gui, Add, DropDownList, x290 y%Tab_Y% w100 h200 gAnchor3settings vFightRoundsDo3, % MenuList(FightRoundsDo3List, FightRoundsDo3)
Tab_Y+=30
iniread, Retreat_LowHp, %SettingName%, Battle, Retreat_LowHp, 0
Gui, Add, CheckBox, x30 y%Tab_Y% w120 h20 gAnchor3settings vRetreat_LowHp checked%Retreat_LowHp% , 旗艦消耗高於
IniRead, Retreat_LowHpBar, %SettingName%, Battle, Retreat_LowHpBar, 30
Gui, Add, Slider, x140 y%Tab_Y% w100 h30 gAnchor3settings vRetreat_LowHpBar range15-90 +ToolTip , %Retreat_LowHpBar%
Tab_Y+=4
Gui, Add, Text, x240 y%Tab_Y% w20 h20 vRetreat_LowHpBarUpdate , %Retreat_LowHpBar% 
Gui, Add, Text, x260 y%Tab_Y% w120 h20 , `% 退出戰鬥，並
Tab_Y-=4
iniread, Retreat_LowHpDo, %SettingName%, Battle, Retreat_LowHpDo, 重新來過
Retreat_LowHpDoList= 重新來過|
	Gui, Add, DropDownList, x375 y%Tab_Y% w85 h200 gAnchor3settings vRetreat_LowHpDo, % MenuList(Retreat_LowHpDoList, Retreat_LowHpDo)

Tab_Y+=30
iniread, Stop_LowHp, %SettingName%, Battle, Stop_LowHp, 0
iniread, Stop_LowHP_SP, %SettingName%, Battle, Stop_LowHP_SP, 0
Gui, Add, CheckBox, x50 y%Tab_Y% w180 h20 gAnchor3settings vStop_LowHp checked%Stop_LowHp% , 討伐BOSS時不退出戰鬥
Gui, Add, CheckBox, x250 y%Tab_Y% w180 h20 gAnchor3settings vStop_LowHP_SP checked%Stop_LowHP_SP% , 更換隊伍後不退出戰鬥

Tab_Y+=30
iniread, Retreat_LowHp2, %SettingName%, Battle, Retreat_LowHp2, 0
Gui, Add, CheckBox, x30 y%Tab_Y% w175 h20 gAnchor3settings vRetreat_LowHp2 checked%Retreat_LowHp2% , 戰鬥結束，旗艦HP低於
IniRead, Retreat_LowHp2Bar, %SettingName%, Battle, Retreat_LowHp2Bar, 30
Gui, Add, Slider, x200 y%Tab_Y% w100 h30 gAnchor3settings vRetreat_LowHp2Bar range5-90 +ToolTip , %Retreat_LowHp2Bar%
Tab_Y+=4
Gui, Add, Text, x310 y%Tab_Y% w20 h20 vRetreat_LowHp2BarUpdate , %Retreat_Low2HpBar% 
Gui, Add, Text, x330 y%Tab_Y% w120 h20 , `% 
Tab_Y-=4
iniread, Retreat_LowHp2Do, %SettingName%, Battle, Retreat_LowHp2Do, 更換隊伍
Retreat_LowHp2DoList = 更換隊伍|撤退|
Gui, Add, DropDownList, x350 y%Tab_Y% w85 h200 gAnchor3settings vRetreat_LowHp2Do, % MenuList(Retreat_LowHp2DoList, Retreat_LowHp2Do)

;~ Tab_Y+=30
;~ iniread, Retreat_UT_LowHp, %SettingName%, Battle, Retreat_UT_LowHp, 0
;~ IniRead, Retreat_UT_LowHpBar, %SettingName%, Battle, Retreat_UT_LowHpBar, 30
;~ Gui, Add, CheckBox, x30 y%Tab_Y% w175 h20 gAnchor3settings vRetreat_UT_LowHp checked%Retreat_UT_LowHp% , 出擊隊伍：旗艦HP低於
;~ Gui, Add, Slider, x200 y%Tab_Y% w100 h30 gAnchor3settings vRetreat_UT_LowHpBar range5-90 +ToolTip , %Retreat_UT_LowHpBar%
;~ Tab_Y+=4
;~ Gui, Add, Text, x310 y%Tab_Y% w20 h20 vRetreat_UT_LowHpBarUpdate , %Retreat_UT_LowHpBar% 
;~ Gui, Add, Text, x330 y%Tab_Y% w120 h20 , `%
;~ Tab_Y-=4
;~ iniread, Retreat_UT_LowHpDo, %SettingName%, Battle, Retreat_UT_LowHpDo, 交換僚艦
;~ Retreat_UT_LowHpDoList = 交換僚艦|
;~ Gui, Add, DropDownList, x350 y%Tab_Y% w85 h200 gAnchor3settings vRetreat_UT_LowHpDo, % MenuList(Retreat_UT_LowHpDoList, Retreat_UT_LowHpDo)

Tab_Y+=30
iniread, Retreat_P1_LowHp, %SettingName%, Battle, Retreat_P1_LowHp, 0
IniRead, Retreat_P1_LowHpBar, %SettingName%, Battle, Retreat_P1_LowHpBar, 30
Gui, Add, CheckBox, x30 y%Tab_Y% w175 h20 gAnchor3settings vRetreat_P1_LowHp checked%Retreat_P1_LowHp% , 前衛 (P1)，出擊HP低於
Gui, Add, Slider, x200 y%Tab_Y% w100 h30 gAnchor3settings vRetreat_P1_LowHpBar range5-90 +ToolTip , %Retreat_P1_LowHpBar%
Tab_Y+=4
Gui, Add, Text, x310 y%Tab_Y% w20 h20 vRetreat_P1_LowHpBarUpdate , %Retreat_P1_LowHpBar% 
Gui, Add, Text, x330 y%Tab_Y% w120 h20 , `%
Tab_Y-=4
iniread, Retreat_P1_LowHpDo, %SettingName%, Battle, Retreat_P1_LowHpDo, 交換前衛
Retreat_P1_LowHpDoList = 交換前衛|
Gui, Add, DropDownList, x350 y%Tab_Y% w85 h200 gAnchor3settings vRetreat_P1_LowHpDo, % MenuList(Retreat_P1_LowHpDoList, Retreat_P1_LowHpDo)


Tab_Y+=30
iniread, Take_ItemQuest, %SettingName%, Battle, Take_ItemQuest, 0
iniread, Take_ItemQuestNum, %SettingName%, Battle, Take_ItemQuestNum, 3
Gui, Add, CheckBox, x30 y%Tab_Y% w120 h20 gAnchor3settings vTake_ItemQuest checked%Take_ItemQuest%, 拾取神秘物資
Tab_Y -= 2
	Gui, Add, DropDownList, x150 y%Tab_Y% w40 h200 gAnchor3settings vTake_ItemQuestNum  Choose%Take_ItemQuestNum%, 1|2|3||4|5|
Tab_Y +=5
Gui, Add, Text, x200 y%Tab_Y% w80 h20 , 次後撤退
Tab_Y += 25
iniread, StopBattleTime, %SettingName%, Battle, StopBattleTime, 0
Gui, Add, CheckBox, x30 y%Tab_Y% w70 h20 vStopBattleTime gAnchor3settings checked%StopBattleTime% , 每出擊
Tab_Y -= 2
iniread, StopBattleTime2, %SettingName%, Battle, StopBattleTime2, 5
Gui, Add, DropDownList, x100 y%Tab_Y% w40 h300 vStopBattleTime2 gAnchor3settings Choose%StopBattleTime2% , 1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|
Tab_Y += 5
Gui Add, Text,  x150 y%Tab_Y% w90 h20 , 輪，休息
Tab_Y -= 5
iniread, StopBattleTime3, %SettingName%, Battle, StopBattleTime3, 10
Tab_Y += 3
Gui, Add, Edit, x220 y%Tab_Y% w40 h20 vStopBattleTime3 gAnchor3settings Number Limit4, %StopBattleTime3%
Tab_Y += 3
Gui Add, Text,  x270 y%Tab_Y% w90 h20 , 分鐘

Gui, Tab, 學　院
Tab_Y := 90 ;///////////學院///////////////
iniread, AcademySub, %SettingName%, Academy, AcademySub, 0
Gui, Add, CheckBox, x30 y%Tab_Y% w150 h20 gAcademysettings vAcademySub checked%AcademySub% +cFF0044, 啟動自動學院
Tab_Y +=30
iniread, AcademyOil, %SettingName%, Academy, AcademyOil, 1
Gui, Add, CheckBox, x30 y%Tab_Y% w80 h20 gAcademysettings vAcademyOil checked%AcademyOil%, 採集石油
iniread, AcademyCoin, %SettingName%, Academy, AcademyCoin, 1
Gui, Add, CheckBox, x+20 y%Tab_Y% w80 h20 gAcademysettings vAcademyCoin checked%AcademyCoin%, 領取金幣
iniread, ClassRoom, %SettingName%, Academy, ClassRoom, 0
Gui, Add, CheckBox, x+20 y%Tab_Y% w100 h20 gAcademysettings vClassRoom checked%ClassRoom%, 大講堂上課
Tab_Y +=30
iniread, AcademyTactics, %SettingName%, Academy, AcademyTactics, 1
Gui, Add, CheckBox, x30 y%Tab_Y% w80 h20 gAcademysettings vAcademyTactics checked%AcademyTactics%, 學習技能
iniread, 150expbookonly, %SettingName%, Academy, 150expbookonly, 1
Gui, Add, CheckBox, x+20 y%Tab_Y% w210 h20 gAcademysettings v150expbookonly checked%150expbookonly%, 僅使用150`%經驗的課本
Tab_Y +=30
iniread, AcademyShop, %SettingName%, Academy, AcademyShop, 1
Gui, Add, CheckBox, x30 y%Tab_Y% w220 h20 gAcademysettings vAcademyShop checked%AcademyShop%, 購買補給：
Tab_Y +=30
Gui, Add, Text, x50 y%Tab_Y% h20, 軍火商(金幣)
iniread, SkillBook_ATK, %SettingName%, Academy, SkillBook_ATK, 1
iniread, SkillBook_DEF, %SettingName%, Academy, SkillBook_DEF, 1
iniread, SkillBook_SUP, %SettingName%, Academy, SkillBook_SUP, 1
iniread, Cube, %SettingName%, Academy, Cube, 1
iniread, Part_Aircraft, %SettingName%, Academy, Part_Aircraft, 0
iniread, Part_Cannon, %SettingName%, Academy, Part_Cannon, 0
iniread, Part_torpedo, %SettingName%, Academy, Part_torpedo, 0
iniread, Part_Anti_Aircraft, %SettingName%, Academy, Part_Anti_Aircraft, 0
iniread, Part_Common, %SettingName%, Academy, Part_Common, 0
iniread, Item_Equ_Box1, %SettingName%, Academy, Item_Equ_Box1, 0
iniread, Item_Water, %SettingName%, Academy, Item_Water, 0
iniread, Item_Tempura, %SettingName%, Academy, Item_Tempura, 0
Tab_Y +=30
Gui, Add, CheckBox, x50 y%Tab_Y% w80 h20 gAcademysettings vSkillBook_ATK checked%SkillBook_ATK%, 攻擊教材
Gui, Add, CheckBox, x140 y%Tab_Y% w80 h20 gAcademysettings vSkillBook_DEF checked%SkillBook_DEF%, 防禦教材
Gui, Add, CheckBox, x230 y%Tab_Y% w80 h20 gAcademysettings vSkillBook_SUP checked%SkillBook_SUP%, 輔助教材
Gui, Add, CheckBox, x320 y%Tab_Y% w80 h20 gAcademysettings vCube checked%Cube%, 心智魔方
Tab_Y +=30
Gui, Add, CheckBox, x50 y%Tab_Y% w115 h20 gAcademysettings vPart_Aircraft checked%Part_Aircraft%, 艦載機部件T3
Gui, Add, CheckBox, x170 y%Tab_Y% w100 h20 gAcademysettings vPart_Cannon checked%Part_Cannon%, 主砲部件T3
Gui, Add, CheckBox, x270 y%Tab_Y% w100 h20 gAcademysettings vPart_torpedo checked%Part_torpedo%, 魚雷部件T3
Gui, Add, CheckBox, x370 y%Tab_Y% w115 h20 gAcademysettings vPart_Anti_Aircraft checked%Part_Anti_Aircraft%, 防空砲部件T3
Tab_Y +=30
Gui, Add, CheckBox, x50 y%Tab_Y% w110 h20 gAcademysettings vPart_Common checked%Part_Common%, 共通部件T3
Gui, Add, CheckBox, x170 y%Tab_Y% w100 h20 gAcademysettings vItem_Equ_Box1 checked%Item_Equ_Box1%, 外觀裝備箱
Gui, Add, CheckBox, x270 y%Tab_Y% w100 h20 gAcademysettings vItem_Water checked%Item_Water%, 秘製冷卻水
Gui, Add, CheckBox, x370 y%Tab_Y% w80 h20 gAcademysettings vItem_Tempura checked%Item_Tempura%, 天婦羅
Tab_Y +=30
Gui, Add, Text, x50 y%Tab_Y% h20, 軍需商(功勳)
Tab_Y +=30
iniread, Item_Ex4_Box, %SettingName%, Academy, Item_Ex4_Box, 0
iniread, Item_Cube_2, %SettingName%, Academy, Item_Cube_2, 0
Gui, Add, CheckBox, x50 y%Tab_Y% w90 h20 gAcademysettings vItem_Ex4_Box checked%Item_Ex4_Box%, 科技箱T4
Gui, Add, CheckBox, x+10 y%Tab_Y% w90 h20 gAcademysettings vItem_Cube_2 checked%Item_Cube_2%, 心智魔方

Gui, Tab, 後　宅
Tab_Y :=90 ;////////////後宅//////////////
iniread, DormSub, %SettingName%, Dorm, DormSub, 0
Gui, Add, CheckBox, x30 y%Tab_Y% w150 h20 gDormsettings vDormSub checked%DormSub% +cFF0044, 啟動自動後宅
Tab_Y +=30
iniread, DormCoin, %SettingName%, Dorm, DormCoin, 1
Gui, Add, CheckBox, x30 y%Tab_Y% w110 h20 gDormsettings vDormCoin checked%DormCoin%, 領取傢俱幣
Tab_Y +=30
iniread, Dormheart, %SettingName%, Dorm, Dormheart, 1
Gui, Add, CheckBox, x30 y%Tab_Y% w130 h20 gDormsettings vDormheart checked%Dormheart%, 打撈海洋之心
Tab_Y +=30
iniread, DormFood, %SettingName%, Dorm, DormFood
Gui, Add, CheckBox, x30 y%Tab_Y% w80 h20 gDormsettings vDormFood checked%DormFood%, 糧食低於
Tab_Y -=2
IniRead, DormFoodBar, %SettingName%, Dorm, DormFoodBar, 80
Gui, Add, Slider, x110 y%Tab_Y% w100 h30 gDormsettings vDormFoodBar range10-80 +ToolTip , %DormFoodBar%
Tab_Y +=2
Gui, Add, Text, x215 y%Tab_Y% w20 h20 vDormFoodBarUpdate , %DormFoodBarUpdate% 
Gui, Add, Text, x240 y%Tab_Y% w100 h20 vTestbar1Percent, `%自動補給


Gui, Tab, 科　研
Tab_Y := 90
iniread, TechacademySub, %SettingName%, TechacademySub, TechacademySub
Gui, Add, CheckBox, x30 y%Tab_Y% w150 h20 gTechacademysettings vTechacademySub checked%TechacademySub% +cFF0044, 啟動自動執行科研
Tab_Y += 30
Gui, Add, Text, x30 y%Tab_Y% w150 h20, 研發項目／優先順序：
iniread, TechTarget_01, %SettingName%, TechacademySub, TechTarget_01, 1
iniread, TechTarget_02, %SettingName%, TechacademySub, TechTarget_02, 1
iniread, TechTarget_03, %SettingName%, TechacademySub, TechTarget_03, 1
iniread, TechTarget_04, %SettingName%, TechacademySub, TechTarget_04, 1
iniread, TechTarget_05, %SettingName%, TechacademySub, TechTarget_05, 1
iniread, TechTarget_06, %SettingName%, TechacademySub, TechTarget_06, 1
iniread, TechTarget_07, %SettingName%, TechacademySub, TechTarget_07, 1
iniread, PY_TechTarget_01, %SettingName%, TechacademySub, PY_TechTarget_01, 1
iniread, PY_TechTarget_02, %SettingName%, TechacademySub, PY_TechTarget_02, 1
iniread, PY_TechTarget_03, %SettingName%, TechacademySub, PY_TechTarget_03, 1
iniread, PY_TechTarget_04, %SettingName%, TechacademySub, PY_TechTarget_04, 1
iniread, PY_TechTarget_05, %SettingName%, TechacademySub, PY_TechTarget_05, 1
iniread, PY_TechTarget_06, %SettingName%, TechacademySub, PY_TechTarget_06, 1
iniread, PY_TechTarget_07, %SettingName%, TechacademySub, PY_TechTarget_07, 1
Tab_Y += 30
Gui, Add, CheckBox, x30 y%Tab_Y% w80 h20 gTechacademysettings vTechTarget_01 checked%TechTarget_01% , 定向研發
Gui, Add, DropDownList, x+10 y%Tab_Y% gTechacademysettings vPY_TechTarget_01 w40 h150 choose%PY_TechTarget_01% , 1||2|3|
Gui, Add, CheckBox,  x+25 y%Tab_Y% w80 h20 gTechacademysettings vTechTarget_02 checked%TechTarget_02% , 資金募集
Gui, Add, DropDownList, x+10 y%Tab_Y% gTechacademysettings vPY_TechTarget_02 w40 h150 choose%PY_TechTarget_02% , 1||2|3|
Gui, Add, CheckBox, x+25 y%Tab_Y% w80 h20 gTechacademysettings vTechTarget_03 checked%TechTarget_03% , 數據蒐集
Gui, Add, DropDownList, x+10 y%Tab_Y% gTechacademysettings vPY_TechTarget_03 w40 h150 choose%PY_TechTarget_03% , 1||2|3|
Tab_Y += 30
Gui, Add, CheckBox, x30 y%Tab_Y% w80 h20 gTechacademysettings vTechTarget_04 checked%TechTarget_04% , 艦裝解析
Gui, Add, DropDownList, x+10 y%Tab_Y% gTechacademysettings vPY_TechTarget_04 w40 h150 choose%PY_TechTarget_04% , 1||2|3|
Gui, Add, CheckBox, x+25 y%Tab_Y% w80 h20 gTechacademysettings vTechTarget_05 checked%TechTarget_05% , 研究委託
Gui, Add, DropDownList, x+10 y%Tab_Y% gTechacademysettings vPY_TechTarget_05 w40 h150 choose%PY_TechTarget_05% , 1||2|3|
Gui, Add, CheckBox, x+25 y%Tab_Y% w80 h20 gTechacademysettings vTechTarget_06 checked%TechTarget_06% , 試驗募集
Gui, Add, DropDownList, x+10 y%Tab_Y% gTechacademysettings vPY_TechTarget_06 w40 h150 choose%PY_TechTarget_06% , 1||2|3|
Tab_Y += 30
Gui, Add, CheckBox, x30 y%Tab_Y% w80 h20 gTechacademysettings vTechTarget_07 checked%TechTarget_07% , 基礎研究
Gui, Add, DropDownList, x+10 y%Tab_Y% gTechacademysettings vPY_TechTarget_07 w40 h150 choose%PY_TechTarget_07% , 1||2|3|


Gui, Tab, 任　務
Tab_Y := 90
iniread, MissionSub, %SettingName%, MissionSub, MissionSub
Gui, Add, CheckBox, x30 y%Tab_Y% w150 h20 gMissionsettings vMissionSub checked%MissionSub% +cFF0044, 啟動自動接收任務
Tab_Y += 30
Gui, Add, Text, x30 y%Tab_Y% w100 h20 , 軍事委託：
Tab_Y += 30
Gui, Add, Text, x30 y%Tab_Y%, 1. 消耗石油10點以上的任務不接取。`n`n2. 任務獎勵出現「石油」強制接取。`n`n3. 任務獎勵出現「紅尖尖」強制接取。
Tab_Y += 90
iniread, AutoBuild, %SettingName%, MissionSub, AutoBuild, 0
iniread, AutoBuild2, %SettingName%, MissionSub, AutoBuild2, 輕型艦
iniread, AutoBuild3, %SettingName%, MissionSub, AutoBuild3, 1
iniread, AutoExEqu, %SettingName%, MissionSub, AutoExEqu, 0
Gui, Add, CheckBox, x30 y%Tab_Y% w80 h20 gMissionsettings vAutoBuild checked%AutoBuild% , 每日建造
Tab_Y -= 3
AutoBuild2List = 輕型艦|重型艦|特型艦|限時艦|
Gui, Add, DropDownList, x+10 y%Tab_Y% w70 h200 gMissionsettings vAutoBuild2, % MenuList(AutoBuild2List, AutoBuild2)
Gui, Add, DropDownList, x+10 y%Tab_Y% w40 h200 gMissionsettings vAutoBuild3  choose%AutoBuild3% , 1||2|3|4|5|6|7|8|9|10|
Tab_Y += 5
Gui, Add, Text, x+10 y%Tab_Y%, 艘。
Tab_Y -= 3
Gui, Add, CheckBox, x+10 y%Tab_Y% w180 h20 gMissionsettings vAutoExEqu checked%AutoExEqu% , 強化最弱的裝備１次。

Gui, Tab, 其　他
Tab_Y := 90
Gui, Add, button, x30 y%TAB_Y% w120 h20 vdebug gDebug2, 測試取色
Gui, Add, button, x180 y%TAB_Y% w120 h20 gForumSub, GitHub
Gui, Add, button, x330 y%TAB_Y% w120 h20 gDiscordSub, Discord
Tab_Y += 30
;~ Gui, Add, Button, x30 y%TAB_Y% w120 h20 gResetAnchorTimes , 重置出擊次數
Gui, Add, Button, x30 y%TAB_Y% w120 h20 gMatchingGame , 記憶迴廊
Gui, Add, button, x180 y%TAB_Y% w120 h20 gDailyGoalSub2, 執行每日任務
Gui, Add, button, x330 y%TAB_Y% w120 h20 gOperationSub, 執行演習
;~ Tab_Y += 30
;~ Gui, Add, button, x180 y%TAB_Y% w120 h20 gIsUpdate, 檢查更新
;~ Gui, Add, button, x180 y%TAB_Y% w120 h20 gAutopuzzle, 自動拼圖
Tab_Y += 30
iniread, CheckUpdate, %SettingName%, OtherSub, CheckUpdate, 0
Gui, Add, Checkbox, x30 y%TAB_Y% w110 h20 gOthersettings vCheckUpdate checked%CheckUpdate% , 自動檢查更新
Tab_Y -= 3
iniread, CheckUpdateMode, %SettingName%, OtherSub, CheckUpdateMode, 正式版
CheckUpdateModeList = 正式版|測試版|
Gui, Add, DropDownList, x+5 y%Tab_Y% w75 h200 gOthersettings vCheckUpdateMode, % MenuList(CheckUpdateModeList, CheckUpdateMode)
Tab_Y += 3

iniread, GuiHideX, %SettingName%, OtherSub, GuiHideX
Gui, Add, CheckBox, x240 y%TAB_Y% w200 h20 gOthersettings vGuiHideX checked%GuiHideX% , 按X隱藏本視窗，而非關閉

Tab_Y += 30
iniread, EmulatorCrushCheck, %SettingName%, OtherSub, EmulatorCrushCheck
Gui, Add, CheckBox, x30 y%TAB_Y% w200 h20 gOthersettings vEmulatorCrushCheck checked%EmulatorCrushCheck% , 模擬器或輔助卡住自動重啟
iniread, AutoLogin, %SettingName%, OtherSub, AutoLogin
Gui, Add, CheckBox, x240 y%TAB_Y% w200 h20 gOthersettings vAutoLogin checked%AutoLogin% , 斷線自動重登(Google帳號)
Tab_Y += 30
iniread, DebugMode, %SettingName%, OtherSub, DebugMode, 0
Gui, Add, CheckBox, x30 y%TAB_Y% w125 h20 gOthersettings vDebugMode checked%DebugMode% , 除錯模式
Tab_Y += 30
Gui, Add, Text,  x30 y%TAB_Y%  w80 h20 , 主　　題：
Tab_Y -= 4
SwitchGuiColorList = 深色|淺色|粉色|黃色|綠色|藍色|紫色|
Gui, Add, DropDownList, x+2 y%Tab_Y% w60 h200 gGuiColorsettings vSwitchGuiColor, % MenuList(SwitchGuiColorList, SwitchGuiColor)
Tab_Y +=2
Gui, Add, CheckBox, x+15 y%TAB_Y% w70 h20 gOthersettings vSetGuiBGcolor checked%SetGuiBGcolor% , 自訂 0x
Tab_Y -= 1
Gui Add, Edit, x+5 y%TAB_Y% w70 h21 vSetGuiBGcolor2 gOthersettings Limit6, %SetGuiBGcolor2%
Gui Add, Button, x+15 y%TAB_Y% w110 h21 gHexadecimalSub , 色票查詢工具

Tab_Y += 32
Iniread, DwmMode, %SettingName%, OtherSub, DwmMode, 1
Iniread, GdiMode, %SettingName%, OtherSub, GdiMode, 0
Iniread, AHKMode, %SettingName%, OtherSub, AHKMode, 0
Gui, Add, Text,  x30 y%TAB_Y%  w100 h20 , 取色方式：
Tab_Y -= 3
Iniread, CloneWindowforDWM, %SettingName%, OtherSub, CloneWindowforDWM, 0
Gui, Add, Radio,  x110 y%TAB_Y% w60 h20 gOthersettings vDwmMode checked%DwmMode% , DWM

Gui, Add, Radio,  x180 y%TAB_Y% w50 h20 gOthersettings vGdiMode checked%GdiMode% , GDI
Gui, Add, Radio,  x240 y%TAB_Y% w60 h20 gOthersettings vAHKMode checked%AHKMode% , AHK
Gui, Add, CheckBox, x310 y%TAB_Y% w300 h20 gOthersettings vCloneWindowforDWM checked%CloneWindowforDWM% , 創造隱形視窗`(DWM)
Tab_Y += 30
Gui, Add, Text,  x30 y%TAB_Y%  w100 h20 , 點擊方式：
Tab_Y -= 3
Iniread, SendFromAHK, %SettingName%, OtherSub, SendFromAHK, 1
Iniread, SendFromADB, %SettingName%, OtherSub, SendFromADB, 0
Gui, Add, Radio,  x110 y%TAB_Y% w120 h20 gOthersettings vSendFromAHK checked%SendFromAHK% , 模擬滑鼠點擊
Gui, Add, Radio,  x230 y%TAB_Y% w150 h20 gOthersettings vSendFromADB checked%SendFromADB% , ADB發送點擊指令
Tab_Y += 35
Gui, Add, Text,  x30 y%TAB_Y%  w140 h20 , 容許誤差：文字
IniRead, Value_Err0, %SettingName%, OtherSub, Value_Err0, 0
Tab_Y -= 3
Gui, Add, Slider, x140 y%TAB_Y% w80 h30 gOthersettings vValue_Err0 range0-50 +ToolTip , %Value_Err0%
Tab_Y += 3
Gui, Add, Text, x220 y%TAB_Y% w30 h20 vValue_Err0BarUpdate , %Value_Err0BarUpdate% 
Gui, Add, Text, x250 y%TAB_Y% w100 h20 , `%

Gui, Add, Text,  x280 y%TAB_Y%  w50 h20 , 背景
IniRead, Value_Err1, %SettingName%, OtherSub, Value_Err1, 0
Tab_Y -= 3
Gui, Add, Slider, x310 y%TAB_Y% w80 h30 gOthersettings vValue_Err1 range0-100 +ToolTip , %Value_Err1%
Tab_Y += 3
Gui, Add, Text, x400 y%TAB_Y% w30 h20 vValue_Err1BarUpdate , %Value_Err1BarUpdate% 
Gui, Add, Text, x430 y%TAB_Y% w100 h20 , `%
Tab_Y += 30
Gui, Add, Text,  x105 y%TAB_Y%  w40 h20 , 圖片
IniRead, Value_Pic, %SettingName%, OtherSub, Value_Pic, 0
Tab_Y -= 3
Gui, Add, Slider, x140 y%TAB_Y% w80 h30 gOthersettings vValue_Pic range0-50 +ToolTip , %Value_Pic%
Tab_Y += 3
Gui, Add, Text, x220 y%TAB_Y% w30 h20 vValue_PicBarUpdate , %Value_PicBarUpdate% 
Gui, Add, Text, x250 y%TAB_Y% w100 h20 , `%
Tab_Y += 35
Gui, Add, Text,  x30 y%TAB_Y%  w120 h20 , 檢測頻率：每　
IniRead, MainsubTimer, %SettingName%, OtherSub, MainsubTimer, 3
Tab_Y -= 3
Gui, Add, Slider, x140 y%TAB_Y% w80 h30 gMainsubTimersettings vMainsubTimer range2-10 +ToolTip , %MainsubTimer%
Tab_Y += 3
Gui, Add, Text, x220 y%TAB_Y% w20 h20 vMainsubTimerBarUpdate , %MainsubTimerBarUpdate% 
Gui, Add, Text, x240 y%TAB_Y% w100 h20 , 秒/次
Tab_Y += 30
Iniread, Ldplayer3, %SettingName%, EmulatorSub, Ldplayer3, 1
Iniread, Ldplayer4, %SettingName%, EmulatorSub, Ldplayer4, 0
Iniread, NoxPlayer5, %SettingName%, EmulatorSub, NoxPlayer5, 0
Gui, Add, Text,  x30 y%TAB_Y%  w140 h20 , 模  擬  器：
Tab_Y -= 3
Gui, Add, Radio,  x110 y%TAB_Y% w80 h20 gEmulatorsettings vLdplayer3 checked%Ldplayer3% , 雷電3.x
Gui, Add, Radio,  x190 y%TAB_Y% w80 h20 gEmulatorsettings vLdplayer4 checked%Ldplayer4% , 雷電4.x
Gui, Add, Radio,  x270 y%TAB_Y% w80 h20 gEmulatorsettings vNoxPlayer5 checked%NoxPlayer5% , 夜神
Global Ldplayer3, Ldplayer4, NoxPlayer5
;///////////////////     GUI Right Side  End ///////////////////

if (Ldplayer3) {
	EmulatorResolution_W := 1318  ; 雷電4.0 1322 夜神 1284
	EmulatorResolution_H := 758 ;夜神 754
	RegRead, ldplayer, HKEY_CURRENT_USER, Software\Changzhi\dnplayer-tw, InstallDir ; Ldplayer 3.76以下版本
	if (ldplayer="") {
		RegRead, ldplayer, HKEY_CURRENT_USER, Software\Changzhi\LDPlayer, InstallDir ; Ldplayer 3.77以上版本
	}
	Consolefile = dnconsole.exe
} else if (Ldplayer4) {
	EmulatorResolution_W := 1322  ; 雷電4.0 1322 夜神 1284
	EmulatorResolution_H := 758 ;夜神 754
	RegRead, ldplayer, HKEY_CURRENT_USER, Software\XuanZhi\LDPlayer, InstallDir ; Ldplayer 4.0+ version
	Consolefile = dnconsole.exe
	Ldplayer4Modify()
} else if (NoxPlayer5) {
	EmulatorResolution_W := 1284  ; 雷電4.0 1322 夜神 1284
	EmulatorResolution_H := 754 ;夜神 754
	iniRead, ldplayer, %SettingName%, NoxInstallDir, NoxInstallDir
	if (ldplayer="" or ldplayer="ERROR")
	{
		InputBox, ldplayer, 設定精靈, 請輸入夜神模擬器的路徑`n`n例如: C:\Program Files\Nox\bin
		iniwrite, %ldplayer%, %SettingName%, NoxInstallDir, NoxInstallDir
	}
	Consolefile = NoxConsole.exe
}
Global EmulatorResolution_W, EmulatorResolution_H, Consolefile
Global SirenCount := 0
gui, PicShow:show, w925 h500 x%azur_x% y%azur_y% NA,  Azur Lane - %title%
Gui Show, w925 h500 x%azur_x% y%azur_y%, Azur Lane - %title%
WinSet, Transparent, 210, ahk_id %MainHwnd%
OnMessage(0x200,"WM_MOUSEMOVE") 
OnMessage(0x216, "WM_MOVING")
OnMessage(0x232, "WM_EXITSIZEMOVE")
Menu, Tray, Tip , Azur Lane `(%title%)
Winget, UniqueID,, %title%
Global UniqueID
Gosub, whitealbum
Settimer, whitealbum, 15000 ;很重要!
iniread, Autostart, %SettingName%, OtherSub, Autostart, 0
if (Autostart) {
	iniread, AutostartMessage, %SettingName%, OtherSub, AutostartMessage
	iniwrite, 0, %SettingName%, OtherSub, Autostart
	iniwrite, 0, %SettingName%, OtherSub, AutostartMessage
	LogShow(AutostartMessage)
	Goto, Start
}
else if (CheckUpdate) { ;啟動時檢查自動更新
	gosub, Isupdate2
}
;//////////////刪除雷電模擬器可能的惡意廣告檔案//////////////////
iniread, DeleteAdsCheck, %SettingName%, DeleteAdsCheck, DeleteAdsCheck, 0
if !(DeleteAdsCheck)
{
	DefaultDir = %A_WorkingDir%
	SetWorkingDir, %ldplayer%
	if (FileExist("fyservice.exe") or FileExist("fynews.exe") or FileExist("ldnews.exe") or FileExist("news")) {
		Text := "發現"
		. "<a href=""https://www.reddit.com/r/RagnarokMobile/comments/e6cccx/tech_support_ldplayer_update_added_shady/"">"
		. "雷電模擬器中的廣告檔案</a>，是否自動刪除？"
		DeleteAdsCheck := "不刪除且不再提示"
		Result := MsgBoxEx(Text, "敬告", "確認|取消", 2, DeleteAdsCheck)
		if (DeleteAdsCheck=1)
		{
			SetWorkingDir, %DefaultDir%
			iniwrite, 1, %SettingName%, DeleteAdsCheck, DeleteAdsCheck
		}
		else If (Result == "確認") 
		{
			while (FileExist("fyservice.exe") or FileExist("fynews.exe") or FileExist("ldnews.exe") or FileExist("news"))
			{ ;ldnews.exe 刪除不影響運作 看起來很像廣告檔案
				WinClose, ahk_exe fynews.exe
				WinClose, ahk_exe fyservice.exe
				WinClose, ahk_exe ldnews.exe
				FileDelete, fynews.exe
				FileDelete, fyservice.exe
				FileDelete, ldnews.exe
				FileRemoveDir, news, 1
				if (A_index>20)
				{
					LogShow("刪除廣告檔案過程中發生問題(Ld_Dir)")
					break
				}
			}		
			SetWorkingDir, %A_temp%
			while (FileExist("fyservice.exe") or FileExist("fynews.exe") or FileExist("ldnews.exe"))
			{
				WinClose, ahk_exe fynews.exe
				WinClose, ahk_exe fyservice.exe
				WinClose, ahk_exe ldnews.exe
				FileDelete, fynews.exe
				FileDelete, fyservice.exe
				FileDelete, ldnews.exe
				if (A_index>20)
				{
					LogShow("刪除廣告檔案過程中發生問題(Temp_Dir)")
					break
				}
			}
			While (InStr(FileExist("fy"), "D"))
			{
				WinClose, ahk_exe fynews.exe
				WinClose, ahk_exe fyservice.exe
				WinClose, ahk_exe ldnews.exe
				FileRemoveDir, fy, 1
				if (A_index>20)
				{
					LogShow("刪除廣告檔案過程中發生問題(Ld_Dir_2)")
					break
				}
			}
		}
	}
	SetWorkingDir, %DefaultDir%
}
if (substr(A_osversion, 1, 2)!=10)
{
	iniread, OsVersionCheck, %SettingName%, Osversion, OsVersionCheck
	Text := "在作業系統非Windows10的環境下，本程式可能無法正確運作。`n`n請嘗試：`n`n1.　更新您的作業系統至Windows10。`n`n2.　<a href=""https://www.google.com/search?q=關閉Aero特效"">關閉Aero特效</a>。`n"
	OsVersionCheckText := "不再提示"
	if (OsVersionCheck!=1)
	{
		Result := MsgBoxEx(Text, "提示", "OK", 4, OsVersionCheckText, "-SysMenu AlwaysOnTop", MainHwnd, 0, "s12 c0x000000", "Segoe UI")
		if (OsVersionCheckText=1) {
			iniwrite, 1, %SettingName%, Osversion, OsVersionCheck
		} else {
			iniwrite, 0, %SettingName%, Osversion, OsVersionCheck
		}
	}
}
IfWinNotExist, ahk_exe NVDisplay.Container.exe
{
	iniread, VideoCardCheck, %SettingName%, VideoCard, VideoCardCheck
	Text := "未偵測到Nvidia顯示卡驅動程式。"
	. "`n`n`n請注意，在非使用Nvidia顯示卡的情況下，本程式取色有關功能可能無法正確運作。"
	. "`n`n如果您使用的是:`n`n1. Nvidia顯示卡，請嘗試"
	. "<a href=""https://www.nvidia.com.tw/Download/index.aspx?lang=tw"">更新顯示卡驅動程式</a>。"
	. "`n`n2. AMD顯示卡，因為作者沒有AMD顯示卡，所以無法排除此問題。"
	VideoCardCheckText := "不再提示"
	if (VideoCardCheck!=1)
	{
		Result := MsgBoxEx(Text, "提示", "OK", 4, VideoCardCheckText, "-SysMenu AlwaysOnTop", MainHwnd, 0, "s12 c0x000000", "Segoe UI")
		if (VideoCardCheckText=1) {
			iniwrite, 1, %SettingName%, VideoCard, VideoCardCheck
		} else {
			iniwrite, 0, %SettingName%, VideoCard, VideoCardCheck
		}
	}
}
gosub, tabfunc
LogShow("啟動完畢，等待開始")
Guicontrol, Enable, start
return

ResetAnchorTimes:
AnchorTimes := 0
AnchorFailedTimes := 0
IniWrite, 0, %SettingName%, Anchor, AnchorTimes
IniWrite, 0, %SettingName%, Anchor, AnchorFailedTimes
GuiControl, ,AnchorTimesText, 出擊次數：0 次 ｜ 全軍覆沒：0 次 ｜ 翻船機率：0.00`%
LogShow("出擊次數已重置")
sleep 1000
return

Debug2:
LogShow("檢測中")
GuiControl, disable, debug
WinRestore,  %title%
WinMove ,  %title%, , , , %EmulatorResolution_W%, %EmulatorResolution_H%
Emulator_HomeBtn := "|<>*131$20.ztzzsDzw0zyD7y7sz3z3XzwFzzUzzwDzz3zzkzzwDzz3zzkzzw0000002"
Emulator_Spot := "|<>*138$11.sDUC080000000020C0y3k"
Game_Ico := "|<>*181$29.nl3zvb27zrSEDzjdkTzDH03yQC0Aksc0MVk00V30000C0000QM001vw007r000B"
if Find(x, y, 1247, 661, 1317, 716, Emulator_HomeBtn) ; Home
{
	LogShow("Emulator_HomeBtn：x" x " y" y)
	ControlClick, x%x% y%y%, ahk_id %UniqueID%,,,, NA
	sleep 2000
	if Find(x, y, 585, 566, 685, 621, Emulator_Spot)
		LogShow("Emulator_Spot：x" x " y" y)
	else
		LogShow("檢測Emulator_Spot失敗")
	st1 := A_TickCount
	if Find(x, y, 0, 0, 1317, 720, Game_Ico)
	{
		st2 := A_TickCount - st1
		LogShow("Game_Ico：x" x " y" y " st: " st2)
		ControlClick, x%x% y%y%, ahk_id %UniqueID%,,,, NA
	}
	else
		LogShow("檢測Game_Ico失敗")
}
else
	LogShow("檢測Home鍵失敗")
LogShow("檢測結束。")
GuiControl,enable, debug
return

TabFunc: ;切換分頁讀取GUI設定，否則可能導致選項失效
gosub, inisettings
gosub, Anchorsettings
gosub, Anchor3settings
gosub, Academysettings
gosub, Dormsettings
gosub, Techacademysettings
gosub, Missionsettings
gosub, Othersettings
gosub, MainsubTimersettings
return

inisettings: ;一般設定
Critical
Guicontrolget, title
Iniwrite, %title%, %SettingName%, emulator, title
WinSetTitle, ahk_id %MainHwnd%,, Azur Lane - %title%
WinSetTitle, ahk_id %PicShowHwnd%,, Azur Lane - %title%
Critical, off
return

Anchorsettings: ;出擊設定
Critical
;///////////////TAB1//////////////
Guicontrolget, AnchorSub
Guicontrolget, AnchorMode
Guicontrolget, AnchorChapter
Guicontrolget, AnchorChapter2
Guicontrolget, Assault
Guicontrolget, mood
Guicontrolget, Autobattle
Guicontrolget, BossAction
Guicontrolget, Shipsfull
Guicontrolget, ChooseParty1
Guicontrolget, ChooseParty2
Guicontrolget, SwitchPartyAtFirstTime
Guicontrolget, WeekMode
Guicontrolget, Use_FixKit
Guicontrolget, AlignCenter
Guicontrolget, BattleTimes
Guicontrolget, BattleTimes2
Guicontrolget, Item_Bullet
Guicontrolget, Item_Quest
Guicontrolget, Ship_Target1 ;航空艦隊
Guicontrolget, Ship_Target2 ;運輸艦隊
Guicontrolget, Ship_Target3 ;主力艦隊
Guicontrolget, Ship_Target4 ;偵查艦隊
Guicontrolget, Ship_TargetElite ;賽任艦隊
Guicontrolget, Plane_Target1 ;航空器
Guicontrolget, Ship_Target1_S ;航空艦隊
Guicontrolget, Ship_Target2_S ;運輸艦隊
Guicontrolget, Ship_Target3_S ;主力艦隊
Guicontrolget, Ship_Target4_S ;偵查艦隊
Guicontrolget, Ship_TargetE_S  ;賽任艦隊
Guicontrolget, Ship_TargetP_S  ;航空器
Guicontrolget, TimetoBattle
Guicontrolget, TimetoBattle1
Guicontrolget, TimetoBattle2
Global Assault, Autobattle, shipsfull, ChooseParty1, ChooseParty2, AnchorMode, SwitchPartyAtFirstTime, WeekMode, AnchorChapter, AnchorChapter2, mood

;////出擊2/////// TAB2
Guicontrolget, IndexAll
Guicontrolget, Index1
Guicontrolget, Index2
Guicontrolget, Index3
Guicontrolget, Index4
Guicontrolget, Index5
Guicontrolget, Index6
Guicontrolget, Index7
Guicontrolget, Index8
Guicontrolget, Index9
Guicontrolget, CampAll
Guicontrolget, Camp1
Guicontrolget, Camp2
Guicontrolget, Camp3
Guicontrolget, Camp4
Guicontrolget, Camp5
Guicontrolget, Camp6
Guicontrolget, Camp7
Guicontrolget, RarityAll
Guicontrolget, Rarity1
Guicontrolget, Rarity2
Guicontrolget, Rarity3
Guicontrolget, Rarity4
Guicontrolget, DailyGoalSub
Guicontrolget, DailyParty
Guicontrolget, DailyGoalSunday
Guicontrolget, DailyGoalRed
Guicontrolget, DailyGoalRedAction
Guicontrolget, DailyGoalGreen
Guicontrolget, DailyGoalGreenAction
Guicontrolget, DailyGoalBlue
Guicontrolget, DailyGoalBlueAction
Guicontrolget, DailyHardMap
Guicontrolget, DailyHardMap2
Guicontrolget, DailyHardMap3
Guicontrolget, OperationSub
Guicontrolget, Operationenemy
Guicontrolget, Operation_ReLogin
Guicontrolget, Leave_Operatio
Guicontrolget, OperatioMyHpBar
Guicontrolget, OperatioMyHpBarUpdate
Guicontrolget, OperatioEnHpBar
Guicontrolget, OperatioEnHpBarUpdate
Guicontrolget, ResetOperationTime
Guicontrolget, ResetOperationTime2
Guicontrolget, Operation_Only
Guicontrolget, Operation_OnlyNum
Guicontrolget, Leave_OperatioDo
Guicontrol, ,OperatioMyHpBarUpdate, %OperatioMyHpBar%
Guicontrol, ,OperatioEnHpBarUpdate, %OperatioEnHpBar%
Global IndexAll, Index1, Index2, Index3, Index4, Index5, Index6, Index7, Index8, Index9, CampAll, Camp1,Camp2, Camp3, Camp4, Camp5, Camp6, Camp7, Camp8, Camp9, RarityAll, Rarity1, Rarity2, Rarity3, Rarity4, DailyParty, Leave_Operatio, OperatioMyHpBar, OperatioEnHpBar, Operation_Only, Operation_OnlyNum, Leave_OperatioDo
Settimer, SaveAnchorsettings, -500
Critical, off
return

SaveAnchorsettings:
Iniwrite, %AnchorSub%, %SettingName%, Battle, AnchorSub
Iniwrite, %AnchorMode%, %SettingName%, Battle, AnchorMode
Iniwrite, %AnchorChapter%, %SettingName%, Battle, CH_AnchorChapter
Iniwrite, %AnchorChapter2%, %SettingName%, Battle, AnchorChapter2
Iniwrite, %Assault%, %SettingName%, Battle, Assault
Iniwrite, %mood%, %SettingName%, Battle, mood
Iniwrite, %Autobattle%, %SettingName%, Battle, Autobattle
Iniwrite, %BossAction%, %SettingName%, Battle, BossAction
Iniwrite, %Shipsfull%, %SettingName%, Battle, Shipsfull
Iniwrite, %ChooseParty1%, %SettingName%, Battle, ChooseParty1
Iniwrite, %ChooseParty2%, %SettingName%, Battle, ChooseParty2
Iniwrite, %SwitchPartyAtFirstTime%, %SettingName%, Battle, SwitchPartyAtFirstTime
Iniwrite, %WeekMode%, %SettingName%, Battle, WeekMode
Iniwrite, %Use_FixKit%, %SettingName%, Battle, Use_FixKit
Iniwrite, %AlignCenter%, %SettingName%, Battle, AlignCenter
Iniwrite, %BattleTimes%, %SettingName%, Battle, BattleTimes
Iniwrite, %BattleTimes2%, %SettingName%, Battle, BattleTimes2
Iniwrite, %Ship_Target1%, %SettingName%, Battle, Ship_Target1
Iniwrite, %Ship_Target2%, %SettingName%, Battle, Ship_Target2
Iniwrite, %Ship_Target3%, %SettingName%, Battle, Ship_Target3
Iniwrite, %Ship_Target4%, %SettingName%, Battle, Ship_Target4
Iniwrite, %Ship_TargetElite%, %SettingName%, Battle, Ship_TargetElite
Iniwrite, %Item_Bullet%, %SettingName%, Battle, Item_Bullet
Iniwrite, %Item_Quest%, %SettingName%, Battle, Item_Quest
Iniwrite, %Plane_Target1%, %SettingName%, Battle, Plane_Target1

Iniwrite, %Ship_Target1_S%, %SettingName%, Battle, Ship_Target1_S
Iniwrite, %Ship_Target2_S%, %SettingName%, Battle, Ship_Target2_S
Iniwrite, %Ship_Target3_S%, %SettingName%, Battle, Ship_Target3_S
Iniwrite, %Ship_Target4_S%, %SettingName%, Battle, Ship_Target4_S
Iniwrite, %Ship_TargetE_S%, %SettingName%, Battle, Ship_TargetE_S
Iniwrite, %Ship_TargetP_S%, %SettingName%, Battle, Ship_TargetP_S

Iniwrite, %TimetoBattle%, %SettingName%, Battle, TimetoBattle
Iniwrite, %TimetoBattle1%, %SettingName%, Battle, TimetoBattle1
Iniwrite, %TimetoBattle2%, %SettingName%, Battle, TimetoBattle2
;//////////////出擊2///////////////
Iniwrite, %IndexAll%, %SettingName%, Battle, IndexAll ;全部
Iniwrite, %Index1%, %SettingName%, Battle, Index1 ;前排先鋒
Iniwrite, %Index2%, %SettingName%, Battle, Index2 ;後排主力
Iniwrite, %Index3%, %SettingName%, Battle, Index3 ;驅逐
Iniwrite, %Index4%, %SettingName%, Battle, Index4 ;輕巡
Iniwrite, %Index5%, %SettingName%, Battle, Index5 ;重巡
Iniwrite, %Index6%, %SettingName%, Battle, Index6 ;戰列
Iniwrite, %Index7%, %SettingName%, Battle, Index7 ;航母
Iniwrite, %Index8%, %SettingName%, Battle, Index8 ;維修
Iniwrite, %Index9%, %SettingName%, Battle, Index9 ;其他
Iniwrite, %CampAll%, %SettingName%, Battle, CampAll ;全部
Iniwrite, %Camp1%, %SettingName%, Battle, Camp1 ;白鷹
Iniwrite, %Camp2%, %SettingName%, Battle, Camp2 ;皇家
Iniwrite, %Camp3%, %SettingName%, Battle, Camp3 ;重櫻
Iniwrite, %Camp4%, %SettingName%, Battle, Camp4 ;鐵血
Iniwrite, %Camp5%, %SettingName%, Battle, Camp5 ;東煌
Iniwrite, %Camp6%, %SettingName%, Battle, Camp6 ;北方聯合
Iniwrite, %Camp7%, %SettingName%, Battle, Camp7 ;其他
Iniwrite, %RarityAll%, %SettingName%, Battle, RarityAll ;全部
Iniwrite, %Rarity1%, %SettingName%, Battle, Rarity1 ;普通
Iniwrite, %Rarity2%, %SettingName%, Battle, Rarity2 ;稀有
Iniwrite, %Rarity3%, %SettingName%, Battle, Rarity3 ;精銳
Iniwrite, %Rarity4%, %SettingName%, Battle, Rarity4 ;超稀有
Iniwrite, %DailyGoalSub%, %SettingName%, Battle, DailyGoalSub  ;自動執行每日任務
Iniwrite, %DailyParty%, %SettingName%, Battle, DailyParty  ;每日隊伍選擇
Iniwrite, %DailyGoalSunday%, %SettingName%, Battle, DailyGoalSunday ;禮拜日三個都打
Iniwrite, %DailyHardMap%, %SettingName%, Battle, DailyHardMap
Iniwrite, %DailyHardMap2%, %SettingName%, Battle, DailyHardMap2
Iniwrite, %DailyHardMap3%, %SettingName%, Battle, DailyHardMap3
Iniwrite, %DailyGoalRed%, %SettingName%, Battle, DailyGoalRed
Iniwrite, %DailyGoalRedAction%, %SettingName%, Battle, DailyGoalRedAction
Iniwrite, %DailyGoalGreen%, %SettingName%, Battle, DailyGoalGreen
Iniwrite, %DailyGoalGreenAction%, %SettingName%, Battle, DailyGoalGreenAction
Iniwrite, %DailyGoalBlue%, %SettingName%, Battle, DailyGoalBlue
Iniwrite, %DailyGoalBlueAction%, %SettingName%, Battle, DailyGoalBlueAction
Iniwrite, %OperationSub%, %SettingName%, Battle, OperationSub ;自動執行演習
Iniwrite, %Operation_ReLogin%, %SettingName%, Battle, Operation_ReLogin
Iniwrite, %Operationenemy%, %SettingName%, Battle, Operationenemy
Iniwrite, %Leave_Operatio%, %SettingName%, Battle, Leave_Operatio
Iniwrite, %OperatioMyHpBar%, %SettingName%, Battle, OperatioMyHpBar ;演習時的我方血量
Iniwrite, %OperatioEnHpBar%, %SettingName%, Battle, OperatioEnHpBar ;演習時的敵方血量
Iniwrite, %ResetOperationTime%, %SettingName%, Battle, ResetOperationTime
Iniwrite, %ResetOperationTime2%, %SettingName%, Battle, ResetOperationTime2
Iniwrite, %Operation_Only%, %SettingName%, Battle, Operation_Only 
Iniwrite, %Operation_OnlyNum%, %SettingName%, Battle, Operation_OnlyNum 
Iniwrite, %Leave_OperatioDo%, %SettingName%, Battle, Leave_OperatioDo
return


Anchor3settings: ;TAB出擊3
Critical
Guicontrolget, FightRoundsDo
Guicontrolget, FightRoundsDo2
Guicontrolget, FightRoundsDo3
Guicontrolget, Retreat_LowHp
Guicontrolget, Retreat_LowHpBar
Guicontrolget, Retreat_LowHpDo
Guicontrolget, Stop_LowHp
Guicontrolget, Stop_LowHP_SP
Guicontrolget, Retreat_LowHp2
Guicontrolget, Retreat_LowHp2Bar
Guicontrolget, Retreat_LowHp2Do
Guicontrolget, Retreat_UT_LowHp
Guicontrolget, Retreat_UT_LowHpBar
Guicontrolget, Retreat_UT_LowHpDo
Guicontrolget, Retreat_P1_LowHp
Guicontrolget, Retreat_P1_LowHpBar
Guicontrolget, Retreat_P1_LowHpDo
Guicontrolget, Take_ItemQuest
Guicontrolget, Take_ItemQuestNum
Guicontrolget, StopBattleTime
Guicontrolget, StopBattleTime2
Guicontrolget, StopBattleTime3
Guicontrol, ,Retreat_LowHpBarUpdate, %Retreat_LowHpBar%
Guicontrol, ,Retreat_LowHp2BarUpdate, %Retreat_LowHp2Bar%
Guicontrol, ,Retreat_UT_LowHpBarUpdate, %Retreat_UT_LowHpBar%
Guicontrol, ,Retreat_P1_LowHpBarUpdate, %Retreat_P1_LowHpBar%

Global Retreat_LowHp, Retreat_LowHpBar, Retreat_LowHpDo, Stop_LowHp, Stop_LowHP_SP, Retreat_LowHp2, Retreat_LowHp2Bar, Retreat_LowHp2Do
Settimer, SaveAnchor3settings, -500
Critical, off
return

SaveAnchor3settings:
Iniwrite, %FightRoundsDo%, %SettingName%, Battle, FightRoundsDo ;當艦隊A....
Iniwrite, %FightRoundsDo2%, %SettingName%, Battle, FightRoundsDo2 ;出擊次數
Iniwrite, %FightRoundsDo3%, %SettingName%, Battle, FightRoundsDo3 ; 做什麼事
Iniwrite, %Retreat_LowHp%, %SettingName%, Battle, Retreat_LowHp
Iniwrite, %Retreat_LowHpBar%, %SettingName%, Battle, Retreat_LowHpBar
Iniwrite, %Retreat_LowHpDo%, %SettingName%, Battle, Retreat_LowHpDo
Iniwrite, %Stop_LowHp%, %SettingName%, Battle, Stop_LowHp
Iniwrite, %Stop_LowHP_SP%, %SettingName%, Battle, Stop_LowHP_SP
Iniwrite, %Retreat_LowHp2%, %SettingName%, Battle, Retreat_LowHp2
Iniwrite, %Retreat_LowHp2Bar%, %SettingName%, Battle, Retreat_LowHp2Bar
Iniwrite, %Retreat_LowHp2Do%, %SettingName%, Battle, Retreat_LowHp2Do
Iniwrite, %Retreat_UT_LowHp%, %SettingName%, Battle, Retreat_UT_LowHp
Iniwrite, %Retreat_UT_LowHpBar%, %SettingName%, Battle, Retreat_UT_LowHpBar
Iniwrite, %Retreat_UT_LowHpDo%, %SettingName%, Battle, Retreat_UT_LowHpDo
Iniwrite, %Retreat_P1_LowHp%, %SettingName%, Battle, Retreat_P1_LowHp
Iniwrite, %Retreat_P1_LowHpBar%, %SettingName%, Battle, Retreat_P1_LowHpBar
Iniwrite, %Retreat_P1_LowHpDo%, %SettingName%, Battle, Retreat_P1_LowHpDo
Iniwrite, %Take_ItemQuest%, %SettingName%, Battle, Take_ItemQuest
Iniwrite, %Take_ItemQuestNum%, %SettingName%, Battle, Take_ItemQuestNum
Iniwrite, %StopBattleTime%, %SettingName%, Battle, StopBattleTime
Iniwrite, %StopBattleTime2%, %SettingName%, Battle, StopBattleTime2
Iniwrite, %StopBattleTime3%, %SettingName%, Battle, StopBattleTime3
return

Academysettings: ;學院設定
Critical
Guicontrolget, AcademySub
Guicontrolget, AcademyOil
Guicontrolget, AcademyCoin
Guicontrolget, ClassRoom
Guicontrolget, AcademyTactics
Guicontrolget, AcademyShop
Guicontrolget, 150expbookonly
Guicontrolget, SkillBook_ATK
Guicontrolget, SkillBook_DEF
Guicontrolget, SkillBook_SUP
Guicontrolget, Cube
Guicontrolget, Part_Aircraft
Guicontrolget, Part_Cannon
Guicontrolget, Part_torpedo
Guicontrolget, Part_Anti_Aircraft
Guicontrolget, Part_Common
Guicontrolget, Item_Equ_Box1
Guicontrolget, Item_Water
Guicontrolget, Item_Tempura
Guicontrolget, Item_Ex4_Box
Guicontrolget, Item_Cube_2
Settimer, SaveAcademysettings, -500
Critical, off
return

SaveAcademysettings:
Iniwrite, %AcademySub%, %SettingName%, Academy, AcademySub
Iniwrite, %AcademyOil%, %SettingName%, Academy, AcademyOil
Iniwrite, %AcademyCoin%, %SettingName%, Academy, AcademyCoin
Iniwrite, %ClassRoom%, %SettingName%, Academy, ClassRoom
Iniwrite, %AcademyShop%, %SettingName%, Academy, AcademyShop
Iniwrite, %AcademyTactics%, %SettingName%, Academy, AcademyTactics
Iniwrite, %150expbookonly%, %SettingName%, Academy, 150expbookonly
Iniwrite, %SkillBook_ATK%, %SettingName%, Academy, SkillBook_ATK
Iniwrite, %SkillBook_DEF%, %SettingName%, Academy, SkillBook_DEF
Iniwrite, %SkillBook_SUP%, %SettingName%, Academy, SkillBook_SUP
Iniwrite, %Cube%, %SettingName%, Academy, Cube
Iniwrite, %Part_Aircraft%, %SettingName%, Academy, Part_Aircraft
Iniwrite, %Part_Cannon%, %SettingName%, Academy, Part_Cannon
Iniwrite, %Part_torpedo%, %SettingName%, Academy, Part_torpedo
Iniwrite, %Part_Anti_Aircraft%, %SettingName%, Academy, Part_Anti_Aircraft
Iniwrite, %Part_Common%, %SettingName%, Academy, Part_Common
Iniwrite, %Item_Equ_Box1%, %SettingName%, Academy, Item_Equ_Box1
Iniwrite, %Item_Water%, %SettingName%, Academy, Item_Water
Iniwrite, %Item_Tempura%, %SettingName%, Academy, Item_Tempura
Iniwrite, %Item_Ex4_Box%, %SettingName%, Academy, Item_Ex4_Box
Iniwrite, %Item_Cube_2%, %SettingName%, Academy, Item_Cube_2
return

Dormsettings: ;後宅設定
Critical
Guicontrolget, DormSub
Guicontrolget, DormCoin
Guicontrolget, Dormheart
Guicontrolget, DormFood
Guicontrolget, DormFoodBar
Guicontrol, ,DormFoodBarUpdate, %DormFoodBar%
Global DormFood
Settimer, SaveDormsettings, -500
Critical, off
return

SaveDormsettings:
Iniwrite, %DormSub%, %SettingName%, Dorm, DormSub
Iniwrite, %DormCoin%, %SettingName%, Dorm, DormCoin
Iniwrite, %Dormheart%, %SettingName%, Dorm, Dormheart
Iniwrite, %DormFood%, %SettingName%, Dorm, DormFood
Iniwrite, %DormFoodBar%, %SettingName%, Dorm, DormFoodBar
return

Techacademysettings: ;科研設定
Critical
Guicontrolget, TechacademySub
Guicontrolget, TechTarget_01 ;定向研發
Guicontrolget, TechTarget_02 ;資金募集
Guicontrolget, TechTarget_03 ;數據蒐集
Guicontrolget, TechTarget_04 ;艦裝解析
Guicontrolget, TechTarget_05 ;研究委託
Guicontrolget, TechTarget_06 ;試驗品募集
Guicontrolget, TechTarget_07 ;基礎研究
Guicontrolget, PY_TechTarget_01
Guicontrolget, PY_TechTarget_02
Guicontrolget, PY_TechTarget_03
Guicontrolget, PY_TechTarget_04
Guicontrolget, PY_TechTarget_05
Guicontrolget, PY_TechTarget_06
Guicontrolget, PY_TechTarget_07
;~ Guicontrolget, Tech_NoCoin
Settimer, SaveTechacademysettings, -500
Critical, off
return

SaveTechacademysettings:
Iniwrite, %TechacademySub%, %SettingName%, TechacademySub, TechacademySub
Iniwrite, %TechTarget_01%, %SettingName%, TechacademySub, TechTarget_01
Iniwrite, %TechTarget_02%, %SettingName%, TechacademySub, TechTarget_02
Iniwrite, %TechTarget_03%, %SettingName%, TechacademySub, TechTarget_03
Iniwrite, %TechTarget_04%, %SettingName%, TechacademySub, TechTarget_04
Iniwrite, %TechTarget_05%, %SettingName%, TechacademySub, TechTarget_05
Iniwrite, %TechTarget_06%, %SettingName%, TechacademySub, TechTarget_06
Iniwrite, %TechTarget_07%, %SettingName%, TechacademySub, TechTarget_07
;~ Iniwrite, %Tech_NoCoin%, %SettingName%, TechacademySub, Tech_NoCoin
Iniwrite, %PY_TechTarget_01%, %SettingName%, TechacademySub, PY_TechTarget_01
Iniwrite, %PY_TechTarget_02%, %SettingName%, TechacademySub, PY_TechTarget_02
Iniwrite, %PY_TechTarget_03%, %SettingName%, TechacademySub, PY_TechTarget_03
Iniwrite, %PY_TechTarget_04%, %SettingName%, TechacademySub, PY_TechTarget_04
Iniwrite, %PY_TechTarget_05%, %SettingName%, TechacademySub, PY_TechTarget_05
Iniwrite, %PY_TechTarget_06%, %SettingName%, TechacademySub, PY_TechTarget_06
Iniwrite, %PY_TechTarget_07%, %SettingName%, TechacademySub, PY_TechTarget_07
return

Missionsettings: ;任務設定
Critical
Guicontrolget, MissionSub
Guicontrolget, AutoBuild
Guicontrolget, AutoBuild2
Guicontrolget, AutoBuild3
Guicontrolget, AutoExEqu
Settimer, SaveMissionsettings, -500
Critical, off
return

SaveMissionsettings:
Iniwrite, %MissionSub%, %SettingName%, MissionSub, MissionSub
Iniwrite, %AutoBuild%, %SettingName%, MissionSub, AutoBuild
Iniwrite, %AutoBuild2%, %SettingName%, MissionSub, AutoBuild2
Iniwrite, %AutoBuild3%, %SettingName%, MissionSub, AutoBuild3
Iniwrite, %AutoExEqu%, %SettingName%, MissionSub, AutoExEqu
return


Othersettings: ;其他設定
Critical
Guicontrolget, CheckUpdate
Guicontrolget, CheckUpdateMode
Guicontrolget, GuiHideX
Guicontrolget, EmulatorCrushCheck
Guicontrolget, AutoLogin
Guicontrolget, SetGuiBGcolor
Guicontrolget, SetGuiBGcolor2
Guicontrolget, DebugMode
Guicontrolget, DwmMode
Guicontrolget, GdiMode
Guicontrolget, AHKMode
Guicontrolget, CloneWindowforDWM
Guicontrolget, SendFromAHK
Guicontrolget, SendFromADB
Guicontrolget, Value_Err0
Guicontrolget, Value_Err0BarUpdate
Guicontrolget, Value_Err1
Guicontrolget, Value_Err1BarUpdate
Guicontrolget, Value_Pic
Guicontrolget, Value_PicBarUpdate
Err0_V := if (Value_Err0!=0) ? Round(Value_Err0/100, 2) : 0.00
Err1_V := if (Value_Err1!=0) ? Round(Value_Err1/100, 2) : 0.00
Value_Pic := if Value_Pic!=0 ? Round(Value_Pic/10, 2) : 0.00
Guicontrol, ,Value_Err0BarUpdate, %Value_Err0%
Guicontrol, ,Value_Err1BarUpdate, %Value_Err1%
Guicontrol, ,Value_PicBarUpdate, %Value_Pic%
Global AutoLogin, DebugMode, DwmMode, GdiMode, AHKMode, CloneWindowforDWM, SendFromAHK, SendFromADB, Err0_V, Err1_V, Value_Pic
Settimer, SaveOthersettings, -500
Critical, off
return

SaveOthersettings:
Iniwrite, %CheckUpdate%, %SettingName%, OtherSub, CheckUpdate
Iniwrite, %CheckUpdateMode%, %SettingName%, OtherSub, CheckUpdateMode
Iniwrite, %GuiHideX%, %SettingName%, OtherSub, GuiHideX
Iniwrite, %EmulatorCrushCheck%, %SettingName%, OtherSub, EmulatorCrushCheck
Iniwrite, %AutoLogin%, %SettingName%, OtherSub, AutoLogin
Iniwrite, %SetGuiBGcolor%, %SettingName%, OtherSub, SetGuiBGcolor
Iniwrite, %SetGuiBGcolor2%, %SettingName%, OtherSub, SetGuiBGcolor2
Iniwrite, %DebugMode%, %SettingName%, OtherSub, DebugMode
Iniwrite, %DwmMode%, %SettingName%, OtherSub, DwmMode
Iniwrite, %GdiMode%, %SettingName%, OtherSub, GdiMode
Iniwrite, %AHKMode%, %SettingName%, OtherSub, AHKMode
Iniwrite, %CloneWindowforDWM%, %SettingName%, OtherSub, CloneWindowforDWM
Iniwrite, %SendFromAHK%, %SettingName%, OtherSub, SendFromAHK
Iniwrite, %SendFromADB%, %SettingName%, OtherSub, SendFromADB
Iniwrite, %Value_Err0%, %SettingName%, OtherSub, Value_Err0
Iniwrite, %Value_Err1%, %SettingName%, OtherSub, Value_Err1
Iniwrite, %Value_Pic%, %SettingName%, OtherSub, Value_Pic
Iniwrite, %MainsubTimer%, %SettingName%, OtherSub, MainsubTimer
return

GuiColorsettings:
Critical
Guicontrolget, SwitchGuiColor
wingetpos, azur_x, azur_y,, WindowName
Iniwrite, %SwitchGuiColor%, %SettingName%, OtherSub, SwitchGuiColor
iniwrite, %azur_x%, %SettingName%, Winposition, azur_x
iniwrite, %azur_y%, %SettingName%, Winposition, azur_y
Iniwrite, 1, %SettingName%, OtherSub, IsSwitchGuicolor
reload
Critical, off
return

Emulatorsettings:
GuiControl, disable, start
Guicontrolget, Ldplayer3
Guicontrolget, Ldplayer4
Guicontrolget, NoxPlayer5
Iniwrite, %Ldplayer3%, %SettingName%, EmulatorSub, Ldplayer3
Iniwrite, %Ldplayer4%, %SettingName%, EmulatorSub, Ldplayer4
Iniwrite, %NoxPlayer5%, %SettingName%, EmulatorSub, NoxPlayer5
Global Ldplayer3, Ldplayer4, NoxPlayer5
if (Ldplayer4 or NoxPlayer5)
{
	IniRead, EmCheckText, %SettingName%, EmCheckText, EmCheckText
	if (EmCheckText!=1)
	{
		Text := "如使用雷電4.0或夜神模擬器遇到問題，`n`n"
		. "作者並不會特別進行維護，`n`n"
		. "有興趣的人可以研究相容各模擬器的版本或方式。`n`n"
		. "另請注意:`n`n"
		. "1. 使用夜神模擬器將導致自動重啟及ADB點擊功能失效。`n`n"
		. "2. 雷電4.0使用步驟：`n"
		. "　(1). 在雷電模擬器啟動的情況下，將解析度更改為1920x1080(dpi 280)後重啟。`n"
		. "　(2). 啟動碧藍航線後，將解析度更改為1280x720(dpi 240)後，關閉模擬器。`n"
		. "　(3). 等待約5~10秒後，按下停止鍵`n"
		. "　(4). 按下開始鍵讓模擬器自動啟動`n"
		. "　※只有第一次使用要這麼做`n"
		EmCheckText := "不再提示"
		MsgBoxEx(Text, "提示", "OK", 5, EmCheckText, "", MainHwnd, 0, "s11 c0x000000", "Segoe UI")
	}
	If (EmCheckText=1)
	{
		IniWrite, 1, %SettingName%, EmCheckText, EmCheckText
	}
}
Text := "切換模擬器版本，等待自動重啟。"
MsgBoxEx(Text, "設定精靈", "", [229, "imageres.dll"], "", "-SysMenu AlwaysOnTop", WinExist("A"), 2, "s11 c0x000000", "Segoe UI")
reload
return

MainsubTimersettings:
Critical
Guicontrolget, MainsubTimer
Guicontrol, ,MainsubTimerBarUpdate, %MainsubTimer%
if (Is_Start=1){
	MainsubTime := MainsubTimer*1000
	DetectSleep := MainsubTimer*3 ;用途Function: Find 的延遲
	Settimer, Mainsub, %MainsubTime%
	Iniwrite, %MainsubTimer%, %SettingName%, OtherSub, MainsubTimer
}
Critical, off
return

exitsub:
Critical
WinSet, Transparent, 0, ahk_id %PicShowHwnd%
WinSet, Transparent, 0, ahk_id %MainHwnd%
WindowName = Azur Lane - %title%
wingetpos, azur_x, azur_y,, WindowName
iniwrite, %azur_x%, %SettingName%, Winposition, azur_x
iniwrite, %azur_y%, %SettingName%, Winposition, azur_y
if (substr(A_osversion, 1, 1)=7) {
	DllCall("dwmapi\DwmEnableComposition", "uint", 1)
}
exitapp
Critical, off
return

Showsub:
Gui, show
gui, PicShow:show
return

CloneWindowSub:
Gui, CloneWindow:New, -Caption +ToolWindow, CloneWindow-%title% ;創造一個GUI
Gui, CloneWindow:Show, w1318 h758,  ;創造一個GUI
if !(debugMode)
	WinSet, Transparent, 0, CloneWindow-%title%
CloneTitle = CloneWindow-%title%
CloneWindow := WinExist(CloneTitle)
Global CloneTitle, CloneWindow
DC := DllCall("user32.dll\GetDCEx", "UInt", CloneWindow, "UInt", 0, "UInt", 2)
Settimer, CloneWindowSub2, %MainsubTime%
return

CloneWindowSub2:
DllCall("User32.dll\PrintWindow", "Ptr", UniqueID, "Ptr", DC, "UInt", 2)
return

HexadecimalSub:
MsgBox, 8228, 設定精靈, 即將前往色票工具網站：https://color.adobe.com/zh/create
ifMsgBox Yes 
	Run, https://color.adobe.com/zh/create
return

GuiClose:
if GuiHideX {
	;~ Traytip, 訊息, 　`nAzurLane (%title%) 於背景執行中!`n　, 1
	Gui, Hide
	gui, PicShow:Hide
	Text = AzurLane - %title% `n`n於背景執行中
	MsgBoxEx(Text, "通知", "", [188, "imageres.dll"], "", "-SysMenu", 0, 1.5, "s12 c0x000000", "Segoe UI", "0xFFFFFF")
} else {
	WindowName = Azur Lane - %title%
	wingetpos, azur_x, azur_y,, WindowName
	iniwrite, %azur_x%, %SettingName%, Winposition, azur_x
	iniwrite, %azur_y%, %SettingName%, Winposition, azur_y
	if (substr(A_osversion, 1, 1)=7) {
		DllCall("dwmapi\DwmEnableComposition", "uint", 1)
	}
	ExitApp
}
return

guicontrols: ;關閉某些按鈕，避免更動
Guicontrol, disable, Start
Guicontrol, disable, title
Guicontrol, disable, EmulatorCrushCheck
Guicontrol, disable, BattleTimes2
Guicontrol, disable, Timetobattle1
Guicontrol, disable, Timetobattle2
Guicontrol, disable, StopBattleTime3
Guicontrol, disable, CloneWindowforDWM
Guicontrol, disable, ResetOperationTime2
Guicontrol, disable, Ldplayer3
Guicontrol, disable, Ldplayer4
Guicontrol, disable, NoxPlayer5
return

Start:
if (substr(A_osversion, 1, 1)=7) {
	LogShow("偵測到系統為Windows7，關閉AERO")
	DllCall("dwmapi\DwmEnableComposition", "uint", 0)
}
gosub, TabFunc
gosub, guicontrols
Global emulatoradb := GetLdplayer()
if (title="")
	reload
IfWinNotExist , %title%
	goto startemulatorsub
Winget, UniqueID,, %title%
Global UniqueID, DetectSleep
LogShow("開始 (模擬器編號: " emulatoradb ")！")
WinRestore,  %title%
WinMove,  %title%, , , , %EmulatorResolution_W%, %EmulatorResolution_H%
WinSet, Transparent, off, %title%
MainsubTime := MainsubTimer*1000
DetectSleep := MainsubTimer*3 ;用途Function: Find 的延遲
Settimer, Mainsub, %MainsubTime%
Settimer, WinSub, 3200
if (DWMmode and CloneWindowforDWM)
	gosub, CloneWindowSub
if (EmulatorCrushCheck and !Noxplayer5)
	Settimer, EmulatorCrushCheckSub, 60000
Global Is_Start := 1
return

ForumSub:
Run, https://github.com/panex0845/AzurLane/
return

DiscordSub:
Run, https://discord.gg/GFCRSap
return

IsUpdate:
Run, https://github.com/panex0845/AzurLane
return

IsUpdate2:
FileReadLine, ThisVersion, ChangeLog.txt, 1
Loop, Parse, ThisVersion
{
  If A_LoopField is Number
    OldVersion .= A_LoopField
}
if (OldVersion="") {
	LogShow2("------------------------------------------------------------------------------")
	message = `　　　ChangeLog檔案遺失，未能正確判斷目前版本，
	LogShow2(message)
	LogShow2(" ")
	message = `　　　　　請嘗試重新安裝本程式或手動更新。
	LogShow2(message)
	LogShow2("------------------------------------------------------------------------------")
	return
}
message = 當前版本 v%OldVersion%，通道：%CheckUpdateMode%。
LogShow(message)
VersionUrl := "https://raw.githubusercontent.com/panex0845/AzurLane/master/ChangeLog.md"
FileUrl := "https://github.com/panex0845/AzurLane/archive/master.zip"
UrlDownloadToFile, %VersionUrl%, Temp.txt
FileReadLine, ThisVersion, Temp.txt, 1
Loop, Parse, ThisVersion
{
  If A_LoopField is Number
    NewVersion .= A_LoopField
}
IfInString, ThisVersion, stable
	IsStable := 1
else 
	TestVer := 1
filename = AzurLane v%NewVersion%.zip
if (FileExist(filename) and NewVersion!=OldVersion)
{
	MB_Cancel := 1
	LogShow2("------------------------------------------------------------------------------")
	message = `　　更新檔 %filename% 已下載完畢，請手動安裝。
	LogShow2(message)
	LogShow2("------------------------------------------------------------------------------")
}
else if (NewVersion!=OldVersion and (CheckUpdateMode="測試版" or (CheckUpdateMode="正式版" and IsStable=1))) {
	OnMessage(0x53, "Update_HELP")
	MsgBox, 0x4041, 設定精靈, 目前版本：%OldVersion%`n`nGitHub版本：%NewVersion%，是否自動下載？
	IfMsgBox OK
	{
		Guicontrol, disable, Start
		LogShow("下載更新檔中，請稍後…")
		FileDelete, temp.txt
		IsDownLoading := 1
		SetTimer, whitealbum, off
		DownloadFile(FileUrl, filename)
		SetTimer, whitealbum, 10000
		TrayTip, AzurLane, 更新檔下載完畢，`n`n請手動安裝。
		message = `　　更新檔 %filename% 已下載完畢，請手動安裝。
		LogShow2("------------------------------------------------------------------------------")
		LogShow2(message)
		LogShow2("------------------------------------------------------------------------------")
		Guicontrol, enable, Start
	}
	else IfMsgBox Cancel
	{
		MB_Cancel := 1
		LogShow("取消")
	}
}
if (CheckUpdateMode="正式版" and TestVer=1) {
	LogShow("已是最新版本 (通道：測試版 v"NewVersion ")")
}
else if !(MB_Cancel or IsDownLoading) {
	LogShow("已是最新版本")
}
FileDelete, temp.txt
NewVersion := ""
OldVersion := ""
return

EmulatorCrushCheckSub:
Critical
if (Find(x, y, 1107, 25, 1207, 80, Emulator_Wifi)) ;遊戲閃退 位於模擬器桌面
{
	iniwrite, "=======遊戲閃退，自動重啟=======", %SettingName%, OtherSub, AutostartMessage
	iniwrite, 1, %SettingName%, OtherSub, Autostart
	runwait, %Consolefile% quit --index %emulatoradb% , %ldplayer%, Hide
	Critical, off
	sleep 10000
	reload
}
Loop, 3
{
	EmulatorCrushCheckCount++
	CheckPostion%EmulatorCrushCheckCount% := [DwmGetpixel(50, 95), DwmGetpixel(582, 74), DwmGetpixel(961, 242),DwmGetpixel(320, 215), DwmGetpixel(778, 583), DwmGetpixel(312, 446), DwmGetpixel(164, 173)]
	For k, v in CheckPostion%EmulatorCrushCheckCount%
		s%EmulatorCrushCheckCount%%k% := v
	sleep 150
	if (EmulatorCrushCheckCount=3)
	{
		Loop, 3
		{
			Check1%A_index% := CheckPostion%A_index%[1]
			Check2%A_index% := CheckPostion%A_index%[2]
			Check3%A_index% := CheckPostion%A_index%[3]
			Check4%A_index% := CheckPostion%A_index%[4]
			Check5%A_index% := CheckPostion%A_index%[5]
			Check6%A_index% := CheckPostion%A_index%[6]
			Check7%A_index% := CheckPostion%A_index%[7]
		}
		if (Check11=Check12 and Check11=Check13)
			if (Check21=Check22 and Check21=Check23)
				if (Check31=Check32 and Check31=Check33)
					if (Check41=Check42 and Check41=Check43)
						if (Check51=Check52 and Check51=Check53)
							if (Check61=Check62 and Check61=Check63)
								if (Check71=Check72 and Check71=Check73)
								{
									Checkzz++
									if (Checkzz>=9)
									{
										Critical, off
										LogShow("畫面靜止，嘗試返回首頁")
										Loop, 10
										{
											if Find(x, y, 1180, 36, 1280, 91, MainPage_Home)
											{
												C_Click(x, y)
												sleep 3000
											}
											else if Find(x, y, 10, 59, 110, 114, MainPage_Return)
											{
												C_Click(x, y)
												sleep 3000
											}
											else if (Find(x, y, 0, 59, 91, 119, DormPage_in_Dorm))
											{
												C_Click(x, y)
												sleep 3000
											}
											else if (Find(x, y, 734, 401, 834, 461, MainPage_Btn_Formation))
												break
											sleep 300
										}
										sleep 5000
										if (Find(x, y, 734, 401, 834, 461, MainPage_Btn_Formation))
										{
											LogShow("成功返回首頁")
										}
										else
										{
											Capture()
											LogShow("===模擬器當機或輔助卡住，自動重啟===")
											EmulatorCrushCheckCount := 0
											iniwrite, "===模擬器當機或輔助卡住，自動重啟===", %SettingName%, OtherSub, AutostartMessage
											iniwrite, 1, %SettingName%, OtherSub, Autostart
											runwait, %Consolefile% quit --index %emulatoradb% , %ldplayer%, Hide
											sleep 10000
											reload
										}
									}
									EmulatorCrushCheckCount := 0
									return
								}
		EmulatorCrushCheckCount := 0
	}
}
Checkzz := 0
return

ResetOperationSub:
GuiControl, disable, ResetOperation
OperationDone := 0  ;重置演習判斷
GotoOperation := 1 ;執行演習
iniWrite, 0, %SettingName%, Battle, OperationYesterday
LogShow("演習已被重置")
sleep 200
GuiControl, Enable, ResetOperation
return

ResetOperationClock:
ResetOperationDone := 0
return

Mainsub: ;優先檢查出擊以外的其他功能
if (Noxplayer5)
	LDplayerCheck := Find(x, y, 0, 0, 60, 35, NoxPlayerLogo) 
else 
	LDplayerCheck := Find(x, y, 0, 0, 60, 35, LdPlayerLogo) 
if !(LDplayerCheck) 
{
	Guicontrol, ,starttext, 目前狀態：未能正確偵測到模擬器。
	sleep 5000
	return
}
Formattime, Nowtime, ,HHmm
if !(LDplayerCheck) ;檢查模擬器有沒有被縮小
{
	goto, Winsub
}
else if (LDplayerCheck)
{
	if (NowTime=0001 or Nowtime=1301)
	{
		DailyDone := 0 ;重置每日判斷
		if !(ResetOperationTime)
		{
			OperationDone := 0  ;重置演習判斷
			ResetOperationDone := 1
		}
		if (AutoBuild)
		{
			ReadBuild := 0
			HadBuild := 0
		}
	}
	if (ResetOperationTime and ResetOperationDone<1 and OperationSub) ;如果有勾選自動重置演習
	{
		ResetOperationTime3 := StrSplit(ResetOperationTime2, ",")
		for k, Resettime in ResetOperationTime3
		{
			Resettime2 := Resettime+1
			if (NowTime=Resettime or Nowtime=Resettime2)
			{
				OperationDone := 0  ;重置演習判斷
				iniread, OperationYesterday, %SettingName%, Battle, OperationYesterday
				if (OperationYesterday>=1) {
					LogShow("自動重置演習。")
				}
				iniWrite, 0, %SettingName%, Battle, OperationYesterday
				GotoOperation := 1
				ResetOperationDone := 1
				Settimer, ResetOperationClock, -121000
				if (Find(x, y, 734, 401, 834, 461, MainPage_Btn_Formation))
				{
					C_Click(1080, 403)
					sleep 2000
				}
			}
		}
	}
	Formation := Find(x, y, 734, 401, 834, 461, MainPage_Btn_Formation) ;編隊BTN
	WeighAnchor := Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor) ;出擊BTN
	MissionCheck := Find(x, y, 868, 680, 968, 740, MainPage_MissionDone) ;任務完成
	MissionCheck2 :=Find(x, y, 2, 154, 102, 214, MainPage_N_Done)
	if (MissionSub and (MissionCheck or MissionCheck2 or (AutoBuild and !HadBuild))) ;任務 or 軍事委託
	{
		sleep 500
		gosub, MissionSub
		sleep 500
	}
	Living_AreaCheck := Find(x, y, 580, 681, 680, 741, "|<>*167$7.zswSD7XlswTzjXvk") ;生活圈驚嘆號
	if (AcademySub and Living_AreaCheck and Formation and WeighAnchor and AcademyDone<1) ;學院
	{
		sleep 500
		AC_Click(501, 713, 624, 738)
		Loop
		{
			if (Find(x, y, 403, 472, 503, 532, WaitingforAcademy)) ;等待進入學院/後宅選單
				break
			else if (Find(x, y, 734, 401, 834, 461, MainPage_Btn_Formation)) ;沒有正確進入選單
				AC_Click(501, 713, 624, 738)
			else if (A_index>=100)
			{
				LogShow("進入生活圈(學院)時發生錯誤")
				return
			}
			sleep 500
		}
		sleep 1200
		if (Find(x, y, 479, 239, 579, 299, AcademyDoneIco)) ;
		{
			LogShow("執行學院任務！")
			gosub, AcademySub
		}
		else 
		{
			AC_Click(305, 75, 955, 175)
			AcademyDone := 1
			Settimer, AcademyClock, -900000 
			sleep 1500
		}
		sleep 500
	}
	Living_AreaCheck := Find(x, y, 580, 681, 680, 741, "|<>*167$7.zswSD7XlswTzjXvk") ;生活圈驚嘆號
	if (DormSub and Living_AreaCheck and Formation and WeighAnchor and DormDone<1)  ;後宅
	{
		sleep 500
		AC_Click(501, 713, 624, 738)
		Loop
		{
			if (Find(n, m, 403, 472, 503, 532, WaitingforAcademy)) ;等待進入學院/後宅選單
				break
			else if (Find(x, y, 734, 401, 834, 461, MainPage_Btn_Formation)) ;沒有正確進入選單
				AC_Click(501, 713, 624, 738)
			else if (A_index>=100)
			{
				LogShow("進入生活圈(後宅)時發生錯誤")
				return
			}
			sleep 500
		}
		sleep 1200
		if (Find(x, y, 907, 238, 1007, 298, DormIco)) ;
		{
			LogShow("執行後宅任務！")
			gosub, DormSub
		}
		else 
		{
			AC_Click(305, 75, 955, 175)
			sleep 1500
			DormDone := 1
			Settimer, DormClock, -900000
		}
		sleep 500
	}
	TechacademyCheck :=if (StopAnchor<1) ? Find(x, y, 740, 684, 840, 744, MainPage_ResearchDeptDone) : 1 ;目前官方提示壞掉 
	if (TechacademySub and TechacademyCheck and Formation and WeighAnchor and TechacademyDone<1)
	{
		sleep 500
		AC_Click(660, 713, 775, 738)
		sleep 1000
		Loop
		{
			if (Find(x, y, 101, 33, 201, 93, TechPage_ResearchDept))
				break ;等待進入科研選單
			else if Find(x, y, 716, 683, 816, 743, MainPage_ResearchDeptDone) 
			{
				AC_Click(660, 713, 775, 738)
			}
			else if (A_index>=100)
			{
				LogShow("進入科研選單時發生錯誤")
				return
			}
		}
		gosub, TechacademySub
	}
	if ((AnchorSub) and (!Living_AreaCheck or AcademyDone=1 or !AcademySub) and (!Living_AreaCheck or DormDone=1 or !DormSub))  ;出擊
	{
		gosub, AnchorSub
	}
}
if ((Timetobattle) and (Nowtime=TimetoBattle1 or Nowtime=TimetoBattle2) and RunOnceTime<1)
{
	StopAnchor := 0
	LogShow("重新出擊")
	Timetobattle11 := Timetobattle1+1
	Timetobattle22 := Timetobattle2+1
	RunOnceTime := 1
}
else if (RunOnceTime=1 and (Nowtime=Timetobattle11 or Nowtime=Timetobattle11))
{
	RunOnceTime := 0
	Timetobattle11 := 0
	Timetobattle22 := 0
}
return

clock:
StopAnchor := 0
return

ReAnchorSub:
Guicontrol, disable, ReAnchorSub
LogShow("再次出擊！")
gosub, TabFunc
StopAnchor := 0
StopBattleTimeCount := 0
WeighAnchorCount := 0
settimer, clock, off
sleep 1000
Guicontrol, enable, ReAnchorSub
return


TechacademySub: ;科研
Techacademy_Done := Find(x, y, 396, 471, 496, 531, TechPage_TechDone)
Shipworks_Done := 0 ;暫時無用
Is_StartTech := 0 ; 研發優先順序
In_StartTech := 0 ; 研發優先順序
if (Techacademy_Done) ;軍部研究室OK
{
	LogShow("進入軍部科研室")
	Random, x, 247, 388
	Random, y, 331, 479
	C_Click(x, y)
	sleep 1000
	Target_Techacademy := [TargetedRD, Fundraising, RaiseData, AnalysisShip, Commissioned, TestCollection, basicResearch, 0]
	Loop
	{
		if (Find(x, y, 612, 601, 712, 661, TechPage_TechComplete)) ;研發已完成(綠色)
		{
			C_Click(614, 282)
		}
		if (Find(x, y, 611, 602, 711, 662, TechPage_ViewDetails)) ;等待研發(查看詳情)
		{
			C_Click(633, 281)
		}
		if (Find(x, y, 450, 130, 830, 330, Touch_to_Contunue, 0.1, 0.1)) ;點擊繼續
		{
			C_Click(x, y)
		}
		if (Find(x, y, 432, 588, 532, 648, TechPage_StartTech)) ;開始研發
		{
			In_StartTech++
			if (Is_StartTech=0 or IndexValue(In_StartTech, 6, 12, 18, 24, 30, 36, 42)) {
				Is_StartTech++
				message = 當前優先順序: %Is_StartTech%
				LogShow(message)
				if Is_StartTech>3
					Is_StartTech := 1
			}
			sleep 200
			for k, v in Target_Techacademy
			{
				if (Find(x, y, 310, 125, 420, 190, v))
					break
			}
			if k=1 
			{
				pj=定向研發
				py:=PY_TechTarget_01
			} 
			else if k=2 
			{
				pj=資金募集
				py:=PY_TechTarget_02
			}
			else if k=3
			{
				pj=數據蒐集
				py:=PY_TechTarget_03
			}
			else if k=4 
			{
				pj=艦裝解析
				py:=PY_TechTarget_04
			}
			else if k=5 
			{
				pj=研究委託
				py:=PY_TechTarget_05
			}
			else if k=6 
			{
				pj=試驗募集
				py:=PY_TechTarget_06
			}
			else if k=7 
			{
				pj=基礎研究
				py:=PY_TechTarget_07
			}
			;~ message = k=%k% pj=%pj% Is_StartTech=%Is_StartTech% py=%py%
			;~ LogShow(message)
			sleep 200
			if (k=1 and !TechTarget_01) or (k=2 and !TechTarget_02) or (k=3 and !TechTarget_03) or (k=3 and !TechTarget_03) or (k=4 and !TechTarget_04) or (k=5 and !TechTarget_05) or (k=6 and !TechTarget_06) or (k=7 and !TechTarget_07)
			{
				message = 項目 %pj% 不研發，更換科研項目。
				LogShow(message)
				TechFailed++ ;找不到研發項目
				AC_Click(320, 700, 980, 720)
				Loop, 20
				{
					if (Find(x, y, 613, 602, 713, 662, ViewDetails)) {
						C_Click(895, 270)
						break
					}
					sleep 300
				}
				if (TechFailed=5)
				{
					C_Click(1169, 690) ;重整研發項目
				}
			}
			else if (k=8)
			{
				LogShow("科研項目發生錯誤(文字搜尋失敗)")
				sleep 5000
				C_Click(690, 717)
				sleep 1000
				C_Click(885, 252)
			}
			if (k=1 and TechTarget_01) or (k=2 and TechTarget_02) or (k=3 and TechTarget_03) or (k=3 and TechTarget_03) or (k=4 and TechTarget_04) or (k=5 and TechTarget_05) or (k=6 and TechTarget_06) or (k=7 and TechTarget_07)
			{
				if (py!=Is_StartTech) 
				{
					message = %pj% 優先順序不符 (順序: %py%)。
					LogShow(message)
					C_Click(698, 705)
					sleep 1000
					C_Click(888, 248)
				}
				else
				{
					message = 開始研發 %pj% (優先順序: %py%)。
					LogShow(message)
					C_Click(507, 617)
					sleep 1000
					if (Find(x, y, 429, 330, 529, 390, TechPage_Is_Teching))
					{
						LogShow("已有研發科目，嘗試切換項目")
						In_StartTech := 0
						C_Click(698, 705)
						sleep 1000
						C_Click(888, 248)
					}
				}
			}
		}
		if (DwmCheckcolor(438, 618, 9742022) and DwmCheckcolor(579, 618, 9740998) and DwmCheckcolor(532, 618, 13552598, 20))  or (DwmCheckcolor(438, 618, 8692422) and DwmCheckcolor(579, 618, 8691398) and DwmCheckcolor(532, 618, 13028302, 20))  ;缺少研發道具
		{
			LogShow("缺少研究道具")
			C_Click(657, 713)
			sleep 1000
			C_Click(885, 265)
		}
		if (Find(x, y, 343, 224, 934, 532, ConsumeMore))
		{
			C_Click(791, 552)
		}
		if (Find(x, y, 422, 587, 522, 647, TechPage_Stop_Teching) or TechFailed>=50 or A_index>=80) ;已經開始研發(停止研發按鈕)
		{
			LogShow("離開軍部科研室")
			TechFailed := 0
			C_Click(714, 712)
			sleep 500
			C_Click(1227, 71)
			Loop, 30
			{
				if (Find(x, y, 734, 401, 834, 461, MainPage_Btn_Formation))
					break
				sleep 500
			}
			break
		}
		sleep 500
	}
}
else
{
	C_Click(1232, 69) ;回首頁
}
TechacademyDone := 1
Settimer, TechacademyClock, -900000
return

TechacademyClock:
TechacademyDone := 0
return

Autopuzzle:
if (Find(x, y, 1064, 285, 1200, 334, DreamParty))
{
	ClickList = D3 C3 C2 D2 D1 C1 C2 D2 D3 D4 C4 B4 A4 A3 A2 B2 B3 C3 C2 C1 B1 A1 A2 B2 B1 C1 D1 D2 D3 D4 C4 C3 C2 B2 B3 B4 C4 C3 D3 D2 C2 C3 B3 A3 A4 B4 B3 C3 D3 D4
	ClickList := StrSplit(ClickList, " ")
	for k, v in ClickList
	{
		List%A_Index% := ClickList[A_Index]
		List%A_index% := StrSplit(List%A_index%, "")
		if (List%A_index%[1]="A")
			y:= 225
		else if (List%A_index%[1]="B")
			y:= 318
		else if (List%A_index%[1]="C")
			y:= 412
		else if (List%A_index%[1]="D")
			y:= 510
		if (List%A_index%[2]="1")
			x:= 389
		else if (List%A_index%[2]="2")
			x:= 531
		else if (List%A_index%[2]="3")
			x:= 662
		else if (List%A_index%[2]="4")
			x:= 800
		ControlClick, x%x% y%y%, ahk_id %UniqueID%,,,, NA
		sleep 100
	}
} else {
	MsgBox, 16, 錯誤, 請移動到拼圖介面
}
return

MatchingGame:
if (Find(x, y, 0, 32, 90, 92, InMatchingGame)){
	ControlClick, x%x% y%y%, ahk_id %UniqueID%,,,, NA
	sleep 1000
}
if (Find(x, y, 1018, 486, 1118, 546, GoMatchingGame)) {
	ControlClick, x%x% y%y%, ahk_id %UniqueID%,,,, NA
	sleep 700
	if (Find(x, y, 722, 523, 822, 583, MatchingGameConfirm))	{
		ControlClick, x%x% y%y%, ahk_id %UniqueID%,,,, NA
	}
	if (debugmode) {
		LogShow("除錯模式已開啟，使用超極速模式")
		LogShow("可能會因為點太快導致未能正確翻牌")
	}
	sleep 1500
	Capture2(1, 36, 1281, 756)
	MatchingGame()
} else {
	LogShow("請至活動總覽頁面執行之。")
}
return

AnchorSub: ;出擊
if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor) and ((StopAnchor<1 and AnchorMode!="停用") or GotoOperation))
{
	AC_Click(1025, 356, 1145, 453) ;於首頁點擊點擊右邊"出擊"
	sleep 2000
}
else if (Find(x, y, 164, 42, 264, 102, Formation_Upp) and Find(x, y, 0, 587, 86, 647, Formation_Tank)) ;在出擊的編隊頁面
{
	if (Retreat_P1_LowHp)
	{
		sleep 1000
		P1_HpPos := [345, 560, 475, 580], P2_HpPos := [565, 500, 700, 530], P3_HpPos := [760, 460, 895, 490]
		P1 := "", P2 := "", P3 := "",
		P1 := GdipImageSearch(p1x, p1y, "img/battle/Page_Formation_Hp.png", 50, 5, P1_HpPos[1], P1_HpPos[2], P1_HpPos[3], P1_HpPos[4])
		P2 := GdipImageSearch(p2x, p2y, "img/battle/Page_Formation_Hp.png", 50, 5, P2_HpPos[1], P2_HpPos[2], P2_HpPos[3], P2_HpPos[4])
		P3 := GdipImageSearch(p3x, p3y, "img/battle/Page_Formation_Hp.png", 50, 5, P3_HpPos[1], P3_HpPos[2], P3_HpPos[3], P3_HpPos[4])
		P1_NowHp := (P1) ? Ceil((p1x-P1_HpPos[1])/130*100) : 0
		P2_NowHp := (P2) ? Ceil((p2x-P2_HpPos[1])/130*100) : 0
		P3_NowHp := (P3) ? Ceil((p3x-P3_HpPos[1])/130*100) : 0
		if (Retreat_P1_LowHpDo="交換前衛") {
			if (P1_NowHp>1 and P1_NowHp<Retreat_P1_LowHpBar) {
				sleep 2500
				if (P3_NowHp>P1_NowHp and P3) {
					LogShow("交換P3與P1位置")
					swipe(807, 397, 340, 470)
				}
				else if (P2_NowHp>P1_NowHp and P2) {
					LogShow("交換P1與P2位置")
					swipe(370, 498, 650, 425)
				}
				sleep 2000
			}
		}
	}
    if (Find(x, y, 726, 127, 826, 187, Auto_Battle_Off) and Autobattle="自動") ;Auto Battle >> ON
    {
		LogShow("開啟自律模式")
        C_Click(819, 160)
    }
	else if (Find(x, y, 728, 128, 828, 188, Auto_Battle_On) and Autobattle="半自動")
	{
		LogShow("開啟半自動模式")
		C_Click(819, 160)
	}
	else if (Find(x, y, 728, 128, 828, 188, Auto_Battle_On) and Autobattle="關閉")
	{
		LogShow("關閉自律模式")
		C_Click(819, 160)
	}
	if (!Find(x, y, 79, 555, 179, 615, None_Kit) and (Use_FixKit)) ;如果有維修工具
	{
		Loop, 100
		{
			if (!Find(x, y, 79, 555, 179, 615, None_Kit)) ;如果有維修工具
			{
				C_Click(119, 570) ;使用維修工具
				sleep 500
			}
			if (Find(x, y, 707, 451, 807, 511, Using_Kit)) ; 跳出訊息選單
			{
				C_Click(x, y) ;點擊使用
				sleep 1000
			}
			if (Find(x, y, 479, 452, 579, 512, Using_kit_Cancel)) ;如果HP是滿的
			{
				C_Click(x, y) ;點擊取消
			}
			sleep 300
			if (Find(x, y, 164, 42, 264, 102, Formation_Upp)) ;回到編隊頁面
			{
				break
			}	
		}
	}
	AnchorTimes++ ;統計出擊次數
	Global AnchorTimes, switchparty
	FightRoundsDoCount++ ;統計當艦隊A每出擊
	rate := Round(AnchorFailedTimes/AnchorTimes*100, 2)
	GuiControl, ,AnchorTimesText, 出擊次數：%AnchorTimes% 次 ｜ 全軍覆沒：%AnchorFailedTimes% 次 ｜ 翻船機率：%rate%`%
	IniWrite, %AnchorTimes%, %SettingName%, Anchor, AnchorTimes
	IniWrite, %AnchorFailedTimes%, %SettingName%, Anchor, AnchorFailedTimes
	LogShow("出擊～！")
    Random, x, 1056, 1225
	Random, y, 656, 690
	Global SirenCount
	SirenCount--
	C_Click(x, y) ;於編隊頁面點擊右下 "出擊"
	sleep 500
	shipsfull()
	FindBoss := 0
	IsDetect := 0
	FindWayCount := 0
	if (BossFailed)
	{
		TargetFailed1 := 1
		TargetFailed2 := 1
		TargetFailed3 := 1
		TargetFailed4 := 1
		TargetFailed5 := 1
		TargetFailed6 := 1
		Plane_TargetFailed1 := 1
	}
	else if (SirenCount > 0)
	{
		TargetFailed1 := 1
		TargetFailed2 := 1
		TargetFailed3 := 1
		TargetFailed4 := 1
		TargetFailed5 := 1
		TargetFailed6 := 1
		Plane_TargetFailed1 := 1
	}
	else
	{
		TargetFailed1 := 0
		TargetFailed2 := 0
		TargetFailed3 := 0
		TargetFailed4 := 0
		TargetFailed5 := 0
		TargetFailed6 := 0
		Plane_TargetFailed1 := 0
	}
    BossFailed := 0
    BulletFailed := 0
    QuestFailed := 0
	SearchLoopcount := 0
	SearchFailedMessage := 0
	SearchLoopcountFailed2 := 0
    if (Find(x, y, 700, 500, 880, 600, Academy_BTN_Confirm)) ;心情低落
    {
		if mood=強制出戰
		{
			LogShow("老婆心情低落：提督SAMA沒人性")
			C_Click(x, y)
		}
		else if mood=不再出擊
		{
			LogShow("老婆心情低落，不再出擊")
			takeabreak := 600
			C_Click(492, 555)
			sleep 3000
			C_Click(1227, 67)
			StopAnchor := 1
		}
		else if mood=休息1小時
		{
			LogShow("老婆心情低落：休息1小時")
			takeabreak := 600
			C_Click(492, 555)
			sleep 3000
			C_Click(1227, 67)
			StopAnchor := 1
			InMap := 1
			settimer, clock,  -3600000
		}
		else if mood=休息2小時
		{
			LogShow("老婆心情低落：休息2小時")
			takeabreak := 600
			C_Click(492, 555)
			sleep 3000
			C_Click(1227, 67)
			StopAnchor := 1
			InMap := 1
			settimer, clock, -7200000
		}
		else if mood=休息3小時
		{
			LogShow("老婆心情低落：休息3小時")
			takeabreak := 600
			C_Click(492, 555)
			sleep 3000
			C_Click(1227, 67)
			StopAnchor := 1
			InMap := 1
			settimer, clock, -10800000
		}
		else if mood=休息5小時
		{
			LogShow("老婆心情低落：休息5小時")
			takeabreak := 600
			C_Click(492, 555)
			sleep 3000
			C_Click(1227, 67)
			StopAnchor := 1
			InMap := 1
			settimer, clock, -14400000
		}
		else
		{
			LogShow("心情低落選項出錯")
		}
    }
    if (DwmCheckcolor(543, 361, 15724527) and DwmCheckcolor(784, 63, 16773987) and DwmCheckcolor(1000, 63, 16729459)) ;石油不足
    {
        LogShow("石油不足，停止出擊到永遠！")
        C_Click(1230, 74)
		StopAnchor := 1
    }
}
else if (Find(x, y, 750, 682, 850, 742, Battle_Map))
{	
	if (GotoOperation and OperationSub)
	{
		LogShow("準備開始演習，返回上一頁")
		sleep 300
		C_Click(56, 86)
		return
	}
	if (StopAnchor)
	{
		LogShow("停止出擊中，返回上一頁")
		sleep 500
		C_Click(56, 86)
		return
	}
	if (InMap)
	{
		InMap := 0
		AC_Click(1164, 701, 1246, 730) ;心情低落後返回地圖 不再偵查 直接迎擊
		return
	}
	if !(IsDetect)
		LogShow("偵查中。")
	sleep 1500
	BOSSICO := "img/SubChapter/targetboss_1.png"
	; /////////////////////檢查敵方艦隊的範圍////////////////////
	if (AnchorChapter="凜冬2" and AnchorChapter2="2" and FightRoundsDoCount<1)
		MapX1 := 130, MapY1 := 130, MapX2 :=1260, MapY2 := 570 ;第一輪不偵測最底下(3星未開 自動走路會卡住)
	else
		MapX1 := 130, MapY1 := 130, MapX2 :=1260, MapY2 := 670 
	; /////////////////////檢查敵方艦隊的範圍////////////////////
	if (Find(x, y, 1138, 517, 1238, 577, Lock_Party)) ;陣容鎖定已被開啟
	{ 
		LogShow("關閉陣容鎖定")
		AC_Click(1197, 537, 1257, 551)
	}
	if (NowHP>=1 and Retreat_LowHp2 and SwitchParty<1 and (NowHp<=Retreat_LowHp2Bar))
	{
		Message = 旗艦HP剩餘於 %NowHP%`%＜%Retreat_LowHp2Bar%`%，%Retreat_LowHp2Do%。
		LogShow(Message)
		if (Retreat_LowHp2Do="更換隊伍")
		{
			if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and Bossaction="優先攻擊－切換隊伍")
			{
				LogShow("已發現BOSS，等待切換隊伍")
			}
			else
			{
				SwitchParty := 1
				sleep 500
				C_Click(1030, 713)
				sleep 2000
			}
		}
		else if (Retreat_LowHp2Do="撤退")
		{
			sleep 1000
			C_Click(827, 715)
			sleep 1000
			C_Click(785, 548)
			sleep 2000
			return
		}
	}
	if (FindWayCount>=50)
	{
		LogShow("尋找路徑異常，撤退")
		FindWayCount := 0
		sleep 1000
		C_Click(827, 715)
		sleep 1000
		C_Click(785, 548)
		sleep 2000
		return
	}
	if (FightRoundsDo and FightRoundsDone<1 and SwitchParty<1)
	{
		if ((FightRoundsDoCount>=FightRoundsDo2)
		or (FightRoundsDo2="或沒子彈" and GdipImageSearch(n, n, "img/SubChapter/Bullet_None.png", 10, SearchDirection, 129, 96, 1271, 677)))
		{
			FightRoundsDone := 1
			if FightRoundsDo3=撤退
			{
				LogShow("艦隊Ａ已出擊 " FightRoundsDoCount " 次， " FightRoundsDo3 )
				sleep 1000
				C_Click(834, 716)
				sleep 2000
				C_Click(791, 556)
				return
			}
			else if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1) and (Bossaction="優先攻擊－切換隊伍")
			{
				;如果出現BOSS則不做事 避免出現BOSS導致多打道中
				LogShow("偵查到BOSS，等待切換隊伍")
				TargetFailed1 := 1
				TargetFailed2 := 1
				TargetFailed3 := 1
				TargetFailed4 := 1
			}
			else if FightRoundsDo3=更換艦隊Ｂ
			{
				SwitchParty := 1
				LogShow("艦隊Ａ已出擊 " FightRoundsDoCount " 次， " FightRoundsDo3 )
				sleep 1000
				C_Click(1034, 713) ;點擊更換艦隊
				sleep 1500
			}
		}
	}
	if (AlignCenter and IsDetect<1) 
	and !(GdipImageSearch(x, y, "img/SubChapter/Map_Lower.png", 1, 1, 150, 540, 650, 745))
	and ((Bossaction="優先攻擊－當前隊伍" or Bossaction="優先攻擊－切換隊伍") 
	and !(GdipImageSearch(n, m, BOSSICO, 15, 1, MapX1, MapY1, MapX2, MapY2))) ; 嘗試置中地圖
	{
		if (AnchorChapter="異色1" or AnchorChapter="異色2")
		{
			Swipe(210, 228, 735, 400)
			sleep 300
		}
		sleep 1000
		Swipe(250, 230, 1000, 610) ;往右下角拖曳
		Swipe(260, 240, 1050, 620) 
		AlignCenterCount := 0 ; 計算拖曳次數
		while (!GdipImageSearch(lx, ly, "img/SubChapter/Map_Lower.png", 1, 1, 300, 550, 1000, 745) and AlignCenterCount<10)
		{
			x := 350, y := 220
			Random, xx, 0, 750
			Random, yy, 0, 400
			x1 := x+xx, y1 := y+yy
			x2 := x1-65, y2 := y1-85
			Swipe(x1, y1, x2, y2)
			AlignCenterCount++
		}
		y1 := ly-2, y2 := ly+2
		while (!GdipImageSearch(x, y, "img/SubChapter/Map_Lower.png", 1, 1, 125, y1, 260, y2) and AlignCenterCount<10)
		{
			Random, x1, 200, 700
			Random, y1, 250, 650
			x2 := x1 + 220
			Swipe(x2, y1, x1, y1)
		}
	}
	SearchLoopcount := 0
	Loop, 100
	{
		sleep 300
		if (AnchorChapter="9" and AnchorChapter2="2") ;右下角開始偵查
		{
			;~ SearchDirection := 7
			;~ MapX1 := if (MapX1-100>=150) ? MapX1-100 : MapX1 := 150
			;~ Guicontrol, ,starttext, 目前狀態：搜尋範圍x1: %MapX1% y1: %MapY1% x2: %MapX2% y2: %MapY2%
		}
		else if (AnchorChapter="10" and (AnchorChapter2>="1" and AnchorChapter2<="3"))
		{
			Random, SearchDirection, 7, 8
		}
		else if (GdipImageSearch(Mpx, Mpy, "img/SubChapter/Myposition.png", 15, 8, MapX1, MapY1, MapX2, MapY2))
		{
			if (Mpx>715)
				Random, SearchDirection, 7, 8 ;人物在右邊先偵測右邊
			else (Mpx<=715 and Mpx>=1)
				Random, SearchDirection, 5, 6
			Guicontrol, ,starttext, 目前狀態：我的位置 x: %Mpx% `, y: %Mpy% 搜尋方向: %SearchDirection%
		}
		else if (AnchorChapter="7" and AnchorChapter2="2") ;7-2從左邊開始偵查到右邊 提高拿到左邊"？"的機率
			SearchDirection := 5
		else
			Random, SearchDirection, 5, 8
		if (Find(x, y, 1169, 386, 1269, 446, View_Detail))
		{
			LogShow("關閉陣型列表")
			C_Click(1071, 476)
		}
		if (bulletFailed<1 and Item_Bullet) ;只有在彈藥歸零時才會拾取
		{
			if (GdipImageSearch(x, y, "img/SubChapter/bullet.png", 105, SearchDirection, MapX1, MapY1, MapX2, MapY2)
			and GdipImageSearch(n, n, "img/SubChapter/Bullet_None.png", 10, SearchDirection, MapX1, MapY1, MapX2, MapY2))
			{
				LogShow("發現：子彈補給！X : " x " Y: " y )
				xx := x 
				yy := y + 80
				Loop, 3
				{
					if (MoveMap(xx, yy))
					{
						break
					}
					if (Find(n, m, 750, 682, 850, 742, Battle_Map)) ;如果在限時(無限時)地圖
					{
						C_Click(xx, yy)
						if (Find(x, y, 495, 330, 530, 390, "|<>*200$8.zyT3kyTzzyT3kwD3kwD3kwD3kwD3kzy"))
						{
							bulletFailed++
							break
						}
						sleep 2000
					}
					if (Find(n, m, 0, 587, 86, 647, Formation_Tank)) ;規避失敗
					{
						Break
					}
					if (DwmCheckcolor(325, 358, 16250871)) ;獲得道具
					{
						C_Click(xx, yy)
						Break
					}
					BackAttack()
					sleep 1000
				}
				bulletFailed++
			}
		}
		if (questFailed<1 and Item_Quest and TakeQuest<6) ;神秘物資
		{
			if (GdipImageSearch(x, y, "img/SubChapter/quest.png", 8, SearchDirection, MapX1, MapY1, MapX2, MapY2))
			{
				TakeQuest++
				LogShow("發現：神秘物資 " TakeQuest " 次！ X: " x " Y: " y)
				xx := x
				yy := y + 70
				Loop, 6
				{
					Guicontrol, ,starttext, % "目前狀態：嘗試拾取神秘物資 X: " x " Y: " y " …… "  A_index "/6。"
					if (MoveMap(xx, yy))
					{
						TakeQuest--
						break
					}
					if (Find(n, m, 750, 682, 850, 742, Battle_Map)) ;如果在限時(無限時)地圖
					{
						C_Click(xx, yy)
						sleep 400
						FindWay(xx, yy)
						if (Find(n, m, 495, 330, 530, 390, "|<>*200$8.zyT3kyTzzyT3kwD3kwD3kwD3kwD3kzy"))
						{
							questFailed++
							TakeQuest--
							if (AnchorChapter=7 and AnchorChapter2=2 and xx<290 and yy<414)
							{
								yy := yy+100
								LogShow("前往神秘物資路徑受阻，攻擊下方部隊。")
								Click_Fleet(xx, yy)
							}
							else 
							{
								LogShow("前往神秘物資的路徑被擋住了！ ")
							}
							sleep 300
							break
						}
						sleep 2000
					}
					if (Find(n, m, 0, 587, 86, 647, Formation_Tank)) ;規避失敗
					{
						LogShow("規避伏擊失敗。")
						TakeQuest--
						Break
					}
					if (Find(n, m, 450, 130, 830, 330, Touch_to_Contunue)) ;獲得道具
					{
						C_Click(276, 619)
						Break
					}
					if (DwmCheckcolor(449, 359, 16249847)) ;撿到子彈
					{
						sleep 1000
						break
					}
					BackAttack()
					sleep 1000
				}
				sleep 300
				IsDetect := 1
				return
			}
		}
		if (Take_ItemQuest and TakeQuest>=Take_ItemQuestNum) ;拾取神秘物資N次後撤退
		{
			LogShow("已拾取神秘物資 " TakeQuest " 次，撤退。")
			sleep 1000
			C_Click(827, 715)
			sleep 1000
			C_Click(785, 548)
			sleep 2000
			return
		}
		if (Bossaction="優先攻擊－當前隊伍" or Bossaction="優先攻擊－切換隊伍" or Bossaction="撤退") ;ＢＯＳＳ
		{
			if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
			{
				FindBoss := 1
				if (Bossaction="撤退")
				{
					LogShow("發現：最終BOSS，撤退！")
					C_Click(830, 710) ;點擊撤退
					sleep 1000
					C_Click(791, 543) ;點擊確定
					return
				}
				else if (x<340 and y<190) ;如果在左上角可能誤點
				{
					LogShow("BOSS位於左上角，拖曳畫面！")
					Random, y, 200, 600
					Swipe(370, y, 700, y)
					return
				}
				else if (Bossaction="優先攻擊－當前隊伍")
				{
					LogShow("優先攻擊最終BOSS！")
					TargetFailed1 := 1
					TargetFailed2 := 1
					TargetFailed3 := 1
					TargetFailed4 := 1
					Loop, 15
					{
						xx := x+20
						yy := y
						if (Find(n, m, 750, 682, 850, 742, Battle_Map) and xx>147 and yy>200 and xx<MapX2 and yy<MapY2) 
						{
							C_Click(xx, yy)
							sleep 400
							FindWay(xx, yy)
							if (Find(n, m, 465, 329, 565, 389, "|<>*200$8.zyT3kyTzzyT3kwD3kwD3kwD3kwD3kzy"))  ;16250871
							{
								BossFailed++
								LogShow("前往BOSS的路徑被擋住了！")
								sleep 2000
								TargetFailed1 := 0
								TargetFailed2 := 0
								TargetFailed3 := 0
								TargetFailed4 := 0
								break
							}
						}
						else if (Find(n, m, 750, 682, 850, 742, Battle_Map) and xx<290 and yy<195) 
						{
							random, swipeboss, 1, 2
							if swipeboss=1
							{
								Swipe(238,315,248,400)  ;下
							}
							else if swipeboss=2
							{
								Swipe(148,300,138,215)  ;上
							}
							break
						}
						if (Find(x, y, 750, 682, 850, 742, Battle_Map)) ;如果在限時(無限時)地圖
						{
							sleep 1000
						}
						if (Find(x, y, 0, 587, 86, 647, Formation_Tank)) ;進入戰鬥界面
						{
							Break
						}
						BackAttack()
						sleep 500
					}
				}
				else if (Bossaction="優先攻擊－切換隊伍")
				{
					xx := x 
					yy := y 
					if (SwitchParty<1)
					{
						LogShow("切換隊伍並重新搜尋最終BOSS！")
						SwitchParty := 1
						BossactionTarget := 1 ;如果已經觸發到BOSS
						bulletFailed := 1
						TargetFailed1 := 1
						TargetFailed2 := 1
						TargetFailed3 := 1
						TargetFailed4 := 1
						boss := Dwmgetpixel(x, y)
						C_Click(1035, 715) ;切換隊伍
						sleep 300
						if (Find(x, y, 440, 328, 540, 388, Switch_NoParty)) ;沒有艦隊可以切換
						{
						}
						else 
						{
							Loop, 20
							{
								if (Dwmgetpixel(x, y)=boss)
								{
									C_Click(1035, 715) ;切換隊伍
									if (Find(x, y, 440, 328, 540, 388, Switch_NoParty)) ;沒有艦隊可以切換
									{
										Break
									}
									sleep 300
									if (Dwmgetpixel(x, y)!=boss)
									{
										break
									}
								}
								else if (Dwmgetpixel(x, y)!=boss)
								{
									break
								}
								sleep 300
							}
						}
						if (AnchorChapter="紅染2" and AnchorChapter2="3") ;直接滑動到BOSS可能的出生點
						{
							sleep 1000
							Loop, 2
							{
								sleep 500
								Swipe(607, 200, 607, 661)
							}
							if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
							{
								LogShow("發現：最終ＢＯＳＳ！X : " x " Y: " y )
								C_Click(x, y)
								BossGetpixel := dwmgetpixel(x, y)
								Loop, 10
								{
									if (BossGetpixel!=dwmgetpixel(x, y))
									{
										sleep 1500
										Break
									}
									sleep 1000
								}
								return
							}
						}
						else if (AnchorChapter="墨染2" and AnchorChapter2="2") ;直接滑動到BOSS可能的出生點
						{
							sleep 1000
							Loop, 2
							{
								sleep 500
								Swipe(1050, 640, 200, 200)
							}
							if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
							{
								LogShow("發現：最終ＢＯＳＳ！X : " x " Y: " y )
								C_Click(x, y)
								BossGetpixel := dwmgetpixel(x, y)
								Loop, 10
								{
									if (BossGetpixel!=dwmgetpixel(x, y))
									{
										sleep 1500
										Break
									}
									sleep 1000
								}
								return
							}
						}
						else if (AnchorChapter="鳶尾2" and AnchorChapter2="2") ;直接滑動到BOSS可能的出生點
						{
							sleep 1000
							Loop, 2
							{
								Swipe(1000, 443, 300, 443)
								sleep 300
							}
							if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
							{
								LogShow("[鳶尾0]發現：最終ＢＯＳＳ！X : " x " Y: " y )
								C_Click(x, y)
								BossGetpixel := dwmgetpixel(x, y)
								Loop, 10
								{
									if (BossGetpixel!=dwmgetpixel(x, y))
									{
										sleep 1500
										Break
									}
									sleep 1000
								}
								return
							}
							Loop, 2
							{
								Swipe(607, 661, 607, 200)
								sleep 300
							}
							if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
							{
								LogShow("[鳶尾1]發現：最終ＢＯＳＳ！X : " x " Y: " y )
								C_Click(x, y)
								BossGetpixel := dwmgetpixel(x, y)
								Loop, 10
								{
									if (BossGetpixel!=dwmgetpixel(x, y))
									{
										sleep 1500
										Break
									}
									sleep 1000
								}
								return
							}
							Loop, 2
							{
								Swipe(607, 200, 607, 661)
								sleep 300
							}
							if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
							{
								LogShow("[鳶尾2]發現：最終ＢＯＳＳ！X : " x " Y: " y )
								C_Click(x, y)
								BossGetpixel := dwmgetpixel(x, y)
								Loop, 10
								{
									if (BossGetpixel!=dwmgetpixel(x, y))
									{
										sleep 1500
										Break
									}
									sleep 1000
								}
								return
							}
						}
						if (AnchorChapter="墜落1" and AnchorChapter2="1") ;直接滑動到BOSS可能的出生點
						{
							sleep 1000
							Loop, 2
							{
								sleep 500
								Swipe(1050, 640, 200, 200)
							}
							if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
							{
								LogShow("發現：最終ＢＯＳＳ！X : " x " Y: " y )
								C_Click(x, y)
								BossGetpixel := dwmgetpixel(x, y)
								Loop, 10
								{
									if (BossGetpixel!=dwmgetpixel(x, y))
									{
										sleep 1500
										Break
									}
									sleep 1000
								}
								return
							}
						}
						else if (AnchorChapter="異色1") ;異色格地圖太大，直接滑動到BOSS可能的出生點
						{
							sleep 1000
							if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
							{
								LogShow("發現：最終ＢＯＳＳ！X : " x " Y: " y )
								C_Click(x, y)
								BossGetpixel := dwmgetpixel(x, y)
								Loop, 10
								{
									if (BossGetpixel!=dwmgetpixel(x, y))
									{
										sleep 1500
										Break
									}
									sleep 1000
								}
								return
							}
							else
							{
								Loop, 3
								{
									Swipe(998, 443, 300, 443)
									sleep 300
								}
								sleep 500
								if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
								{
									LogShow("發現：最終ＢＯＳＳ(2)！X : " x " Y: " y )
									C_Click(x, y)
									BossGetpixel := dwmgetpixel(x, y)
									Loop, 10
									{
										if (BossGetpixel!=dwmgetpixel(x, y))
										{
											sleep 1500
											Break
										}
										sleep 1000
									}
									return
								}
								else
								{
									Loop, 2
									{
										Swipe(607, 561, 607, 200)
										sleep 300
									}
									sleep 500
									if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
									{
										LogShow("發現：最終ＢＯＳＳ(3)！X : " x " Y: " y )
										C_Click(x, y)
										BossGetpixel := dwmgetpixel(x, y)
										Loop, 10
										{
											if (BossGetpixel!=dwmgetpixel(x, y))
											{
												sleep 1500
												Break
											}
											sleep 1000
										}
										return
									}
								}
							}
						}
						else if (AnchorChapter="異色2" and AnchorChapter2="1") ;異色格地圖太大，直接滑動到BOSS可能的出生點2
						{
							sleep 1000
							if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
							{
								LogShow("發現：最終ＢＯＳＳ！X : " x " Y: " y )
								C_Click(x, y)
								BossGetpixel := dwmgetpixel(x, y)
								Loop, 10
								{
									if (BossGetpixel!=dwmgetpixel(x, y))
									{
										sleep 1500
										Break
									}
									sleep 1000
								}
								return
							}
							else
							{
								Loop, 3
								{
									Swipe(998, 443, 300, 443)
									sleep 300
								}
								sleep 500
								if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
								{
									LogShow("發現：最終ＢＯＳＳ(2)！X : " x " Y: " y )
									C_Click(x, y)
									BossGetpixel := dwmgetpixel(x, y)
									Loop, 10
									{
										if (BossGetpixel!=dwmgetpixel(x, y))
										{
											sleep 1500
											Break
										}
										sleep 1000
									}
									return
								}
								else
								{
									Loop, 2
									{
										Swipe(607, 200, 607, 560)
										sleep 300
									}
									sleep 500
									if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
									{
										LogShow("發現：最終ＢＯＳＳ(3)！X : " x " Y: " y )
										C_Click(x, y)
										BossGetpixel := dwmgetpixel(x, y)
										Loop, 10
										{
											if (BossGetpixel!=dwmgetpixel(x, y))
											{
												sleep 1500
												Break
											}
											sleep 1000
										}
										return
									}
								}
							}
						}
						else if (AnchorChapter="異色2" and AnchorChapter2="4") ;異色格地圖太大，直接滑動到BOSS可能的出生點2
						{
							sleep 1000
							if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
							{
								LogShow("發現：最終ＢＯＳＳ！X : " x " Y: " y )
								C_Click(x, y)
								BossGetpixel := dwmgetpixel(x, y)
								Loop, 10
								{
									if (BossGetpixel!=dwmgetpixel(x, y))
									{
										sleep 1500
										Break
									}
									sleep 1000
								}
								return
							}
							else
							{
								Swipe(922, 253, 498, 608)
								sleep 600
								if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and BossFailed<1)
								{
									LogShow("發現：最終ＢＯＳＳ(2)！X : " x " Y: " y )
									C_Click(x, y)
									BossGetpixel := dwmgetpixel(x, y)
									Loop, 10
									{
										if (BossGetpixel!=dwmgetpixel(x, y))
										{
											sleep 1500
											Break
										}
										sleep 1000
									}
									return
								}
							}
						}
					}
					else
					{
						C_Click(xx, yy)
						C_Click(xx, yy)
						sleep 400
						FindWay(xx, yy)
						if (Find(x, y, 495, 330, 530, 390, "|<>*200$8.zyT3kyTzzyT3kwD3kwD3kwD3kwD3kzy"))
						{
							BossFailed++
							LogShow("前往BOSS的路徑被擋住了！")
							sleep 1000
							if !(FightRoundsDo)
							{
								C_Click(1035, 715) ;換回原本的隊伍
								SwitchParty := 0
							}
							sleep 1000
							TargetFailed1 := 0
							TargetFailed2 := 0
							TargetFailed3 := 0
							TargetFailed4 := 0
							return
						}
						sleep 4050
						BackAttack()
						if !(Find(x, y, 0, 587, 86, 647, Formation_Tank) and BossFailed<1) ; 如果沒有成功進入戰鬥，再試一次
						{
							C_Click(xx, yy)
							sleep 2050
						}
					}
				}
				else
				{
					LogShow("優先攻擊－當前隊伍 or 優先攻擊－切換隊伍 發生錯誤")
				}
				return
			}
		}
		if (SirenCount > 0) {
			LogShow("SirenCount: " SirenCount)
			TargetFailed1 := 1
			TargetFailed2 := 1
			TargetFailed3 := 1
			TargetFailed4 := 1
			Plane_TargetFailed1 := 1
		}
		if (Find(x, y, 1189, 572, 1289, 627, Step_3, 0.1, 0.1))
		{
			LogShow("進入凜冬特殊關卡！")
			Loop
			{
				Guicontrol, ,starttext, % "目前狀態：處理凜冬特殊關卡中 …… "  A_index "/60。"
				Message_Normal()
				GetItem()
				if GdipImageSearch(sn, sm, "img/SubChapter/MoveWay.png", 37, 8, MapX1, MapY1, MapX2, MapY2)
					C_Click(sn, sm)
				else if Find(sx, sy, 710, 355, 810, 410, NowScore2)
					C_Click(sx, sy)
				else if (Find(x, y, 1079, 674, 1179, 729, Map_ChapterEventWinter2_Supply))
					break
				else if (A_index=60)
				{
					LogShow("特殊關卡處理失敗，嘗試撤退")
					sleep 1000
					C_Click(834, 716) ;開始撤退
					sleep 2000
					C_Click(791, 556) ;確認
					sleep 2000
					return
				}
				sleep 1000
			}
			sleep 1000
			return
		}
		else if (FindFleet_2(x, y, FP, SearchDirection, MapX1, MapY1, MapX2, MapY2)) ;偵查OO艦隊
		{
			xx := x
			yy := y
			Loop, 10
			{
				if (MoveMap(xx, yy))
				{
					IsDetect := 1
					break
				}
				Guicontrol, ,starttext, % "目前狀態：嘗試前往 " FP " X: " xx " Y: " yy " …… "  A_index "/10。"
				if (IsFine_Switched)
				{
					IsFine_Switched := 0
					break
				}
				if (Find(x, y, 750, 682, 850, 742, Battle_Map)) ;如果在限時(無限時)地圖
				{
					if (MoveMap(xx, yy))
					{
						IsDetect := 1
						break
					}
					C_Click(xx, yy)
					sleep 300
					if FindWay(xx, yy)
						break
					if (Find(x, y, 495, 330, 530, 390, "|<>*200$8.zyT3kyTzzyT3kwD3kwD3kwD3kwD3kzy"))
					{
						if (FP="航空艦隊")
							TargetFailed1 := 1
						else if (FP="運輸艦隊")
							TargetFailed2 := 1
						else if (FP="主力艦隊")
							TargetFailed3 := 1
						else if (FP="偵查艦隊")
							TargetFailed4 := 1	
						else if (FP="航空器")						
							Plane_TargetFailed1 := 1
						LogShow("前往 " FP " 的路徑被擋住了…" SearchLoopcount "/80")
						IsDetect := 1
						Block_Way := 0
						sleep 2000
						break
					}
					sleep 1500
				}
				if (Find(x, y, 0, 587, 86, 647, Formation_Tank))
				{
					Guicontrol, ,starttext, % "目前狀態：編隊頁面，準備出擊！"
					return
				}
				BackAttack()
				sleep 500
			}
		}
		if (AnchorChapter="墜落1" or AnchorChapter="墜落2")  ;
		{
			TargetFailed1 := 1, TargetFailed2 := 1, TargetFailed3 := 1,	TargetFailed4 := 1, BossFailed := 0
			LvIco := ["img/SubChapter/Lv.png"]
			EliteIco := ["img/SubChapter/targetElite_1.png"]
			Random, SearchDirection, 5, 8
			if ((BOSS_RS := FindFleet(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2)
			or LvIco_RS := FindFleet(x, y, LvIco, 30, SearchDirection, MapX1, MapY1, MapX2, MapY2)
			or (Ship_TargetElite and EliteIco_RS := FindFleet(x, y, EliteIco, 0, SearchDirection, MapX1, MapY1, MapX2, MapY2)))
			and !FindBoss)
			{
				LogShow("發現：敵方艦隊！ X: " x " Y: " y " ")
				xx := x 
				yy := y 
				Loop, 15
				{
					if (MoveMap(xx, yy))
					{
						IsDetect := 1
						break
					}
					if (Find(n, m, 750, 682, 850, 742, Battle_Map)) ;如果在限時(無限時)地圖
					{
						C_Click(xx, yy)
						sleep 600
						if FindWay(xx, yy)
							break
						if (Find(n, m, 495, 330, 530, 390, "|<>*200$8.zyT3kyTzzyT3kwD3kwD3kwD3kwD3kzy"))
						{
							LogShow("前往敵方艦隊的路徑被擋住了！")
							IsDetect := 1
							sleep 2000
							break
						}
						sleep 1500
					}
					if (Find(x, y, 0, 587, 86, 647, Formation_Tank))
					{
						Break
					}
					BackAttack()
					sleep 500
				}
				return
			}
			else if (Find(x, y, 1070, 576, 1170, 636, GreenMine))
			{
				LogShow("進入特殊關卡，撤退。")
				C_Click(794, 714)
				sleep 200
				C_Click(781, 545)
			}
		}
		if ((Bossaction!="能不攻擊就不攻擊" or SearchLoopcount>10) and BossFailed<1 ) ;ＢＯＳＳ
		{
			if (GdipImageSearch(x, y, BOSSICO, 15, SearchDirection, MapX1, MapY1, MapX2, MapY2))
			{
				xx := x 
				yy := y 
				if (MoveMap(xx, yy))
				{
					IsDetect := 1
					break
				}
				if (SearchLoopcount>10 and Bossaction="能不攻擊就不攻擊")
				{
					LogShow("已經偵查不到其他船艦，攻擊最終BOSS！")
				}
				else
				{
				LogShow("發現最終BOSS！")
				}
				if (SwitchParty<1 and Bossaction="隨緣攻擊－切換隊伍")
				{
					LogShow("發現BOSS：隨緣攻擊－切換隊伍！")
					SwitchParty := 1
					C_Click(1035, 706)
				}
				else
				{
					C_Click(xx, yy)
					C_Click(xx, yy)
					FindWay(xx, yy)
				}
				if (Find(x, y, 495, 330, 530, 390, "|<>*200$8.zyT3kyTzzyT3kwD3kwD3kwD3kwD3kzy")) 
				{
					BossFailed++
					return
				}
				sleep 4050
				BackAttack()
				if !(Find(x, y, 0, 587, 86, 647, Formation_Tank) and BossFailed<1) ; 如果沒有成功進入戰鬥，再試一次
				{
					C_Click(xx, yy)
					sleep 2050
				}
				return
			}
		}
		if (SirenCount > 0) {
			TargetFailed1 := 1
			TargetFailed2 := 1
			TargetFailed3 := 1
			TargetFailed4 := 1
			Plane_TargetFailed1 := 1
		}
		else if (!BossactionTarget)
		{
			TargetFailed1 := 0
			TargetFailed2 := 0
			TargetFailed3 := 0
			TargetFailed4 := 0
			Plane_TargetFailed1 := 0
		}
		else if (BossFailed)
		{
			TargetFailed1 := 0
			TargetFailed2 := 0
			TargetFailed3 := 0
			TargetFailed4 := 0
			Plane_TargetFailed1 := 0
		}
		if (SearchLoopcount>=2 and Find(x, y, 750, 682, 850, 742, Battle_Map))
		{
			if (SearchFailedMessage<1)
			{
				LogShow("偵查失敗，嘗試拖曳畫面")
				SearchFailedMessage := 1
			}
			if side<1
			{
				Swipe(1013,531,211,106)  ;↖
				Swipe(1013,531,211,106)  ;↖
				side := 2
			}
			else if side=2
			{
				Swipe(652,190,652,710)  ;swipe side : ↓
				side=3
			}
			else if side=3
			{
				Swipe(652,190,652,710)  ;swipe side : ↓
				side=4
			}
			else if side=4
			{
				Swipe(257,310,1040,310) ;swipe side : →
				side=5
			}
			else if side=5
			{
				Swipe(188,241,1164,621) ;swipe side : ↘
				Swipe(188,241,1164,621) ;swipe side : ↘
				side=6
			}
			else if side=6
			{
				Swipe(604,710,652,180)  ;swipe side : ↑
				side=7
			}
			else if side=7
			{
				Swipe(363,555,1011,220) ;swipe side : ↗
				Swipe(363,555,1011,220) ;swipe side : ↗
				side=8
			}
			else if side=8
			{
				Swipe(1256,310,120,310) ;swipe side : ←
				side=0
			}
			sleep 300
			SearchLoopcountFailed++
			SearchLoopcountFailed2++
			if (GdipImageSearch(x, y, "img/SubChapter/Myposition.png", 15, SearchDirection, MapX1, MapY1, MapX2, MapY2) and SearchLoopcountFailed>1)
			{
				if (AnchorChapter=9 and AnchorChapter2=2) ;9-2防卡
				{
					xx := x 
					yy := y + 120
					LogShow("未找到指定目標，嘗試向上移動")
					C_Click(xx, yy)
					C_Click(xx, yy)
				}
				else
				{
					Random, xx, 1, 3
					if xx=1
						xx := x + 150, yy := y + 200
					else if xx=2
						xx := x - 150, yy := y + 200
					else if xx=3
						xx := x, yy := y + 320
					if (xx>130 and xx<1185 and yy>150 and yy<660)
					{
						LogShow("未找到指定目標，嘗試隨機移動")
						MoveCheck := Dwmgetpixel(xx, yy)
						sleep 500
						if (Dwmgetpixel(xx, yy)=MoveCheck) ;避免切換到艦隊
						{
							C_Click(xx, yy)
							C_Click(xx, yy)
						}
						MoveCheck := 0
					}
				}
				SearchLoopcountFailed := 0
				sleep 2000
				if (DwmCheckcolor(793, 711, 16250871))
				{
					MoveFailed++
				}
			}
			if (SirenCount > 0) {
				TargetFailed1 := 1
				TargetFailed2 := 1
				TargetFailed3 := 1
				TargetFailed4 := 1
				Plane_TargetFailed1 := 1
			}
			else if (!BossactionTarget)
			{
				TargetFailed1 := 0
				TargetFailed2 := 0
				TargetFailed3 := 0
				TargetFailed4 := 0
				Plane_TargetFailed1 := 0
			}
			else if (BossactionTarget and SearchLoopcountFailed2>15)
			{
				TargetFailed1 := 0
				TargetFailed2 := 0
				TargetFailed3 := 0
				TargetFailed4 := 0
				Plane_TargetFailed1 := 0
				BossactionTarget := 0
			}
			else if (BossFailed)
			{
				TargetFailed1 := 0
				TargetFailed2 := 0
				TargetFailed3 := 0
				TargetFailed4 := 0
				Plane_TargetFailed1 := 0
			}
			else if (SearchLoopcountFailed2>15)
			{
				TargetFailed1 := 0
				TargetFailed2 := 0
				TargetFailed3 := 0
				TargetFailed4 := 0
				Plane_TargetFailed1 := 0
			}
			if (SearchLoopcountFailed2>50 and ChooseParty2!="不使用" and SwitchParty<1)
			{
					LogShow("未能偵測到任何目標，嘗試切換隊伍")
					SwitchParty := 1
					Random, x, 963, 1096
					Random, y, 701, 728
					C_Click(x,y) ;點擊"切換"
			}
			if (SearchLoopcountFailed2>80)
			{
				LogShow("重複80次未能偵查到目標，撤退")
				TargetFailed1 := 0
				TargetFailed2 := 0
				TargetFailed3 := 0
				TargetFailed4 := 0
				TargetFailed5 := 0
				TargetFailed6 := 0
				Plane_TargetFailed1 := 0
				BossFailed := 0
				BulletFailed := 0
				QuestFailed := 0
				SearchLoopcount := 0
				SearchLoopcountFailed2 := 0
				C_Click(794, 714)
				sleep 200
				C_Click(781, 545)
			}
		}
		SearchLoopcount++
	} until !(Find(bmx, bmy, 750, 682, 850, 742, Battle_Map))
}
else if (Find(x, y, 95, 34, 195, 94, Weigh_Anchor)) ;在出擊選擇關卡的頁面
{
	if (MissionSub and Find(x, y, 1014, 651, 1114, 711, CommisionDone)) ;委託任務已完成
	{
		LogShow("執行軍事委託(主線)！")
		C_Click(1006, 712)
		sleep 1000
		Loop, 60
		{
			if (Find(x, y, 1014, 651, 1114, 711, CommisionDone))
			{
				C_Click(1006, 712)
				sleep 1000
			}
			sleep 300
		} Until Find(x, y, 99, 33, 199, 93, Commision_Delegation)
		sleep 1000
		DelegationMission()
		sleep 1000
		Loop, 30
		{
			if (Find(x, y, 99, 33, 199, 93, Commision_Delegation))
			{
				C_Click(58, 92)
				sleep 2000
			}
			else if (Find(x, y, 95, 34, 195, 94, Weigh_Anchor))
			{
				break
			}
			sleep 500
		}
	}
	if (DailyGoalSub and !DailyDone)
	{
		iniread, Yesterday, %SettingName%, Battle, Yesterday
		FormatTime, Today, ,dd
		Formattime, Checkweek, , Wday ;星期的天數 (1 – 7). 星期天為 1.
		if (Yesterday=Today)
		{
			DailyDone := 1
		}
		else if ((Checkweek=1 or Checkweek=4 or Checkweek=7) and DailyGoalRed) ;
		{
			DailyDone := 0
		}
		else if ((Checkweek=1 or Checkweek=3 or Checkweek=6) and DailyGoalGreen) ;
		{
			DailyDone := 0
		}
		else if ((Checkweek=1 or Checkweek=2 or Checkweek=5) and DailyGoalBlue) ;
		{
			DailyDone := 0
		}
		else if (DailyHardMap)
		{
			DailyDone := 2
		}
		else 
		{
			DailyDone := 1
		}
		if (DailyHardMap and (DailyDone=0 or DailyDone=2)) ;切換地圖模式及關卡
		{
			LogShow("切換每日困難地圖：第 " DailyHardMap2 " 章 第 " DailyHardMap3 " 節 ")
			AnchorMode := "困難"
			AnchorChapter := DailyHardMap2
			AnchorChapter2 := DailyHardMap3
			IsDailyHardMap := 1
		}
		if (DailyDone=0)
		{
			if (Find(x, y, 95, 34, 195, 94, Weigh_Anchor) and Find(x, y, 774, 684, 874, 744, Daily_Task))
			{ ;如果在出擊頁面檢查到每日還沒執行
				LogShow("執行每日任務！")
				Loop
				{
					if (Find(x, y, 95, 34, 195, 94, Weigh_Anchor) and Find(x, y, 774, 684, 874, 744, Daily_Task))  ;如果在出擊頁面檢查到每日還沒執行
					{
						C_Click(826, 709) ;嘗試進入每日頁面
						sleep 3000
					}
					if (Find(x, y, 98, 33, 198, 93, DailyRaid))
					{
						Break ;成功進入每日頁面
					}
					sleep 500
				}
			Goto, DailyGoalSub
			}
		}
		else
		{
			DailyDone := 1
		}
	}
	if (OperationSub and !OperationDone)
	{
		iniread, OperationYesterday, %SettingName%, Battle, OperationYesterday
		FormatTime, OperationToday, ,dd
		if (OperationYesterday=OperationToday)
		{
			OperationDone := 1
		}
		else if (ResetOperationTime and OperationYesterday>=1)
		{
			OperationDone := 1
		}
		else
		{
			if (Operation_ReLogin and !IsOperation_ReLogin) 
			{
				if (EmulatorCrushCheck and !Noxplayer5) ;關閉檢測桌面 避免誤判閃退
					Settimer, EmulatorCrushCheckSub, off
				LogShow("演習前重登。")
				runwait, %Consolefile% killapp --index %emulatoradb% --packagename "com.hkmanjuu.azurlane.gp" , %ldplayer%, Hide
				Loop
				{
					if (Find(x, y, 1107, 25, 1207, 80, Emulator_Wifi))
						break
					else if (A_index>=60) 
					{
						LogShow("返回桌面的過程中發生錯誤")
						break
					}
					sleep 1000
				}
				runwait, %Consolefile% runapp --index %emulatoradb% --packagename "com.hkmanjuu.azurlane.gp" , %ldplayer%, Hide
				IsOperation_ReLogin := 1
				sleep 5000
				if (EmulatorCrushCheck and !Noxplayer5)
					Settimer, EmulatorCrushCheckSub, 60000
				return
			}
			if (Find(x, y, 95, 34, 195, 94, Weigh_Anchor) and Find(x, y, 1078, 663, 1178, 723, BTN_Exercise))
			{ ;如果在出擊頁面檢查到演習還沒執行
				if (Operation_ReLogin and IsOperation_ReLogin)
				{
					IsOperation_ReLogin := 0
				}
				LogShow("自動執行演習！")
				Loop
				{
					if (Find(x, y, 95, 34, 195, 94, Weigh_Anchor) and Find(x, y, 1078, 663, 1178, 723, BTN_Exercise)) ;如果在出擊頁面檢查到演習還沒執行
					{
						C_Click(1177, 706) ;嘗試進入演習頁面
						sleep 3000
					}
					if (Find(x, y, 99, 35, 199, 95, Operation_Upp)) ;左上"演習"
					{
						Break ;成功進入每日頁面
					}
				}
			Goto, OperationSub
			}
		}
	}
	if (StopAnchor=1)
	{
		LogShow("停止出擊中，返回首頁")
		C_Click(56, 86)
		sleep 1000
		return
	}
	if (BattleTimes) ;如果有勾選出擊N輪
	{
		if (WeighAnchorCount>=BattleTimes2 or BattleTimes2=0) ;如果已達出擊次數
		{
			textshow = 已出擊 %WeighAnchorCount% 輪，強制休息。
			WeighAnchorCount := 0
			LogShow(textshow)
			sleep 1000
			StopAnchor := 1
			C_Click(1229, 71) ;回首頁
			return
		}
	}
	if (StopBattleTime) ;勾選 " 每出擊N輪
	{
		if (StopBattleTimeCount>=StopBattleTime2)
		{
			StopAnchor := 1
			textshow = ☆☆ 已出擊 %StopBattleTimeCount% 輪，休息 %StopBattleTime3% 分鐘。 ☆☆
			LogShow(textshow)
			StopBattleTimeCount := 0
			StopBattleTime3ms := StopBattleTime3*60*1000
			Settimer, clock, -%StopBattleTime3ms%
			C_Click(1229, 71) ;回首頁
			sleep 5000
			return
		}
	}
	if (WeighAnchorCount>=5) ;每打5輪回首頁 (檢查一些在首頁才會有的功能)
	{
		WeighAnchorCount := 0
		C_Click(1229, 71) 
		sleep 2000
		return
	}
	if (DailyHardMap and IsDailyHardMap) ;每日切換地圖模式及關卡
	{
		AnchorMode := "困難"
		AnchorChapter := DailyHardMap2
		AnchorChapter2 := DailyHardMap3
		IsDailyHardMap := 1
	}
	bulletFailed := 1 ;進去關卡第一輪不拿彈藥
	StopBattleTimeCount++ ;每出擊N場修及的判斷次數
	WeighAnchorCount++ ;判斷目前出擊次數
	FightRoundsDoCount := 0 ;將艦隊A每出擊次數歸零
	FightRoundsDone := 0 ;將艦隊A每出擊次數歸零
	TakeQuest := 0 ;將拿取神祕物資次數歸零
	NowHP := 0 ;清空目前HP
	sleep 1000 ;判斷現在位於第幾關 1 2 3 4 5 6 7 8 9 
	Chapter1 := Find(x, y, 162, 499, 262, 559, Map01_1)  ;第一關 1-1
	Chapter2 := Find(x, y, 830, 500, 930, 560, Map02_1) ;第二關 2-1
	Chapter3 := Find(x, y, 419, 263, 519, 323, Map03_1) ;第三關 3-1
	Chapter4 := Find(x, y, 252, 349, 352, 409, Map04_1) ;第四關 4-1
	Chapter5 := Find(x, y, 256, 409, 356, 469, Map05_1) ;第五關 5-1
	Chapter6 := Find(x, y, 933, 541, 1033, 601, Map06_1) ;第六關 6-1
	Chapter7 := Find(x, y, 222, 524, 322, 584, Map07_1) ;第七關 7-1
	Chapter8 := Find(x, y, 568, 230, 668, 290, Map08_1) ; 第八關 8-1
	Chapter9 := Find(x, y, 246, 282, 346, 337, Map09_1) ;第九關 9-1
	Chapter10 := Find(x, y, 215, 285, 315, 340, Map10_1) ;10-1
	Chapter11 := 0
	Chapter12 := 0
	Chapter13 := 0
	ChapterEvent1 := DwmCheckcolor(500, 248, 16777215) ;14 活動：紅染1 A1
	ChapterEvent2 := DwmCheckcolor(421, 588, 16777215) ;15 活動：紅染2 B1
	ChapterEventSP := DwmCheckcolor(530, 263, 16777215) ; 16 活動：努力、希望和計畫
	ChapterEvent3 := DwmCheckcolor(272, 291, 16777215) ;17 活動 異色格1 A1
	ChapterEvent4 := if (GdipImageSearch(x, y, "img/Number/Number_1.png", 60, 8, 359, 292, 380, 322)) ? 1 : 0 ;18 活動 異色格2 
	ChapterEvent5 := Find(x, y, 449, 273, 549, 333, Map_ChapterEvent5_1) ;19墜落之翼 A-1
	ChapterEvent6 := Find(x, y, 420, 431, 520, 491, Map_ChapterEvent6_1)  ;20墜落之翼 D-1
	ChapterEventglory := Find(x, y, 287, 319, 387, 374, Map_ChapterEventglorySP1) ;21 光榮Sp
	ChapterEventWinter1 := Find(x, y, 321, 303, 421, 358, Map_ChapterEventWinter1_1) ;22 凜冬1
	ChapterEventWinter2 := Find(x, y, 338, 505, 438, 560, Map_ChapterEventWinter2_1)  ;23 凜冬23
	ChapterEventInk1:= Find(x, y, 338, 305, 418, 333, Map_ChapterEventInk1_1)  ;24 墨染1
	ChapterEventInk2:= Find(x, y, 422, 499, 464, 523, Map_ChapterEventInk2_1)  ;25 墨染2
	ChapterEventIris1:= Find(x, y, 288, 277, 370, 303, Map_ChapterEventIris1_1)  ;26 鳶尾1
	ChapterEventIris2:= Find(x, y, 375, 289, 427, 321, Map_ChapterEventIris2_1)  ;27 鳶尾2
	ChapterFailed := 1
	array := [Chapter1, Chapter2,Chapter3, Chapter4, Chapter5, Chapter6, Chapter7, Chapter8, Chapter9, Chapter10, Chapter11, Chapter12, Chapter13, ChapterEvent1,ChapterEvent2, ChapterEventSP, ChapterEvent3, ChapterEvent4, ChapterEvent5, ChapterEvent6, ChapterEventglory,  ChapterEventWinter1, ChapterEventWinter2, ChapterEventInk1, ChapterEventInk2, ChapterEventIris1, ChapterEventIris2, ChapterFailed]
	Chapter := 0
	Loop % array.MaxIndex()
	{
		this_Chapter := array[A_Index]
		Chapter++
		if (this_Chapter=1)
		{
			break
		}
	}
	;~ LogShow("目前位於第 " Chapter " 關")
	if (AnchorChapter=Chapter) 
	{
		;~ LogShow("畫面已經在主線地圖") 
	}
	else if (IndexValue(Chapter, 14, 15, 17, 18, 19, 20, 22, 23, 24, 25, 26, 27)) 
	and ((AnchorChapter="紅染1" or AnchorChapter="紅染2") 
	or (AnchorChapter="異色1" or AnchorChapter="異色2") 
	or (AnchorChapter="墜落1" or AnchorChapter="墜落2")
	or (AnchorChapter="墨染1" or AnchorChapter="墨染2")
	or (AnchorChapter="鳶尾1" or AnchorChapter="鳶尾2")
	or (AnchorChapter="凜冬1" or AnchorChapter="凜冬2"))
	{
		BacktoNormalMap++
		if ((OperationSub and OperationDone<1) or (DailyGoalSub and DailyDone<1) or (BacktoNormalMap>2))
		{
			Message = 位於%AnchorChapter%地圖，返回主線。
			LogShow(Message)
			BacktoNormalMap := 0
			C_Click(60, 90)
			return
		}
	}
	else if (IndexValue(Chapter, 16, 21) and AnchorChapter="希望1" AnchorChapter="光榮1")
	{
		;~ LogShow("畫面已經在希望1地圖") 
	}
	else if ((IndexValue(Chapter, 14, 15, 16, 17, 18, 19, 20, 22, 23, 24, 25)) and ((OperationSub and OperationDone<1) or (DailyGoalSub and DailyDone<1)))
	{
		if (OperationSub and OperationDone<1)
			text1=每日
		if (DailyGoalSub and DailyDone<1)
			text1=演習
		SendText = 位於活動關卡，返回地圖執行%text1%。
		LogShow(SendText)
		C_Click(60, 90)
		return
	}
	else if (IndexValue(Chapter, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27) and (AnchorChapter>=1 and AnchorChapter<=14))
	{
		LogShow("位於活動地圖，返回主線。")
		C_Click(60, 90)
		return
	}
	else if (Chapter=array.MaxIndex())
	{
		LogShow("選擇章節時發生錯誤2")
	}
	else
	{
		;~ LogShow("1111")
		ClickSide := (AnchorChapter-Chapter) ; 負數點右邊 正數點左邊
		ClickCount := abs(AnchorChapter-Chapter)
		if (ClickSide>0)
		{
			Loop, %ClickCount%
			{
			C_Click(1224,412)
			sleep 200
			}
		}
		else
		{
			Loop, %ClickCount%
			{
			C_Click(52,412)
			sleep 200
			}
		}
	}
	Chaptermessage = —選擇關卡： %AnchorMode% 第 %AnchorChapter% 章 第 %AnchorChapter2% 節—
	LogShow(Chaptermessage)
	if (AnchorChapter>=1 and AnchorChapter<=14)
	{
		sleep 250
		SelectMode()
		sleep 250
		if (AnchorChapter=1 and AnchorChapter2=1) ; 選擇關卡 1-1
		{
			if (DwmCheckcolor(220, 527, 16777215))
			{
				C_Click(221,526)
			}
		}
		else if (AnchorChapter=1 and AnchorChapter2=2) ; 選擇關卡 1-2
		{
			if (DwmCheckcolor(509, 341, 16777215))
			{
				C_Click(510,342)
			}
		}
		else if (AnchorChapter=1 and AnchorChapter2=3) ; 選擇關卡 1-3
		{
			if (DwmCheckcolor(712, 599, 16777215))
			{
				C_Click(713,600)
			}
		}
		else if (AnchorChapter=1 and AnchorChapter2=4) ; 選擇關卡 1-4
		{
			if (DwmCheckcolor(861, 246, 16777215))
			{
				C_Click(862,247)
			}
		}
		else if (AnchorChapter=2 and AnchorChapter2=1) ; 選擇關卡 2-1
		{
			if (DwmCheckcolor(867, 531, 16777215))
			{
				C_Click(868,530)
			}
		}
		else if (AnchorChapter=2 and AnchorChapter2=2) ; 選擇關卡 2-2
		{
			if (DwmCheckcolor(802, 261, 16777215))
			{
				C_Click(803,262)
			}
		}
		else if (AnchorChapter=2 and AnchorChapter2=3) ; 選擇關卡 2-3
		{
			if (DwmCheckcolor(341, 345, 16777215))
			{
				C_Click(341,346)
			}
		}
		else if (AnchorChapter=2 and AnchorChapter2=4) ; 選擇關卡 2-4
		{
			if (DwmCheckcolor(437, 619, 16777215))
			{
				C_Click(438,620)
			}
		}
		else if (AnchorChapter=3 and AnchorChapter2=1) ; 選擇關卡3-1
		{
			if (DwmCheckcolor(476, 292, 16777215))
			{
				C_Click(477,293)
			}
		}
		else if (AnchorChapter=3 and AnchorChapter2=2) ; 選擇關卡3-2
		{
			if (DwmCheckcolor(304, 572, 16777215))
			{
				C_Click(305,573)
			}
		}
		else if (AnchorChapter=3 and AnchorChapter2=3) ; 選擇關卡3-3
		{
			if (DwmCheckcolor(866, 208, 16777215))
			{
				C_Click(867,209)
			}
		}
		else if (AnchorChapter=3 and AnchorChapter2=4) ; 選擇關卡3-4
		{
			if (DwmCheckcolor(690, 432, 16777215))
			{
				C_Click(691,433)
			}
		}
		else if (AnchorChapter=4 and AnchorChapter2=1) ; 選擇關卡4-1
		{
			if (DwmCheckcolor(311, 377, 16777215))
			{
				C_Click(312,378)
			}
		}
		else if (AnchorChapter=4 and AnchorChapter2=2) ; 選擇關卡4-2
		{
			if (DwmCheckcolor(476, 540, 16777215))
			{
				C_Click(477,541)
			}
		}
		else if (AnchorChapter=4 and AnchorChapter2=3) ; 選擇關卡4-3
		{
			if (DwmCheckcolor(878, 618, 16777215))
			{
				C_Click(879,619)
			}
		}
		else if (AnchorChapter=4 and AnchorChapter2=4) ; 選擇關卡4-4
		{
			if (DwmCheckcolor(855, 360, 16777215))
			{
				C_Click(856,361)
			}
		}
		else if (AnchorChapter=5 and AnchorChapter2=1) ; 選擇關卡5-1
		{
			if (DwmCheckcolor(315, 437, 16777215))
			{
				C_Click(516,438)
			}
		}
		else if (AnchorChapter=5 and AnchorChapter2=2) ; 選擇關卡5-2
		{
			if (DwmCheckcolor(906, 607, 16777215))
			{
			C_Click(907,608)
			}
		}
		else if (AnchorChapter=5 and AnchorChapter2=3) ; 選擇關卡5-3
		{
			if (DwmCheckcolor(788, 435, 16777215))
			{
				C_Click(789,436)
			}
		}
		else if (AnchorChapter=5 and AnchorChapter2=4) ; 選擇關卡5-4
		{
			if (DwmCheckcolor(642, 284, 16777215))
			{
				C_Click(623,285)
			}
		}
		else if (AnchorChapter=6 and AnchorChapter2=1) ; 選擇關卡6-1
		{
			if (DwmCheckcolor(965, 573, 16777215))
			{
				C_Click(966,574)
			}
		}
		else if (AnchorChapter=6 and AnchorChapter2=2) ; 選擇關卡6-2
		{
			if (DwmCheckcolor(777, 416, 16777215))
			{
				C_Click(778,417)
			}
		}
		else if (AnchorChapter=6 and AnchorChapter2=3) ; 選擇關卡6-3
		{
			if (DwmCheckcolor(477, 289, 16777215))
			{
				C_Click(478,290)
			}
		}
		else if (AnchorChapter=6 and AnchorChapter2=4) ; 選擇關卡6-4
		{
			if (DwmCheckcolor(373, 498, 16777215))
			{
				C_Click(374,499)
			}
		}
		else if (AnchorChapter=7 and AnchorChapter2=1) ; 選擇關卡7-1
		{
			if (DwmCheckcolor(279, 558, 16777215))
			{
				C_Click(280,559)
			}
		}
		else if (AnchorChapter=7 and AnchorChapter2=2) ; 選擇關卡7-2
		{
			if (DwmCheckcolor(533, 255, 16777215))
			{
				C_Click(534,256)
			}
		}
		else if (AnchorChapter=7 and AnchorChapter2=3) ; 選擇關卡7-3
		{
			if (DwmCheckcolor(875, 356, 16777215))
			{
				C_Click(876,357)
			}
		}
		else if (AnchorChapter=7 and AnchorChapter2=4) ; 選擇關卡7-4
		{
			if (DwmCheckcolor(1018, 521, 16777215))
			{
				C_Click(1019,522)
			}
		}
		else if (AnchorChapter=8 and AnchorChapter2=1) ; 選擇關卡8-1
		{
			if (DwmCheckcolor(623, 259, 16777215))
			{
				C_Click(624,259)
			}
		}
		else if (AnchorChapter=8 and AnchorChapter2=2) ; 選擇關卡8-2
		{
			if (DwmCheckcolor(349, 431, 16777215))
			{
				C_Click(348,430)
			}
		}
		else if (AnchorChapter=8 and AnchorChapter2=3) ; 選擇關卡8-3
		{
			if (DwmCheckcolor(390, 638, 16777215))
			{
				C_Click(391,639)
			}
		}
		else if (AnchorChapter=8 and AnchorChapter2=4) ; 選擇關卡8-4
		{
			if (DwmCheckcolor(858, 532, 16777215))
			{
				C_Click(859,533)
			}
		}
		else if (AnchorChapter=9 and AnchorChapter2=1) ; 選擇關卡9-1
		{
			if Find(x, y, 246, 282, 346, 337, Map09_1)
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter=9 and AnchorChapter2=2) ; 選擇關卡9-2
		{
			if (Find(x, y, 394, 532, 494, 592, Map09_2))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter=9 and AnchorChapter2=3) ; 選擇關卡9-3
		{
			if (Find(x, y, 802, 308, 902, 368, Map09_3))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter=9 and AnchorChapter2=4) ; 選擇關卡9-4
		{
			if (Find(x, y, 934, 560, 1034, 620, Map09_4))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter=10 and AnchorChapter2=1) ; 選擇關卡10-1
		{
			if (Find(x, y, 215, 285, 315, 340, Map10_1))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter=10 and AnchorChapter2=2) ; 選擇關卡10-2
		{
			if (Find(x, y, 483, 425, 583, 480, Map10_2))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter=10 and AnchorChapter2=3) ; 選擇關卡10-3
		{
			if (Find(x, y, 665, 582, 765, 637, Map10_3))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter=10 and AnchorChapter2=4) ; 選擇關卡10-4
		{
			if (Find(x, y, 765, 286, 865, 341, Map10_4))
			{
				C_Click(x, y)
			}
		}
		else
		{
			LogShow("選擇地圖：" AnchorChapter " 章 第 " AnchorChapter2 "節發生錯誤")
			return
		}
	}
	else if (AnchorChapter="紅染1" or AnchorChapter="紅染2")
	{
		if (DwmCheckcolor(1238, 246, 16760369) and (AnchorChapter="紅染1" or AnchorChapter="紅染2"))
		{
			C_Click(1201, 226)
			sleep 2000
		}
		else if (ChapterEvent1 and AnchorChapter="紅染2") ;
		{
			C_Click(1223, 411)
			sleep 2000
		}
		else if (ChapterEvent2 and AnchorChapter="紅染1") ;
		{
			C_Click(48, 409)
			sleep 2000
		}
		if (AnchorChapter="紅染1" and AnchorChapter2=1)
		{
			if (DwmCheckcolor(500, 249, 16777215))
			{
				C_Click(501,250)
			}
		}
		else if (AnchorChapter="紅染1" and AnchorChapter2=2)
		{
			if (DwmCheckcolor(798, 594, 16777215))
			{
				C_Click(799,595)
			}
		}
		else if (AnchorChapter="紅染1" and AnchorChapter2=3)
		{
			if (DwmCheckcolor(963, 326, 16777215))
			{
				C_Click(964,325)
			}
		}
		else if (AnchorChapter="紅染1" and AnchorChapter2=4)
		{
			LogShow("紅染1篇沒有第四關")
		}
		else if (AnchorChapter="紅染2" and AnchorChapter2=1)
		{
			if (DwmCheckcolor(421, 591, 16777215))
			{
				C_Click(422,592)
			}
		}
		else if (AnchorChapter="紅染2" and AnchorChapter2=2)
		{
			if (DwmCheckcolor(935, 573, 16777215))
			{
				C_Click(936,574)
			}
		}
		else if (AnchorChapter="紅染2" and AnchorChapter2=3)
		{
			if (DwmCheckcolor(774, 297, 16777215))
			{
				C_Click(775,298)
			}
		}
	}
	else if (AnchorChapter="希望1")
	{
		if (DwmCheckcolor(1199, 234, 16772054) and AnchorChapter="希望1")
		{
			C_Click(1201, 226) ;畫面在主線地圖時，點擊特殊作戰進入SP地圖
			sleep 2000
		}
		if (AnchorChapter="希望1" and AnchorChapter2=1)
		{
			if (DwmCheckcolor(530, 265, 16777215))
			{
				C_Click(531,264) ;點擊SP1
			}
		}
		else if (AnchorChapter="希望1" and AnchorChapter2=2)
		{
			if (DwmCheckcolor(819, 395, 16777215))
			{
				C_Click(820,394) ;點擊SP2
			}
		}
		else if (AnchorChapter="希望1" and AnchorChapter2=3)
		{
			if (DwmCheckcolor(649, 601, 16777215))
			{
				C_Click(650,600) ;點擊SP3
			}
		}
	}
	else if (AnchorChapter="光榮1")
	{
		if (Find(x, y, 1137, 242, 1237, 297, Map_Special) and AnchorChapter="光榮1")
		{
			C_Click(1201, 226) ;畫面在主線地圖時，點擊特殊作戰進入SP地圖
			sleep 2000
		}
		if (AnchorChapter="光榮1" and AnchorChapter2=1)
		{
			if (Find(x, y, 287, 319, 387, 374, Map_ChapterEventglorySP1))
			{
				C_Click(x, y) ;點擊SP1
			}
		}
		else if (AnchorChapter="光榮1" and AnchorChapter2=2)
		{
			if (Find(x, y, 394, 581, 494, 636, Map_ChapterEventglorySP2))
			{
				C_Click(x, y) ;點擊SP2
			}
		}
		else if (AnchorChapter="光榮1" and AnchorChapter2=3)
		{
			if (Find(x, y, 844, 435, 944, 490, Map_ChapterEventglorySP3))
			{
				C_Click(x, y) ;點擊SP3
			}
		}
	}
	else if (AnchorChapter="異色1" or AnchorChapter="異色2")
	{
		if (DwmCheckcolor(1194, 232, 16772062) and (AnchorChapter="異色1" or AnchorChapter="異色2")) ;如果在主線，則進入異色關卡
		{
			C_Click(1201, 226) 
			sleep 2000
		}
		else if (ChapterEvent3 and AnchorChapter="異色2") ;
		{
			C_Click(1223, 411)
			sleep 2000
		}
		else if (ChapterEvent4 and AnchorChapter="異色1") ;
		{
			C_Click(48, 409)
			sleep 2000
		}
		if (AnchorChapter="異色1" and AnchorChapter2=1)
		{
			if (DwmCheckcolor(272, 291, 16777215))
			{
				C_Click(284,292)
			}
		}
		else if (AnchorChapter="異色1" and AnchorChapter2=2)
		{
			if (DwmCheckcolor(378, 565, 16777215))
			{
				C_Click(373,564)
			}
		}
		else if (AnchorChapter="異色1" and AnchorChapter2=3)
		{
			if (DwmCheckcolor(858, 314, 16777215))
			{
				C_Click(864,319)
			}
		}
		else if (AnchorChapter="異色1" and AnchorChapter2=4)
		{
			if (DwmCheckcolor(941, 575, 16777215))
			{
				C_Click(955,577)
			}
		}
		else if (AnchorChapter="異色2" and AnchorChapter2=1)
		{
			if (GdipImageSearch(x, y, "img/Number/Number_1.png", 100, 8, 359, 292, 380, 322))
			{
				C_Click(422,305)
			}
		}
		else if (AnchorChapter="異色2" and AnchorChapter2=2)
		{
			if (GdipImageSearch(x, y, "img/Number/Number_2.png", 100, 8, 933, 253, 953, 280))
			{
				C_Click(966,265)
			}
		}
		else if (AnchorChapter="異色2" and AnchorChapter2=3)
		{
			if (GdipImageSearch(x, y, "img/Number/Number_3.png", 100, 8, 473, 592, 493, 621))
			{
				C_Click(517,608)
			}
		}
		else if (AnchorChapter="異色2" and AnchorChapter2=4)
		{
			if (GdipImageSearch(x, y, "img/Number/Number_4.png", 100, 8, 780, 421, 800, 450))
			{
				C_Click(817,435)
			}
		}
	}
	else if (AnchorChapter="墜落1" or AnchorChapter="墜落2")
	{
		SelectMode() 
		if (Find(x, y, 1137, 243, 1237, 303, SPEvent) and (AnchorChapter="墜落1" or AnchorChapter="墜落2")) ;如果在主線，則進入墜落關卡
		{
			C_Click(1201, 226) 
			sleep 2000
		}
		else if (ChapterEvent5 and AnchorChapter="墜落2") ;
		{
			C_Click(1223, 411)
			sleep 2000
		}
		else if (ChapterEvent6 and AnchorChapter="墜落1") ;
		{
			C_Click(48, 409)
			sleep 2000
		}
		if (AnchorChapter="墜落1" and AnchorChapter2=1)
		{
			if (Find(x, y, 449, 273, 549, 333, Map_ChapterEvent5_1))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="墜落1" and AnchorChapter2=2)
		{
			if (Find(x, y, 618, 601, 718, 661, Map_ChapterEvent5_2))
			{
				C_Click(x, y)
			}
		}		
		else if (AnchorChapter="墜落1" and AnchorChapter2=3)
		{
			if (Find(x, y, 984, 318, 1084, 378, Map_ChapterEvent5_3))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="墜落1" and AnchorChapter2=4)
		{
			LogShow("地圖：墜落1不具第 4 節")
			StopAnchor := 1
			return
		}
		else if (AnchorChapter="墜落2" and AnchorChapter2=1)
		{
			if (Find(x, y, 420, 431, 520, 491, Map_ChapterEvent6_1))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="墜落2" and AnchorChapter2=2)
		{
			if (Find(x, y, 815, 600, 915, 660, Map_ChapterEvent6_2))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="墜落2" and AnchorChapter2=3)
		{
			if (Find(x, y, 921, 282, 1021, 342, Map_ChapterEvent6_3))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="墜落2")
		{
			LogShow("地圖：墜落2 尚未完成")
			StopAnchor := 1
			return
		}
	}
	else if (AnchorChapter="凜冬1" or AnchorChapter="凜冬2")
	{
		SelectMode() 
		if (Find(x, y, 1137, 242, 1237, 297, Map_Special) and (AnchorChapter="凜冬1" or AnchorChapter="凜冬2")) ;如果在主線，則進入凜冬關卡
		{
			C_Click(1201, 226) 
			sleep 2000
		}
		else if (ChapterEventWinter1 and AnchorChapter="凜冬2") ;
		{
			C_Click(1223, 411)
			sleep 2000
		}
		else if (ChapterEventWinter2 and AnchorChapter="凜冬1") ;
		{
			C_Click(48, 409)
			sleep 2000
		}
		if (AnchorChapter="凜冬1" and AnchorChapter2=1)
		{
			if (Find(x, y, 321, 303, 421, 358, Map_ChapterEventWinter1_1))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="凜冬1" and AnchorChapter2=2)
		{
			if (Find(x, y, 789, 543, 889, 598, Map_ChapterEventWinter1_2))
			{
				C_Click(x, y)
			}
		}		
		else if (AnchorChapter="凜冬1" and AnchorChapter2=3)
		{
			if (Find(x, y, 947, 318, 1047, 373, Map_ChapterEventWinter1_3))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="凜冬1" and AnchorChapter2=4)
		{
			LogShow("地圖：凜冬1不具第 4 節")
			StopAnchor := 1
			return
		}
		else if (AnchorChapter="凜冬2" and AnchorChapter2=1)
		{
			if (Find(x, y, 338, 505, 438, 560, Map_ChapterEventWinter2_1))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="凜冬2" and AnchorChapter2=2)
		{
			if (Find(x, y, 921, 578, 1021, 633, Map_ChapterEventWinter2_2))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="凜冬2" and AnchorChapter2=3)
		{
			if (Find(x, y, 965, 316, 1065, 371, Map_ChapterEventWinter2_3))
			{
				C_Click(x, y)
			}
		}
		else if (AnchorChapter="凜冬2"  and AnchorChapter2=4)
		{
			LogShow("執行EX難度")
			if (Find(x, y, 199, 674, 299, 729, Map_ChapterEventWinter2_EX_Mode))
			{
				C_Click(x, y)
				sleep 1000
			}
			if (Find(x, y, 508, 460, 608, 515, Map_ChapterEventWinter2_EX))
			{
				C_Click(x, y)
			}
		}
	}
	else if (AnchorChapter="墨染1" or AnchorChapter="墨染2")
	{
		SelectMode() 
		if (Find(x, y, 1137, 242, 1237, 297, Map_Special) and (AnchorChapter="墨染1" or AnchorChapter="墨染2")) ;如果在主線，則進入凜冬關卡
		{
			C_Click(1201, 226) 
			sleep 2000
			StopBattleTimeCount-- ;每出擊N場修及的判斷次數
		}
		else if (ChapterEventInk1 and AnchorChapter="墨染2") ;
		{
			C_Click(1223, 411)
			sleep 2000
			StopBattleTimeCount-- ;每出擊N場修及的判斷次數
		}
		else if (ChapterEventInk2 and AnchorChapter="墨染1") ;
		{
			C_Click(48, 409)
			sleep 2000
			StopBattleTimeCount-- ;每出擊N場修及的判斷次數
		}
		else if (AnchorChapter="墨染1" and AnchorChapter2=1)
		{
			if (Find(x, y, 338, 305, 418, 333, Map_ChapterEventInk1_1))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 1
					else
						Global SirenCount := 2
				}
			}
		}
		else if (AnchorChapter="墨染1" and AnchorChapter2=2)
		{
			if (Find(x, y, 436, 524, 480, 546, Map_ChapterEventInk1_2))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 1
					else
						Global SirenCount := 2
				}
			}
		}
		else if (AnchorChapter="墨染1" and AnchorChapter2=3)
		{
			if (Find(x, y, 974, 572, 1054, 598, Map_ChapterEventInk1_3))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 1
					else
						Global SirenCount := 2
				}
			}
		}
		else if (AnchorChapter="墨染1" and AnchorChapter2=4)
		{
			if (Find(x, y, 857, 344, 943, 370, Map_ChapterEventInk1_4))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 1
					else
						Global SirenCount := 2
				}
			}
		}
		else if (AnchorChapter="墨染2" and AnchorChapter2=1)
		{
			if (Find(x, y, 422, 499, 464, 523, Map_ChapterEventInk2_1))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 1
					else
						Global SirenCount := 3
				}
			}
		}
		else if (AnchorChapter="墨染2" and AnchorChapter2=2)
		{
			if (Find(x, y, 914, 423, 992, 445, Map_ChapterEventInk2_2))
			{
				C_Click(x, y)
				Global side := 8
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 2
					else
						Global SirenCount := 3
				}
			}
		}
	}
	else if (AnchorChapter="鳶尾1" or AnchorChapter="鳶尾2")
	{
		SelectMode() 
		if (Find(x, y, 1167, 259, 1245, 287, Map_Special) and (AnchorChapter="鳶尾1" or AnchorChapter="鳶尾2")) ;如果在主線，則進入凜冬關卡
		{
			C_Click(1201, 226) 
			sleep 2000
			StopBattleTimeCount-- ;每出擊N場修及的判斷次數
		}
		else if (ChapterEventIris1 and AnchorChapter="2") ;
		{
			C_Click(1223, 411)
			sleep 2000
			StopBattleTimeCount-- ;每出擊N場修及的判斷次數
		}
		else if (ChapterEventIris2 and AnchorChapter="1") ;
		{
			C_Click(48, 409)
			sleep 2000
			StopBattleTimeCount-- ;每出擊N場修及的判斷次數
		}
		else if (AnchorChapter="鳶尾1" and AnchorChapter2=1)
		{
			if (Find(x, y, 288, 277, 370, 303, Map_ChapterEventIris1_1))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 1
					else
						Global SirenCount := 2
				}
			}
		}
		else if (AnchorChapter="鳶尾1" and AnchorChapter2=2)
		{
			if (Find(x, y, 872, 296, 922, 328, Map_ChapterEventIris1_2))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 1
					else
						Global SirenCount := 2
				}
			}
		}
		else if (AnchorChapter="鳶尾1" and AnchorChapter2=3)
		{
			if (Find(x, y, 568, 496, 658, 526, Map_ChapterEventIris1_3))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 1
					else
						Global SirenCount := 2
				}
			}
		}
		else if (AnchorChapter="鳶尾2" and AnchorChapter2=1)
		{
			if (Find(x, y, 375, 289, 427, 321, Map_ChapterEventIris2_1))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 1
					else
						Global SirenCount := 2
				}
			}
		}
		else if (AnchorChapter="鳶尾2" and AnchorChapter2=2)
		{
			if (Find(x, y, 495, 595, 597, 617, Map_ChapterEventIris2_2))
			{
				C_Click(x, y)
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 2
					else
						Global SirenCount := 3
				}
			}
		}
		else if (AnchorChapter="鳶尾2" and AnchorChapter2=3)
		{
			if (Find(x, y, 803, 422, 887, 448, Map_ChapterEventIris2_3))
			{
				C_Click(x, y)
				Global side := 8
				if (Ship_TargetElite and Ship_TargetE_S=1) {
					if (AnchorMode="普通")
						Global SirenCount := 2
					else
						Global SirenCount := 3
				}
			}
		}
	}
	else
	{
		LogShow("選擇關卡時發生錯誤！")
		sleep 2000
		return
	}
	sleep 2000
	SwitchParty := 0 ;BOSS換隊
	ToMap()
	;~ ChapterCheck := ("0,0,0")
	;~ ChapterCheckArray := StrSplit(ChapterCheck, ",")
	;~ msgbox % ChapterCheckArray.MaxIndex()
	;~ Loop % ChapterCheckArray.MaxIndex()
	;~ {
		;~ this_Chapter := ChapterCheckArray[A_Index]
		;~ Chapter++
		;~ if (this_Chapter=1)
		;~ {
			;~ msgbox, 目前位於：第 %Chapter% 關
			;~ Chapter := 0
			;~ break
		;~ }
	;~ }
	;~ LogShow("ERROR")
}
else
{
	battlevictory()
	Battle()
	ChooseParty(StopAnchor)
	ToMap()
	shipsfull()
	BackAttack()
	Message_Story()
	Battle_End()
	UnknowWife()
	Message_Normal()
	Message_Center()
	GetCard()
	GetItem()
	battlevictory()
	GuLuGuLuLu()
	CloseEventList()
	SystemNotify()
	ClickFailed()
	AutoLoginIn()
}
return

OperationSub:
LogShow("開始演習。")
GotoOperation := 0
OperationFightCount := 0
Global OperationFightCount
Loop
{
	sleep 300
	if (GdipImageSearch(x, y, "img/Operation/None_Operation.png", 100, 8, 1060, 173, 1213, 205)) ;演習次數剩餘0次
	{
			LogShow("演習次數剩餘0次，演習結束！")
			Iniwrite, %OperationToday%, %SettingName%, Battle, OperationYesterday
			C_Click(1239, 72) ;回到首頁
			break
	}
	if (Operation_Only and Operation_OnlyNum=OperationFightCount and Find(x, y, 99, 35, 199, 95, Operation_Upp))
	{
		message = 已經執行演習 %OperationFightCount% 次，演習結束！
		LogShow(message)
		Iniwrite, %OperationToday%, %SettingName%, Battle, OperationYesterday
		C_Click(1239, 72) ;回到首頁
		break
	}
	else if (Find(x, y, 99, 35, 199, 95, Operation_Upp))  ;演習介面隨機
	{
		if (Operationenemy="最弱的")
		{
			Capture2(234, 298, 293, 322)   ;第一位敵人主力
			enemy1 := OCR("capture/OCRTemp.png")
			Capture2(481, 298, 538, 322)   ;第二位敵人主力
			enemy2 := OCR("capture/OCRTemp.png")			
			Capture2(720, 298, 783, 322)  ;第三位敵人主力
			enemy3 := OCR("capture/OCRTemp.png")
			Capture2(963, 298, 1027, 322) ;第四位敵人主力
			enemy4 := OCR("capture/OCRTemp.png")
			FileDelete, capture\OCRTemp.png
			Min_enemy := MinMax("min",enemy1,enemy2,enemy3,enemy4)
			enemytext = 敵方戰力：%enemy1%, %enemy2%, %enemy3%, %enemy4%.
			LogShow(enemytext)
			;~ msgbox, enemy1=%enemy1%`nenemy2=%enemy2%`nenemy3=%enemy3%`nenemy4=%enemy4%`nMin_enemy=%Min_enemy%
			if (Min_enemy=enemy1)
			{
				C_Click(218, 280)
			} 
			else if (Min_enemy=enemy2)
			{
				C_Click(462, 280)
			}
			else if (Min_enemy=enemy3)
			{
				C_Click(708, 280)
			}
			else if (Min_enemy=enemy4)
			{
				C_Click(940, 280)
			}
			else
			{
				C_Click(218, 280) ;判斷失敗 打左邊第一個
			}
			enemy1 := 0
			enemy2 := 0
			enemy3 := 0
			enemy4 := 0
			Min_enemy := 0
		}
		else if (Operationenemy="隨機的")
		{
			LogShow("選擇隨機的敵方艦隊")
			Random, clickpos, 1, 4 ;隨機挑選敵人
			if clickpos=1
			{
				C_Click(226, 286)
			}
			else if clickpos=2
			{
				C_Click(453, 286)
			}
			else if clickpos=3
			{
				C_Click(700, 286)
			}
			else if clickpos=4
			{
				C_Click(941, 286)
			}
		}
		else if (Operationenemy="最左邊")
		{
			C_Click(226, 286)
		}
		else if (Operationenemy="最右邊")
		{
			C_Click(941, 286)
		}
	}
	else if (Find(x, y, 560, 568, 660, 628, Operation_Start)) ;演習對手訊息
	{
		C_Click(647, 608)
		sleep 500
	}
	else if (Find(x, y, 98, 33, 198, 93, Operation_Formation)) ;編隊畫面
	{
		LogShow("演習出擊。")
		C_Click(1089, 689)
		sleep 1300
		if (Find(x, y, 98, 33, 198, 93, Operation_Formation))
		{
			LogShow("演習結束！")
			Iniwrite, %OperationToday%, %SettingName%, Battle, OperationYesterday
			C_Click(1239, 72) ;回到首頁
			break
		}
		sleep 5000
		if (Find(x, y, 98, 33, 198, 93, Operation_Formation)) ;點了出擊過了5秒還是沒出擊
		{
			LogShow("演習異常，強制結束！")
			Iniwrite, %OperationToday%, %SettingName%, Battle, OperationYesterday
			C_Click(1239, 72) ;回到首頁
			break
		}
		OperationFightCount++
	}
	else if (Find(x, y, 101, 33, 201, 93, Operation_Shop)) ;誤點商店
	{
		C_Click(57, 90) ;誤點商店，自動離開
	}
	Try
	{
		battlevictory()
		Battle_Operation()
		ChooseParty(StopAnchor)
		ToMap()
		shipsfull()
		BackAttack()
		Message_Story()
		Battle_End()
		UnknowWife()
		Message_Normal()
		Message_Center()
		GetCard()
		GetItem()
		battlevictory()
		GuLuGuLuLu()
		CloseEventList()
		SystemNotify()
		AutoLoginIn()
	}
}
OperationFightCount := 0
OperationFailed := 0
return

startemulatorSub:
runwait, %Consolefile% globalsetting --fastplay 0, %ldplayer%, Hide
sleep 500
runwait, %Consolefile% launchex --index %emulatoradb% --packagename "com.hkmanjuu.azurlane.gp" , %ldplayer%, Hide
sleep 10000
Winget, UniqueID,, %title%
Global UniqueID
Loop
{
	IfWinExist ahk_class adframe ;雷電模擬器右下角的廣告
		WinClose ahk_class adframe
	IfWinExist ahk_class ADFullScreenFrame ;雷電模擬器的全螢幕廣告
		winclose ahk_class ADFullScreenFrame
	if (Find(x, y, 1197, 704, 1297, 764, CRIWare))
	{
		LogShow("位於遊戲首頁，自動登入")
		sleep 5000
		C_Click(642, 420)
		Loop, 10
			sleep 1000
	}
	else if (Find(x, y, 420, 450, 850, 600, Game_Update)) ;更新提示
	{
		LogShow("開始自動更新")
		C_Click(786, 534)
	}
	else if (Find(x, y, 271, 171, 371, 226, System_Announce))
	{
		LogShow("關閉系統公告(維修)")
		C_Click(955, 199)
	}
	else if (Find(x, y, 756, 514, 856, 569, Game_Update, 0.1, 0.1))
	{
		LogShow("更新提示：確認")
		C_Click(786, 535)
	}
	else if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor))
	{
		LogShow("自動登入完畢。")
		break
	}
	AutoLoginIn()
	SystemNotify()
	GetItem()
	CloseEventList()
	sleep 1000
	WinMove,  %title%, , , , %EmulatorResolution_W%, %EmulatorResolution_H%
}
iniread, Autostart, %SettingName%, OtherSub, Autostart, 0
if (Autostart)
{
	iniwrite, 0, %SettingName%, OtherSub, Autostart
	goto, start
}
else
{
	goto, start
}
return

DailyGoalSub:
if  (DailyGoalSub and DailyDone<1)
{
	iniread, Yesterday, %SettingName%, Battle, Yesterday
	FormatTime, Today, ,dd
	if (Yesterday=Today)
	{
		DailyDone := 1
		LogShow("已完成每日任務。")
		Loop
		{
			if (Find(x, y, 97, 34, 197, 94, DailyYraid)) ;如果在每日頁面
			{
				LogShow("返回主選單。")
				C_Click(1242, 69)
			}
			if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor)) ;如果成功返回首頁
			{
				Break
			}
		}
	}
	else
	{
		DailyGoalSub2:
		Formattime, Checkweek, , Wday ;星期的天數 (1 – 7). 星期天為 1.
		Loop
		{
			if (Find(x, y, 348, 162, 448, 222, Daily_LV))
			{
				sleep 300
				if ((Checkweek=1 or Checkweek=4 or Checkweek=7) and DailyGoalRedAction=1) or ((Checkweek=3 or Checkweek=6) and DailyGoalGreenAction=1) or ((Checkweek=2 or Checkweek=5) and DailyGoalBlueAction=1)
				{
					C_Click(721, 262)
				}
				else if ((Checkweek=1 or Checkweek=4 or Checkweek=7) and DailyGoalRedAction=2) or ((Checkweek=3 or Checkweek=6) and DailyGoalGreenAction=2) or ((Checkweek=2 or Checkweek=5) and DailyGoalBlueAction=2)
				{
					C_Click(721, 401)
				}
				else if ((Checkweek=1 or Checkweek=4 or Checkweek=7) and DailyGoalRedAction=3) or ((Checkweek=3 or Checkweek=6) and DailyGoalGreenAction=3) or ((Checkweek=2 or Checkweek=5) and DailyGoalBlueAction=3)
				{
					C_Click(721, 552)
				}
				else if ((Checkweek=1 or Checkweek=4 or Checkweek=7) and DailyGoalRedAction=4) or ((Checkweek=3 or Checkweek=6) and DailyGoalGreenAction=4) or ((Checkweek=2 or Checkweek=5) and DailyGoalBlueAction=4)
				{
					C_Click(756, 552)
				}
				sleep 1000
				if (Find(x, y, 427, 328, 527, 388, Daily_Ico)) ;如果出現驚嘆號 (多確認一個紅尖尖 避免誤判)
				{
					if (Checkweek=1 and CheckweekCount<1 and DailyGoalSunday) ;如果是禮拜天  (打左邊)
					{
						CheckweekCount := 1
						Checkweek := 2
						C_Click(55, 90)
						sleep 500
						C_Click(367, 376)
						C_Click(645, 414)
						sleep 1000
					}
					else if (Checkweek=2 and CheckweekCount=1 and DailyGoalSunday) ;如果是禮拜天  (打右邊)
					{
						CheckweekCount := 2
						Checkweek := 3
						C_Click(55, 90)
						sleep 500
						C_Click(889, 403)
						C_Click(907, 416)
						C_Click(627, 410)
						sleep 1000
					}
					else
					{
						Logshow("每日任務次數用盡，返回主選單。")
						Loop, 30
						{
							if (Find(x, y, 97, 34, 197, 94, DailyYraid)) ;檢查每日頁面左上角 每日
							{
								C_Click(1242, 66)
								sleep 2000
							}
							if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor))
							{
								DailyBreak := 1
								DailyDone := 1
								Logshow("每日任務已結束")
								Break
							}
							sleep 500
						}
						DailyDone := 1
						DailyBreak := 1
					}
				}
				if (DailyBreak=1)
				{
					Break
				}
				sleep 2000
			}
			else if (Find(x, y, 100, 34, 200, 94, Daily_Formation))
			{
				if (ChooseDailyParty<1) ;第一次執行時判斷使用第幾隊 寫法偷懶 等有閒再來改
				{
					Logshow("選擇每日艦隊中。")
					sleep 1000
					Loop, 5
					{
						C_Click(39, 372) ;偷懶...不判斷目前第幾隊 直接點左邊5下換回第一艦隊
					}
					if DailyParty=第一艦隊
					{ ;不執行 本來就是第一艦隊
					}
					else if DailyParty=第二艦隊
					{
						C_Click(915, 376)
					}
					else if DailyParty=第三艦隊
					{
						Loop, 2 
						{
							C_Click(915, 376)
						}
					}
					else if DailyParty=第四艦隊
					{
						Loop, 3 
						{
							C_Click(915, 376)
						}
					}
					else if DailyParty=第五艦隊
					{
						Loop, 4 
						{
							C_Click(915, 376)
						}
					}
					ChooseDailyParty := 1
				}
				Logshow("出擊每日任務！")
				if (Retreat_LowHp) { ; 每日任務不撤退
					Global StopRetreat_LowHp := 1
				}
				C_Click(1147, 667)
				if (DwmCheckcolor(330, 209, 16777215) and DwmCheckcolor(330, 209, 16777215) and DwmCheckcolor(791, 546, 4355509) and DwmCheckcolor(849, 232, 4877741))
				{
					Logshow("老婆心情低落，休息10分鐘。")
					C_Click(496, 543) ;點擊取消
					sleep 600000
					if (DwmCheckcolor(1235, 650, 16250871))
					{
						C_Click(1133, 690) ;點擊出擊
					}
				}
				else if (DwmCheckcolor(543, 358, 16250871) and DwmCheckcolor(543, 364, 15198183))
				{
					Logshow("石油不足，停止每日任務。")
					StopAnchor := 1
					Loop, 20
					{
						if (DwmCheckcolor(133, 56, 15201279) and DwmCheckcolor(133, 56, 15201279)) ;檢查"編隊"
						{
							C_Click(1230, 68) ;返回主選單
						}
						else if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor))
						{
							Break
						}
						sleep 1000
					}
					return
				}
			}
			else if (Find(x, y, 0, 364, 91, 424, Daily_Left) and Find(x, y, 1196, 366, 1296, 426, Daily_Right))   ;如果在每日選擇關卡頁面，選中間那個
			{
				C_Click(642, 423)
			}
			else
			{
				Try
				{
					battlevictory()
					Battle()
					ChooseParty(StopAnchor)
					ToMap()
					shipsfull()
					BackAttack()
					Message_Story()
					Battle_End()
					UnknowWife()
					Message_Normal()
					Message_Center()
					GetCard()
					GetItem()
					battlevictory()
					GuLuGuLuLu()
					CloseEventList()
					SystemNotify()
					AutoLoginIn()
				}
			}
		}
	}
	if !(DailyHardMap) ;如果沒有勾選每日自動打困難存檔 (如果有勾選打完困難才存檔 避免某些情況沒有執行困難地圖)
		Iniwrite, %Today%, %SettingName%, Battle, Yesterday
	DailyBreak := 0
	ChooseDailyParty := 0
	CheckweekCount := 0
	StopRetreat_LowHp := 0
}
return

MissionSub:
if (MissionCheck) ;如果有任務獎勵
{
    LogShow("發現任務獎勵！")
    C_Click(883, 725) ;點擊任務按紐
	sleep 1000
	Loop
	{
		if (Find(x, y, 868, 680, 968, 740, MainPage_MissionDone)) 
		{
			C_Click(883, 725) ;點擊任務按紐
			sleep 1000
		}
		else if (A_index>=20) 
		{
			LogShow("進入任務列表失敗")
			return
		}
		sleep 500
	} until Find(x, y, 2, 154, 102, 214, MissionPage_All) ;等待進入任務界面 (偵測金色的"全部")
    Loop
    {
        if (Find(x, y, 1023, 29, 1123, 89, MissionPage_ReveiveAward)) ;全部領取任務獎勵
        {
            LogShow("領取全部任務獎勵！")
            C_Click(1068, 63)
        }
        else if (Find(x, y, 1087, 152, 1187, 212, MissionPage_ReveiveAward_1)) ;領取第一個任務獎勵
        {
            C_Click(1136, 187)
        }
		else if (Find(x, y, 450, 130, 830, 330, Touch_to_Contunue)) ;獲得道具
		{
			C_Click(636, 91)
		}
        else if (GdiGetPixel(751, 205)=4286894079 or GdiGetPixel(749, 278)=4287419391 ) ;確認獎勵
        {
            C_Click(641, 597)
        }
        else if (Find(x, y, 1051, 622, 1151, 682, GetCards)) ;獲得新卡片
		{
			C_Click(567, 289)
		}
        else if (GdiGetPixel(915, 232)=4291714403 and GdiGetPixel(815, 232)=4283594165) ;是否鎖定該腳色(否)
        {
            C_Click(489, 546)
        }
		else if (DwmCheckcolor(459, 544, 16777215) and DwmCheckcolor(811, 546, 16777215) and DwmCheckcolor(413, 225, 16777215)) ;是否提交物品(是)
        {
            C_Click(811, 546)
        }
		else if (Find(x, y, 1161, 46, 1261, 106, SkipBtn)) ;劇情
        {
            C_Click(811, 546)	 
        }
        else if (Find(x, y, 1084, 153, 1184, 213, MissionPage_MoveForward) or Find(x, y, 233, 334, 333, 394, MissionPage_List_Empty))
        {
            LogShow("獎勵領取結束，返回主選單！")
            C_Click(1227, 69)
			MissionDone := 1
			sleep 1000
        }
		else if (Find(x, y, 734, 401, 834, 461, MainPage_Btn_Formation) and MissionDone=1)
		{
			MissionDone :=0
			break
		}
        sleep 500
    }
}
if (MissionCheck2) ;在主選單偵測到軍事任務已完成
{
	LogShow("執行軍事委託")
	C_Click(20, 200)
	sleep 1000
	Loop
	{
		if (Find(x, y, 2, 154, 102, 214, MainPage_N_Done))
		{
			C_Click(20, 200)
			sleep 1000
		}
		if (Find(x, y, 392, 288, 492, 348, Delegation_Done)) ;出現選單"完成"
		{
			C_Click(x, y) ;點擊軍事委託完成
			sleep 2500
		}
		if (Find(x, y, 200, 80, 450, 180, Delegation_Incredible) or Find(x, y, 200, 80, 450, 180, Delegation_Perfect)) ;出現委託成功S頁面
		{
			break
		}
		else if (A_Index>200)
		{
			LogShow("軍事委託出現錯誤1")
			C_Click(1234, 100)
			return
		}
		sleep 500
	}
	Loop
	{
		sleep 400
		if (Find(x, y, 200, 80, 450, 180, Delegation_Incredible) or Find(x, y, 200, 80, 450, 180, Delegation_Perfect)) ;委託成功 S
		{
			C_Click(639, 141) ;隨便點
			sleep 1000
		}
		else if (Find(x, y, 210, 322, 310, 382, Delegation_idle)) ;如果已經"空閒"
		{
			sleep 1000
			if (Find(x, y, 210, 322, 310, 382, Delegation_idle))
			{
				C_Click(441, 314)
				sleep 1500
			}
		}
		else if (Find(x, y, 99, 34, 199, 94, DelegationPage_in_Delegation)) ;成功進入委託頁面
		{
			Rmenu := 1
			break
		}
		else
		{
			if (A_Index=50 or A_Index=60 or A_Index=70 or A_Index=80 or A_Index=90)
			{
				C_Click(514, 116)
			}
			else if (A_Index>100)
			{
				LogShow("軍事委託出現錯誤2")
				Rmenu := 0
				Break
			}
		}
		GetItem()
	}
	if (Rmenu=1)
	{
		Rmenu := 0
		DelegationMission()
		sleep 1000
		C_Click(1246, 89)
		Loop
		{
			if (Find(x, y, 12, 342, 49, 660, Delegation_LeftComm))
			{
				C_Click(1246, 89)
				sleep 1000
			}
			else if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor))
			{
				break
			}
			else if (A_Index>50)
			{
				LogShow("軍事委託未能回到首頁，嘗試點擊左側。")
				C_Click(1246, 89)
				break
			}
			sleep 500
		}
	}
	else
	{
		Loop
		{
			if (Find(x, y, 12, 342, 49, 660, Delegation_LeftComm))
			{
				C_Click(1246, 89)
				sleep 1000
			}
			else  if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor))
			{
				break
			}
			else if (A_Index>50)
			{
				LogShow("軍事委託未能回到首頁，嘗試點擊左側2。")
				C_Click(1246, 89)
				break
			}
			sleep 500
		}
	}
	LogShow("軍事委託結束")
}
if (AutoBuild and !HadBuild)
{
	if !(ReadBuild)
	{
		FormatTime, Today, ,dd
		IniRead, HadBuild, %SettingName%, AutoBuild, HadBuild, 0
		if (Today=HadBuild)
			HadBuild := 1
		else
			HadBuild := 0
		ReadBuild := 1
	}
	if !(HadBuild)
	{
		if (Find(x, y, 950, 698, 1050, 753, Build)) ;首頁的建造
		{
			LogShow("開始自動建造：" AutoBuild2 " " AutoBuild3 " 艘")
			C_Click(x, y)
			sleep 1500
			Loop
			{
				if (Find(x, y, 950, 698, 1050, 753, Build)) ;首頁的建造
					C_Click(x, y)
				else if (Find(x, y, 14, 59, 114, 114, Page_Build)) ;已進入建造頁面
				{
					C_Click(50, 203)
					sleep 2000
					break
				}
				else if (A_index>=50) 
				{
					LogShow("進入每日自動建造過程中發生錯誤")
					break
				}
				sleep 500
			}
			if (AutoBuild2="輕型艦")
				C_Click(460, 672)
			else if (AutoBuild2="重型艦")
				C_Click(668, 672)
			else if (AutoBuild2="特型艦")
				C_Click(880, 672)
			else if (AutoBuild2="限時艦")
				C_Click(261, 672)
			sleep 1000
			Loop
			{
				if (Find(x, y, 1167, 614, 1267, 669, Start_Building) and !Start_Building_Check) ;開始建造
				{
					C_Click(1138, 665)
					sleep 1000
				}
				else if (Find(x, y, 720, 278, 820, 333, Build_Qty)) ;建造數量
				{
					if (AutoBuild3>=2)
					{
						Qty := AutoBuild3 -1
						xx := x, yy := y
						Loop, %Qty%
						{
							sleep 300
							C_Click(xx, yy)
						}
					}
					sleep 500
					C_Click(786, 510) ;確認建造
					sleep 1000
				}
				else if (Find(x, y, 1100, 128, 1200, 183, Batch_Build)) ;批量完成
				{
					Start_Building_Check := 1
					C_Click(x, y)
				}
				else if (Find(x, y, 730, 475, 830, 530, Build_Confirm))
				{
					C_Click(793, 566)
				}
				else if (Find(x, y, 1167, 614, 1267, 669, Start_Building) and Start_Building_Check)
				{
					sleep 1000
					C_Click(1221, 73) ;返回首頁
					Loop
					{
						if (Find(x, y, 1167, 614, 1267, 669, Start_Building))
							C_Click(1221, 73) ;返回首頁
						else if (Find(x, y, 950, 698, 1050, 753, Build))
							break
						else if (A_index>=50)
						{
							LogShow("建造船艦返回首頁的過程中發生錯誤")
							return
						}
						GetItem()
						SystemNotify()
						CloseEventList()
						sleep 500
					}
					Start_Building_Check := 0
					sleep 1000
					break
				}
				else if (Find(x, y, 537, 215, 637, 270, Get_Character))
				{
					C_Click(x, y)
				}
				else if (Find(x, y, 520, 333, 620, 388, Build_HaveNoEnough))
				{
					LogShow("已經沒有足夠的物資可供建造船艦")
					Start_Building_Check := 1
					C_Click(486, 551)
				}
				GetCard()
				shipsfull()
				sleep 300
			}
			IniWrite, %Today%, %SettingName%, AutoBuild, HadBuild
			HadBuild := 1
			LogShow("建造" AutoBuild2 " " AutoBuild3 " 艘已執行完畢。")
			sleep 3500
			if (AutoExEqu and Find(x, y, 318, 696, 418, 751, MainPage_Storage, 0.1, 0.1)) ;自動強化裝備 首頁的倉庫按鈕
			{
				C_Click(x, y)
				Loop
				{
					if (Find(x, y, 318, 696, 418, 751, MainPage_Storage)) ;首頁的倉庫
					{
						C_Click(x, y)
					}
					else if (Find(x, y, 1018, 33, 1118, 88, Storage_Rare)) ;進入倉庫後的右上角稀有度
					{
						C_Click(x, y)
					}
					else if (Find(x, y, 1059, 164, 1159, 219, Storage_EX)) ;把排序：稀有度改成強化
					{
						C_Click(x, y)
					}
					else if (Find(x, y, 906, 37, 1006, 92, Descending)) ;降序改成升序 確保排序第一個是最弱(或未經強化)的裝備
					{
						C_Click(x, y)
					}
					else if (Find(x, y, 908, 31, 1008, 86, Ascending) and Find(x, y, 1045, 32, 1145, 87, Storage_EX2) and !Equ_EX_Complete)
					{
						C_Click(205, 191) ;強化第一個裝備
					}
					else if (Find(x, y, 714, 522, 880, 712, Storage_EX3) and !Equ_EX_Complete) ;點擊裝備後的 拆解 | 強化 按鈕  並點擊強化
					{
						C_Click(x, y)
					}
					else if (Find(x, y, 570, 240, 670, 295, Storage_EX4)) ;出現 強化完成頁面 點擊繼續
					{
						Equ_EX_Complete := 1
						C_Click(x, y)
					}
					else if (Find(x, y, 714, 522, 880, 712, Storage_EX3) and Equ_EX_Complete) ;強化 按鈕  點擊空白處離開
					{
						C_Click(629, 85)
					}
					else if (Find(x, y, 246, 682, 346, 737, Storage_material)) ;位於材料頁面 切換到裝備
					{
						C_Click(1029, 708)
					}
					else if (Find(x, y, 1015, 33, 1115, 88, Storage_Bulid)) ;位於製造裝備頁面 切換到裝備 
					{
						C_Click(1029, 708)
					}
					else if (Find(x, y, 1045, 32, 1145, 87, Storage_EX2) and Equ_EX_Complete) ;裝備已強化完畢，離開
					{
						Loop
						{
							if (Find(x, y, 1045, 32, 1145, 87, Storage_EX2))
								C_Click(1238, 67) ;返回首頁
							else if !(Find(x, y, 1045, 32, 1145, 87, Storage_EX2))
								break
							else if (A_index>=30)
							{
								LogShow("強化裝備返回首頁的過程中發生錯誤")
								return
							}
							sleep 500
						}
						Equ_EX_Complete := 0
						break
					}
					sleep 300
				}
				LogShow("裝備強化完畢")
			}
			else if (AutoExEqu)
			{
				LogShow("首頁：強化裝備出現錯誤")
			}
		}
	}
}
return

AcademySub:
if (AcademyDone<1)
{
	ShopX1 := 100, ShopY1 := 100, ShopX2 := 1250, ShopY2 := 650
	Random, x, 320, 509
	Random, y, 290, 508
	C_Click(x, y)
	sleep 1000
	Loop ;等待進入學院
	{
		sleep 500
		if (Find(x, y, 97, 34, 197, 94, AcademyPage_Academy))
		{
			break
		}
		else if (A_index=200)
		{
			Logshow("AcademySub Error")
			return ;不再執行
		}
	}
	Loop
	{
		if (GdipImageSearch(x, y, "img/Academy/AcademyOil.png", 120, 8, 95, 298, 542, 723) and AcademyOil and GetOil<1) ;
		{
			LogShow("發現石油，高雄發大財！")
			GetOil := 1
			C_Click(x+8, y+12)
		}
		if (GdipImageSearch(x, y, "img/Academy/AcademyCoin.png", 100, 8, 450, 411, 843, 748) and AcademyCoin and fullycoin<1) ;
		{
			LogShow("發現金幣，高雄發大財！")
			C_Click(x+8, y+12)
			if (DwmCheckcolor(437, 361, 15724527))
			{
				LogShow("高雄的錢…真的太多了…")
				fullycoin := 1
			}
		}
		if (Find(x, y, 1021, 202, 1121, 262, AcademyPage_Shop) and AcademyShop and AcademyShopDone<1)
		{
			LogShow("商店街發大財")
			C_Click(1113, 210)
			Loop, 20
			{
				sleep 500
			} until Find(x, y, 98, 32, 198, 92, AcademyPage_into_Shop) ;檢查是否進入商店
			ShopX1 := 430, ShopY1 := 150, ShopX2 := 1250, ShopY2 := 620
			Loop
			{
				sleep 400
				if (Find(x, y, ShopX1, ShopY1, ShopX2, ShopY2, Item_OuterEqBox) and Item_Equ_Box1 and Item_Equ_Box1Coin<1) ;如果有外觀裝備箱
				{
					Item_Equ_Box1Pos := dwmgetpixel(x,y)
					LogShow("購買外觀裝備箱(金幣)")
					Loop, 20
					{
						if (Item_Equ_Box1Pos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊裝備箱
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								Item_Equ_Box1Coin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							C_Click(187,362) ;點不知火取消獲得道具的視窗
							Break
						}
						sleep 600
					}
				}
				if (GdipImageSearch(x, y, "img/SupplyStore/SkillBook_ATK.png", 110, 8, ShopX1, ShopY1, ShopX2, ShopY2) and SkillBook_ATK and AtkCoin<1) ;如果有攻擊課本
				{
					SkillBookPos := dwmgetpixel(x,y)
					LogShow("購買艦艇教材-攻擊(金幣)")
					Loop, 20
					{
						if (SkillBookPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊課本
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								AtkCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if (GdipImageSearch(x, y, "img/SupplyStore/SkillBook_DEF.png", 110, 8, ShopX1, ShopY1, ShopX2, ShopY2) and SkillBook_DEF and DefCoin<1) ;如果有防禦課本
				{
					SkillBookPos := dwmgetpixel(x,y)
					LogShow("購買艦艇教材-防禦(金幣)")
					Loop, 20
					{
						if (SkillBookPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊課本
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								DefCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if (GdipImageSearch(x, y, "img/SupplyStore/SkillBook_SUP.png", 110, 8, ShopX1, ShopY1, ShopX2, ShopY2) and SkillBook_SUP and SupCoin<1) ;如果有防禦課本
				{
					SkillBookPos := dwmgetpixel(x,y)
					LogShow("購買艦艇教材-輔助(金幣)")
					Loop, 20
					{
						if (SkillBookPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊課本
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								SupCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if (GdipImageSearch(x, y, "img/SupplyStore/Cube.png", 113, 8, ShopX1, ShopY1, ShopX2, ShopY2) and Cube and CubeCoin<1) ;如果有心智魔方
				{
					CubePos := dwmgetpixel(x,y)
					LogShow("購買心智魔方(金幣)")
					Loop, 20
					{
						if (CubePos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊魔方
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								CubeCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if (GdipImageSearch(x, y, "img/SupplyStore/Part_Aircraft.png", 70, 8, ShopX1, ShopY1, ShopX2, ShopY2) and Part_Aircraft and Part_AircraftCoin<1) 
				{
					Part_AircraftPos := dwmgetpixel(x,y)
					LogShow("購買艦載機部件T3(金幣)")
					Loop, 20
					{
						if (Part_AircraftPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								Part_AircraftCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if ((GdipImageSearch(x, y, "img/SupplyStore/Part_Cannon.png", 70, 8, ShopX1, ShopY1, ShopX2, ShopY2)
				or GdipImageSearch(x, y, "img/SupplyStore/Part_Cannon2.png", 70, 8, ShopX1, ShopY1, ShopX2, ShopY2))
				and Part_Cannon and Part_CannonCoin<1) 
				{
					Part_CannonPos := dwmgetpixel(x,y)
					LogShow("購買主砲部件T3(金幣)")
					Loop, 20
					{
						if (Part_CannonPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								Part_CannonCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if (GdipImageSearch(x, y, "img/SupplyStore/Part_torpedo.png", 90, 8, ShopX1, ShopY1, ShopX2, ShopY2) and Part_torpedo and Part_torpedoCoin<1) 
				{
					Part_torpedoPos := dwmgetpixel(x,y)
					LogShow("購買魚雷部件T3(金幣)")
					Loop, 20
					{
						if (Part_torpedoPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								Part_torpedoCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if (GdipImageSearch(x, y, "img/SupplyStore/Part_Anti_Aircraft.png", 70, 8, ShopX1, ShopY1, ShopX2, ShopY2) and Part_Anti_Aircraft and Part_Anti_AircraftCoin<1) 
				{
					Part_Anti_AircraftPos := dwmgetpixel(x,y)
					LogShow("購買防空砲部件(金幣)")
					Loop, 20
					{
						if (Part_Anti_AircraftPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								Part_Anti_AircraftCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if ((GdipImageSearch(x, y, "img/SupplyStore/Part_Common.png", 70, 8, ShopX1, ShopY1, ShopX2, ShopY2)
				or GdipImageSearch(x, y, "img/SupplyStore/Part_Common2.png", 70, 8, ShopX1, ShopY1, ShopX2, ShopY2))
				and Part_Common and Part_CommonCoin<1)
				{
					Part_CommonPos := dwmgetpixel(x,y)
					LogShow("購買共通部件(金幣)")
					Loop, 20
					{
						if (Part_CommonPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								Part_CommonCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if (GdipImageSearch(x, y, "img/SupplyStore/Item_Water.png", 125, 8, ShopX1, ShopY1, ShopX2, ShopY2) and Item_Water and Item_WaterCoin<1) 
				{
					Item_WaterPos := dwmgetpixel(x,y)
					LogShow("購買秘製冷卻水(金幣)")
					Loop, 20
					{
						if (Item_WaterPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								Item_WaterCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if (GdipImageSearch(x, y, "img/SupplyStore/Item_Tempura.png", 125, 8, ShopX1, ShopY1, ShopX2, ShopY2) and Item_Tempura and Item_TempuraCoin<1) 
				{
					Item_TempuraPos := dwmgetpixel(x,y)
					LogShow("購買天婦羅(金幣)")
					Loop, 20
					{
						if (Item_TempuraPos=dwmgetpixel(x,y))
						{
							xx := x+10
							yy := y+8
							C_Click(xx,yy) ;點擊
						}
						if (Find(x, y, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
						{
							Random, xx, 713, 863
							Random, yy, 543, 569
							C_Click(xx,yy) ;隨機點擊"兌換"鈕
							sleep 4000
							if (Find(x, y, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
							{
								Item_TempuraCoin++
								Random, xx, 423, 558
								Random, yy, 543, 569
								C_Click(xx,yy) ;點擊取消
							}
							Break
						}
						sleep 600
					}
				}
				if (Item_Ex4_Box and A_index>=3 and A_index<=10)
				{
					if (Find(x, y, 700, 651, 1034, 711, supply)) ;軍需商店
					{
						C_Click(x, y)
					}
					if (Find(x, y, ShopX1, ShopY1, ShopX2, ShopY2, theBox_T4) and Item_Box_T4Coin<1) ;T4裝備箱
					{
						Item_Box_T4 := dwmgetpixel(x,y)
						Loop, 20
						{
							if (dwmgetpixel(x,y)=Item_Box_T4)
							{
								C_Click(x, y)
								sleep 500
							}
							if (Find(n, m, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
							{
								Random, xx, 713, 863
								Random, yy, 543, 569
								C_Click(xx,yy) ;隨機點擊"兌換"鈕
								sleep 4000
								if (Find(n, m, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
								{
									Item_Box_T4Coin++
									Random, xx, 423, 558
									Random, yy, 543, 569
									C_Click(xx,yy) ;點擊取消
								}
							Break
							}
							sleep 500
						}
					}
				}
				if (Item_Cube_2 and A_index>=3 and A_index<=10)
				{
					if (Find(x, y, 700, 651, 1034, 711, supply)) ;軍需商店
					{
						C_Click(x, y)
					}
					if (Find(x, y, ShopX1, ShopY1, ShopX2, ShopY2, theCube2) and Item_Cube_2Coin<1) ;心智魔方
					{
						Item_Cube_2_C := dwmgetpixel(x,y)
						Loop, 20
						{
							if (dwmgetpixel(x,y)=Item_Cube_2_C)
							{
								C_Click(x, y)
								sleep 500
							}
							if (Find(n, m, 700, 500, 860, 600, Shop_exchange)) ;跳出購買訊息
							{
								Random, xx, 713, 863
								Random, yy, 543, 569
								C_Click(xx,yy) ;隨機點擊"兌換"鈕
								sleep 4000
								if (Find(n, m, 700, 500, 850, 600, Shop_Confirm)) ;如果金幣不足
								{
									Item_Cube_2Coin++
									Random, xx, 423, 558
									Random, yy, 543, 569
									C_Click(xx,yy) ;點擊取消
								}
							Break
							}
							sleep 500
						}
					}
				}
				if (A_index>=5)
				{
					AcademyShopDone := 1
					AtkCoin := 0
					DefCoin := 0
					SupCoin := 0
					CubeCoin := 0
					LogShow("購買結束")
					C_Click(59, 91)
					break
				}
			}
		}
		if (Find(x, y, 825, 146, 925, 206, AcademyDoneIco2) and AcademyTactics and learnt<1) ;學院出現！
		{
			LogShow("我們真的學不來！")
			C_Click(740, 166) ;點擊學院
			sleep 3000  
			Loop
			{
				if (Find(x, y, 343, 224, 934, 532, KeepLearing))
				{
					LogShow("繼續學習！")
					C_Click(788, 567)
				}
				else if (Find(x, y, 1031, 624, 1131, 684, StartLesson)) ;選擇課本頁面
				{
					If (150expbookonly)
					{
						if (GdipImageSearch(x, y, "img/Academy/150exp.png", 110, 8, 100, 100, 1200, 650)) ;如果找到150% EXP課本
						{
							LogShow("使用150%經驗課本！")
							xx := x
							yy := y + 30
							C_Click(xx, yy)
							C_Click(1097, 641) ;開始課程
						}
						else
						{
							LogShow("未找到150%經驗課本！")
							C_Click(904, 655) ;取消
						}
					}
					else
					{
						LogShow("開始課程！")
						C_Click(1097, 641)
						if (DwmCheckcolor(556, 358, 16249847))
						{
							LogShow("課本不足，未能學習")
							C_Click(903,653)
						}
					}
				}
				else if (Find(x, y, 700, 500, 860, 650, Academy_BTN_Confirm)) 
				{
					LogShow("確認使用教材以訓練技能！")
					C_Click(x, y)
				}
				else if (Find(x, y, 102, 33, 202, 93, Academy_In_Academy))
				{
					sleep 4000
					if (Find(x, y, 102, 33, 202, 93, Academy_In_Academy))
					{
						LogShow("學習結束～！")
						learnt := 1
						C_Click(56, 94)
						sleep 1000
						break
					}
				}
				else
				{
					Message_Center() ;技能滿等
				}
				sleep 300
			}
		}
		if (Classroom)
		{
			Formattime, Checkweek, , Wday ;星期的天數 (1 – 7). 星期天為 1.
			if (Find(x, y, 480, 204, 580, 259, ClassRoomDone) and Checkweek!=1) ;大講堂出現！ 星期天不執行
			{
				LogShow("大講堂上課。")
				C_Click(460, 208)
				Loop
				{
					if (Find(x, y, 481, 203, 581, 258, ClassRoomDone)) ;等待進入大講堂
						C_Click(460, 208)
					if (Find(x, y, 866, 643, 966, 698, ClassRoomLvUp))
						break
					sleep 300
				}
				sleep 500
				Loop
				{
					if (Find(x, y, 1050, 644, 1150, 699, ClassRoomEnd)) ;結束課程
						C_Click(x, y)
					else if (Find(x, y, 760, 524, 860, 579, ClassRoomEndConfirm)) ;確認結束課程
						C_Click(x, y)
					else if (Find(x, y, 200, 57, 400, 112, ClassRoomVictory)) ;出現Victory
						C_Click(x, y)
					else if (Find(x, y, 703, 428, 803, 483, ClassRoomAddS)) ;添加
						C_Click(x, y)
					else if (Find(x, y, 125, 407, 225, 462, ClassRoomAddS2)) ;追加腳色(授課)
						C_Click(x, y)
					else if (Find(x, y, 84, 31, 184, 86, ClassRoomDock)) ;船塢
						break
					sleep 500
				}
				Try ;開始篩選 ; 
				{
					sleep 1500
					C_Click(1136, 64) ;開啟篩選
					Loop
					{
						sleep 500
						if (A_index>100)
						{
							LogShow("進入篩選清單的過程中發生錯誤(大講堂)")
						}
					} until Find(x, y, 23, 121, 123, 176, Dock_Sort)
					sleep 1000
					C_Click(511, 156) ;排序 等級
					C_Click(354, 230) ;索引 全部
					C_Click(357, 362)  ;陣營全 陣營
					C_Click(353, 497)  ;稀有度 全部
					C_Click(353, 566) ;附加索引 全部
					C_Click(795, 676) ;確認
					sleep 1500
				}
				if (Find(x, y, 969, 38, 1069, 93, Descending)) ;降序改成升序 
				{
					C_Click(x, y)
					sleep 1500
				}
				Lock_C := FindAll(0, 0, 1280, 720, "|<>*159$11.zzsT0A01y3wDxzzzs000001U7UD0Q8", 0.1, 0.1)
				if (Lock_C)
				{
					ClassRoomEnd_Ship := 5
					Loop
					{
						C_Click(Lock_C[A_index].x, Lock_C[A_index].y)
						sleep 500
						if (Find(x, y, 551, 351, 651, 406, ClassRoom_Moveout)) ; 是否移除後宅
						{
							ClassRoomEnd_Ship++
							C_Click(487, 549) ;取消
						}
					} until A_index>=ClassRoomEnd_Ship
					C_Click(1071, 703)
				}
				else
				{
					LogShow("未找到上鎖的船艦。")
					C_Click(62, 93) ;返回上一頁
					Lock_C := 0
				}
				Loop
				{
					if (Find(x, y, 1172, 137, 1272, 192, ClassRoom_Lesson))
					{
						C_Click(604, 68)
					}
					else if (Find(x, y, 84, 31, 184, 86, ClassRoomDock))
					{
						C_Click(1071, 703)
					}
					else if (Find(x, y, 1048, 644, 1148, 699, ClassRoomBegin)) ;開始上課
					{
						if !(Lock_C)
						{
							C_Click(58, 91)
							sleep 500
						}
						else
						{
							C_Click(x, y)
							sleep 500
							if (Find(x, y, 487, 329, 587, 384, ClassRoomNoBegin)) ;熟爛度不足
							{
								C_Click(58, 91) ;離開大講堂
								sleep 2000
								C_Click(792, 552) ;離開大講堂
								sleep 2000
							}
						}
					}
					else if (Find(x, y, 1050, 644, 1150, 699, ClassRoomEnd)) ;結束課程
					{
						C_Click(58, 91) ;離開大講堂
						sleep 500
					}
					else if (Find(x, y, 86, 34, 186, 94, AcademyPage_Academy)) ;返回學院頁面
					{
						break
					}
					else if (A_index>=50)
					{
						LogShow("大講堂出現錯誤")
						C_Click(58, 91)
						return
					}
					sleep 500
				}
			}
		}
		if (A_index>10)
		{
			LogShow("離開學院。")
			GetOil := 0
			fullycoin := 0
			learnt := 0
			AcademyShopDone := 0
			AcademyDone := 1
			Settimer, AcademyClock, -900000 ;15分鐘後再開始檢查
			sleep 1000
			C_Click(38, 92)
			sleep 3000
			Loop, 60
			{
				if (Find(x, y, 86, 34, 186, 94, AcademyPage_Academy))
					C_Click(38, 92)
				else if !(Find(x, y, 86, 34, 186, 94, AcademyPage_Academy))
					break
				sleep 500
			}
			break
		}
		sleep 300
	}
}
return

AcademyClock:
LogShow("AcademyDone := 0")
AcademyDone := 0
return

WinSub:
LDplayerCheck := [Find(x, y, 1119, 0, 1219, 46, LdPlayerLogo), CloneWindowforDWM]
if !LDplayerCheck[1] or LDplayerCheck[2]
{
	WinGet, Wincheck, MinMax, %title%
	if Wincheck=-1
	{
		LogShow("視窗被縮小，等待自動恢復")
		WinRestore, %title%
	}
}
return

ReSizeWindowSub:
GuiControl, disable, ReSizeWindowSub
LogShow("視窗已調整為：1280 x 720")
WinRestore,  %title%
WinMove,  %title%, , , , %EmulatorResolution_W%, %win_h%
sleep 100
GuiControl, enable, ReSizeWindowSub
return

DormSub:
if (DormDone<1) ;後宅發現任務
{
	DormX1 := 0
	DormY1 := 0
	DormX2 := 1250
	DormY2 := 620
	Random, x, 750, 938
	Random, y, 290, 508
	C_Click(x, y)
	sleep 1000
	Loop ;等待進入後宅
	{
		sleep 500
		if (Find(x, y, 907, 238, 1007, 298, DormIco)) ;
		{
			Random, x, 750, 938
			Random, y, 290, 508
			C_Click(x, y)
			sleep 1000
		}
		GuLuGuLuLu()
		if (Find(x, y, 0, 59, 91, 119, DormPage_in_Dorm))
		{
			sleep 500
			break
		}
		else if (Find(x, y, 1077, 637, 1177, 692, DormPage_Exp_Confirm))
		{
			C_Click(x, y) ;獲得經驗 按確定
		}
		else if (A_Index>=100)
		{
			LogShow("進入後宅的過程中發生錯誤")
			return
		}
		GuLuGuLuLu() ;如果太過飢餓 
	}
	Loop
	{
		GuLuGuLuLu() ;如果太過飢餓 
		if (Find(x, y, 53, 168, 153, 228, DormPage_Training))
			C_Click(1261, 464) ;點到訓練自動離開
		if (DwmCheckcolor(372, 337, 11924356) and DwmCheckcolor(458, 344, 9235282) and DwmCheckcolor(450, 292, 8090037))
			C_Click(1261, 464) ;點到施工自動離開
		if (Find(x, y, 592, 477, 692, 537, DormPage_Cancel))
			C_Click(x, y) ;點到換層自動離開
		if (Find(x, y, 277, 482, 377, 542, DormPage_Supplies))
			C_Click(617, 115) ;點到存糧自動離開
		if (Find(x, y, 92, 513, 192, 573, DormPage_Subject))
			C_Click(37, 90) ;點到管理自動離開
		if (Find(x, y, 98, 208, 198, 268, DormPage_Subject_Shop))
			C_Click(1200, 68) ;點到商店自動離開
		if (Find(x, y, 591, 533, 691, 593, DormPage_Inform_Confirm))
			C_Click(638, 545) ;點到訊息自動離開
		if (Find(x, y, 301, 87, 401, 147, DormPage_Share))
			C_Click(1299, 646) ;點到分享自動離開
		if (Find(x, y, 1077, 637, 1177, 692, DormPage_Exp_Confirm))
			C_Click(1110, 657) ;獲得經驗 按確定
		if (Find(x, y, 470, 452, 570, 512, DormPage_NickName))
			C_Click(x, y) ;點到取名自動離開
		if (DormFood and DormFoodDone<1)
		{
			FoodX := Ceil((550-30)*(DormFoodBar/100)+30)
			if (DwmGetpixel(FoodX, 725)<8000000) ;存糧進度條
			{
				FoodCheck := 1
			} else {
				FoodCheck := 0
			}
			;~ FoodCheck := DwmCheckcolor(FoodX, 729, 5394770) 
			FoodCheck2 := Find(x, y, 0, 657, 98, 717, DormPage_YellowCross) ;左下黃十字
			if (FoodCheck and FoodCheck2)
			{
				if (DormFoodBar>=50 and DormFoodBar<65)
				{
					DormFoodBar := 66
				}
				else if (DormFoodBar<50 and DormFoodBar>39)
				{
					DormFoodBar := 38
				}
				LogShow("存糧不足，自動補給")
				C_Click(292,718)
				Loop
				{
					Food1 := Dwmgetpixel(305, 468)
					Food2 := Dwmgetpixel(461, 468)
					Food3 := Dwmgetpixel(619, 468)
					Food4 := Dwmgetpixel(774, 468)
					SuppilesbartargetX := Ceil((1020-430)*(DormFoodBar/100)+430)  ; x1=430 , x2=1020, y=303
					Suppilesbar := DwmCheckcolor(SuppilesbartargetX, 303, 4869450)
					if (Food1<10000000 and Suppilesbar)
					{
						C_Click(358,416) 
					}
					else if (Food2<10000000 and Suppilesbar)
					{
						C_Click(519,416)
					}
					else if (Food3<10000000 and Suppilesbar)
					{
						C_Click(669,416)
					}
					else if (Food4<10000000 and Suppilesbar)
					{
						C_Click(826,416)
					}
					if (!Suppilesbar or (Food1>10000000 and Food2>10000000 and Food3>10000000 and Food4>10000000))
					{
						C_Click(557,119) ;離開餵食
						sleep 500
						DormFoodDone := 1
						break
					}
				}
			}
		}
		if (GdipImageSearch(x, y, "img/Dorm/Dorm_Coin.png", 8, 8, DormX1, DormY1, DormX2, DormY2) and DormCoin and Dorm_Coin<=3) 
		{
			LogShow("收成傢俱幣 X: " x " Y: " y)
			C_Click(x, y)
			Dorm_Coin++
		}
		else if (GdipImageSearch(x, y, "img/Dorm/Dorm_heart.png", 18, 8, DormX1, DormY1, DormX2, DormY2) and Dormheart and Dorm_heart<3) 
		{
			LogShow("增加親密度 X: " x " Y: " y)
			C_Click(x, y)
			Dorm_heart++
		}
		if (A_index>=15)
		{
			LogShow("離開後宅。")
			Dorm_Coin := 0
			Dorm_heart := 0
			DormFoodDone := 0
			DormDone := 1
			Settimer, DormClock, -1800000 ;半小時檢查一次
			sleep 1000
			C_Click(35, 86)
			sleep 3000
			Loop, 30
			{
				if (Find(x, y, 0, 59, 91, 119, DormPage_in_Dorm))
					C_Click(x, y)
				else if !(Find(x, y, 0, 59, 91, 119, DormPage_in_Dorm))
					break
				sleep 500
			}
			break
		}
		sleep 300
	}
}
return

DormClock:
DormDone := 0
LogShow("DormDone := 0")
return

Reload:
Critical
Guicontrol, disable, Reload
WinSet, Transparent, 0, ahk_id %PicShowHwnd%
WinSet, Transparent, 0, ahk_id %MainHwnd%
WindowName = Azur Lane - %title%
wingetpos, azur_x, azur_y,, WindowName
iniwrite, %azur_x%, %SettingName%, Winposition, azur_x
iniwrite, %azur_y%, %SettingName%, Winposition, azur_y
Reload
return

whitealbum: ;重要！
Randomtext := ["白色相簿什麼的已經無所謂了。"
, "為什麼你會這麼熟練啊！"
, "是我，是我先，明明都是我先來的……"
, "又到了白色相簿的季節。"
, "為什麼會變成這樣呢……"
, "傳達不了的戀情已經不需要了。"
, "你到底要把我甩開多遠你才甘心啊！？"
, "冬馬和雪菜都是好女孩！"
, "夢裡不覺秋已深，余情豈是為他人。"
, "先從我眼前消失的是你吧！？"
, "你就把你能治好的人給治好吧。"
, "我……害怕雪，因為很美麗，所以我害怕。"
, "對不起…我的嫉妒，真的很深啊。"
, "逞強的話語中 卻總藏著一聲嘆息 。"]
Random, num, 1, % Randomtext.MaxIndex()
Guicontrol, ,starttext, % "目前狀態： " Randomtext[num]
return

DelegationMission() {
	Loop
	{
		if (Find(x, y, 97, 34, 197, 94, Delegation_WaitingforDelegation)) ;左上角委託
			break
		sleep 500
	}
	Loop
	{
		sleep 300
		if (Find(x, y, 133, 107, 233, 162, Delegation_Page_Done)) 
		{	
			LogShow("完成委託任務")
			C_Click(411, 180)
		}
		else if (Find(x, y, 72, 57, 172, 112, Delegation_Spot))
		{
			C_Click(x, y)
		}
		else if (Find(x, y, 450, 130, 830, 330, Touch_to_Contunue))
		{
			LogShow("每日獲得道具，點擊繼續")
			C_Click(636, 91)
		}
		else if (Find(x, y, 359, 175, 465, 250, Delegation_Inprogress) or Find(x, y, 359, 175, 465, 250, NoneDelegation)) ;任務都在進行中 or 都沒接到任務
		{
			break
		}
		else if (A_index=100 or A_index=120 or A_index=140 or A_index=160)
		{
			LogShow("似乎卡住了，嘗試點擊上方1")
			C_Click(411, 180)
		}
	}
	C_Click(51, 283) ;緊急
	sleep 1500
	Loop, 20
	{
		sleep 500
	} until DwmCheckcolor(53, 295, 16252820) ;等待切換到緊急頁面
	Loop
	{
		sleep 200
		if (Find(x, y, 133, 107, 233, 162, Delegation_Page_Done)) 
		{	
			LogShow("完成委託任務")
			C_Click(411, 180)
		}
		else if (Find(x, y, 72, 57, 172, 112, Delegation_Spot))
		{
			C_Click(x, y)
		}
		else if (Find(x, y, 450, 130, 830, 330, Touch_to_Contunue))
		{
			LogShow("緊急獲得道具，點擊繼續")
			C_Click(636, 91)
		}
		else if (Find(x, y, 359, 175, 459, 235, Delegation_Inprogress) or Find(x, y, 359, 175, 465, 235, NoneDelegation) or Find(x, y, 325, 334, 425, 394, Delegation_Empty)) ;任務都在進行中 or 都沒接到任務
		{
			break
		}
		else if (A_index=100 or A_index=120 or A_index=140 or A_index=160)
		{
			LogShow("似乎卡住了，嘗試點擊上方2")
			C_Click(411, 180)
		}
		else if (Find(x, y, 0, 278, 100, 338, Delegation_urgent))
		{
			failedcount++
			if (failedcount>20)
				break
		}
	}
	if (Find(x, y, 364, 177, 465, 725, NoneDelegation))  ;接獲緊急任務
	{
		DelegationMission3()
	}
	C_Click(53, 191) ;每日
	sleep 300
	DelegationMission3()
	sleep 500
	Loop, 30
	{
		if (DwmCheckcolor(167, 64, 15201279))
		{
			C_Click(53, 89) ;離開
			sleep 2000
		}
		else if !(DwmCheckcolor(167, 64, 15201279))
		{
			Break
		}
		sleep 300
	}
}

DelegationMission3() ;自動接收軍事任務 . 0=接受失敗 . 1=接受成功 . 2=油耗過高不接受 . 3=進入選單失敗
{
	if (DwmCheckcolor(438, 205, 6515067) or DwmCheckcolor(438, 205, 7042444)) ;第一個任務未開始
	{
		LogShow("Mission1 := 0")
		Mission1 := 0
	}
	if (DwmCheckcolor(435, 352, 6516091) or DwmCheckcolor(435, 352, 7042444)) ;第二個任務未開始
	{
		LogShow("Mission2 := 0")
		Mission2 := 0
	}
	if (DwmCheckcolor(437, 499, 7040379) or DwmCheckcolor(437, 499, 7043468)) ;第三個任務未開始
	{
		LogShow("Mission3 := 0")
		Mission3 := 0
	}
	if (DwmCheckcolor(435, 643, 6516091) or DwmCheckcolor(435, 643, 7043468)) ;第四個任務未開始
	{
		LogShow("Mission4 := 0")
		Mission4 := 0
	}
	if (Mission1 = 0 and !DwmCheckcolor(1082, 62, 9211540) and !DwmCheckcolor(1088, 63, 11383477))
	{
		C_Click(560, 192)
		Mission1 := DelegationMission2()
		if (Mission1=2 and !DwmCheckcolor(1082, 62, 9211540) and !DwmCheckcolor(1088, 63, 11383477) and Mission4=0)
		{
			Swipe(1221,395, 1221, 115)
			C_Click(560, 651)
			DelegationMission2()
		}
	}
	if (Mission2 = 0 and !DwmCheckcolor(1082, 62, 9211540) and !DwmCheckcolor(1088, 63, 11383477))
	{
		C_Click(560, 332)
		Mission2 := DelegationMission2()
		if (Mission1=2  and Mission4=0)
		{
			Swipe(1221,395, 1221, 115)
			C_Click(560, 651)
			DelegationMission2()
		}
	}
	if (Mission3 = 0 and !DwmCheckcolor(1082, 62, 9211540) and !DwmCheckcolor(1088, 63, 11383477))
	{
		C_Click(560, 471)
		Mission3 := DelegationMission2()
		if (Mission3=2  and Mission4=0)
		{
			Swipe(1221,395, 1221, 115)
			C_Click(560, 651)
			DelegationMission2()
		}
	}
	if (Mission4 = 0 and !DwmCheckcolor(1082, 62, 9211540) and !DwmCheckcolor(1088, 63, 11383477))
	{
		C_Click(560, 620)
		Mission4 := DelegationMission2()
		if (Mission4=2)
		{
			Swipe(1221,395, 1221, 115)
			C_Click(560, 651)
			DelegationMission2()
		}
		if (DwmCheckcolor(1085, 61, 12435142)) ;如果可派出艦隊是1/4
		{
			Swipe(1221,395, 1221, 115)
			C_Click(560, 651)
			DelegationMission2()			
		}
	}
	Mission1 := 0
	Mission2 := 0
	Mission3 := 0
	Mission4 := 0
}

DelegationMission2()
{
	Loop, 30  ;等待選單開啟
	{
		sleep 300
		if (Find(x, y, 870, 352, 970, 412, BTN_Advice))
		{
			loopcount := 0
			break
		}
		loopcount++
		if (loopcount>30)
		{
			;~ Logshow("未能成功進入軍事任務選單")
			e := 3
			loopcount := 0
			return e
		}
	}
	;~ LogShow("成功進入")
	if (DwmCheckcolor(1138, 338, 4870499) or Find(x, y, 729, 154, 829, 214, Ico_Oil) or Find(x, y, 1060, 151, 1160, 211, Ico_Gem) or Find(x, y, 1060,137,1160,173, Ico_Crystal)) ;如果耗油是個位數 或 出現寶石 或 出現油田
	{
		C_Click(931, 380)
		sleep 300
		if !(Find(x, y, 730, 350, 830, 410, Party_OK)) ;如果成功推薦角色
		{
			C_Click(1096, 385) ;開始
			sleep 1000
			if (Find(x, y, 763, 524, 863, 584, Spend_Oil_Confirm)) ;如果有花費油
			{
				C_Click(787, 546) ;確認
				sleep 1000
			}
			C_Click(1227, 172) ;離開介面
			sleep 300
			Swipe(1220,187,1220,473) ;往上拉
			e := 1 ;成功接受委託任務
			;~ LogShow("軍事任務成功接受")
			return e
		}
		else 
		{
			C_Click(1227, 172) ;離開介面
			sleep 500
			Swipe(1220,187,1220,473) ;往上拉
			sleep 500
			e := 0 ;接收失敗...可能是角色等級或數量不足 etc...
			;~ LogShow("軍事任務接收失敗")
			return e
		}
	}
	else
	{
		C_Click(1227, 172) ;離開介面
		sleep 500
		Swipe(1220,187,1220,473) ;往上拉
		sleep 500
		e := 2 ;油耗超過個位數 不予接受
		;~ LogShow("軍事任務油耗超過個位數")
		return e
	}
}

battlevictory() ;戰鬥勝利(失敗) 大獲全勝
{
	if (Find(x, y, 783, 385, 883, 445, Battle_Victory, 0.1, 0.1))
	{	
		if (Find(x, y, 790, 438, 870, 498, Battle_Defeat2)) ; 有隊員倒下
		{
			message = 敵艦討伐完畢（隊員受重創）。
		}
		else if (Find(x, y, 790, 449, 870, 548, Battle_Defeat2)) ; XX
		{
			message = 敵艦討伐完畢（戰鬥時間逾120秒）。
		}
		else 
		{
			message = 敵艦討伐完畢。
		}
		LogShow(message)
		Random, x, 100, 1000
		Random, y, 100, 600
		sleep 500
		C_Click(x, y)
	}
	else if (Find(x, y, 443, 339, 543, 394, Battle_De_Upgrade)) ;指揮官可以通過以下方式提升艦隊實力
	{
		LogShow("提督SAMA請提升實力。")
		AC_Click(537, 639, 715, 666)
	}
	else if (Find(x, y, 446, 69, 546, 129, Battle_Defeat) or Find(x, y, 801, 391, 855, 440, Battle_Defeat2)) ;點擊繼續
	{
		Global AnchorFailedTimes
		AnchorFailedTimes++
		rate := Round(AnchorFailedTimes/AnchorTimes*100, 2)
		Message = 出擊: %AnchorTimes% 次　覆沒：%AnchorFailedTimes% 次　機率： %rate%`%
		LogShow(Message)
		Random, x, 100, 1000
		Random, y, 100, 600
		sleep 500
		C_Click(x, y)
	}
}

GetItem()
{
	if (Find(x, y, 450, 130, 830, 330, Touch_to_Contunue)) ;獲得道具
	{
		LogShow("獲得道具，點擊繼續！")
		C_Click(638, 519)
	}
}

GetCard()
{
	if (Find(x, y, 1051, 622, 1151, 682, GetCards)) ;獲得新卡片
	{
		sleep 1500
		Capture() ;拍照
		C_Click(604, 349) ;離開介面
		sleep 500
		if (Find(x, y, 720, 500, 850, 620, Academy_BTN_Confirm))
		{
			LogShow("獲得新卡片，自動上鎖！")
			C_Click(x, y) ;上鎖
		}
	}
}

Message_Center()
{
	if (Find(x, y, 571, 537, 671, 597, Tips))
	{
		LogShow("每日提示，今日不再顯示！")
		C_Click(790, 497)
		C_Click(641, 559)
	}
	else if (Find(x, y, 580, 500, 695, 600, Center_Confirm)) ;中央訊息 按鈕在下方
	{
		LogShow("中央訊息，點擊確認！")
		C_Click(635, 542)
		return 1
	}
	return 0
}

Message_Normal()
{
	if (Find(x, y, 446, 333, 546, 393, Message_Reconnect) and Find(x, y, 320, 150, 460, 350, Message_Inform) and Find(x, y, 441, 450, 541, 650, Message_Cancel))
	{
		LogShow("遊戲斷線，嘗試重連") ;有取消跟確認的
		C_Click(785, 544)
	}
	else if (Find(x, y, 320, 150, 460, 350, Message_Inform) and Find(x, y, 441, 450, 541, 650, Message_Cancel))
	{
		LogShow("出現訊息，點擊取消！") ;有取消跟確認的
		Random, x, 423, 537
		Random, y, 554, 573
		C_Click(x, y)
	}
	else if (Find(x, y, 467, 279, 567, 339, Message_FixKit))
	{
		LogShow("出現維修工具，點擊取消！") ;有取消跟確認的
		Random, x, 466, 578
		Random, y, 471, 493
		C_Click(x, y)
	}
	else if (Find(x, y, 372, 319, 472, 379, Message_FixKit2))
	{
		LogShow("出現維修工具，點擊取消2！") ;有取消跟確認的
		Random, x, 458, 576
		Random, y, 466, 493
		C_Click(x, y)
	}
	else if (Find(x, y, 409, 530, 509, 610, Message_See))
	{
		LogShow("出現訊息，點擊知道了。")
		AC_Click(425, 560, 550, 580)
	}
}

Four_Chicken() {
	if (Find(x, y, 516, 339, 616, 399, Chicken_Face)) {
		LogShow("網路不穩定，發現四隻小雞！")
		Loop
		{
			if (Find(x, y, 516, 339, 616, 399, Chicken_Face)) {
				Chicken++
			}
			if (Chicken=60) {
				LogShow("重新連線逾時，重新啟動模擬器。")
				LogShow("但是其實還沒做，卡住了")
			}
			if (A_index>120)
			{
				break
			}
			sleep 1000
		}
	}
}

UnknowWife()
{
	if (Find(x, y, 390, 343, 490, 403, UnknowWife)) ;未知腳色(確認)
	{
		LogShow("未知腳色(確認)！")
		C_Click(811, 546)
	}
}

Battle_End()
{
	if (Find(x, y, 866, 655, 966, 715, Battle_End)) ;確定
	{
		LogShow("結算畫面，點擊確定！")
		Random, x, 1015, 1160
		Random, y, 679, 712
		C_Click(x, y)
		sleep 6000
	}
}

Message_Story()
{
	 if (Find(x, y, 1161, 46, 1261, 106, SkipBtn))
	{
		LogShow("劇情對話，自動略過")
		C_Click(1200, 74)
		sleep 1500
		C_Click(790, 550)
	}
}

BackAttack()
{
	if (Find(x, y, 765, 471, 865, 531, Battle_BackAttack)) ;遇襲
	{
		if Assault=迎擊
		{
			LogShow("遇襲：迎擊！")
			C_Click(843, 508)
		}
		else if Assault=規避
		{
			LogShow("遇襲：規避！")
			C_Click(1068, 502)
		}
		else
		{
			LogShow("伏擊錯誤")
		}
	}
}

shipsfull()
{
	global StopAnchor
	if (Find(x, y, 400, 300, 600, 500, SF_Ship_is_Full))
	{
		if shipsfull=停止出擊
		{
			LogShow("船䲧已滿：停止出擊。")
			Traytip, Azur Lane, 船䲧已滿：停止出擊。
			C_Click(896,231)
			sleep 1000
			C_Click(1227,71)
			sleep 1000
			C_Click(1227,71)
			Loop
			{
				if (Find(x, y, 0, 587, 86, 647, Formation_Tank)) ;進入戰鬥的編隊頁面 
				{
					C_Click(1227,71)
					sleep 1000
				}
				if (Find(x, y, 400, 300, 600, 500, SF_Ship_is_Full))
				{
					C_Click(896,231)
					sleep 1000
				}
				if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor)) ;回到首頁
				{
					StopAnchor := 1 ;不再出擊
					return StopAnchor
					Break
				}
				else
				{
					BreakShipsfailed++
					if (BreakShipsfailed>=50)
					{
						StopAnchor := 1 ;不再出擊
						return StopAnchor
						Break
					}
				}
				sleep 300
			}
			BreakShipsfailed := 0
		}
		else if shipsfull=關閉遊戲
		{
			LogShow("船䲧已滿：關閉模擬器。")
			sleep 500
			run, %Consolefile% quit --index %emulatoradb%, %ldplayer%, Hide
			sleep 500
			Settimer, EmulatorCrushCheckSub, off
		}
		else if shipsfull=整理船䲧
		{
			LogShow("船䲧已滿：開始整理。")
			C_Click(437, 546)
			Loop ;等待進入船䲧畫面
			{
				sleep 400
				shipcount++
				if (shipcount>100)
				{
					LogShow("等待進入船䲧的過程中發生錯誤")
					StopAnchor := 1 ;不再出擊
					return StopAnchor
				}
			} until Find(x, y, 96, 32, 196, 92, SF_In_Dock)
			shipcount := 0
			Gosub, Anchorsettings ;Get GUI settings again
			sleep 500
			Loop
			{
				if (Find(x, y, 96, 32, 196, 92, SF_In_Dock))
				{
					C_Click(1136, 64) ;開啟篩選
					Loop
					{
						sleep 500
						if (A_index>100)
						{
							LogShow("等待進入篩選清單的過程中發生錯誤")
							StopAnchor := 1 ;不再出擊
							return StopAnchor
						}
					} until Find(x, y, 23, 121, 123, 176, Dock_Sort)
					sleep 1000
					C_Click(511, 156) ;排序 等級
					C_Click(354, 230) ;索引 全部
					C_Click(357, 362)  ;陣營全 陣營
					C_Click(353, 497)  ;稀有度 全部
					C_Click(351, 569) ;附加索引 全部
					if (Index1)
						C_Click(510, 229)
					if (Index2)
						C_Click(666, 229)
					if (Index3)
						C_Click(833, 229)
					if (Index4)
						C_Click(991, 229)
					if (Index5)
						C_Click(1134, 229)
					if (Index6)
						C_Click(348, 292)
					if (Index7)
						C_Click(517, 292)
					if (Index8)
						C_Click(666, 292)
					if (Index9)
						C_Click(833, 292)
					if (Camp1)
						C_Click(513, 365)
					if (Camp2)
						C_Click(666, 365)
					if (Camp3)
						C_Click(833, 365)
					if (Camp4)
						C_Click(991, 365)
					if (Camp5)
						C_Click(1134, 365)
					if (Camp6)
						C_Click(356, 419)
					if (Camp7)
						C_Click(666, 419)
					if (Rarity1)
						C_Click(513, 497)
					if (Rarity2)
						C_Click(666, 497)
					if (Rarity3)
						C_Click(833, 497)
					if (Rarity4)
						C_Click(991, 497) ;注意 此為退役超稀有
					if (Find(x, y, 23, 121, 123, 176, Dock_Sort))
					{
						if ((Rarity1) and GdipImageSearch(x, y, "img/Dock/Dock_Rarity_02_N.png", 40, 8, 445, 480, 576, 516)) 
						or ((Rarity2) and GdipImageSearch(x, y, "img/Dock/Dock_Rarity_03_N.png", 40, 8, 605, 480, 732, 516)) 
						or ((Rarity3) and GdipImageSearch(x, y, "img/Dock/Dock_Rarity_04_N.png", 40, 8, 763, 480, 891, 516))
						{
							LogShow("篩選腳色過程中出現出錯，強制停止1")
							Loop
							{
								sleep 5000
							}
							return
						}
						if ((Rarity1) and !GdipImageSearch(x, y, "img/Dock/Dock_Rarity_02_Y.png", 40, 8, 453, 480, 571, 516)) 
						or ((Rarity2) and !GdipImageSearch(x, y, "img/Dock/Dock_Rarity_03_Y.png", 40, 8, 608, 480, 731, 516)) 
						or ((Rarity3) and !GdipImageSearch(x, y, "img/Dock/Dock_Rarity_04_Y.png", 40, 8, 766, 480, 887, 516))
						{
							LogShow("篩選腳色過程中出現出錯，強制停止2")
							Loop
							{
								sleep 5000
							}
							return
						}
						if ((Rarity1) and GdipImageSearch(x, y, "img/Dock/Dock_Rarity_02_Y.png", 40, 8, 453, 480, 571, 516)) 
						or ((Rarity2) and GdipImageSearch(x, y, "img/Dock/Dock_Rarity_03_Y.png", 40, 8, 608, 480, 731, 516)) 
						or ((Rarity3) and GdipImageSearch(x, y, "img/Dock/Dock_Rarity_04_Y.png", 40, 8, 766, 480, 887, 516))
						{
							C_Click(796, 702) ;點擊確定
						}
						else
						{
							LogShow("篩選腳色過程中出現出錯，強制停止3")
							Loop
							{
								sleep 5000
							}
							return
						}
						sleep 1000
						if (Find(x, y, 77, 370, 177, 430, Dock_Ship_Empty)) ;如果篩選完畢發現沒有船可以退役
						{
							LogShow("篩選後已經無符合條件的船艦，強制停止")
							StopAnchor := 1
							C_Click(1243, 67) ;回到首頁
							return StopAnchor
						}
					break
					}
					else
					{
						LogShow("排序角色出錯，為避免退役錯誤強制停止。")
						Loop
						{
							sleep 5000
						}
					}
				sleep 300
				}
			}
			LogShow("排序退役腳色完畢，開始退役。")
			Loop
			{
				if (Find(x, y, 247, 84, 347, 144, Dock_Inform))
					C_Click(1014,677)  ;退役確定 
				else if (DwmCheckcolor(330, 208, 16777215) and DwmCheckcolor(523, 546, 16777215) and DwmCheckcolor(811, 555, 16777215)) ;如果有角色等級不為1(確定)
					C_Click(787,546)  
				else if (Find(x, y, 450, 130, 830, 330, Touch_to_Contunue)) ;獲得道具(一行)
					C_Click(x, y)
				else if (Find(x, y, 500, 150, 700, 400, Dock_Get_Items_2))
					C_Click(x, y)
				else if (Find(x, y, 909, 551, 1009, 611, Dock_UnEqu_Confirm)) ;拆裝(確定)
					C_Click(979, 580)
				else if (Find(x, y, 532, 151, 632, 211, Dock_Get_Items)) ;將獲得以下材料
					C_Click(805, 605)
				else if (Find(x, y, 77, 370, 177, 430, Dock_Ship_Empty)) ;暫無符合條件的艦船
				{
					sleep 300
					C_Click(64, 91)
					Logshow("退役結束")
					break
				}
				else if (Find(x, y, 96, 32, 196, 92, SF_In_Dock) and !Find(x, y, 77, 370, 177, 430, Dock_Ship_Empty)) ;第一位還沒被退役
				{
					DockCount++
					if (DockCount>30 and Find(x, y, 96, 32, 196, 92, SF_In_Dock)) ;偵測"船塢"
					{
						C_Click(64, 91) ;避免出現一些問題(例如船未上鎖)，強制結束退役
						DockCount := 0
						Logshow("發生一些問題，退役結束")
						break
					}
					else
					{
						C_Click(165,220) ;1
						if !DwmCheckcolor(330, 220, 2171945)
							C_Click(330,220) ;2
						if !DwmCheckcolor(495, 220, 4342090)
							C_Click(495,220) ;3
						if !DwmCheckcolor(660, 220, 5393754)
							C_Click(660,220) ;4
						if !DwmCheckcolor(825, 220, 5393754)
							C_Click(825,220) ;5
						if !DwmCheckcolor(990, 220, 3750986)
							C_Click(990,220) ;6
						if !DwmCheckcolor(1155, 220, 2698289)
							C_Click(1155,220) ;7
						if !DwmCheckcolor(165, 420, 4335665)
							C_Click(165,420) ;2-1
						if !DwmCheckcolor(330, 420, 3745841)
							C_Click(330,420) ;2-2
						if !DwmCheckcolor(495, 220, 4342090)
							C_Click(495,420) ;2-3
						C_Click(1148,702)  ;確定
					}
				}
				Try
				{
					IsDockCount++
					if (IsDockCount>300 and Find(x, y, 96, 32, 196, 92, SF_In_Dock)) ;偵測"船塢"
					{
						C_Click(64, 91) ;避免出現一些問題(例如船未上鎖)，強制結束退役
						IsDockCount := 0
						Logshow("發生一些問題，退役結束2")
						break
					}
				}
				sleep 500
			}
			DockCount := 0
			IsDockCount  := 0
		}
	}
}

ToMap()
{
	if (Find(x, y, 868, 517, 968, 577, ToMap_Start))
	{
		if (WeekMode) ;周回模式開關
		{
			if (Find(x, y, 996, 602, 1096, 662, Mode_off)) ;
			{
				LogShow("開啟周回模式")
				C_Click(1022, 631)
			}
		}
		else if !(WeekMode)
		{
			if (Find(x, y, 958, 602, 1058, 662, Mode_on))
			{
				LogShow("關閉周回模式")
				C_Click(1012, 631)
			}
		}
		LogShow("立刻前往攻略地圖")
		Random, x, 866, 1034
		Random, y, 533, 571
		C_Click(x, y)
	}
}

ChooseParty(Byref StopAnchor)
{
	Global
	if (Find(x, y, 112, 97, 212, 157, Fleet_Select))
	{
		LogShow("選擇出擊艦隊中。")
		if (AnchorMode="普通") and !(AnchorChapter="希望1")
		{
			C_Click(1142, 370) ;先清掉第二艦隊
			sleep 300
			C_Click(1060, 230) ;開啟第一艦隊的選擇選單
			sleep 500
			if (Find(x, y, 1012, 329, 1112, 389, Fleet_Select_Party2)) ;如果選單沒有正確開啟
				return
			if ChooseParty1=第一艦隊
				C_Click(1093, 296) 
			else if ChooseParty1=第二艦隊
				C_Click(1093, 340) 
			else if ChooseParty1=第三艦隊
				C_Click(1093, 382) 
			else if ChooseParty1=第四艦隊
				C_Click(1098, 424) 
			else if ChooseParty1=第五艦隊
				C_Click(1098, 466) 
			else if ChooseParty1=第六艦隊
				C_Click(1098, 506) 
			if ChooseParty2!=不使用
			{
				sleep 500
				C_Click(1053, 368)	;開啟第二艦隊的選擇選單
				sleep 500
				if (Find(x, y, 1047, 601, 1147, 661, Fleet_Start)) ;如果選單沒有正確開啟
				{
					C_Click(1161, 126)
					return
				}
			}
			if ChooseParty2=第一艦隊
				C_Click(1103, 431)
			else if ChooseParty2=第二艦隊
				C_Click(1103, 472)
			else if ChooseParty2=第三艦隊
				C_Click(1103, 514)
			else if ChooseParty2=第四艦隊
				C_Click(1103, 556)
			else if ChooseParty2=第五艦隊
				C_Click(1103, 600)
			else if ChooseParty2=第六艦隊
				C_Click(1103, 641)
			sleep 300
		}
		Random, x, 1000, 1150
		Random, y, 620, 655
		C_Click(x, y)	;立刻前往
		sleep 500
		BTN_Confirm := dwmgetpixel(743, 555) ;4355509
		BTN_Cancel := dwmgetpixel(444, 554) ;9211540
		if (DwmCheckcolor(330, 209, 16777215) and Isbetween(BTN_Cancel, 8211540, 11211540) and Isbetween(BTN_Confirm, 3755509, 4905509)) ;心情低落
		{
			LogShow("老婆心情低落中。")
			C_Click(743, 541)
		}
		else if (DwmCheckcolor(530, 360, 15724535) or DwmCheckcolor(530, 360, 16249847)) ; 資源不夠
		{
			LogShow("石油不足，停止出擊到永久。")
			StopAnchor := 1
			sleep 1000
			C_Click(1230, 68) ;返回主選單
			sleep 2000
			return StopAnchor
		}
		else if Find(x, y, 377, 328, 477, 388, Fleet_Done) and (AnchorMode="困難")
		{
			if (IsDailyHardMap)
			{
				LogShow("每日困難地圖執行結束。")
				Guicontrolget, AnchorMode
				Guicontrolget, AnchorChapter
				Guicontrolget, AnchorChapter2
				IsDailyHardMap := 0
				Iniwrite, %Today%, %SettingName%, Battle, Yesterday
				return
			}
			else
			{
				LogShow("困難模式次數已用盡，停止出擊到永久。")
				StopAnchor := 1
				sleep 1000
				C_Click(1230, 68) ;返回主選單
				sleep 2000
				return StopAnchor
			}
		}
		Loop, 20
		{
			sleep 500
			if (Find(x, y, 750, 682, 850, 742, Battle_Map)) ;如果進入地圖頁面 
			{
				if (SwitchPartyAtFirstTime and (ChooseParty2!="不使用" or AnchorMode="困難"))
				{
					Loop, 20 ;等待進入地圖的掃描結束
					{
						MapScan1 := DwmGetPixel(364, 351)
						sleep 500
						MapScan2 := DwmGetPixel(364, 351)
						if (MapScan1=MapScan2)
							break
					}
					sleep 3000
					Random, x, 970, 1050
					Random, y, 710, 720
					C_Click(x,y) ;點擊"切換"
					sleep 1000
				}
				if (AnchorChapter="7" and AnchorChapter2="2") ;如果是7-2 往右邊拖曳 以偵測左邊問號
				{
					sleep 1000
					Swipe(500, 400, 780, 570)
				}
				else if (AnchorChapter="7" and AnchorChapter2="4") ;如果是7-4 往右邊拖曳 以偵測左邊問號
				{
					sleep 1000
					Swipe(500, 400, 900, 400)
				}
				else if ((AnchorChapter="希望1") and AnchorChapter2="3") ;如果是SP3 先往左上拉 避免開場的多次偵測
				{
					Swipe(272, 419, 1100, 422)
				}
				else if (AnchorChapter="凜冬1" and AnchorChapter2="1") 
				{
					sleep 1000
					Swipe(300, 400, 950, 550)
				}
				else if (AnchorChapter="凜冬1" and AnchorChapter2="3") 
				{
					sleep 1000
					Swipe(300, 500, 1100, 500)
				}
				else if (AnchorChapter="凜冬1" or AnchorChapter="凜冬2") 
				{
					sleep 1000
					Swipe(500, 400, 650, 450)
				}
				break
			}
		} 
	}
}

Battle_Operation()
{
	Global OperationFightCount, OperationFailed
	if (Find(x, y, 1188, 51, 1288, 111, BTN_Pause))
	{
		LogShow("報告提督SAMA，艦娘演習中！")
		Loop
		{
			sleep 300
			if !(Find(x, y, 1188, 51, 1288, 111, BTN_Pause))
			{
				sleep 1000
				if !(Find(x, y, 1188, 51, 1288, 111, BTN_Pause))
				{
					Break
				}
			}
			if (Leave_Operatio and IsChanged<20) ;快輸了自動離開 重試20次
			{
				; 我方血量起點 X: 584 Y: 87  Color : 15672353 終點 X: 274 
				; 敵方血量起點 X: 694 Y: 87 Color : 15672353 終點 X: 1001
				MyHpbar := [271, 79, 586, 90]
				EmHpbar := [692, 79, 1004, 90]
				if (GdipImageSearch(myhpx, my, "img\battle\OperationHp.png", 50, 1, MyHpbar[1], MyHpbar[2], MyHpbar[3], MyHpbar[4]) 
				and GdipImageSearch(emhpx, ey, "img\battle\OperationHp.png", 50, 8, EmHpbar[1], EmHpbar[2], EmHpbar[3], EmHpbar[4]))
				{
					Myhp := 100-Ceil((myhpx-MyHpbar[1])/(MyHpbar[3]-MyHpbar[1])*100)  ; 0~315
					Emhp := Ceil(((emhpx-EmHpbar[1])/(EmHpbar[3]-EmHpbar[1]))*100) ; 0~312
					Guicontrol, ,starttext, 目前狀態：演習中，我方HP:  %Myhp% `% VS 敵方HP:  %Emhp% `%。
				}
				else
				{
					Myhp := 100 ;"偵測失敗"
					Emhp := 100 ;"偵測失敗"
					Guicontrol, ,starttext, 目前狀態：演習中。
				}
				if (Myhp<OperatioMyHpBar and Emhp>OperatioEnHpBar)
				{
					sleep 1000
					if (GdipImageSearch(myhpx, my, "img\battle\OperationHp.png", 50, 1, MyHpbar[1], MyHpbar[2], MyHpbar[3], MyHpbar[4]) 
					and GdipImageSearch(emhpx, ey, "img\battle\OperationHp.png", 50, 8, EmHpbar[1], EmHpbar[2], EmHpbar[3], EmHpbar[4]))
					{
						Myhp := 100-Ceil((myhpx-MyHpbar[1])/(MyHpbar[3]-MyHpbar[1])*100)  ; 0~315
						Emhp := Ceil(((emhpx-EmHpbar[1])/(EmHpbar[3]-EmHpbar[1]))*100) ; 0~312
						Guicontrol, ,starttext, 目前狀態：演習中，我方HP:  %Myhp% `% VS 敵方HP:  %Emhp% `%。
					}
					else
					{
						Myhp := 100 ;"偵測失敗"
						Emhp := 100 ;"偵測失敗"
						Guicontrol, ,starttext, 目前狀態：演習中。
					}
					if (Myhp<OperatioMyHpBar and Emhp>OperatioEnHpBar)   ;再檢查一次
					{
						OperationFightCount--
						LogShow("我方血量 " Myhp "% 敵方血量 " Emhp "% ，離開戰鬥")
						Loop, 100
						{
							if (Find(x, y, 1188, 51, 1288, 111, BTN_Pause)) ;點擊暫停按紐
							{
								Random, x, 1152, 1256
								Random, y, 69, 88
								C_Click(x, y)
								sleep 1000
							}
							else if (Find(x, y, 439, 500, 539, 600, Battle_Exit_Battle)) ;退出戰鬥
							{
								Random, x, 443, 567
								Random, y, 540, 569
								C_Click(x, y)
								sleep 1000
							}
							else if (Find(x, y, 767, 500, 850, 600, Battle_Exit_Battle)) ;確認退出
							{
								Random, x, 726, 862
								Random, y, 544, 570
								C_Click(x, y)
								sleep 2000
							}
							else if (Find(x, y, 1123, 641, 1223, 701, Battle_Defensive)) ;迎擊
							{
								Random, x, 1163, 1244
								Random, y, 700, 725s
								C_Click(x, y)
								sleep 1000
							}
							else if (Find(x, y, 100, 34, 200, 94, Daily_Formation)) ;回到編隊出擊頁面
							{
								C_Click(59, 90) ;返回上一頁
							}
							else if (Find(x, y, 99, 35, 199, 95, Operation_Upp)) ;回到演習頁面
							{
								if (Leave_OperatioDo="原隊重試")
								{
									;//////////do notthing//////////
								}
								else if (Leave_OperatioDo="更換對手")
								{
									C_Click(1142, 395) ;更換對手
									IsChanged++
								}
								else if (Leave_OperatioDo="原隊重試2")
								{
									OperationFailed++
									if (OperationFailed>10) ;重試3次
									{
										OperationFailed := 0
										LogShow("未能成功擊敗對手，更換對手！")
										C_Click(1142, 395) ;更換對手
									}
								}
								else if (Leave_OperatioDo="原隊重試3")
								{
									OperationFailed++
									if (OperationFailed>10)
									{
										OperationFailed := 0
										LogShow("未能成功擊敗對手，打第二隊！")
										C_Click(457, 337) ;打第二隊
									}
								}
								Break
							}
							else if (DwmCheckcolor(1221, 73, 16777215)) ;太慢退出
							{
								C_Click(620, 391)
								break
							}
							sleep 333
						}
					}
				}
			}
			battletime++
			if (battletime>900) ;如過戰鬥超過15分鐘
			{
				LogShow("戰鬥超時，自動離開")
				Loop, 999
				{
					sleep 500
					if (Find(x, y, 1188, 51, 1288, 111, BTN_Pause)) ;點擊暫停按紐
					{
						Random, x, 1152, 1256
						Random, y, 69, 88
						C_Click(x, y)
						sleep 1000
					}
					else if (Find(x, y, 439, 500, 539, 600, Battle_Exit_Battle)) ;退出戰鬥
					{
						Random, x, 443, 567
						Random, y, 540, 569
						C_Click(x, y)
						sleep 1000
					}
					else if (Find(x, y, 767, 500, 850, 600, Battle_Exit_Battle)) ;確認退出
					{
						Random, x, 726, 862
						Random, y, 544, 570
						C_Click(x, y)
						sleep 2000
					}
					else if (Find(x, y, 100, 34, 200, 94, Daily_Formation)) ;回到編隊出擊頁面
					{
						C_Click(59, 90) ;返回上一頁
					}
					else if (Find(x, y, 99, 35, 199, 95, Operation_Upp)) ;回到演習頁面
					{
						Break
					}
				}
			}
		}
		battletime := 0
	}
}

Battle()
{
	global NowHP
	if (Find(x, y, 1188, 51, 1288, 111, BTN_Pause))
	{
		LogShow("報告提督SAMA，艦娘航行中！")
		Loop
		{
			sleep 1000
			if !(Find(x, y, 1188, 51, 1288, 111, BTN_Pause))
			{
				sleep 1000
				if !(Find(x, y, 1188, 51, 1288, 111, BTN_Pause))
				{
					Guicontrol, ,starttext, 目前狀態：敵艦討伐結束。
					Break
				}
			}
			else if Autobattle=半自動
			{
				if (DwmCheckcolor(455, 82, 15671329)) or (DwmCheckcolor(372, 61, 16777215))
				{
					if (MoveDown<1)
					{
						Swipe(150,630, 150, 700, 650) ;下
						sleep 200
						Swipe(116,587, 20, 587, 1000) ;往後
						swipeside := 3
					}
					MoveDown := 1
					if (DwmCheckcolor(897, 656, 16777215) and DwmCheckcolor(1225, 83, 16249847)) ;飛機準備就緒
					{
						C_Click(897, 656)
					}
					else if (DwmCheckcolor(1043, 651, 16777215) and DwmCheckcolor(1225, 83, 16249847) and swipeside=4) ;魚雷準備就緒
					{
						C_Click(1043, 651)
					}
					else if (DwmCheckcolor(1198, 654, 16777215) and DwmCheckcolor(1225, 83, 16249847) and swipeside=4) ;大砲準備就緒
					{
						C_Click(1182, 649)
					}
				}
				HalfAuto++
				if HalfAuto>3
				{
					;~ if swipeside=1
					;~ {
						;~ Swipe(149,545, 149, 400, 2500) ;上
						;~ Swipe := 2
					;~ }
					;~ else if swipeside=2
					;~ {
						;~ Swipe(150,630, 150, 700, 2500) ;下
						;~ Swipe := 3
					;~ }
					if swipeside=3
					{
						Swipe(198,591, 298, 591, 1800) ;往前
						swipeside := 4
					}
					else if swipeside=4
					{
						Swipe(116,587, 20, 587, 1600) ;往後
						swipeside := 3
					}
					HalfAuto := 0
				}
				sleep 300
			}
			battletime++
			if (battletime>600) ;如過戰鬥超過10分鐘
			{
				LogShow("戰鬥超時，自動離開")
				Loop, 999
				{
					sleep 500
					if (DwmCheckcolor(1241, 82, 16249847))
					{
						C_Click(1210, 82) ;點擊暫停
						sleep 1000
					}
					if (DwmCheckcolor(457, 549, 16777215) and DwmCheckcolor(457, 549, 16777215))
					{
						C_Click(504, 553) ;退出戰鬥
						sleep 1000
					}
					if (DwmCheckcolor(330, 209, 16777215) and DwmCheckcolor(821, 535, 16777215))
					{
						C_Click(790, 544) ;拋棄獲得的資源 道具 腳色
						sleep 10000
						break
					}
				}
			}
			if (Retreat_LowHp and !StopRetreat_LowHp) ;旗艦HP過低撤退
			{
				Hp_Variation := 25
				if (OriginalHP<1) ;先檢查原本HP剩多少
				{
					DetectHP_Pos := [10, 420, 105, 480]
					if (GdipImageSearch(x, y, "img/battle/LowHP.png", Hp_Variation, 8, DetectHP_Pos[1], DetectHP_Pos[2], DetectHP_Pos[3], DetectHP_Pos[4]))
					{
						OriginalHP := Ceil((x-10)/85*100)
						OriginalHP2 := OriginalHP-Retreat_LowHpBar
						Message = 旗艦HP: %OriginalHP%`%，當HP＜: %OriginalHP2%`%，%Retreat_LowHpDo%。
						LogShow(Message)
					}
					else if (DebugMode)
					{
						LogShow("HP檢測中。")
						sleep 500
					}
					else
					{
						sleep 500
					}
				}
				else if (OriginalHP>=1)
				{
					IsPositive_Integer := if (OriginalHP-Retreat_LowHpBar)>1 ? 1 : 0
					if (IsPositive_Integer)
					{
						DetectHP_Pos := [10, 420, 105, 480]
						if (GdipImageSearch(x, y, "img/battle/LowHP.png", Hp_Variation, 8, DetectHP_Pos[1], DetectHP_Pos[2], DetectHP_Pos[3], DetectHP_Pos[4]))
						{
							NowHP := Ceil((x-10)/85*100)
							SufferHP := OriginalHP-NowHP
							if (SufferHP>=0)
							{
								Guicontrol, ,starttext, 目前狀態：戰鬥中，目前HP: %NowHP%`%，消耗HP: %SufferHP%`%。
							}
							else if (SufferHP<0)
							{
								SufferHP := Abs(SufferHP)
								Guicontrol, ,starttext, 目前狀態：戰鬥中，目前HP: %NowHP%`%，維修HP: %SufferHP%`%。
							}
							if (debugMode)
							{
								HpdebugMode++
								if (HpdebugMode=5)
								{
									if (SufferHP>=0)
										Message = 目前HP: %NowHP%`%，消耗HP: %SufferHP%`%。
									else if (SufferHP<0)	
										Message = 目前HP: %NowHP%`%，維修HP: %SufferHP%`%。
									LogShow(Message)
									HpdebugMode := 0
								}
							}
						}
						if (Stop_LowHp and NotRetreat<1) ;如果檢測到打王則不撤退
						{
							if (Find(x, y, 292, 31, 392, 91, Battle_BossIco)) 
							{
								NotRetreat := 1
								if (debugmode)
									LogShow("BOSS出現，停止撤退！")
							}
						}
						if (Stop_LowHP_SP and switchparty>=1 and NotRetreat<1)
						{
							NotRetreat := 1
							if (debugmode)
								LogShow("已交換隊伍，停止撤退！")
						}
						if ((OriginalHP-NowHP)>=Retreat_LowHpBar and NotRetreat<1 and NowHP!=0) ;HP過低撤退
						{
							SufferHP := OriginalHP-NowHP
							Message = 目前HP: %NowHP%`%，消耗HP: %SufferHP%`%。
							LogShow(Message)
							Message = 旗艦消耗高於%Retreat_LowHpBar%`%，%Retreat_LowHpDo%
							LogShow(Message)
							Guicontrol, ,starttext, 目前狀態：旗艦消耗高於 %Retreat_LowHpBar% `%，%Retreat_LowHpDo%
							Loop, 300
							{
								if (Find(x, y, 783, 385, 883, 445, Battle_Victory, 0.1, 0.1)) ;撤退太慢戰鬥勝利
								{
									break
								}
								else if (Find(x, y, 446, 69, 546, 129, Battle_Defeat)) ;撤退太慢戰鬥失敗
								{
									break
								}
								else if (Find(x, y, 1188, 51, 1288, 111, BTN_Pause)) ;點擊暫停按紐
								{
									Random, x, 1152, 1256
									Random, y, 69, 88
									C_Click(x, y)
									sleep 1000
								}
								else if (Find(x, y, 439, 500, 539, 600, Battle_Exit_Battle)) ;退出戰鬥
								{
									Random, x, 443, 567
									Random, y, 540, 569
									C_Click(x, y)
									sleep 1000
								}
								else if (Find(x, y, 767, 500, 850, 600, Battle_Exit_Battle)) ;確認退出
								{
									Random, x, 726, 862
									Random, y, 544, 570
									C_Click(x, y)
									sleep 2000
								}
								else if (Find(x, y, 1123, 641, 1223, 701, Battle_Defensive)) ;迎擊
								{
									Random, x, 1163, 1244
									Random, y, 700, 725
									C_Click(x, y)
									sleep 1000
								}
								else if (Find(x, y, 1029, 628, 1129, 688, Battle_Weigh)) ;再次出擊
								{
									Random, x, 1060, 1221
									Random, y, 658, 692
									C_Click(x, y)
									sleep 1000
									if (Find(x, y, 700, 500, 880, 600, Academy_BTN_Confirm)) ;心情低落
									{
										if mood=強制出戰
										{
											LogShow("老婆心情低落：提督SAMA沒人性")
											C_Click(x, y)
										}
									}
									break
								}
								sleep 350
							}
						}
					sleep 500
					}
					else
					{
						if (GdipImageSearch(x, y, "img/battle/LowHP.png", Hp_Variation, 8, DetectHP_Pos[1], DetectHP_Pos[2], DetectHP_Pos[3], DetectHP_Pos[4]))
						{
							NowHP := Ceil((x-10)/85*100)
						}
						if (ShowLog<1)
						{
							Message = 目前HP(%OriginalHP%`%)扣除: %Retreat_LowHpBar%`%後小於1，不撤退。
							LogShow(Message)
							ShowLog := 1
						}
					}
				}
			}
			if (!(Retreat_LowHp) and Retreat_LowHp2) ;旗艦HP過低撤退
			{
				DetectHP_Pos := [10, 420, 105, 480]
				Hp_Variation := 25
				if (GdipImageSearch(x, y, "img/battle/LowHP.png", Hp_Variation, 8, DetectHP_Pos[1], DetectHP_Pos[2], DetectHP_Pos[3], DetectHP_Pos[4]))
				{
					NowHP := Ceil((x-10)/85*100)
					if (debugMode)
					{
						HpdebugMode++
						if (HpdebugMode=5)
						{
							Message = 旗艦血量： %NowHP%`%
							LogShow(Message)
							HpdebugMode := 0
						}
					}
				}
				sleep 100
			}
		}
		battletime := 0
	}
}

GuLuGuLuLu()
{
	if (DwmCheckcolor(355, 206, 16776183) and DwmCheckcolor(355, 206, 16776183) and DwmCheckcolor(468, 561, 16764787) and DwmCheckcolor(794, 564, 16755282))
	{
			LogShow("提督SAMA人家不給吃飯飯！")
			Random, x, 446, 588
			Random, y, 541, 576
			C_Click(x, y)
	}
}

CloseEventList()
{
	if (Find(x, y, 148, 33, 248, 93, EventList))
	{
		LogShow("關閉活動總覽")
		C_Click(1240,66)
	}
}

SystemNotify()
{
	if (Find(x, y, 117, 75, 217, 135, Announce))
	{
		LogShow("出現系統公告，不再顯示")
		if !(Find(x, y, 946, 78, 1046, 138, Announce_Check))
		{
			C_Click(994, 110)
		}
		C_Click(1193, 103)
	}
}

AutoLoginIn() ;預設登入Google帳號
{
	if (AutoLogin)
	{
		If (Find(x, y, 589, 435, 689, 495, Login_In)) ;斷線的登入頁面(密碼登入)
		{
			LogShow("遊戲斷線，開始重登")
			C_Click(777, 254) ;快速登入
			sleep 500
			Loop
			{
				sleep 500
				If (Find(x, y, 589, 435, 689, 495, Login_In)) ;斷線的登入頁面(密碼登入)
				{
					C_Click(777, 254) ;快速登入
					sleep 500
				}
				else if (Find(x, y, 658, 555, 758, 615, Login_Google)) ;FB or Google
				{
					C_Click(704, 586) ;GOOGLE登入
					sleep 500
				}
				else if (Find(x, y, 554, 270, 654, 330, Select_Account)) ;選擇帳戶
				{
					C_Click(442, 455) ;第一個帳戶
					sleep 1000
				}
				else if (Find(x, y, 1197, 704, 1297, 764, CRIWare)) ;位於首頁
				{
					C_Click(587, 377)
					sleep 500
				}
				else if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor))
				{
					break
				}
				SystemNotify()
			}
		}
		else if (Find(x, y, 1197, 704, 1297, 764, CRIWare)) ;登入伺服器選擇頁面
		{
			Guicontrol, ,starttext, 目前狀態：位於遊戲首頁，嘗試登入。
			AC_Click( 231, 70, 1051, 507) ;隨機點擊登入
			sleep 3000
		}
	}
}

ClickFailed()
{
	if (DwmCheckcolor(331, 210, 16777215) and DwmCheckcolor(919, 282, 16241474) and DwmCheckcolor(415, 224, 16777215)) ;誤點"制空值"訊息
	{
		C_Click(893, 229)
		Swipe(153, 227,153,453)
	}
	else if (DwmCheckcolor(220, 127, 16777215) and DwmCheckcolor(452, 570, 16771988) and DwmCheckcolor(838, 561, 16746116)) ;誤點敵軍詳情
	{
		C_Click(1136, 298)
		Swipe(153, 453,153,227)
	}
}

Swipe(x1,y1,x2,y2,swipetime=200) {	
	If (SendFromAHK)
	{
		drag := 8
		WinGetpos,xx,yy,w1,h1, ahk_id %UniqueID%
		MouseGetPos,x,y, thewindow ;偵測滑鼠位置
		HideGuiID = Gui%UniqueID%
		if (thewindow=UniqueID) { ;如果滑鼠位於視窗內，則創造一個隱形GUI
			Gui, HideGui: -caption +AlwaysOnTop +ToolWindow
			Gui, HideGui:Show, Hide w%w1% h%h1% x%xx% y%yy%, %HideGuiID% ;創造一個隱形的GUI去檔住滑鼠
			WinSet, Transparent, 1, %HideGuiID%
			Gui, HideGui:Show
		}
		ShiftX := Ceil((x2 - x1)/drag) , ShiftY := Ceil((y2 - y1)/drag), sleeptime := Ceil(swipetime/drag) ;計算拖曳座標距離 時間
		Loop, %drag%
		{
			ControlClick, x%x1% y%y1%, ahk_id %UniqueID%,,,, D NA ;拖曳畫面(X1->X2, Y1->Y2)
			x1 += ShiftX, y1 += ShiftY
			sleep %sleeptime%
		}
		ControlClick, x%x1% y%y1%, ahk_id %UniqueID%,,,, U NA 
		Gui, HideGui:Hide ;隱藏上方創造的隱形GUI
		
	} else if (SendFromADB){
		y1 := y1-36, y2 := y2-36
		runwait,  ld.exe -s %emulatoradb% input swipe %x1% %y1% %x2% %y2% %swipetime%,%ldplayer%, Hide ;雷電4.0似乎有BUG 偶爾會卡住
	}
	sleep 600
}

AC_Click(PosX1, PosY1, PosX2, PosY2)
{
	sleep 100
	Random, x, PosX1, PosX2
	Random, y, PosY1, PosY2
	if (SendfromAHK){
		ControlClick, x%x% y%y%, ahk_id %UniqueID%,,,, NA 
		sleep 800
	} else if (SendfromADB){
		y := y - 36
		Runwait, ld.exe -s %emulatoradb% input tap %x% %y%, %ldplayer%, Hide
		sleep 600
	}
}

C_Click(PosX, PosY) {
	sleep 100
	random , x, PosX - 3, PosX + 3 ;隨機偏移 避免偵測
	random , y, PosY - 2, PosY + 2
	if (SendfromAHK){
		ControlClick, x%x% y%y%, ahk_id %UniqueID%,,,, NA 
		sleep 800
	} else if (SendfromADB){
		y := y - 36
		Runwait, ld.exe -s %emulatoradb% input tap %x% %y%, %ldplayer%, Hide
		sleep 600
	}
}

GdiGetPixel( x, y) {
    pBitmap:= Gdip_BitmapFromHWND(UniqueID)
    Argb := Gdip_GetPixel(pBitmap, x, y)
    Gdip_DisposeImage(pBitmap)
    return ARGB
}

Capture(){
	FileCreateDir, capture
	formattime, nowtime,,yyyy.MM.dd_HH.mm.ss
	pBitmap := Gdip_BitmapFromHWND(UniqueID)
	pBitmap_part := Gdip_CloneBitmapArea(pBitmap, 0, 36, 1280, 722)
	Gdip_SaveBitmapToFile(pBitmap_part, "capture/" . title . "AzurLane_" . nowtime . ".jpg", 100)
	Gdip_DisposeImage(pBitmap)
	Gdip_DisposeImage(pBitmap_part)
}

Capture2(x1, y1, x2, y2) {
	FileCreateDir, capture
	x2 := x2-x1, y2 := y2-y1
	pBitmap := Gdip_BitmapFromHWND(UniqueID)
	pBitmap_part := Gdip_CloneBitmapArea(pBitmap, x1, y1, x2, y2)
	Gdip_SaveBitmapToFile(pBitmap_part, "capture/" . "OCRTemp" . ".png")
	Gdip_DisposeImage(pBitmap)
	Gdip_DisposeImage(pBitmap_part)
}

ColorVariation(Color1, Color2) {
	color := ConvertColor(Color1)
	pix := ConvertColor(Color2)
	tr := format("{:d}","0x" . substr(color,3,2)), tg := format("{:d}","0x" . substr(color,5,2)), tb := format("{:d}","0x" . substr(color,7,2))
	pr := format("{:d}","0x" . substr(pix,3,2)), pg := format("{:d}","0x" . substr(pix,5,2)), pb := format("{:d}","0x" . substr(pix,7,2))
	distance := sqrt((tr-pr)**2+(tg-pg)**2+(pb-tb)**2)
	msgbox %distance%
}

DwmCheckcolor(x, y, color="", Variation=15) {
	if (NoxPlayer5) {
		x := x+1, y := y-4
	}
	if (GdiMode) {
		pBitmap:= Gdip_BitmapFromHWND(UniqueID)
		Argb := Gdip_GetPixel(pBitmap, x, y)
		Gdip_DisposeImage(pBitmap)
		pix := ARGB & 0x00ffffff
	} else if (DwmMode) {
		if !(CloneWindowforDWM) {
			hDC := DllCall("user32.dll\GetDCEx", "UInt", UniqueID, "UInt", 0, "UInt", 1|2)
			pix := DllCall("gdi32.dll\GetPixel", "UInt", hDC, "Int", x, "Int", y, "UInt")
			DllCall("user32.dll\ReleaseDC", "UInt", UniqueID, "UInt", hDC)
		} else {
			hDC := DllCall("user32.dll\GetDCEx", "UInt", CloneWindow, "UInt", 0, "UInt", 1|2)
			pix := DllCall("gdi32.dll\GetPixel", "UInt", hDC, "Int", x, "Int", y, "UInt")
			DllCall("user32.dll\ReleaseDC", "UInt", CloneWindow, "UInt", hDC)
		}
		pix := ConvertColor(pix)
	} else if (AHKMode) {
		PixelGetColor, pix, x, y , Alt RGB
	}
	if (Variation>=0) {
		color := DecToHex(color)
		pix := DecToHex(pix)
		tr := format("{:d}","0x" . substr(color,3,2)), tg := format("{:d}","0x" . substr(color,5,2)), tb := format("{:d}","0x" . substr(color,7,2))
		pr := format("{:d}","0x" . substr(pix,3,2)), pg := format("{:d}","0x" . substr(pix,5,2)), pb := format("{:d}","0x" . substr(pix,7,2))
		distance := sqrt((tr-pr)**2+(tg-pg)**2+(pb-tb)**2)
		if (distance<=Variation) {
			return 1
		}
		return 0
	}
}

GdipImageSearch(byref x, byref y, imagePath = "img/picturehere.png",  Variation=100, direction = 1, x1=0, y1=0, x2=0, y2=0) {
	sleep % DetectSleep
    if (Value_Pic!=0) {
		Variation := if (Variation>=2) ? Variation+Value_Pic : Variation
	}
	pBitmap := Gdip_BitmapFromHWND(UniqueID)
	bmpNeedle := Gdip_CreateBitmapFromFile(imagePath)
    if (Gdip_ImageSearch(pBitmap, bmpNeedle, LIST, x1, y1, x2, y2, Variation, , direction, 1)) {
		LISTArray := StrSplit(LIST, ",")
		x := LISTArray[1], y := LISTArray[2]
	 }
    Gdip_DisposeImage(bmpNeedle)
	Gdip_DisposeImage(pBitmap)
    return List
}

LogShow(logData) {
	formattime, nowtime,, MM-dd HH:mm:ss
	guicontrol, , ListBoxLog, [%nowtime%]  %logData%||
	if (DebugMode) {
		FileAppend, [%nowtime%]  %logData%`n, AzurLane.log
	}
}

LogShow2(logData) {
	guicontrol, , ListBoxLog, %logData%||
}

DwmGetPixel(x, y) {
	if (NoxPlayer5) {
		x := x+1, y := y-4
	}
	if (GdiMode) {
		pBitmap:= Gdip_BitmapFromHWND(UniqueID)
		Argb := Gdip_GetPixel(pBitmap, x, y)
		Gdip_DisposeImage(pBitmap)		
		RGB := ARGB & 0x00ffffff
		return RGB
	} else if (DwmMode) {
		if !(CloneWindowforDWM) {
			hDC := DllCall("user32.dll\GetDCEx", "UInt", UniqueID, "UInt", 0, "UInt", 1|2)
			pix := DllCall("gdi32.dll\GetPixel", "UInt", hDC, "Int", x, "Int", y, "UInt")
			DllCall("user32.dll\ReleaseDC", "UInt", UniqueID, "UInt", hDC)
		} else {
			hDC := DllCall("user32.dll\GetDCEx", "UInt", CloneWindow, "UInt", 0, "UInt", 1|2)
			pix := DllCall("gdi32.dll\GetPixel", "UInt", hDC, "Int", x, "Int", y, "UInt")
			DllCall("user32.dll\ReleaseDC", "UInt", CloneWindow, "UInt", hDC)
		}
		pix := ConvertColor(pix)
		Return pix
	} else if (AHKMode) {
		PixelGetColor, pix, x, y , Alt RGB
		Return pix
	}
}

DecToHex(dec) {
   oldfrmt := A_FormatInteger
   hex := dec
   SetFormat, IntegerFast, hex
   hex += 0
   hex .= ""
   SetFormat, IntegerFast, %oldfrmt%
   return hex
}

ConvertColor(BGRValue) {
	BlueByte := ( BGRValue & 0xFF0000 ) >> 16
	GreenByte := BGRValue & 0x00FF00
	RedByte := ( BGRValue & 0x0000FF ) << 16
	return RedByte | GreenByte | BlueByte
}

CheckArray(Var*) { ;檢查數組中，其中一個是否為真
	for k, v in Var
	if v=1
		return 1
	return 0
}

CheckArray2(Var*) {
	for k, v in Var
	if v=0
		return 0
	return 1
}

MinMax(type := "max", values*) {
	y := 0, c:= 0
	for k, v in values
		if v is number 
			x .= (k = values.MaxIndex() ? v : v ";"), ++c, y += v 
	Sort, x, % "d`; N" (type = "max" ? " R" : "")
	return type = "avg" ? y/c : SubStr(x, 1, InStr(x, ";") - 1)
}

Isbetween(Var, Min, Max) {
	if (Var>Min and Var<Max)
		return 1
	return 0
}

Find(byref x="", byref y="", x1=0, y1=0, x2=0, y2=0, text="", err0=0, err1=0) {
	sleep % DetectSleep
	if (err0=0 or err0<Err0_V)
		err0 := Err0_V
	if (err1=0 or err1<Err1_V)
		err1 := Err1_V
	WinGetPos, wx, wy, ww, wh, %title%
	id := WinExist(title)
	BindWindow(id)
	xx1 := wx+x1, yy1 := wy+y1, xx2 := wx+x2, yy2 := wy+y2
	if (ok := FindText(xx1, yy1, xx2, yy2 , err0, err1, text))	{
		X:=ok.1.x, Y:=ok.1.y, Comment:=ok.1.id
		x := x-wx, y:=y-wy
		return 1
	}
	x := "", y := ""
	return 0
}

FindAll(x1=0, y1=0, x2=0, y2=0, text="", err0=0, err1=0) {
	if (err0=0 or err0<Err0_V)
		err0 := Err0_V
	if (err1=0 or err1<Err1_V)
		err1 := Err1_V
	WinGetPos, wx, wy, ww, wh, %title%
	id := WinExist(title)
	BindWindow(id)
	xx1 := wx+x1, yy1 := wy+y1, xx2 := wx+x2, yy2 := wy+y2
	if (ok := FindText(xx1, yy1, xx2, yy2 , err0, err1, text,1,1)) {
		 for i,v in ok
		{
			ok[i].x := ok[i].x-wx
			ok[i].y := ok[i].y-wy
		}
		return ok
	}
	return 0
}

MsgBoxEx(Text, Title := "", Buttons := "", Icon := "", ByRef CheckText := "", Styles := "", Owner := "", Timeout := "", FontOptions := "", FontName := "", BGColor := "", Callback := "") {
    Static hWnd, y2, p, px, pw, c, cw, cy, ch, f, o, gL, hBtn, lb, DHW, ww, Off, k, v, RetVal
    Static Sound := {2: "*48", 4: "*16", 5: "*64"}

    Gui New, hWndhWnd LabelMsgBoxEx -0xA0000
    Gui % (Owner) ? "+Owner" . Owner : ""
    Gui Font
    Gui Font, % (FontOptions) ? FontOptions : "s9", % (FontName) ? FontName : "Segoe UI"
    Gui Color, % (BGColor) ? BGColor : "White"
    Gui Margin, 10, 12

    If (IsObject(Icon)) {
        Gui Add, Picture, % "x20 y24 w32 h32 Icon" . Icon[1], % (Icon[2] != "") ? Icon[2] : "shell32.dll"
    } Else If (Icon + 0) {
        Gui Add, Picture, x20 y24 Icon%Icon% w32 h32, user32.dll
        SoundPlay % Sound[Icon]
    }

    Gui Add, Link, % "x" . (Icon ? 65 : 20) . " y" . (InStr(Text, "`n") ? 24 : 32) . " vc", %Text%
    GuicontrolGet c, Pos
    GuiControl Move, c, % "w" . (cw + 30)
    y2 := (cy + ch < 52) ? 90 : cy + ch + 34

    Gui Add, Text, vf -Background ; Footer

    Gui Font
    Gui Font, s9, Segoe UI
    px := 42
    If (CheckText != "") {
        CheckText := StrReplace(CheckText, "*",, ErrorLevel)
        Gui Add, CheckBox, vCheckText x12 y%y2% h26 -Wrap -Background AltSubmit Checked%ErrorLevel%, %CheckText%
        GuicontrolGet p, Pos, CheckText
        px := px + pw + 10
    }

    o := {}
    Loop Parse, Buttons, |, *
    {
        gL := (Callback != "" && InStr(A_LoopField, "...")) ? Callback : "MsgBoxExBUTTON"
        Gui Add, Button, hWndhBtn g%gL% x%px% w90 y%y2% h26 -Wrap, %A_Loopfield%
        lb := hBtn
        o[hBtn] := px
        px += 98
    }
    GuiControl +Default, % (RegExMatch(Buttons, "([^\*\|]*)\*", Match)) ? Match1 : StrSplit(Buttons, "|")[1]

    Gui Show, Autosize Center Hide, %Title%
    DHW := A_DetectHiddenWindows
    DetectHiddenWindows On
    WinGetPos,,, ww,, ahk_id %hWnd%
    GuiControlGet p, Pos, %lb% ; Last button
    Off := ww - (((px + pw + 14) * A_ScreenDPI) // 96)
    For k, v in o {
        GuiControl Move, %k%, % "x" . (v + Off)
    }
    Guicontrol MoveDraw, f, % "x-1 y" . (y2 - 10) . " w" . ww . " h" . 48

    Gui Show
    Gui +SysMenu %Styles%
    DetectHiddenWindows %DHW%

    If (Timeout) {
        SetTimer MsgBoxExTIMEOUT, % Round(Timeout) * 1000
    }

    If (Owner) {
        WinSet Disable,, ahk_id %Owner%
    }

    GuiControl Focus, f
    Gui Font
    WinWaitClose ahk_id %hWnd%
    Return RetVal

    MsgBoxExESCAPE:
    MsgBoxExCLOSE:
    MsgBoxExTIMEOUT:
    MsgBoxExBUTTON:
        SetTimer MsgBoxExTIMEOUT, Delete

        If (A_ThisLabel == "MsgBoxExBUTTON") {
            RetVal := StrReplace(A_GuiControl, "&")
        } Else {
            RetVal := (A_ThisLabel == "MsgBoxExTIMEOUT") ? "Timeout" : "Cancel"
        }

        If (Owner) {
            WinSet Enable,, ahk_id %Owner%
        }

        Gui Submit
        Gui %hWnd%: Destroy
    Return
}

Click_Fleet(x, y) {
	Loop, 15
	{
		if (Find(n, m, 750, 682, 850, 742, Battle_Map)) ;如果在限時(無限時)地圖
		{
			C_Click(x, y)
			sleep 1500
		}
		if (Find(n, m, 0, 587, 86, 647, Formation_Tank))
		{
			Break
		}
		BackAttack()
		sleep 500
	}
}

WM_MOVING(wParam, lParam) {
	Critical
	Global PicShowHwnd, MainHwnd
	x := NumGet(lParam+0), y := NumGet(lParam+0, 4)
	if A_Gui=1
		DllCall("SetWindowPos", "UInt", PicShowHwnd, "UInt", MainHwnd, "Int", x, "Int", y, "Int", "", "Int", "", "Int", 0x01)
}

WM_EXITSIZEMOVE() {
	WinGetActiveStats, ATitle, W, H, X, Y
	if A_Gui=1
		gui, PicShow:show, x%X% y%Y%
}

IndexValue(Var, Array*) {
	For k, i in Array {
		if (Var<i)
			continue
		else if (Var=i)
			return 1
	}
	return 0
}

MoveMap(x , y) {
	if (x<500 and y<200) {
		swipe(600, 350, 600, 450)
		return 1
	}
	else if (x>1180)	{
		swipe(800, 350, 600, 350)
		return 1
	}
	else if (y<145) {
		swipe(600, 350, 600, 550)
		return 1
	}
	else if (y>680) {
		swipe(600, 550, 600, 350)
		return 1
	}
	return 0
}

MenuList(MenuList, Default) {
    Loop, parse, MenuList, |
        Choice .= (A_LoopField=Default) ? (A_LoopField "||") : (A_LoopField "|")
    StringTrimRight, NewMenuList, Choice, 1
    return NewMenuList
}

guisize:
Critical
if a_eventinfo = 1
	gui, PicShow:show, minimize
Critical, off
return

WM_MOUSEMOVE() {
	Global Var := if %A_GuiControl% ? %A_GuiControl% : A_GuiControl
	Global ControlV := A_GuiControl, OldControlV
	if (Var and ControlV!=OldControlV) {
		Settimer, ToolTIpText, -1
		OldControlV := ControlV
		Is_TT_Text := 0
	} else if (Is_TT_Text  and !ControlV) {
		ToolTip
		Is_TT_Text := 0
		OldControlV := ""
	}
	;~ ToolTip  % ControlV 
	;~ Clipboard := % ControlV "_TT"
}

ToolTIpText:
if !(Is_TT_Text2) {
	Shipsfull_TT := "當船䲧容量已滿，將退役被勾選的項目(未勾選時預設全部)。"
	Leave_OperatioDo_TT := "更換對手：將退出戰鬥，並更換對手。`n`n"
											. "原隊重試：將不斷重試到勝利或失敗為止。`n`n"
											. "原隊重試2：如重試10次後仍無法擊敗對手，將更換對手。`n`n"
											. "原隊重試3：如重試10次後仍無法擊敗對手，會嘗試攻擊左2對手。"
	ResetOperationTime2_TT := "時間格式：24小時制，請用「 `, 」分隔。`n`nExample：0010`, 1210`, 1810"
	SendFromAHK_TT := "速度快，直接模擬使用者點擊，`n但在拖曳畫面過程中有可能受到實體滑鼠的干擾。"
	SendFromADB_TT := "速度普通，使用ADB模擬使用者點擊，不受任何實體滑鼠干擾，建議使用。"
	Value_Err0_TT := "如果在某些地方會卡住，容許誤差(文字/背景)請嘗試同時更改為10`%。"
	Value_Err1_TT := "如果在某些地方會卡住，容許誤差(文字/背景)請嘗試同時更改為10`%。"
	Value_Pic_TT := "不建議更動。"
	MainsubTimer_TT := "檢測頻率越低偵測效率越高，但CPU占用也越高，`n`n適當延長檢測頻率將可降低一定程度的資源占用。"
	Ldplayer3_TT := "推薦使用。"
	Ldplayer4_TT := "僅供測試使用。"
	NoxPlayer5_TT := "僅供測試使用。"
	Operation_Relogin_TT := "偶爾會刷新到排位更前面的對手。"
	AutoBuild_TT := "使用本功能，船塢已滿設定必須是「整理船塢」，`n`n否則可能於船塢已滿時發生錯誤。"
}
if !(Is_TT_Text)
{
	ToolTip % %ControlV%_TT
	Global Is_TT_Text := 1
	Is_TT_Text2 := 1
}
return

GetLdplayer() {
	if (Noxplayer5) 
		return LDnum := "NoxPlayer"
	Runwait, %comspec% /c dnconsole list2 >ping.txt, %ldplayer%, Hide
	FileEncoding , CP936
	Loop, Read, %ldplayer%\ping.txt
	{
		contents := StrSplit(a_loopreadline, ",")
		If (contents[2]=title 
		or (contents[2]="LDplayer" and title="雷電模擬器")
		or (title="雷電模擬器-" . contents[1] and contents[2]= "LDplayer-" . contents[1])) {
			LDnum := contents[1]
			break
		}
	}
	FileEncoding , CP950
	if (LDnum<0) {
		LogShow2("模擬器編號取得失敗，請嘗試更換模擬器標題。")
		LDnum := -1
	}
	FileDelete, %ldplayer%\ping.txt
	return LDnum
}

Ldplayer4Modify(){
	runwait, %Consolefile% modify --index %emulatoradb% --resolution 1280`,720`, 240 --cpu 2 --memory 2048 , %ldplayer%, Hide
}

MatchingGame() {
	LogShow("圖片辨識中")
	FileCreateDir, capture
	pBitmap := Gdip_CreateBitmapFromFile("capture/OCRTemp.png")
	x :=240, y := 195, w :=80, h := 115
	While (A_Index<=18) {
		pBitmap_part := Gdip_CloneBitmapArea(pBitmap, x, y, w, h)
		Gdip_SaveBitmapToFile(pBitmap_part, "capture/" . A_index . ".png")
		Gdip_DisposeImage(pBitmap_part)
		x := x+145
		if A_index=6
			x :=240, y := 345
		if A_index=12
			x :=240, y := 505
	}
	While (A_Index<=18) {
		imagePath := "capture\" . A_index . ".png"
		if (DirpBitmap := Gdip_CreateBitmapFromFile(imagePath)) {
			While (A_Index<=17) {
				imagePath2 := "capture\" . A_Index+1 . ".png"
				DelbmpNeedle := Gdip_CreateBitmapFromFile(imagePath2)
				pBitmap_part := Gdip_CloneBitmapArea(DelbmpNeedle, 10, 10, 50, 80)
				if (DelbmpNeedle and pBitmap_part and imagePath!=imagePath2) {
					if (Gdip_ImageSearch(DirpBitmap, pBitmap_part, LIST, 0, 0, 70, 100, 140, , 8, 1)) 	{
						file := imagePath2
						Gdip_DisposeImage(DelbmpNeedle)
						Gdip_DisposeImage(pBitmap_part)
						FileDelete, % "capture\" . A_Index+1 . ".png"
						break
					}
				}
				Gdip_DisposeImage(DelbmpNeedle)
				Gdip_DisposeImage(pBitmap_part)
			}
			Gdip_DisposeImage(DirpBitmap)
		}
	}
	LogShow("等待翻牌結束")
	Loop
	{
	} Until Find(x, y, 232, 423, 332, 483, LittleChicken)
	While (A_index<=18)
	{
		List := 0
		imagePath := % "capture\" . A_index . ".png"
		if (debugmode) {
			speedspeed := 400, speedspeed2 := 50
		} else {
			speedspeed := 800, speedspeed2 := 500
		}
		if (bmpNeedle := Gdip_CreateBitmapFromFile(imagePath)) {
			Gdip_ImageSearch(pBitmap, bmpNeedle, LIST, 150, 150, 1200, 680, 140, , 8, 0, ",")
			LISTArray := StrSplit(LIST, ",")
			x1 := LISTArray[1]+40, y1 := LISTArray[2]+100, x2 := LISTArray[3]+40, y2 := LISTArray[4]+100
			if (x1 and y1 and x2 and y2) {
				LogShow2("------------------------------------------")
				LogShow2("配對1 x1: " x1 " y1: " y1 "，配對2 x2: " x2 " y2: " y2)
				if (A_index!=1)
					sleep % speedspeed
				Loop, 2
				{
					ControlClick, x%x1% y%y1%, ahk_id %UniqueID%,,,, NA
					sleep 20
				}
				sleep % speedspeed2
				Loop, 2
				{
					ControlClick, x%x2% y%y2%, ahk_id %UniqueID%,,,, NA
					sleep 20
				}
			}
			Gdip_DisposeImage(bmpNeedle)
		}
	}
	Gdip_DisposeImage(pBitmap)
	While (A_index<=18) {
		FileDelete, % "capture\" . A_Index . ".png"
	}
	FileDelete, capture\OCRTemp.png
	LogShow("----------結束---------")
}
return

DownloadFile(UrlToFile, SaveFileAs) {
ComObjError(false)
WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
While !(filesize) {
	Guicontrol, ,starttext, 目前狀態：取得下載資料中...%A_Index%。
	WebRequest.Open("Head", UrlToFile)
	sleep 150
	WebRequest.Send()
	sleep 150
	filesize := Round(WebRequest.GetResponseHeader("Content-Length")/1024/1024, 1)
}
SetTimer, __UpdateProgressBar, 100
UrlDownloadToFile, %UrlToFile%, %SaveFileAs%
SetTimer, __UpdateProgressBar, off
Guicontrol, ,starttext, 檔案 %SaveFileAs% 下載完畢。
Return

__UpdateProgressBar:
	CurrentSize := Round((FileOpen(SaveFileAs, "r").Length)/1024/1024, 1)
	CurrentSizeTick := A_TickCount
	Speed := Round((CurrentSize-LastSize)/((CurrentSizeTick-LastSizeTick)/1000), 1) . " Mb/s"
	LastSizeTick := CurrentSizeTick
	LastSize := Round((FileOpen(SaveFileAs, "r").Length)/1024/1024,1)
	PercentDone := Round(CurrentSize/filesize*100)
	Guicontrol, ,starttext, 下載中：%PercentDone% `% (%CurrentSize% MB/%filesize% MB)，速度：%Speed%
Return
}

SelectMode() {
	global 
	if (AnchorMode="停用")
	{
		StopAnchor := 1
		LogShow("選擇地圖已停用，停止出擊到永遠。")
		sleep 1000
		C_Click(1228, 68)
		sleep 1000
		Loop, 30
		{
			if (Find(x, y, 95, 34, 195, 94, Weigh_Anchor)) ;如果還在出擊頁面
			{
				C_Click(1228, 68)
			}
			else if (Find(x, y, 996, 362, 1096, 422, MainPage_Btn_WeighAnchor)) ;成功回到首頁
			{
				Break
			}
			sleep 350
		}
		return
	}
	else if (AnchorMode="普通")
	{
		if (Find(x, y, 22, 677, 272, 737, HardMode)) ;一般關卡的困難 OR 活動難度的困難
		{
			;不做任何事
		}
		else if (Find(x, y, 22, 677, 272, 737, NormalMode))
		{
			C_Click(99,703)
			sleep 1000
			if !(Find(x, y, 22, 677, 272, 737, HardMode))
			{
				LogShow("難度選擇為普通時發生錯誤1")
				return
			}
		}
		else if (AnchorChapter="希望1")
		{
			;不做任何事 (SP似乎沒有分難度)
		}
		else 
		{
			LogShow("難度選擇為普通時發生錯誤2")
			return
		}
	}
	else if (AnchorMode="困難")
	{
		if (Find(x, y, 22, 677, 272, 737, NormalMode))
		{
			;不做任何事
		}
		else if (Find(x, y, 22, 677, 272, 737, HardMode))
		{
			C_Click(99,703)
			sleep 1000
			if !(Find(x, y, 22, 677, 272, 737, NormalMode))
			{
				LogShow("難度選擇為困難時發生錯誤1")
				return
			}
		}
		else 
		{
			LogShow("難度選擇為困難時發生錯誤2")
			return
		}
	}
}

FindWay(x, y) {
	global
	if (AnchorChapter="墜落1" or AnchorChapter="墜落2" or AnchorChapter="凜冬1" or AnchorChapter="凜冬2" or AnchorChapter="墨染1" or AnchorChapter="墨染2" or AnchorChapter="鳶尾1" or AnchorChapter="鳶尾2") {
		if (Find(fn, fm, 439, 328, 539, 388, theWay_TooFar)) {
			LogShow("前往敵方艦隊的路途過遠！")
			IsDetect := 1
			DetectPos := 0
			IsFind := 0
			SearchLoopcountFailed2 := 0
			SearchLoopcount := 0
			FindWayCount++
			sleep 1000
			xx := x, yy := y
			Loop, 25
			{
				Guicontrol, ,starttext, % "目前狀態：尋路中「 " s_x1 ", " s_y1 ", " s_x2 ", " s_y2 " 」 …" A_index "/25。"
				DetectPos+= 35
				s_x1 := (x-DetectPos<=MapX1) ? MapX1 : (x-DetectPos)
				s_x2 := (x+DetectPos>=MapX2) ? MapX2 : (x+DetectPos)
				s_y1 := (y-DetectPos<=MapY1) ? MapY1 : (y-DetectPos)
				s_y2 := (y+DetectPos>=MapY2) ? MapY2 : (y+DetectPos)
				Message := % "X1: " s_x1 " X2: " s_x2 " Y1: " s_y1 " Y2: " s_y2
				if GdipImageSearch(n, m, "img/SubChapter/MoveWay.png", 37, 8, s_x1, s_y1, s_x2, s_y2) {
					LogShow("前往: X " n " Y " m " 循環 " A_index " 次")
					n1 := n+10, m1 := m+10
					mm := dwmgetpixel(n, m1)
					C_Click(n1, m1)
					sleep 1000
					if (Message_Center)
					{
						Swipe(500, 300, 500, 500)
						sleep 500
					}
					IsFind := 1
					break
				}
				sleep 100
			}
			myposx := abs(xx-n)
			if (m-yy<200 and myposx<150 and IsFind) {
				sleep 1000
				C_Click(x, yy)
			}
			if !(IsFind) {
				IsFine_Switched := 1
				C_Click(1025, 713)
				sleep 500
				C_Click(1025, 713)
				sleep 500
				if GdipImageSearch(n, m, "img/SubChapter/MoveWay.png", 37, 8, MapX1, MapY1, MapX2, MapY2)
				{
					LogShow("前往: X " n " Y " m " 循環 " A_index " 次")
					n1 := n+10, m1 := m+10
					C_Click(n, m1)
					sleep 1000
				}
			}
			return 1
		}
	}
	return 0
}

Update_help() {
	global
	Gui, ChangeLog: New,
	Gui, ChangeLog: font, s12, Segoe UI
	Gui, ChangeLog: Add, ListBox, x0 y0 w700 h420 vchangeloglist readonly
	FileEncoding , CP65001
	Loop, Read, temp.txt
	{
		contents := (a_loopreadline="") ? " " : a_loopreadline
		guicontrol, , changeloglist, % contents
	}
	FileEncoding , CP950
	Gui, ChangeLog: Show, w700 h420, ChangeLog
}

FindFleet3(byref x, byref y, imagearray, Variation=100, direction = 1, x1=0, y1=0, x2=0, y2=0) { ;舊版
	pBitmap := Gdip_BitmapFromHWND(UniqueID)
	for k, v in imagearray
	{
		bmpNeedle := Gdip_CreateBitmapFromFile(v)
		if Gdip_ImageSearch(pBitmap, bmpNeedle, List, x1, y1, x2, y2, Variation, , direction, 1)
		{
			LISTArray := StrSplit(List, ",")
			x := LISTArray[1], y := LISTArray[2]
			break
		}
		Gdip_DisposeImage(bmpNeedle)
	}
	Gdip_DisposeImage(bmpNeedle)
	Gdip_DisposeImage(pBitmap)
	return List
}

FindFleet(byref x, byref y, imagearray, Variation=100, direction = 1, x1=0, y1=0, x2=0, y2=0) {
	pBitmap := Gdip_BitmapFromHWND(UniqueID)
	wfp := ""
	for k, v in imagearray
	{
		bmpNeedle := Gdip_CreateBitmapFromFile(v)
		if Gdip_ImageSearch(pBitmap, bmpNeedle, List, x1, y1, x2, y2, Variation, , direction, 0, "|", ",")
		{
			Loop, parse, List, "|"
			{
				FleetPos%A_index% := StrSplit(A_LoopField, ",")
				s++
			}
			Loop, %s%
			{
				s2 := A_index+1
				if ((Abs(FleetPos%s2%[1]-FleetPos%A_index%[1])>=90 and Abs(FleetPos%s2%[2]-FleetPos%A_index%[2])>=90) or A_index=s)
					wfp .= FleetPos%A_index%[1]"," FleetPos%A_index%[2]"｜"
			}
			StringTrimRight, wfp, wfp, 1
			L := imagearray[1]
			IfInString, L, target3_1
				FFP := "主力艦隊"
			else IfInString, L, target4_1
				FFP := "偵查艦隊"
			else IfInString, L, target2_1
				FFP := "運輸艦隊"
			else IfInString, L, target_1
				FFP := "航空艦隊"
			else IfInString, L, targetElite_1
				FFP := "賽任艦隊"
			else IfInString, L, target_plane1
				FFP := "航空器"
			LogShow("發現" FFP "：" wfp)
			Loop, parse, wfp, "｜"
			{
				LISTArray2 := StrSplit(A_LoopField, ",")
				C_Click(LISTArray2[1], LISTArray2[2])
				sleep 800
				if FindWay(LISTArray2[1], LISTArray2[2])
				{
					x := LISTArray2[1], y := LISTArray2[2]
					break
				}
				else if (Find(nx, ny, 495, 330, 530, 390, "|<>*200$8.zyT3kyTzzyT3kwD3kwD3kwD3kwD3kzy"))
				{
					LogShow("前往 X: " LISTArray2[1] " Y: " LISTArray2[2] "的路徑被擋住了！")
					sleep 3000
				}
				else
				{
					break
				}
			}
			x := LISTArray2[1], y := LISTArray2[2]
			break
		}
		Gdip_DisposeImage(bmpNeedle)
	}
	Gdip_DisposeImage(bmpNeedle)
	Gdip_DisposeImage(pBitmap)
	return wfp
}

FindFleet_2(byref x, byref y, byref FFP, direction = 1, x1=0, y1=0, x2=0, y2=0) {
	pBitmap := Gdip_BitmapFromHWND(UniqueID)
	wfp := ""
	imagearray := SortFleet()
	global TargetFailed1, TargetFailed2, TargetFailed3, TargetFailed4, Plane_TargetFailed1, SearchLoopcount
	for k, v in imagearray
	{
		bmpNeedle := Gdip_CreateBitmapFromFile(v)
		L := imagearray[A_index]
		IfInString, L, target3_1
		{
			FFP := "主力艦隊"
			FFP_V := 42
			Blocked := TargetFailed3
		}
		else IfInString, L, target4_1
		{
			FFP := "偵查艦隊"
			FFP_V := 50
			Blocked := TargetFailed4
		}
		else IfInString, L, target2_1
		{
			FFP := "運輸艦隊"
			FFP_V := 60
			Blocked := TargetFailed2
		}
		else IfInString, L, target_1
		{
			FFP := "航空艦隊"
			FFP_V := 32
			Blocked := TargetFailed1
		}
		else IfInString, L, targetElite_1
		{
			FFP := "賽任艦隊"
			FFP_V := 8
			Blocked := 0
		}
		else IfInString, L, target_plane1
		{
			FFP := "航空器"
			FFP_V := 25
			Blocked := Plane_TargetFailed1
		}
		else IfInString, L, Lv
		{
			FFP := "Lv"
			FFP_V := 30
			Blocked := 0
		}
		if ((!Blocked or SearchLoopcount>9) and Gdip_ImageSearch(pBitmap, bmpNeedle, List, x1, y1, x2, y2, FFP_V, , direction, 0, "|", ","))
		{
			Loop, parse, List, "|"
			{
				FleetPos%A_index% := StrSplit(A_LoopField, ",")
				s++
			}
			Loop, %s%
			{
				s2 := A_index+1
				if ((Abs(FleetPos%A_index%[1]-FleetPos%s2%[1])>=20) or Abs(FleetPos%A_index%[2]-FleetPos%s2%[2])>=20 or A_index=s)
					wfp .= FleetPos%A_index%[1]"," FleetPos%A_index%[2]"｜"
			}
			StringTrimRight, wfp, wfp, 1
			LogShow("發現：" FFP " " wfp)
			;~ msgbox % "All: `n" List "`n`nSort: `n" wfp "`n`nSD: " direction
			Loop, parse, wfp, "｜"
			{
				LISTArray2 := StrSplit(A_LoopField, ",")
				if (FFP="賽任艦隊")
					LISTArray2[2] := LISTArray2[2]+80
				if MoveMap(LISTArray2[1], LISTArray2[2])
				{
					wfp := ""
					break
				}
				C_Click(LISTArray2[1], LISTArray2[2])
				sleep 800
				if FindWay(LISTArray2[1], LISTArray2[2])
				{
					break
				}
				else if (Find(nx, ny, 495, 330, 530, 390, "|<>*200$8.zyT3kyTzzyT3kwD3kwD3kwD3kwD3kzy"))
				{
					LogShow("前往 X: " LISTArray2[1] " Y: " LISTArray2[2] "的路徑被擋住了！")
					sleep 3000
				}
				else
				{
					break
				}
			}
			x := LISTArray2[1], y := LISTArray2[2]
			break
		}
		Gdip_DisposeImage(bmpNeedle)
	}
	Gdip_DisposeImage(bmpNeedle)
	Gdip_DisposeImage(pBitmap)
	return wfp
}

SortFleet() {
	global Ship_Target1_S, Ship_Target2_S, Ship_Target3_S, Ship_Target4_S, Ship_TargetE_S, Ship_TargetP_S
	global Ship_Target1, Ship_Target2, Ship_Target3, Ship_Target4, Ship_TargetElite, Plane_Target1
	global SearchLoopcount
	if (Ship_Target1 or SearchLoopcount>9)
		Ship_Target1Pic := "img/SubChapter/target_1.png"
	if (Ship_Target2 or SearchLoopcount>9)
		Ship_Target2Pic := "img/SubChapter/target2_1.png"
	if (Ship_Target3 or SearchLoopcount>9)
		Ship_Target3Pic := "img/SubChapter/target3_1.png"
	if (Ship_Target4 or SearchLoopcount>9)
		Ship_Target4Pic := "img/SubChapter/target4_1.png"
	if (Ship_TargetElite or SearchLoopcount>9)
		Ship_TargetElitePic := "img/SubChapter/targetElite_1.png"
	if (Plane_Target1)
		Plane_TargetPic := "img/SubChapter/target_plane1.png"
	myArray := [[Ship_Target1_S, Ship_Target1Pic]
	,[Ship_Target2_S, Ship_Target2Pic]
	,[Ship_Target3_S, Ship_Target3Pic]
	,[Ship_Target4_S, Ship_Target4Pic]
	,[Ship_TargetE_S, Ship_TargetElitePic]
	,[Ship_TargetP_S, Plane_TargetPic]]
	tList := ""
	For each, arr In myArray
		tList .= arr[1] " " arr[2] "`n"
	tList := RegExReplace(tList,"s)^\v+|\v+$")
	Sort, tList
	myArray :=	[]
	Loop, parse, tList, `n, `r
		_ :=	StrSplit(A_LoopField," "), myArray.Push([_[1],_[2]])
	For each, arr In myArray
		myResult .= (arr[2]!="") ? arr[2] "," : ""
	StringTrimRight, myResult, myResult, 1
	return StrSplit(myResult, ",")
}

;~ F3::
;~ MapX1 := 10, MapY1 := 10, MapX2 := 1260, MapY2 := 700
;~ Random, SearchDirection, 5, 8
;~ img := "img/SubChapter/target3_1.png"
;~ v := 40
;~ if FindFleet_2(x, y, FP, SearchDirection, MapX1, MapY1, MapX2, MapY2) ;(FindFleet(x, y,fleet , 40, 5, MapX1, MapY1, MapX2, MapY2))
;~ {
	;~ WinActivate, %title%
	;~ mousemove, %x%, %y%
	;~ LogShow2( img " _ X: " x " Y: " y)
;~ } else {
	;~ LogShow2( img " NotFound ")
;~ }
;~ return
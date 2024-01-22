#include "Stdafx.h"

#include "GameApp.h"

#include "SceneObjSet.h"
#include "EffectSet.h"
#include "MusicSet.h"
#include "CharacterPoseSet.h"
#include "MapSet.h"
#include "ChaCreateSet.h"
#include "EventSoundSet.h"
#include "AreaRecord.h"
#include "ServerSet.h"

#ifdef __EDITOR__
#include "MPEditor.h"
#endif
#include "FindPath.h"
#include "LEFont.h"

#include "EffectObj.h"
#include "notifyset.h"
#include "ChatIconSet.h"
#include "ItemTypeSet.h"
#include "InputBox.h"
#include "ItemPreSet.h"
#include "ItemRefineSet.h"
#include "ItemRefineEffectSet.h"
#include "StoneSet.h"
#include "ElfSkillSet.h"
#include "GameWG.h"
#include "GameMovie.h"
#include "MonsterSet.h"
#include "helpinfoSet.h"

#ifdef __SOUND__
#ifndef USE_DSOUND
#include "AudioThread.h"
CAudioThread g_AudioThread;
DWORD		 g_dwCurMusicID = 0;
#endif
#endif
// 多语言库须先初始化
//CLanguageRecord g_oLangRec("./scripts/table/StringSet.bin", "./scripts/table/StringSet.txt");
//pi_LeakReporter pi_leakReporter("gamememleak.log");
//CResourceBundleManage g_ResourceBundleManage("Game.loc"); //Add by lark.li 20080130

bool volatile g_bLoadRes = FALSE;
CGameApp* g_pGameApp	 = NULL;

CEffectSet*			  CEffectSet::_Instance			  = NULL;
CShadeSet*			  CShadeSet::_Instance			  = NULL;
CMusicSet*			  CMusicSet::_Instance			  = NULL;
CPoseSet*			  CPoseSet::_Instance			  = NULL;
CMapSet*			  CMapSet::_Instance			  = NULL;
CChaCreateSet*		  CChaCreateSet::_Instance		  = NULL;
CEventSoundSet*		  CEventSoundSet::_Instance		  = NULL;
CAreaSet*			  CAreaSet::_Instance			  = NULL;
CServerSet*			  CServerSet::_Instance			  = NULL;
CNotifySet*			  CNotifySet::_Instance			  = NULL;
CChatIconSet*		  CChatIconSet::_Instance		  = NULL;
CItemTypeSet*		  CItemTypeSet::_Instance		  = NULL;
CItemPreSet*		  CItemPreSet::_Instance		  = NULL;
CItemRefineSet*		  CItemRefineSet::_Instance		  = NULL;
CItemRefineEffectSet* CItemRefineEffectSet::_Instance = NULL;
CStoneSet*			  CStoneSet::_Instance			  = NULL;
CElfSkillSet*		  CElfSkillSet::_Instance		  = NULL;
CMonsterSet*		  CMonsterSet::_Instance		  = NULL; //Add by sunny.sun 20080903
CHelpInfoSet*		  CHelpInfoSet::_Instance		  = NULL;

#ifdef __EDITOR__
MPEditor g_Editor;
#endif
CFindPath	g_cFindPath(128, 38);
CFindPathEx g_cFindPathEx;
CInputBox	g_InputBox;

CGameWG	   g_oGameWG;
CGameMovie g_GameMovie;

// 客户端版本号, 在GateServer有验证
short g_sClientVer = 110;
//short g_sClientVer = 138;

// CLightEff plight;

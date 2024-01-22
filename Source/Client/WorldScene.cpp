#include "stdafx.h"
#include "worldscene.h"
#include "Character.h"
#include "SceneObj.h"
#include "SceneItem.h"
#include "EffectObj.h"
#include "EffectSet.h"
#include "LEModelEff.h"
#include "LEFont.h"
#include "SceneObjSet.h"
#include "GameApp.h"
#include "GameConfig.h"
#ifdef __EDITOR__
#include "MPEditor.h"
#endif
#include "SceneObjFile.h"
#include "SmallMap.h"
#include "CharacterAction.h"
#include "UIEdit.h"
#include "UIList.h"
#include "SceneItemSet.h"
#include "UIGuiData.h"
#include "LuaInterface.h"
#include "UICursor.h"
#include "GlobalVar.h"
#include "UIFormMgr.h"
#include "MapSet.h"
#include "GameAppMsg.h"
#include "UIChat.h"
#include "UITeam.h"
#include "talksessionformmgr.h"
#include "cameractrl.h"
#include "uiminimapform.h"
#include "LoginScene.h"
#include "PacketCmd.h"
#include "SkillRecord.h"
#include "SceneLight.h"
#include "LitLoad.h"
#include "STAttack.h"
#include "Actor.h"
#include "UIHeadSay.h"
#include "AreaRecord.h"
#include "stpose.h"
#include "STNpcTalk.h"
#include "uiequipform.h"
#include "uistartform.h"
#include "stmove.h"
#include "ShipFactory.h"
#include "CommFunc.h"
#include "EventRecord.h"
#include "event.h"
#include "isskilluse.h"
#include "uicozeform.h"
#include "HairRecord.h"
#include "uiboatform.h"
#include "uisystemform.h"
#include "FindPath.h"

#include "UIDoublePwdForm.h"

//---------------------------------------------------------------------------
// 给场景光标变换使用的内联函数
//---------------------------------------------------------------------------
inline bool	_HaveEventCursor( CEvent* pEvent, int nMainType )
{
	if( pEvent->IsNormal() && pEvent->GetInfo()->IsValid( nMainType ) )
	{
		CCursor::I()->SetFrame( (CCursor::eState)pEvent->GetInfo()->sCursor );
		return true;
	}

	CCursor::I()->Restore();
	return false;
}

bool g_bIsMouseWalk = false; //鼠标压住移动模式
//---------------------------------------------------------------------------
// class CWorldScene
//---------------------------------------------------------------------------
BYTE		CWorldScene::_bAttackRed		= 100;
BYTE		CWorldScene::_bAttackGreen		= 100;
BYTE		CWorldScene::_bAttackBlue		= 100;
bool		CWorldScene::_IsShowPing		= false;
bool		CWorldScene::_IsAutoPick		= false;
bool		CWorldScene::_IsShowCameraInfo	= false;

bool		CWorldScene::_IsThrowItemHint	= false;

CWorldScene::CWorldScene(stSceneInitParam& param)
: CGameScene(param), _pAnimLightSeq(0), _dwAnimLightNum(0), _nOldMainChaInArea(-1),_IsShowSideLife(false)
{
//	LG( "scene memory", "CWorldScene Create\n" );

    _pShipMgr = new xShipMgr();
    _pShipMgr->Init(this);

	_bEnableCamDrag    = TRUE;
	for(int i=0; i<4; i++)
		m_strChar[i] = NULL;
}

CWorldScene::~CWorldScene()
{
//	LG( "scene memory", "CWorldScene Destroy\n" );

    delete _pShipMgr;

    if(_pAnimLightSeq)
    {
        delete[] _pAnimLightSeq;
    }
	_cFont.ReleaseFont();
}

BOOL CWorldScene::_LoadAnimLight(const char* file)
{

    FILE* fp;
	fopen_s( &fp, file, "rt");
    if(fp == NULL)
        return 0;

    fscanf_s(fp, "%d", &_dwAnimLightNum);
    _pAnimLightSeq = new(AnimCtrlLight[_dwAnimLightNum]);

    for(DWORD j = 0; j < _dwAnimLightNum; j++)
    {
        DWORD key_num;
        fscanf_s(fp, "%d", &key_num);

        IndexDataSceneLight* p;
        IndexDataSceneLight* data_seq = new(IndexDataSceneLight[key_num]);

        for(DWORD i = 0; i < key_num; i++)
        {
            p = &data_seq[i];
            fscanf_s(fp, "%d, %d, %f %f %f, %f, %f %f %f\n", 
                &p->id, &p->light.type,
                &p->light.amb.r, &p->light.amb.g, &p->light.amb.b,
                &p->light.range,
                &p->light.attenuation0, &p->light.attenuation1, &p->light.attenuation2);

            p->light.pos.x = p->light.pos.y = p->light.pos.z = 0.0f;
            p->light.amb.r /= 255.0f;
            p->light.amb.g /= 255.0f;
            p->light.amb.b /= 255.0f;
            p->light.amb.a = 1.0f;
            p->light.dif = p->light.amb;
        }

        _pAnimLightSeq[j].SetData(data_seq, key_num);

        delete[] data_seq;
    }

    fclose(fp);

    return 1;
}

void CWorldScene::SetAttackChaColor( BYTE r, BYTE g, BYTE b )
{
	_bAttackRed = r;
	_bAttackGreen = g;
	_bAttackBlue = b;
}

bool CWorldScene::_Init()
{
#ifdef __FPS_DEBUG__
	LETimer tInit;
    tInit.Begin();
#endif    
    if( !CGameScene::_Init() ) return false;

	_cMouseDown.Init( this );
	 // end


    // 为给界面显示创建一个Character以及相关的控件
	if(!g_pGameApp->GetMainCam()->m_bSelectMode)
		_InitUI() ;
	else
		_InitSelectUI();
	 
    // 编辑器模式
	if(g_Config.m_bEditor)
	{		
		// 创建相关控件并设置参数    
        CCharacter *pCha = NULL;
		for(int i = 0; i < g_Config.m_nChaCnt; i++)
		{
			pCha = AddCharacter(g_Config.m_ChaList[i].nTypeID);
			if( pCha )
			{
				pCha->setPos(g_Config.m_ChaList[i].nX * 100, g_Config.m_ChaList[i].nY * 100); 		
				pCha->EnableAI(FALSE);

				pCha->setYaw( 45 - rand()%90);

				if(i == 0) SetMainCha(pCha->getID());
			}
		}
		pCha = GetMainCha();
		if( pCha ) 
		{
			//CCameraCtrl *pCam = g_pGameApp->GetMainCam();	

			//pCam->SetFollowObj(pCha->GetPos());
			//g_pGameApp->ResetGameCamera();
			g_pGameApp->EnableCameraFollow(true);

            if( pCha->getTypeID()<5 )
            {
                if( g_Config.nLeftHand>0 )
                {
                    pCha->UpdataItem( g_Config.nLeftHand, LINK_ID_LEFTHAND );
                }

                if( g_Config.nRightHand>0 )
                {
                    pCha->UpdataItem( g_Config.nRightHand, LINK_ID_RIGHTHAND );
                }
				pCha->LoadingCall();
            }
		}
	}

#ifdef USE_RENDER
	_cFont.CreateFont(&g_Render,const_cast<char*>(RES_STRING(CL_LANGUAGE_MATCH_66)));
#else
	_cFont.CreateFont(g_Render.GetDevice(),const_cast<char*>(RES_STRING(CL_LANGUAGE_MATCH_66)));
#endif
	_cFont.BindingRes(&ResMgr);

	CFormMgr::s_Mgr.SetEnabled( true );
	
    _LoadAnimLight(".\\scripts\\txt\\aaa.tx");

	_cSceenSign.Init( this );

	SwitchShipBuilder();

    _IsUseSound = true;

	if(!g_pGameApp->GetMainCam()->m_bSelectMode)
		g_stUIChat.GetTeamMgr()->SceneSwitch();
#ifdef __FPS_DEBUG__
//	LG("init", "World Scene Init Use Time = %d\n", tInit.End());
#endif
    return true;
}

bool CWorldScene::_Clear()
{
    if( !CGameScene::_Clear() ) return false;

	_cMouseDown.Reset();
	return true;
}

void CWorldScene::_FrameMove( DWORD dwTimeParam )
{
	CGameScene::_FrameMove( dwTimeParam );

	g_Render.SetWorldViewAspect(0.0f);

    static DWORD dwLastTime = 0;
    if( (dwLastTime<dwTimeParam) && GetMainCha() )
    {
		dwLastTime = dwTimeParam + 200 + rand() % 300;
        PlayEnvSound( (int)(g_pGameApp->GetMainCam()->m_RefPos.x * 100.0f), (int)(g_pGameApp->GetMainCam()->m_RefPos.y * 100.0f) );

        if( _pTerrain )
        {
            static bool isOldFight = false;
            bool isFight = !(_pTerrain->GetTile(GetMainCha()->GetCurX()/100, GetMainCha()->GetCurY()/100)->sRegion & enumAREA_TYPE_NOT_FIGHT);
            if( isOldFight!=isFight )
            {
                if( isFight )
                {
                    g_pGameApp->SysInfo( RES_STRING(CL_LANGUAGE_MATCH_788) );
                }
                else
                {
                    g_pGameApp->SysInfo( RES_STRING(CL_LANGUAGE_MATCH_789) );
                }
            }

            isOldFight = !(_pTerrain->GetTile(GetMainCha()->GetCurX()/100, GetMainCha()->GetCurY()/100)->sRegion & enumAREA_TYPE_NOT_FIGHT);

			if( _pMapInfo->IsShowSwitch )
			{
				int nArea = _pTerrain->GetTile( GetMainCha()->GetCurX()/100, GetMainCha()->GetCurY()/100 )->getIsland();
				if( nArea!=_nOldMainChaInArea )
				{
					_nOldMainChaInArea=nArea;

					static CAreaInfo* pArea;
					pArea = GetAreaInfo( nArea );
					if( pArea )
					{
						g_pGameApp->ShowBigText( "%s", pArea->szDataName );
						g_pGameApp->PlayMusic( pArea->nMusic );
						//g_stUIMap.RefreshMapName( pArea->szDataName );
					}
					else if( _pMapInfo )
					{
						string name = string(_pMapInfo->szName) + RES_STRING(CL_LANGUAGE_MATCH_790);
						//g_stUIMap.RefreshMapName( name.c_str() );
						g_pGameApp->ShowBigText( "%s", name.c_str() );
					}
				}
			}
        }        

		_pEventMgr->DistanceTrigger( GetMainCha() );

        if( _cSceenSign.IsShowMove() && GetMainCha()->GetIsArrive() && GetMainCha()->GetActor()->IsEmpty() )
        {
			_cSceenSign.Hide();
			if(CGameApp::GetCurScene()->GetEffect(536))
			{
				CGameApp::GetCurScene()->GetEffect(536)->SetValid(FALSE);
			}
        }

        g_stUIMap.RefreshChaPos( GetMainCha()->GetCurX(), GetMainCha()->GetCurY() );
    }

	//jze
	if(g_cFindPathEx.HaveTarget())
	{
		g_cFindPathEx.Move();
	}

	if( g_pGameApp->_CanInput() )
	{
		_cMouseDown.Start();
		switch( CFormMgr::GetMouseAction() )
		{
		case GUI::enumMA_Gui:
			break;
		case GUI::enumMA_Skill:
			if( GetUseLevel().IsFalse(LEVEL_CHA_RUN) )
			{
				CCursor::I()->Restore();
			}
			else if( !CGameScene::GetMainCha() )
			{
				CCursor::I()->Restore();
			}
			else
			{
				CSkillRecord* pSkill = CGameScene::GetMainCha()->GetReadySkillInfo();
				if( pSkill && pSkill->IsAttackArea() )
				{
					// 改变鼠标为攻击地面
					CGameScene::Set3DMouseState( enumFollow );
					g_pGameApp->GetCursor()->SetCursor( csCircleCursor );
					CCursor::I()->SetFrame( CCursor::stSkillAttack );
				}
				else
				{
					g_pGameApp->GetCursor()->SetCursor( csNormalCursor );
					CGameScene::Set3DMouseState( enumClick );

					// 单体技能,检测攻击对象是否正确
					if( pSkill )
					{
						CCursor::I()->SetFrame( CCursor::stSkillAttack );
					}
					else
					{
						CCursor::I()->Restore();
					}
				}
			}
			break;
		case GUI::enumMA_Drill:
			if( !CGameApp::IsMouseInScene() ) 
				break;

		case GUI::enumMA_None:
			if( GetUseLevel().IsTrue(LEVEL_CHA_RUN) ) 
			{	
				DWORD key = g_pGameApp->GetMouseKey();
				if( g_bIsMouseWalk )
				{
					if( key & M_Down )
					{
						if( GetMainCha() )
						{
							if( key & M_LDown )
							{
								D3DXVECTOR3 vPos;
								GetPickPos( g_pGameApp->GetMouseX(), g_pGameApp->GetMouseY(), vPos );
								int nScrX = (int)(vPos.x * 100.0f);
								int nScrY = (int)(vPos.y * 100.0f);
								_cMouseDown.ActMove( GetMainCha(), nScrX, nScrY );
							}
							else
							{
								CMoveState* pMove = dynamic_cast<CMoveState*>( GetMainCha()->GetActor()->GetCurState() );
								if( pMove )
								{
									GetMainCha()->GetActor()->Stop();
								}
							}
						}
						CCursor::I()->Restore();
						g_bIsMouseWalk = false;
					}
					else
					{
						CCursor::I()->SetFrame( CCursor::stUpBank );
						_cMouseDown.CheckWalkContinue();
					}
				}
				else if( CGameApp::IsMouseContinue(0) )
				{
					//鼠标压住移动模式 取消路径搜寻，避免互相干扰 by Waiting 2009-08-04
					g_stUIMap.ClearRadar();
					g_cFindPathEx.Reset();
					g_cFindPath.SetShortPathFinding(128,38);
					g_bIsMouseWalk = true;
					CCursor::I()->Restore();
				}
				else if( key==0 )
				{
					_SceneCursor();
				}
				else if( key & M_LDown )
				{
					bool bGiveResponse = true;

					//if(g_cFindPath.LongPathFinding())
					//{
					//	CWorldScene* pScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
					//	int CurX = pScene->GetMainCha()->GetCurX();
					//	int CurY = pScene->GetMainCha()->GetCurY();
					//	int SerX = pScene->GetMainCha()->GetServerX();
					//	int SerY = pScene->GetMainCha()->GetServerY();
					//	pScene->GetMainCha()->CheckIsFightArea();
					//	if(GetDistance(CurX,CurY,SerX,SerY) > 500 && !pScene->GetMainCha()->GetIsFight())
					//		bGiveResponse = false;
					//}

					if(bGiveResponse)
					{
						_SceneCursor();
						g_cFindPathEx.Reset();
						g_cFindPath.SetShortPathFinding(128,38);
						_cMouseDown.MouseButtonDown();
					}
				}
				else if( key & M_RDown )
				{
					// 改变鼠标为攻击单人
					g_pGameApp->GetCursor()->SetCursor( csNormalCursor );
					CGameScene::Set3DMouseState( enumClick );
					CCursor::I()->Restore();

					int nMouseX = g_pGameApp->GetMouseX();
					int nMouseY = g_pGameApp->GetMouseY();
					bool IsShop = false;
					CCharacter* pCha = NULL;

					for(int i = 0; i < _nChaCnt; i++)
					{
						pCha = &_pChaArray[i];
						if(!pCha->IsValid()) 
							continue;

						if( pCha->IsShop() )
						{
							if( pCha->GetHeadSay()->InShop( nMouseX, nMouseY ) )
							{
								if( !pCha->IsMainCha() && GetMainCha() && !GetMainCha()->IsShop() )
								{
									_cMouseDown.ActShop( GetMainCha(), pCha );
								}
								IsShop = true;
								break;
							}
						}
					}

					if( !IsShop )
					{
						pCha = HitSelectCharacter( nMouseX, nMouseY, enumSC_PLAYER );
						if( pCha )
						{
							g_stUIStart.PopMenu( pCha );
						}
					}
				}
				else
				{
					_SceneCursor();
				}
			}
			else
			{
				CCursor::I()->Restore();
			}
			break;
		}
		_cMouseDown.FrameMove();

		static DWORD key = 0;
		static DWORD RDownTime = 0;
		key = g_pGameApp->GetMouseKey();
		if( key & M_RDown ) 
		{
			RDownTime = CGameApp::GetCurTick() + 200;
		}
		if( (key & M_RUp) && (CGameApp::GetCurTick() <= RDownTime) )
		{
			CCharacter* pMain = CGameScene::GetMainCha();
			if( pMain )
			{
				pMain->ResetReadySkill();
				CActionState* pState = pMain->GetActor()->GetCurState();
				if( pState ) pState->MouseRightDown();
			}

			if( CFormMgr::GetMouseAction()==GUI::enumMA_None )
				_cMouseDown.Reset();
		}
	}

    if(_pShipMgr)
    {
        _pShipMgr->FrameMove();
    }

	if( _IsAutoPick )
	{
		static DWORD dwTime = 0;
		if( CGameApp::GetCurTick() > dwTime )
		{
			dwTime = CGameApp::GetCurTick() + 10000;
			PickItem();
		}
	}
}

void CWorldScene::_Render()
{
    //GetMainCha()->SetColor(255, 0, 0);
   // LG("load"," Scene Render!\n");
	CGameScene::_Render();

    CCharacter *pUICha = GetCha(0);
    if(pUICha)
    {
         //pUICha->RenderForUI( 100, 300 );
    }

	if( _IsShowPing )
	{
		CWaitMoveState::RenderPing();
	}

	if( _IsShowCameraInfo )
	{
		CWaitMoveState::RenderCameraInfo();
	}
}

int CWorldScene::SwitchShipBuilder()
{
    return 1;
}

bool CWorldScene::_HandleSuperKey()
{
	if(g_pGameApp->IsKeyDown(DIK_F2))
	{
		//CGameScene::_pLargerMap->Show( !CGameScene::_pLargerMap->IsShow() );
	}
	if(g_pGameApp->IsKeyDown(DIK_7)) 
	{
        ((CWorldScene*)this)->SwitchShipBuilder();
    }
	else if( g_pGameApp->IsKeyDown(DIK_R) )
	{
		if( CGameScene::GetMainCha() )
		{
			stNetChangeChaPart stPart;
			memset( &stPart, 0, sizeof(stPart) );
			stPart.sTypeID = 201;
			CS_BeginAction( CGameScene::GetMainCha(), enumACTION_LOOK, &stPart );
		}
	}
    else if(g_pGameApp->IsKeyDown(DIK_5))
    {
        static bool be_windowed = 1;
        g_pGameApp->ChangeVideoStyle(800, 600, D3DFMT_D16, be_windowed);
    }

    return CGameScene::_HandleSuperKey();
}

BOOL CWorldScene::_InitUI()
{
	CForm* form = CFormMgr::s_Mgr.Find( "frmMainChat" );
	if(form)
	{
		form->Show();

		CEdit* edit = dynamic_cast<CEdit*>(form->Find( "edtSay" ));  //是否能输入图元
		if( edit ) edit->SetIsParseText(true ); 
	} 

	form = CFormMgr::s_Mgr.Find( "frmMain800" );
	if( form ) form->Show();

	form = CFormMgr::s_Mgr.Find( "frmDetail" );
	if( form ) form->Show();

	form = CFormMgr::s_Mgr.Find( "frmMainFun" );
	if( form ) form->Show();

	form = CFormMgr::s_Mgr.Find( "frmMinimap" );
	if( form ) form->Show();

	form = CFormMgr::s_Mgr.Find( "frmFast" );
	if( form ) form->Show();

	ShowMinimap( TRUE );
	g_pGameApp->GetCursor()->SetIsVisible( TRUE );
	return TRUE;
}
CWorldScene& CWorldScene::GetCurrScene()
{
	CWorldScene* pScene = 
		dynamic_cast<CWorldScene*>(g_pGameApp->GetCurScene());

	if (!pScene) NULL;

	return *pScene;
}
BOOL CWorldScene::_InitSelectUI()
{
	//选人界面的表单
	frmSelectCha = CFormMgr::s_Mgr.Find( "frmSelect", 6 );
	if(!frmSelectCha)		return false;

	btnDel = dynamic_cast<CTextButton *>(frmSelectCha->Find("btnDel"));
	if (!btnDel)            return false;
	btnYes = dynamic_cast<CTextButton *>(frmSelectCha->Find("btnYes"));
	if (!btnYes)            return false;
	btnCreate = dynamic_cast<CTextButton *>(frmSelectCha->Find("btnCreate"));
	if (!btnCreate)         return false;
	btnExit = dynamic_cast<CTextButton *>(frmSelectCha->Find("btnNo"));
	if (!btnExit)            return false;
	btnAlter = dynamic_cast<CTextButton *>(frmSelectCha->Find("btnAlter"));
	if (!btnAlter)           return false;
	btnleft = dynamic_cast<CTextButton *>(frmSelectCha->Find("btnLeft3d"));
	if (!btnleft)           return false;
	btnright = dynamic_cast<CTextButton *>(frmSelectCha->Find("btnRight3d"));
	if (!btnright)           return false;

	// 设置创建按钮闪烁
	btnCreate->SetFlashCycle();

	frmSelectCha->SetPos(
		(g_pGameApp->GetWindowWidth() - frmSelectCha->GetWidth())/2,
		g_pGameApp->GetWindowHeight() - frmSelectCha->GetHeight() - 20 );
	frmSelectCha->Refresh();
	frmSelectCha->Show();

	frmSelectCha->evtEntrustMouseEvent = _SelChaFrmMouseEvent;

	// 角色list
	frmCharList= dynamic_cast<CList *> (frmSelectCha->Find( "lstChar" ));
	if(!frmCharList)
		return false;
	frmCharList->evtListMouseDown = _evtCharListLDBDown;

	// 选择种族
	frmRace = CFormMgr::s_Mgr.Find( "frmRace", 6 );
	if(!frmRace)
		return false;
	btnrace1 = dynamic_cast<CTextButton *>(frmRace->Find("btnrace1"));
	if (!btnrace1)         return false;
	btnrace2 = dynamic_cast<CTextButton *>(frmRace->Find("btnrace2"));
	if (!btnrace2)            return false;
	btnrace3 = dynamic_cast<CTextButton *>(frmRace->Find("btnrace3"));
	if (!btnrace3)           return false;
	btnback = dynamic_cast<CTextButton *>(frmRace->Find("btnback"));
	if (!btnback)           return false;
	
	frmRace->evtEntrustMouseEvent = _SelChaFrmMouseEvent;

	// 模型选择
	frmmod = CFormMgr::s_Mgr.Find( "frmmod", 6 );
	if(!frmmod)
		return false;
	edtModName = dynamic_cast<CEdit*>(frmmod->Find( "edtname" ));
	if( edtModName )
	{
		edtModName->SetCaption("");
		edtModName->SetIsPassWord( true );
		edtModName->SetIsWrap(true);
		//edtModName->evtEnter = _evtEnter;
	}
	btnModYes = dynamic_cast<CTextButton *>(frmmod->Find("btnYes"));
	if (!btnModYes)         return false;
	btnModleft = dynamic_cast<CTextButton *>(frmmod->Find("btnLeft3d"));
	if (!btnModleft)           return false;
	btnModright = dynamic_cast<CTextButton *>(frmmod->Find("btnRight3d"));
	if (!btnModleft)           return false;
	frmmod->evtEntrustMouseEvent = _SelChaFrmMouseEvent;

	// 创建欢迎界面   该界面仅在当前帐号内无角色时出现
	frmWelcomeNotice = CFormMgr::s_Mgr.Find("frmWelcomeNotice");
	if(!frmWelcomeNotice)		return false;
	frmWelcomeNotice->evtEntrustMouseEvent = _evtWelcomeNoticeEvent;

	// 定义首次创建角色成功提示界面   该界面仅在该帐号走完第一个角色的创建流程后显示
	frmCreateOKNotice = CFormMgr::s_Mgr.Find("frmCreateOKNotice");
	if(!frmCreateOKNotice)		return false;
	frmCreateOKNotice->evtEntrustMouseEvent = _evtCreateOKNoticeEvent;

	// 处理按钮是否可以用
	UpdateButton();

	frmChaNameAlter = CFormMgr::s_Mgr.Find("frmChaNameAlter");
	if(! frmChaNameAlter)       return false;
	frmChaNameAlter->evtEntrustMouseEvent = _evtChaNameAlterMouseEvent;

	return true;
}
void CWorldScene::_SelChaFrmMouseEvent(CCompent *pSender, int nMsgType, 
										   int x, int y, DWORD dwKey)
{
	string strName = pSender->GetName();

	// if ( stricmp ("frmSelect", pSender->GetForm()->GetName()) != 0 )
	//if ( _stricmp ("frmSelect", pSender->GetForm()->GetName()) != 0 )
	//{
	//	return ;
	//}

	if(strName=="btnrace1")
	{
		GetCurrScene().frmRace->SetIsShow(false);
		//GetCurrScene().frmSelectCha->SetIsShow(true);
		GetCurrScene().frmmod->SetIsShow(true);
		CCharacter* pCha = CGameApp::GetCurScene()->AddCharacter(2);
		if (!pCha) return ;
		pCha->UpdataFace( GetCurrScene().m_part );
		pCha->setPos(6500, 5300);
		pCha->setYaw(140);
		CGameApp::GetCurScene()->SetMainCha(pCha->getID());
	}
	else if(strName=="btnrace2")
	{
		GetCurrScene().frmRace->SetIsShow(false);
		//GetCurrScene().frmSelectCha->SetIsShow(true);
		GetCurrScene().frmmod->SetIsShow(true);
		CCharacter* pCha = CGameApp::GetCurScene()->AddCharacter(2);
		if (!pCha) return ;
		pCha->UpdataFace( GetCurrScene().m_part );
		pCha->setPos(6500, 5300);
		pCha->setYaw(140);
		CGameApp::GetCurScene()->SetMainCha(pCha->getID());
	}
	else if(strName=="btnrace3")
	{
		GetCurrScene().frmRace->SetIsShow(false);
		//GetCurrScene().frmSelectCha->SetIsShow(true);
		GetCurrScene().frmmod->SetIsShow(true);
		CCharacter* pCha = CGameApp::GetCurScene()->AddCharacter(2);
		if (!pCha) return ;
		pCha->UpdataFace( GetCurrScene().m_part );
		pCha->setPos(6500, 5300);
		pCha->setYaw(140);
		CGameApp::GetCurScene()->SetMainCha(pCha->getID());
	}
	else if(strName == "btnback")
	{
		GetCurrScene().frmRace->SetIsShow(false);
		GetCurrScene().frmSelectCha->SetIsShow(true);
		if(_pMainCha)
			_pMainCha->SetHide(true);
	}
	else if(strName == "btnLeft3d")
	{
		if(_pMainCha)
		{
			int iYaw = _pMainCha->getYaw();
			iYaw += 10;
			_pMainCha->setYaw(iYaw);
		}
	}
	else if(strName == "btnRight3d")
	{
		if(_pMainCha)
		{
			int iYaw = _pMainCha->getYaw();
			iYaw -= 10;
			_pMainCha->setYaw(iYaw);
		}
	}
	else if(strName == "btnCreate")
	{
		GetCurrScene().frmSelectCha->SetIsShow(false);
		GetCurrScene().frmRace->Show();
	}
	else if(strName == "btnDel")
	{
		if(g_Config.m_IsDoublePwd)
		{
			// 删除角色需要二次密码  modify by Philip.Wu  2006-07-19
			g_stUIDoublePwd.SetType(CDoublePwdMgr::DELETE_CHARACTOR);
			g_stUIDoublePwd.ShowDoublePwdForm();
		}
		else
		{
			// 删除帐号
			//CBoxMgr::ShowSelectBox(_CheckFrmMouseEvent, RES_STRING(CL_LANGUAGE_MATCH_384), true);
		}
	}
	else if ( strName == "btnYes" )
	{
		if ( _stricmp ("frmSelect", pSender->GetForm()->GetName()) == 0 )
		{
			//进入游戏
			//向服务器发送开始游戏的消息
			GetCurrScene().SendBeginPlayToServer();
			CGameApp::Waiting();
		}
		if ( _stricmp ("frmmod", pSender->GetForm()->GetName()) == 0 )
		{
			memset( &GetCurrScene().m_part, 0, sizeof(GetCurrScene().m_part) );
			GetCurrScene().m_part.sTypeID = 2;
			GetCurrScene().m_part.sHairID = 0;
			GetCurrScene().m_part.SLink[enumEQUIP_FACE] = (short)_pMainCha->GetPartID(1);
			char szLookbuf[defLOOK_DATA_STRING_LEN];
			if (LookData2String(&GetCurrScene().m_part, szLookbuf, defLOOK_DATA_STRING_LEN))
			{
				CS_NewCha( GetCurrScene().edtModName->GetCaption(), "vampire", GetCurrScene().m_part );
				CGameApp::Waiting();
			}
			else
				g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_54));
		}
		
	}		
	else if( strName =="btnNo")
	{	
		// 退出选人场景
		CS_Logout();
		CS_Disconnect(DS_DISCONN);
		g_pGameApp->LoadScriptScene( enumLoginScene );
	}
	else if( strName == "btnAlter" )
	{
		// 更新二次密码

		g_stUIDoublePwd.ShowAlterForm();
	}

	return;
}
void CWorldScene::SendBeginPlayToServer()
{
	if (m_nCurChaIndex < 0 && m_nCurChaIndex > 2) return;

	CCharacter* pChao = m_strChar[m_nCurChaIndex];
	if(pChao)
		CS_BeginPlay( pChao->getName() ); 

}
void CWorldScene::ClearSelectUI()
{
	if (frmSelectCha)
		frmSelectCha->SetIsShow(false);
	g_pGameApp->GetMainCam()->m_bSelectMode = false;
}

// 询问是否要创建二次密码  add by Philip.Wu  2006-07-20
void CWorldScene::_evtCreateDoublePwdEvent(CCompent *pSender, int nMsgType, int x, int y, DWORD dwKey)
{
	if( nMsgType == CForm::mrYes ) 
	{
		// 显示创建二次密码窗体
		g_stUIDoublePwd.ShowCreateForm();
	}
	else
	{
		// 退出选人场景
		CS_Logout();
		CS_Disconnect(DS_DISCONN);
		g_pGameApp->LoadScriptScene( enumLoginScene );
	}
}
// 欢迎界面 事件处理
void CWorldScene::_evtWelcomeNoticeEvent(CCompent *pSender, int nMsgType, int x, int y, DWORD dwKey)
{

}


// 首次创建角色成功提示界面 事件处理
void CWorldScene::_evtCreateOKNoticeEvent(CCompent *pSender, int nMsgType, int x, int y, DWORD dwKey)
{
	string strName = pSender->GetName();
	CSelectChaScene* pSelectChaScene = dynamic_cast<CSelectChaScene*>(g_pGameApp->GetCurScene());


}

// 首次创建角色成功提示界面 事件处理
void CWorldScene::_evtChaNameAlterMouseEvent(CCompent *pSender, int nMsgType, int x, int y, DWORD dwKey)
{
	string strName = pSender->GetName();
	CSelectChaScene* pSelectChaScene = dynamic_cast<CSelectChaScene*>(g_pGameApp->GetCurScene());


}
// 角色选择
void CWorldScene::_evtCharListLDBDown(CGuiData *pSender, int x, int y, DWORD key)
{
	CList* pkcharList = dynamic_cast<CList*>(pSender);
	if (!pkcharList) return;
	bool bCreate = false;

	if( pkcharList == GetCurrScene().frmCharList)
	{
		DWORD dwcount = pkcharList->GetItems()->GetCount();
		const char* ReginText = pkcharList->GetItems()->GetSelect()->GetItem()->GetBegin()->GetString();
		string strname(ReginText);
		//if(strname.compare("人物未创建") == 0 )
		//	bCreate = true;
		for(int jj= 0; jj<4; jj++)
		{
			if(!GetCurrScene().m_strChar[jj])
				continue;
			if(strname.compare(GetCurrScene().m_strChar[jj]->getName()) == 0)
			{
				GetCurrScene().m_strChar[jj]->SetHide(false);
				GetCurrScene().m_nCurChaIndex = jj;
			}
			else
			{
				if(GetCurrScene().m_strChar[jj])
					GetCurrScene().m_strChar[jj]->SetHide(true);
			}
		}

	} 


	if (key & Mouse_LDown)
	{
		if(bCreate)
		{
			GetCurrScene().frmSelectCha->SetIsShow(false);
			GetCurrScene().frmRace->Show();
			
		}
		if(GetCurrScene().m_nCurChaIndex >= 0)
			GetCurrScene().UpdateButton();

	}
}
//-----------------------------------------------------------------------
void CWorldScene::DelCurrentSelCha()
{
	//在场景中删除该角色

	if(m_strChar[m_nCurChaIndex])
	{
		m_strChar[m_nCurChaIndex]->SetValid(false);
		m_strChar[m_nCurChaIndex] = NULL;
		m_nCurChaIndex = 0;
	}

	//处理相关UI界面
	UpdateButton();
	return;

}
bool CWorldScene::SelectCharacters(NetChaBehave* chabehave, int num)
{

	UpdateButton();

	return true;
}
bool CWorldScene::CreateCha()
{
	CCharacter* pCha = CGameApp::GetCurScene()->AddCharacter(2);
	if (!pCha) return false;
	pCha->setName(edtModName->GetCaption());
	pCha->UpdataFace( m_part );
	pCha->setPos(6500, 5300);
	pCha->setYaw(140);
	_pMainCha->SetHide(true);
	CGameApp::GetCurScene()->SetMainCha(pCha->getID());
	for(int i=0; i<4;i++)
	{
		if(m_strChar[i] == NULL)
		{
			SetCharNameToUI(pCha,i);
			m_nCurChaIndex = i;
			break;
		}
	}
	

	frmmod->SetIsShow(false);
	frmSelectCha->SetIsShow(true);

	UpdateButton();
	CGameApp::Waiting( false );
	return true;
}
void CWorldScene::SetCharNameToUI(CCharacter* pChar, int nChaIndex)
{
	int dwcount = (int)frmCharList->GetItems()->GetCount();

	if(nChaIndex < 0 || nChaIndex >= dwcount)
		return;
	frmCharList->GetItems()->Select(nChaIndex);
	m_strChar[nChaIndex] = pChar;
	
	frmCharList->GetItems()->GetSelect()->GetItem()->GetBegin()->SetString(pChar->getName());
}
void CWorldScene::SendDelChaToServer(const char szPassword2[])
{
	if (m_nCurChaIndex >= 0 && m_nCurChaIndex <= 2)
		//通知服务器删除角色
		CS_DelCha( m_strChar[m_nCurChaIndex]->getName(), szPassword2 ); 

}
void CWorldScene::UpdateButton()
{
	int i(0);

	if (i == 3)
		btnCreate->SetIsEnabled(false);

	if (m_nCurChaIndex < 0 || m_nCurChaIndex > 2)
	{
		btnDel->SetIsEnabled(false);
		btnYes->SetIsEnabled(false);
	}
	else
	{
		btnDel->SetIsEnabled(true);
		btnYes->SetIsEnabled(true);
	}

	if(! g_Config.m_IsDoublePwd)
	{
		btnCreate->SetIsEnabled(false);
		btnAlter->SetIsEnabled(false);
	}
	else
	{
		btnAlter->SetIsEnabled(true);
	}
}
// 获得角色个数
int CWorldScene::GetChaCount()
{
	int nCount = 0;

	return nCount;
}


void CWorldScene::ShowWelcomeNotice(bool bShow)
{
	if(frmWelcomeNotice)
	{
		frmWelcomeNotice->ShowModal();
	}
}



bool CWorldScene::_IsBlock( CCharacter* pCha, int x, int y )
{
	static D3DXVECTOR3 vPos;
    GetPickPos( x, y, vPos);

	int nX = (int)(vPos.x * 100.0f);
	int nY = (int)(vPos.y * 100.0f);	
	
    if( _pTerrain )
    {
        return _pTerrain->IsGridBlock( nX/50, nY/50 ) || !g_IsMoveAble( pCha->getChaCtrlType(), pCha->GetDefaultChaInfo()->chTerritory, (EAreaMask)_pTerrain->GetTile(nX/100, nY/100)->sRegion );
    }
    return true;
}

void CWorldScene::_SceneCursor()
{
    static CSceneItem* pItem = NULL;
    static CCharacter* pAttackCha = NULL;
	static int nMouseX, nMouseY;
	static CCharacter* pMain = NULL;
	static CCharacter* pCha = NULL;
	static CSkillRecord* pSkill = NULL;

	static D3DXVECTOR3 t_pos;
	static int t_angle;
	static int h;
	nMouseX = g_pGameApp->GetMouseX();
	nMouseY = g_pGameApp->GetMouseY();

	if( g_pGameApp->IsMouseButtonPress(1) ) // g_pGameApp->GetMainCam()->IsRotating()
	{
		g_pGameApp->GetCursor()->SetCursor( csNormalCursor );
		CGameScene::Set3DMouseState( enumClick );

		CCursor::I()->SetFrame( CCursor::stCamera );
		return;
	}

	pMain=GetMainCha();
	if( !pMain || GetUseLevel().IsFalse(LEVEL_CHA_RUN) || CGameApp::IsMouseContinue(0) ) 
	{
		CCursor::I()->Restore();
		return;
	}

	// 根据技能类型显示hint
	// 1.范围技能,所有怪物显示为红色
	// 2.单体技能,检测攻击对象是否正确
	// 3.没有技能时可与npc对话,捡物品等               
    pCha = _pChaArray;
    if( g_pGameApp->IsShiftPress() )
    {
		// 按住shift显示所有怪物名字
        for(int i = 0; i < _nChaCnt; i++)
        {
            if( pCha->IsValid() ) 
            {
                if( pCha->IsEnabled() )
                {
                    pCha->GetHeadSay()->SetIsShowName( true );
                    pCha->GetHeadSay()->SetIsShowLife( !pCha->IsNPC() );
                }
                else
                {
                    pCha->GetHeadSay()->SetIsShowName( false );
                    pCha->GetHeadSay()->SetIsShowLife( false );
                }
            }
            pCha++;
        }
    }
	else if( g_pGameApp->IsAltPress() )
	{
		// 显示所有队长的名字
        for(int i = 0; i < _nChaCnt; i++)
        {
            if( pCha->IsValid() ) 
            {
                if( pCha->IsEnabled() )
                {
					pCha->GetHeadSay()->SetIsShowName( pCha->IsTeamLeader() );
                    pCha->GetHeadSay()->SetIsShowLife( pCha->IsTeamLeader() );
                }
                else
                {
                    pCha->GetHeadSay()->SetIsShowName( false );
                    pCha->GetHeadSay()->SetIsShowLife( false );
                }
            }
            pCha++;
        }
	}
	else if( pMain->GetTeamLeaderID() > 0 )
    {
		int nTeamID = pMain->GetTeamLeaderID();
        for(int i = 0; i < _nChaCnt; i++)
        {
            if( pCha->IsValid() )
            {
				if( pCha->GetTeamLeaderID()==nTeamID )
				{
					pCha->GetHeadSay()->SetIsShowName( true );
					pCha->GetHeadSay()->SetIsShowLife( true );
				}
				else
				{
					pCha->GetHeadSay()->SetIsShowName( pCha->IsNPC() );
					pCha->GetHeadSay()->SetIsShowLife( false );
				}
            }
            pCha++;
        }
    }
	else if( _IsShowSideLife && pMain->getSideID()!=0 )
	{
		int nSideID = pMain->getSideID();
        for(int i = 0; i < _nChaCnt; i++)
        {
            if( pCha->IsValid() )
            {
				pCha->GetHeadSay()->SetIsShowName( pCha->IsNPC() );
				if( pCha->getSideID()==nSideID )
				{
					pCha->GetHeadSay()->SetIsShowLife( true );
				}
				else
				{
					pCha->GetHeadSay()->SetIsShowLife( false );
				}
            }
            pCha++;
        }
	}
	else	
	{
        for(int i = 0; i < _nChaCnt; i++)
        {
            if( pCha->IsValid() ) 
            {
                pCha->GetHeadSay()->SetIsShowName( pCha->IsNPC() );
                pCha->GetHeadSay()->SetIsShowLife( false );
            }
            pCha++;
        }
	}
	pMain->GetHeadSay()->SetIsShowLife( true );
	pMain->GetHeadSay()->SetIsShowName( true );

	pSkill = pMain->GetReadySkillInfo();

	if( pSkill && pSkill->IsAttackArea() )
	{
		// 改变鼠标为攻击地面
		CGameScene::Set3DMouseState( enumFollow );
		g_pGameApp->GetCursor()->SetCursor( csCircleCursor );
		CCursor::I()->SetFrame( CCursor::stSkillAttack );

        if( pSkill->GetShape()>=enumRANGE_TYPE_SQUARE )
        {
    		g_pGameApp->GetCursor()->GetCursor()->SetRadius( pSkill->GetRange() * 2 );

			// 范围技能,所有怪物显示为红色
			int dis = pSkill->GetRange();
            /*CCharacter**/ pCha = _pChaArray;
            for(int i = 0; i < _nChaCnt; i++)
            {
				if( pCha->IsValid() && !pCha->IsNPC() && pCha->IsEnabled() ) 
                {
                    if( GetDistance( nMouseX, nMouseY, pCha->GetCurX(), pCha->GetCurY() )<=dis )
					{
						pCha->GetHeadSay()->SetIsShowName( true );
						pCha->GetHeadSay()->SetIsShowLife( true );
                        pCha->SetColor( _bAttackRed, _bAttackGreen, _bAttackBlue );
					}
                }
                pCha++;
            }
        }
        else
        {
    		g_pGameApp->GetCursor()->GetCursor()->SetRadius( 0 );
        }

		_cMouseDown.SetAreaSkill( pSkill );
	}
	else
	{
		// 改变鼠标为攻击单人
		g_pGameApp->GetCursor()->SetCursor( csNormalCursor );
		CGameScene::Set3DMouseState( enumClick );

		static bool IsDefault = false;
		IsDefault = false;

		// 单体技能,检测攻击对象是否正确
		if( pSkill )
		{
			CCursor::I()->SetFrame( CCursor::stSkillAttack );

			if( g_pGameApp->IsCtrlPress() )
			{
				pAttackCha = HitSelectCharacter( nMouseX, nMouseY, enumSC_ALL );
				if( pAttackCha )
				{
					pAttackCha->GetHeadSay()->SetIsShowName( true );

					if( pMain!=pAttackCha )
					{
						pAttackCha->GetHeadSay()->SetIsShowLife( !pAttackCha->IsNPC() );
						pAttackCha->SetColor( _bAttackRed, _bAttackGreen, _bAttackBlue );

						_cMouseDown.SetAttackCha( pSkill, pAttackCha, CGameApp::GetCurTick() );
					}
				}
			}
			else
			{
				pAttackCha = HitSelectCharacter( nMouseX, nMouseY, pSkill->GetSelectCha() );
				if( pAttackCha )
				{
					pAttackCha->GetHeadSay()->SetIsShowName( true );
					if(	g_SkillUse.IsAttack( pSkill, pMain, pAttackCha ) )
					{
						pAttackCha->GetHeadSay()->SetIsShowLife( !pAttackCha->IsNPC() );
						pAttackCha->SetColor( _bAttackRed, _bAttackGreen, _bAttackBlue );

						_cMouseDown.SetAttackCha( pSkill, pAttackCha, CGameApp::GetCurTick() );
					}
				}
			}
		}
		else
		{
			_cMouseDown.SetMove();
			g_Render.GetPickRayVector( nMouseX, nMouseY, &org, &ray );
			if( (pItem=HitSceneItemText( nMouseX, nMouseY )) )
			{
				if( pItem->getEvent() )
				{
					if( _HaveEventCursor( pItem->getEvent(), pMain->GetMainType() ) )
					{
						_cMouseDown.SetEvent( pItem, pItem->getEvent() );
					}
					else
					{
						CCursor::I()->SetFrame( CCursor::stStop );
					}
				}
				else if( pItem->IsPick() )
				{
					CCursor::I()->SetFrame( CCursor::stPick );
					_cMouseDown.SetPickItem( pItem, CGameApp::GetCurTick() );
				}
				else
				{
					IsDefault = true;
				}
			}
			else if( pAttackCha = HitSelectCharacter( nMouseX, nMouseY, enumSC_ALL ) )
			{
				pAttackCha->GetHeadSay()->SetIsShowName( true );
				if( g_pGameApp->IsCtrlPress() && pMain!=pAttackCha )
				{
					CCursor::I()->SetFrame( CCursor::stAttack ); 

					pAttackCha->GetHeadSay()->SetIsShowLife( !pAttackCha->IsNPC() );
					pAttackCha->SetColor( _bAttackRed, _bAttackGreen, _bAttackBlue );

					_cMouseDown.SetAttackCha( pMain->GetDefaultSkillInfo(), pAttackCha, CGameApp::GetCurTick() );
				}
				else if( pAttackCha->getEvent() )
				{
					pAttackCha->GetHeadSay()->SetIsShowName( false );
					if( _HaveEventCursor(pAttackCha->getEvent(), pMain->GetMainType()) )
					{
						_cMouseDown.SetEvent( pAttackCha, pAttackCha->getEvent() );
					}
					else
					{
						CCursor::I()->SetFrame( CCursor::stStop );
					}
				}
				else if( pAttackCha->IsNPC() )
				{
					CCursor::I()->SetFrame( CCursor::stChat );
					_cMouseDown.SetNpc( pAttackCha );
				}
				else if( (pSkill=pMain->GetDefaultSkillInfo()) && g_SkillUse.IsAttack( pSkill, pMain, pAttackCha ) ) 
				{
					CCursor::I()->SetFrame( CCursor::stAttack ); 

					pAttackCha->GetHeadSay()->SetIsShowLife( !pAttackCha->IsNPC() );
					pAttackCha->SetColor( _bAttackRed, _bAttackGreen, _bAttackBlue );

					_cMouseDown.SetAttackCha( pSkill, pAttackCha, CGameApp::GetCurTick() );
				}
				else if( pAttackCha!=pMain && pAttackCha->IsPlayer() )
				{
					CCursor::I()->SetFrame( CCursor::stMouse );
					pAttackCha->SetColor( _bAttackRed, _bAttackGreen, _bAttackBlue );

					if( g_pGameApp->IsAltPress() )
					{
						_cMouseDown.SetFollow( pAttackCha );
					}
				}
				else
				{
					IsDefault = true;
				}
			}
			else if( HitTestSceneObjChair( &t_pos, &t_angle, &h, &org, &ray ) )
			{
				h = (int)(t_pos.z * 100.0f);
				_cMouseDown.SetDummyObj( (int)(t_pos.x * 100.0f), (int)(t_pos.y * 100.0f), h, t_angle+90, POSE_SEAT2 );

				CCursor::I()->SetFrame( CCursor::stActive );  
			}
			else if( HitTestSceneObjWall( &t_pos, &t_angle, &org, &ray ) )
			{
				_cMouseDown.SetDummyObj( (int)(t_pos.x * 100.0f), (int)(t_pos.y * 100.0f), (int)(t_pos.z * 100.0f), t_angle+90, POSE_LEAN );
				CCursor::I()->SetFrame( CCursor::stActive ); 
			}
			else
			{
				IsDefault = true;
			}
			
			if( IsDefault )
			{
				static D3DXVECTOR3 vPos;
				static int nScrX, nScrY;

				GetPickPos( nMouseX, nMouseY, vPos);
				nScrX = (int)(vPos.x * 100.0f);
				nScrY = (int)(vPos.y * 100.0f);
				
				if( _pTerrain 
					&& 
						( 
						_pTerrain->IsGridBlock( nScrX/50, nScrY/50 ) 
						|| !g_IsMoveAble( pMain->getChaCtrlType(), pMain->GetDefaultChaInfo()->chTerritory, (EAreaMask)_pTerrain->GetTile(nScrX/100, nScrY/100)->sRegion )
						) 
					)
				{
					CCursor::I()->SetFrame( CCursor::stBlock );
				}
				else
				{
					CCursor::I()->Restore();
				}
			}
		}

		static CAttackState* attack = NULL;
		attack = dynamic_cast<CAttackState*>( pMain->GetActor()->GetCurState());
		if( attack )
		{
			pAttackCha = attack->GetTarget();
			if( pAttackCha )
			{
				pAttackCha->GetHeadSay()->SetIsShowName( true );
				pAttackCha->GetHeadSay()->SetIsShowLife( !pAttackCha->IsNPC() );
			}
		}
	}
}

#ifdef _KOSDEMO_
//extern MINDPOWER_API int g_nPosX;
//extern MINDPOWER_API int g_nPosY;
extern MINDPOWER_API int g_nPosZ;
extern MINDPOWER_API int g_nNoDrawLevel;
extern MINDPOWER_API bool g_bLineMode;
#endif
void CWorldScene::_KeyDownEvent( int key )
{
	if( GetUseLevel().IsFalse(LEVEL_CHA_RUN) ) return;

    // by jack, test ship	
    if( g_pGameApp->IsEnableSuperKey() && key == VK_F11)
    {
        // _pShipMgr->_factory->Show(1);
        // _pShipMgr->_factory->Test();
        return;
    }
    // end

#ifdef __EDITOR__
	if( g_Editor.IsEnable() )
	{
		if(key == VK_F11)
		{
			GetMainCha()->SetDrunkState(!GetMainCha()->GetDrunkState());
		}

		if( key==VK_F12 ) 
		{
			BYTE tex_flag_save;
			// save loading res mt flag
			drIByteSet* res_bs = g_Render.GetInterfaceMgr()->res_mgr->GetByteSet();
			tex_flag_save = res_bs->GetValue(OPT_RESMGR_LOADTEXTURE_MT);
			res_bs->SetValue(OPT_RESMGR_LOADTEXTURE_MT, 0);
	      

			if( !GetMainCha() )
				return;

			if( GetMainCha()->IsBoat() )
			{
				LG( "info", RES_STRING(CL_LANGUAGE_MATCH_791) );
				return;
			}
	#if 0
			FILE *fp;
			fopen_s( &fp, ".\\scripts\\TestCha.txt", "rt" );
			if( fp == NULL)
				goto __end;

			DWORD id;
			DWORD part_buf[ 5 ];

			fscanf_s( fp, "%d %d %d %d %d %d", &id, &part_buf[ 0 ], &part_buf[ 1 ], &part_buf[ 2 ], &part_buf[ 3 ],
				&part_buf[ 4 ], &part_buf[ 5 ] );

			fclose( fp );

			fopen_s( &fp, ".\\scripts\\TestCha.txt", "wt" );

			if( fp == NULL )
				goto __end;

			fprintf( fp, "%d\n%010d %010d %010d %010d %010d", id > 4 ? 0 : id+1,
				part_buf[ 0 ], part_buf[ 1 ], part_buf[ 2 ], part_buf[ 3 ], part_buf[ 4 ] );

			fclose( fp );

			this->GetMainCha()->LoadPart( id, part_buf[ id ] );


	__end:
			;
	#endif
	#if 1
			static DWORD cha_id = 0;
			static DWORD group_id = 1;
			static DWORD part_id = 0;

			CCharacter* c = this->GetMainCha();

			if( c->getTypeID() == cha_id )
			{
			}
			else
			{
				cha_id = c->getTypeID();
				group_id = 1;
				part_id = 0;
			}

			//CCharacterInfo* info = GetCharInfo( cha_id );
			CChaRecord* info = GetChaRecordInfo( cha_id );

			if( part_id < 5 )
			{
			}
			else
			{
				part_id = 0;
				group_id += 1;
			}
			if( group_id > (DWORD)info->sSuitNum - 1 )
			{
				group_id = 0;
			}


            // 编辑器用，套装编号超过 99 处理       modify by Philip.Wu   2007-09-11
            //
            // ＸＸＸＸ ＸＸＸＸ ＸＸ。ＬＧＯ
            // 骨架号   十个百千
            //
			DWORD part = 0;
            if(group_id <= 99)
            {
                part = info->sModel* 1000000 + group_id * 10000 + part_id;
            }
            else
            {
                int thousand = (group_id / 1000) % 10; // 千位
                int hundred  = (group_id /  100) % 10; // 百位

                group_id = group_id % 100;
                part = info->sModel* 1000000 + group_id * 10000 + part_id;
                part += hundred * 1000 + thousand * 100;
            }


			char file[ 260 ];
			_snprintf_s( file, _countof( file ), _TRUNCATE, ".\\model\\character\\%010d.lgo", part );

			FILE* fp = NULL;
			fopen_s( &fp, file, "rb" );
			if( fp   )
			{
				fclose( fp );
				c->LoadPart( part_id, part );

				//// 发送外观更新
				stTempChangeChaPart stPart;
				memset( &stPart, 0, sizeof(stPart) );
				if( part_id>=0 && part_id<5 )
				{
					stPart.dwPartID = part_id;
					stPart.dwItemID = part;
					CS_BeginAction( CGameScene::GetMainCha(), enumACTION_TEMP, &stPart );
				}
			}


			part_id += 1;
	#endif
	#if 0
			static DWORD iii = 0;

			if( iii++ % 2 == 0 )
			{
				CSceneItem* item_obj = AddSceneItem( "xxx.lgo" );
				//CSceneItem* item_obj = AddSceneItem( 2, 1 );
				item_obj->ShowBoundingObject( 1 );
				GetMainCha()->AttachItem( LINK_ID_RIGHTHAND, item_obj, -1 );
				item_obj->FrameMove(0);
				GetMainCha()->DetachItem( LINK_ID_RIGHTHAND );

			}
			else
			{
				CSceneItem* item_obj = GetMainCha()->DetachItem( LINK_ID_RIGHTHAND );
				if( item_obj )
				{
					item_obj->SetValid( 0 );
				}
			}
	#endif

			res_bs->SetValue(OPT_RESMGR_LOADTEXTURE_MT, tex_flag_save);


		}
	}
#endif//of __EDITOR__

	if( !GetMainCha() ) return;

	if( g_pGameApp->IsCtrlPress() )
	{
		if( (key=='h' || key=='H') )
		{
			_IsThrowItemHint = !_IsThrowItemHint;
			g_pGameApp->SysInfo( _IsThrowItemHint ? RES_STRING(CL_WORLDSCENE_CPP_00001) : RES_STRING(CL_WORLDSCENE_CPP_00002) );
		}

		if( (key=='s' || key=='S') )
			_IsShowSideLife = !_IsShowSideLife;

		if( key=='a' || key=='A' )
		{
			_cMouseDown.PickItem( GetMainCha() );
			if( g_pGameApp->IsShiftPress() )
			{
				_IsAutoPick = !_IsAutoPick;
				g_pGameApp->SysInfo( _IsAutoPick ? RES_STRING(CL_LANGUAGE_MATCH_792) : RES_STRING(CL_LANGUAGE_MATCH_793) );
			}
		}

		if( g_pGameApp->IsAltPress() && (key=='c' || key=='C') )	// 打印摄像机
			_IsShowCameraInfo = !_IsShowCameraInfo;			

		if( g_pGameApp->IsAltPress() && (key=='k' || key=='K') )
			_IsShowPing = !_IsShowPing;			

		if( g_pGameApp->IsAltPress() && (key=='m' || key=='M') )
		{
			g_Config.SetMoveClient( !g_Config.m_IsMoveClient );
		}

#ifdef _DEBUG	// 测试用
		if( g_pGameApp->IsAltPress() && (key=='f' || key=='F'))
		{
			static bool ken = true;
			g_Render.GetDevice()->SetRenderState(D3DRS_FILLMODE, ken ? D3DFILL_WIREFRAME : D3DFILL_SOLID);
			ken = !ken;
		}
#endif

		extern bool g_IsShowShop;
		if( (key=='b' || key=='B') )
		{
			g_IsShowShop = !g_IsShowShop;
			g_pGameApp->SysInfo( g_IsShowShop ? RES_STRING(CL_LANGUAGE_MATCH_794) : RES_STRING(CL_LANGUAGE_MATCH_795) );
			//CCozeForm::GetInstance()->OnPublishMsg("test", "PublishMsg");

			CCharacter *pCha = NULL;
			for(int i = 0; i < _nChaCnt; i++)
			{
				pCha = &_pChaArray[i];
				if(pCha->IsValid() && !pCha->GetIsForUI())
				{
					pCha->RefreshShopShop();
				}
			}
		}
	}
	
    if( key==VK_INSERT && !GetMainCha()->IsBoat() )
    {
        CInsertState *seat = dynamic_cast<CInsertState*>(GetMainCha()->GetActor()->GetCurState());
		if( seat )
        {
			seat->Cancel();
            return;
        }

        seat = new CInsertState(GetMainCha()->GetActor());
        seat->SetIsSend( true );
        seat->SetAngle( GetMainCha()->getYaw() );
        GetMainCha()->GetActor()->SwitchState(seat);
        return;
    }

#if defined(_KOSDEMO_) && defined(_DEBUG)
	switch(key)
	{
//	case VK_UP:		
//		g_nTemp ++;	
//		break;
//	case VK_DOWN:	
//		g_nTemp --;
//		break;
//	case VK_NUMPAD8:
//		g_nPosX ++;
//		break;
//	case VK_NUMPAD7:
//		g_nPosX --;
//		break;
//	case VK_NUMPAD5:
//		g_nPosY ++;
//		break;
//	case VK_NUMPAD4:
//		g_nPosY --;
//		break;
	case VK_NUMPAD2:
		g_nPosZ ++;
		break;
	case VK_NUMPAD1:
		g_nPosZ --;
		break;
	case VK_OEM_4:	//[
		g_nNoDrawLevel --;
		if( g_nNoDrawLevel < 0 )
			g_nNoDrawLevel = 0;
		break;
	case VK_OEM_6:	//]
		g_nNoDrawLevel ++;
		if( g_nNoDrawLevel > 7 )
			g_nNoDrawLevel = 7;
		break;
	case 'l':
	case 'L':
		g_bLineMode = !g_bLineMode;
		break;
	case VK_OEM_1:	//;
		{
			LETerrain *pTerr = GetTerrain();
			if( pTerr )
			{
				pTerr->EnableWireFrame(!pTerr->IsEnableWireFrame());
			}
		}
		break;
	}
#endif

    g_stUIEquip.ExecFastKey( key );
}

bool CWorldScene::_MouseButtonDown(int nButton)
{	
	if(g_pGameApp->GetMainCam()->m_bSelectMode)
	{
		// 创建二次密码窗体显示时，不允许点击人物  add by Philip.Wu  2006-07-20
		if(g_stUIDoublePwd.GetIsShowCreateForm() || g_stUIDoublePwd.GetIsShowAlterForm() || g_stUIDoublePwd.GetIsShowDoublePwdForm())
		{
			return false;
		}

		m_nCurChaIndex = 0;


		//处理表单上的按钮是否可用
		UpdateButton();

		return true;
	}
	if( _vMousePos.x <= 0 ) return false;

	if( GetUseLevel().IsFalse(LEVEL_CHA_RUN) ) return false;

	if( nButton==0 )
	{
		if( _e3DMouseState==enumClick ) g_pGameApp->GetCursor()->MoveTo( _vMousePos );

		// 将全部的界面置为不显示
		CUIInterface::MainChaMove();

		// 角色移动后关闭船只选择界面  add by Philip.Wu  2006-06-02
		_pShipMgr->CloseForm();

		return true;
	}
	else if(nButton==1)
	{
		/*
		LPDIRECT3DTEXTURE8		pCurSuf =NULL;
		HRESULT hr;
		if(FAILED(hr = g_Render.GetDevice()->CreateTexture( 128, 128, 1, D3DUSAGE_RENDERTARGET , 
		D3DFMT_X8R8G8B8, D3DPOOL_DEFAULT, &pCurSuf ) ))
		{
			int t = 3;
		}
		SAFE_RELEASE(pCurSuf);
		*/
    }
	return false;
}

void CWorldScene::SetMainCha(int nChaID)
{
    CCharacter *pCha = GetCha(nChaID);
    if(!pCha) return;

//	char* szLogName = pCha->getLogName();
//	LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_796), GetTickCount());
	
	_pMainCha = pCha;
    pCha->EnableAI(FALSE);

	pCha->ResetReadySkill();

	_cMouseDown.Reset();
    _UserLeve.AllTrue();

    // 重设镜头
    CCameraCtrl *pCam = g_pGameApp->GetMainCam();
    LETerrain *pTerr = GetTerrain();

    D3DXVECTOR3 vecCha = pCha->GetPos();
    vecCha.z = GetGridHeight(vecCha.x,vecCha.y);

	pCam->InitModel(pCha->IsBoat() ? 3 : 0,&vecCha);

	//pCam->SetFollowObj(vecCha);
    //g_pGameApp->GetCameraTrack()->Reset(vecCha.x,vecCha.y,vecCha.z);

	//pCam->InitPos( vecCha.x,vecCha.y, vecCha.z );
    pCam->SetBufVel( pCha->getMoveSpeed(), nChaID);


    pCam->FrameMove(0);
	//g_pGameApp->ResetGameCamera( pCha->IsBoat() ? 3 : 0 );

	pCam->SetViewTransform();
    //g_Render.LookAt(pCam->m_EyePos, pCam->m_RefPos);
    //g_Render.SetCurrentView(LERender::VIEW_WORLD);

	CGameScene::LoadingCall();
}

bool CWorldScene::_MouseButtonUp(int nButton)
{
	if(nButton==0)
	{
		if( !GetMainCha() ) return false;

#ifdef __EDITOR__
		if(!g_Editor.IsEnable())
#endif
		{
			//CCharacter *pCha = SelectCharacter();
			//if(pCha && pCha->IsNPC())
			//{
			//	CCharacter *pMain = this->GetMainCha();            
			//	if(g_pGameApp->IsShiftPress()) pMain = pCha;
			//	DWORD dwHairType[4] = {  2000101 , 2000201, 2000301, 2000001  };
			//	if(pMain)
			//	{
			//		if(pMain->DistanceFrom(pCha) < 400)
			//		{
			//			static int nHairNo = 0;
			//			pMain->LoadPart(1, dwHairType[nHairNo]);
			//			nHairNo++;
			//			if(nHairNo>=4) nHairNo = 0;
			//			return false;
			//		}
			//	}
			//}
		}
	}
    else if( nButton==1 )
    {
    }
	
	return false;
}

bool CWorldScene::_MouseMove(int nOffsetX, int nOffsetY)
{


	return false;
}

bool CWorldScene::_MouseButtonDB(int nButton)
{ 
	//g_pGameApp->ResetGameCamera(0);

	//CCameraCtrl *pCam = g_pGameApp->GetMainCam();
	//CCharacter *pCha = GetMainCha();
	//if(pCha)
	//{
	//	D3DXVECTOR3 vecCha = pCha->GetPos();

	//	g_pGameApp->Get ->Reset(vecCha.x,vecCha.y,vecCha.z);
	//	pCam->SetFollowObj(vecCha);
	//	pCam->FrameMove(0);
	//	g_Render.SetWorldViewFOV(Angle2Radian(pCam->m_ffov));
	//	g_Render.LookAt(pCam->m_EyePos, pCam->m_RefPos);
	//	g_Render.SetCurrentView(LERender::VIEW_WORLD);
	//}

	return false; 
}

CCharacter* CWorldScene::HitSelectCharacter( int nScrX, int nScrY, int nSelect )
{
    CCharacter *pObj;
    CCharacter *pObjXXX = 0;

    float dis = 0.0f;
    MPPickInfo info;
    MPVector3 org, ray;

    g_Render.GetPickRayVector( nScrX, nScrY, (D3DXVECTOR3*)&org, (D3DXVECTOR3*)&ray );
    LEVector3Normalize( &ray );
	int i=0;
	switch( nSelect )
	{
		case enumSC_TEAM:
			if( CCharacter* pMain = CGameScene::GetMainCha() )
			{
				if( pMain->GetTeamLeaderID()>0 )
				{
					int nMainTeamID = pMain->GetTeamLeaderID();
					for( ; i < _nChaCnt; i++ )
					{
						pObj = &_pChaArray[i];
						if( pObj->IsValid() 
							&& pObj->GetTeamLeaderID()==nMainTeamID
							&& pObj->getChaCtrlType()==enumCHACTRL_PLAYER 
							&& pObj->IsEnabled() 
							&& !pObj->IsHide() )
						{
							if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
							{
								if( !pObjXXX )
								{
									pObjXXX = pObj;
									dis = info.dis;
								}
								else if( dis > info.dis )
								{
									pObjXXX = pObj;
									dis = info.dis;
								}
							}
						}
					}
					return pObjXXX;
				}
				else
				{
					if( SUCCEEDED( pMain->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						return pMain;
					}
					return NULL;
				}
			}
		case enumSC_SELF:
			if( CCharacter* pMain = CGameScene::GetMainCha() )
			{
				if( SUCCEEDED( pMain->HitTestPrimitive( &info, &org, &ray ) ) )
				{
					return pMain;
				}
			}
			return NULL;
		case enumSC_PLAYER:
		{
			for( ; i < _nChaCnt; i++ )
			{
				pObj = &_pChaArray[i];
				if( pObj->IsValid() 
					&& pObj->getChaCtrlType()==enumCHACTRL_PLAYER 
					&& !pObj->IsHide() )
				{
					if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						if( !pObjXXX )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( dis > info.dis )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
					}
				}
			}
			break;
		}
		case enumSC_PLAYER_ASHES:
		{
			for( ; i < _nChaCnt; i++ )
			{
				pObj = &_pChaArray[i];
				if( pObj->IsValid() 
					&& pObj->getChaCtrlType()==enumCHACTRL_PLAYER 
					&& !pObj->IsEnabled() 
					&& !pObj->IsHide() )
				{
					if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						if( !pObjXXX )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( dis > info.dis )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
					}
				}
			}
			break;
		}
		case enumSC_ENEMY:	// 判断是否可PK,可PK则怪物+非同队玩家,否则仅为怪物
		{			
			CCharacter* pMain = CGameScene::GetMainCha();
			if( pMain && pMain->GetIsPK() )
			{
				int nMainTeamID = pMain->GetTeamLeaderID();
				if( nMainTeamID!=0 )
				{
					for( ; i < _nChaCnt; i++ )
					{
						pObj = &_pChaArray[i];
						if( pObj->IsValid() 
							&& (pObj->getChaCtrlType()==enumCHACTRL_MONS 
								|| ( pObj->getChaCtrlType()==enumCHACTRL_PLAYER && pObj->GetTeamLeaderID()!=nMainTeamID ) )
							&& pObj->IsEnabled() 
							&& !pObj->IsHide() )
						{
							if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
							{
								if( !pObjXXX )
								{
									pObjXXX = pObj;
									dis = info.dis;
								}
								else if( dis > info.dis )
								{
									pObjXXX = pObj;
									dis = info.dis;
								}
							}
						}
					}
				}
				else
				{
					for( ; i < _nChaCnt; i++ )
					{
						pObj = &_pChaArray[i];
						if( pObj->IsValid() 
							&& (pObj->getChaCtrlType()==enumCHACTRL_MONS 
								|| ( pObj->getChaCtrlType()==enumCHACTRL_PLAYER && pMain!=pObj) )
							&& pObj->IsEnabled() 
							&& !pObj->IsHide() )
						{
							if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
							{
								if( !pObjXXX )
								{
									pObjXXX = pObj;
									dis = info.dis;
								}
								else if( dis > info.dis )
								{
									pObjXXX = pObj;
									dis = info.dis;
								}
							}
						}
					}
				}
			}
			else
			{
				for( ; i < _nChaCnt; i++ )
				{
					pObj = &_pChaArray[i];
					if( pObj->IsValid() 
						&& pObj->getChaCtrlType()==enumCHACTRL_MONS 
						&& pObj->IsEnabled() 
						&& !pObj->IsHide() )
					{
						if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
						{
							if( !pObjXXX )
							{
								pObjXXX = pObj;
								dis = info.dis;
							}
							else if( dis > info.dis )
							{
								pObjXXX = pObj;
								dis = info.dis;
							}
						}
					}
				}
			}
			break;
		}
		case enumSC_MONS:
		{
			for( ; i < _nChaCnt; i++ )
			{
				pObj = &_pChaArray[i];
				if( pObj->IsValid() 
					&& pObj->getChaCtrlType()==enumCHACTRL_MONS 
					&& pObj->IsEnabled() 
					&& !pObj->IsHide() )
				{
					if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						if( !pObjXXX )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( dis > info.dis )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
					}
				}
			}
			break;
		}
		case enumSC_MONS_TREE:
		{
			for( ; i < _nChaCnt; i++ )
			{
				pObj = &_pChaArray[i];
				if( pObj->IsValid() 
					&& pObj->getChaCtrlType()==enumCHACTRL_MONS_TREE 
					&& pObj->IsEnabled() 
					&& !pObj->IsHide() )
				{
					if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						if( !pObjXXX )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( dis > info.dis )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
					}
				}
			}
			break;
		}
		case enumSC_MONS_REPAIRABLE:
		{
			for( ; i < _nChaCnt; i++ )
			{
				pObj = &_pChaArray[i];
				if( pObj->IsValid() 
					&& pObj->getChaCtrlType()==enumCHACTRL_MONS_REPAIRABLE 
					&& pObj->IsEnabled() 
					&& !pObj->IsHide() )
				{
					if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						if( !pObjXXX )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( dis > info.dis )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
					}
				}
			}
			break;
		}
		case enumSC_MONS_MINE:
		{
			for( ; i < _nChaCnt; i++ )
			{
				pObj = &_pChaArray[i];
				if( pObj->IsValid() 
					&& pObj->getChaCtrlType()==enumCHACTRL_MONS_MINE 
					&& pObj->IsEnabled() 
					&& !pObj->IsHide() )
				{
					if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						if( !pObjXXX )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( dis > info.dis )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
					}
				}
			}
			break;
		}
		case enumSC_MONS_FISH:
		{
			for( ; i < _nChaCnt; i++ )
			{
				pObj = &_pChaArray[i];
				if( pObj->IsValid() 
					&& pObj->getChaCtrlType()==enumCHACTRL_MONS_FISH 
					&& pObj->IsEnabled() 
					&& !pObj->IsHide() )
				{
					if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						if( !pObjXXX )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( dis > info.dis )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
					}
				}
			}
			break;
		}
		case enumSC_MONS_DBOAT:
		{
			for( ; i < _nChaCnt; i++ )
			{
				pObj = &_pChaArray[i];
				if( pObj->IsValid() 
					&& pObj->getChaCtrlType()==enumCHACTRL_MONS_DBOAT
					&& pObj->IsEnabled() 
					&& !pObj->IsHide() )
				{
					if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						if( !pObjXXX )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( dis > info.dis )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
					}
				}
			}
			break;
		}
		default:
		{
			for( ; i < _nChaCnt; i++ )
			{
				pObj = &_pChaArray[i];
				if( pObj->IsValid() && pObj->IsEnabled() && !pObj->IsHide() )
				{
					if( SUCCEEDED( pObj->HitTestPrimitive( &info, &org, &ray ) ) )
					{
						if( !pObjXXX )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( pObj->GetDangeType()>pObjXXX->GetDangeType() )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
						else if( pObj->GetDangeType()==pObjXXX->GetDangeType() && dis > info.dis )
						{
							pObjXXX = pObj;
							dis = info.dis;
						}
					}
				}
			}
			break;
		}

	}
    return pObjXXX;
}

int CWorldScene::PickItem()
{
	CCharacter* pMain = CGameScene::GetMainCha();
	if( !pMain ) return 0;

	// pMain->GetActor()->CancelState();

	int nCount = 0;
	stNetItemPick info;
	vector<stNetItemPick> vPickinfo;
	CSceneItem* pItem = _pSceneItemArray;
	int dis = defPICKUP_DISTANCE;
	if( !pMain->GetIsArrive() )
	{
		dis += 100;
	}
	for( int i=0; i<_nSceneItemCnt; i++ ) 
	{
		if( pItem->IsValid() && !pItem->IsHide() && pItem->getAttachedCharacterID()==-1 && pItem->IsPick() )
		{
			if( GetDistance( pMain->GetServerX(), pMain->GetServerY(), pItem->GetCurX(), pItem->GetCurY() )<=dis )
			{
				info.lWorldID	= pItem->getAttachID();
				info.lHandle    = pItem->lTag;
				//CS_BeginAction( pMain, enumACTION_ITEM_PICK, &info );
				vPickinfo.push_back( info );
				// _cMouseDown.ActPickItem( pMain, pItem, false );
				nCount++;
				if( nCount >= defMAX_KBITEM_NUM_PER_TYPE )
					break;
			}
		}
		pItem++;
	}
	if( nCount > 0 && nCount <= defMAX_KBITEM_NUM_PER_TYPE )
	{
		CS_BeginAction( pMain, enumACTION_TOTAL_ITEM_PICK, &vPickinfo );
	}
	return nCount;
}

void CWorldScene::SetScreen( int w, int h, bool IsFull )
{
	CCharacter *pCha = NULL;
	for(int i = 0; i < _nChaCnt; i++)
	{
		pCha = &_pChaArray[i];
		if(pCha->IsValid() && !pCha->GetIsForUI())
		{
			pCha->RefreshShadow();
		}
	}
}


// 在装载loading后,刷新
void CWorldScene::LoadingCall()
{
	CGameScene::LoadingCall();

	// 发送是否背包锁定查询消息
	//::CS_KitbagCheck();

	if(g_Config.m_bEditor)	// 编辑器模式 特殊处理
	{
		static bool firstTime = true;
		if( firstTime )
		{
			char szMap[32] = {0};
			char szAppName[] = {(char)0xB1, (char)0xE0, (char)0xBC, (char)0xAD, (char)0xC6, (char)0xF7, (char)0};	// 防止被认为是中文而提取成多语言
			GetPrivateProfileString(szAppName, "MapName", "", szMap, 32, "./scripts/kop.cfg");

			CMapInfo* pMap = GetMapInfo(szMap);
			if(pMap && SwitchMap(pMap->nID))
			{
				GetMainCha()->setPos(pMap->nInitX * 100, pMap->nInitX * 100);
			}
			firstTime = false;
		}
	}

	static bool bLoadRes3 = false;
	if( !bLoadRes3 )
	{
		bLoadRes3 = true;
		//g_pGameApp->LoadRes3();
		//g_pGameApp->LoadRes4();
	}

	int nLevel = 0;
	CCharacter* pCha = g_stUIBoat.GetHuman();
	if(pCha) 
	{
		SGameAttr* pAttr = pCha->getGameAttr();
		if(pAttr)
		{
			nLevel = (int)pAttr->get( ATTR_LV );
		}
	}

	if(nLevel <= 1)
	{
		// 一级强制打开新手帮助
		g_stUISystem.m_sysProp.m_gameOption.bHelpMode = true;
		::WritePrivateProfileString("gameOption", "helpMode", "1", "./user/system.ini");

		g_stUIStart.ShowLevelUpHelpButton(true);
		g_stUIStart.ShowInfoCenterButton(true);
	}

	if(! g_stUISystem.m_sysProp.m_gameOption.bHelpMode)
	{
		g_stUIStart.ShowLevelUpHelpButton(false);
		g_stUIStart.ShowInfoCenterButton(false);
	}
	else
	{
		g_stUIStart.ShowLevelUpHelpButton(nLevel == 1 ? true : false);
	}

	// 同步临时背包查询消息
	CS_SyncKitbagTemp();

	//CSceneItem* pItem = _pSceneItemArray;
	//if(pItem)
	//{
	//	DWORD dwWorldID = pItem->getAttachID();
	//	CS_SyncKitbagTemp();
	//}
	if(! g_Config.m_IsDoublePwd)
	{
		// 显示创建二次密码窗体
		g_stUIDoublePwd.ShowCreateForm();

		//CBoxMgr::ShowSelectBox(_evtCreateDoublePwdEvent, RES_STRING(CL_LANGUAGE_MATCH_800), true);//"当前帐号未创建二次密码\n\n是否现在创建?"
	}
}




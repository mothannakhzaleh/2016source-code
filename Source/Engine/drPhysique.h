//
#pragma once

#include "drHeader.h"
#include "drMath.h"
#include "drInterfaceExt.h"
#include "drClassDecl.h"
#include "drITypes.h"
#include "drPrimitive.h"
#include "drLinkCtrl.h"

DR_BEGIN


struct drPhysiqueBoneInfo
{
	drPhysique* p;
	std::string str;
	drIAnimCtrlObjBone* bc;
	drIAnimCtrlBone* cb;
	drIAnimDataBone* data;
	drAnimCtrlObjTypeInfo tp;
	drResFileAnimData res;
};

struct drPhysiquePriInfo
{
	drPhysique* p;
	DWORD part_id;
	std::string str;
};

class drGeomManager
{
public:
	drGeomManager();
	~drGeomManager();

	drGeomObjInfo* GetGeomObjInfo( const char file[] );
	bool LoadGeomobj( const char file[] );

	drIAnimDataBone* GetBoneData( const char file[] );
	bool LoadBoneData( const char file[] );

    //保存已经载入的Bone数据索引，避免重复载入
    //目的:解决创建人物时耗时过长的问题
	inline void AttachBoneData(const char* file, drIAnimDataBone* pBone) { m_AnimDataMap[file] = pBone; }

private:
	typedef std::map<std::string, drGeomObjInfo*> GEOMOBJ_MAP;
		GEOMOBJ_MAP m_GeomobjMap;

	typedef std::map<std::string, drIAnimDataBone*> ANIMDATA_MAP;
		ANIMDATA_MAP m_AnimDataMap;
};

extern drGeomManager g_GeomManager;

class drPhysique : public drIPhysique, public drLinkCtrl
{
private:
    DWORD _id;
    drIResourceMgr* _res_mgr;
    drISceneMgr* _scene_mgr;
    drIPrimitive* _obj_seq[ DR_MAX_SUBSKIN_NUM ];
    drIAnimCtrlAgent* _anim_agent;

    drStateCtrl _state_ctrl;
    char _file_name[ DR_MAX_NAME ];
    drMatrix44 _mat_base;
    float _opacity;
	int	  volatile _count;
	bool  _start;
	bool  _end;

DR_STD_DECLARATION();

public:
    drPhysique( drIResourceMgr* res_mgr );
    drPhysique();
    ~drPhysique();

    // link ctrl method
    virtual DR_RESULT GetLinkCtrlMatrix( drMatrix44* mat, DWORD link_id );

    drIResourceMgr* GetResourceMgr() { return _res_mgr; }
	
    DR_RESULT Destroy();
	DR_RESULT LoadBoneCatch( drPhysiqueBoneInfo& info );
    DR_RESULT LoadBone( const char* file );
    DR_RESULT LoadPrimitive(DWORD part_id, drIGeomObjInfo* geom_info);
	DR_RESULT LoadPriCatch( const drPhysiquePriInfo& info );
    DR_RESULT LoadPrimitive( DWORD part_id, const char* file );
    DR_RESULT DestroyPrimitive( DWORD part_id );
    DR_RESULT CheckPrimitive( DWORD part_id ) { return _obj_seq[ part_id ] ? DR_RET_OK : DR_RET_FAILED; }

    DR_RESULT Update();
    DR_RESULT Render();

    drMatrix44* GetMatrix() { return &_mat_base; }
    void SetMatrix( const drMatrix44* mat ) { _mat_base = *mat; }

    void SetOpacity(float opacity);

    DR_RESULT PlayPose( const drPlayPoseInfo* info );
    DR_RESULT PlayObjImpPose( const drPlayPoseInfo* info, DWORD obj_id, DWORD ctrl_type );

    drIPoseCtrl* GetObjImpPoseCtrl( DWORD skin_id, DWORD ctrl_type );

    DR_RESULT HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray );;
    DR_RESULT HitTestPhysique( drPickInfo* info, const drVector3* org, const drVector3* ray );

    void ShowHelperObject( int show );
    void ShowBoundingObjectPhysique( int show );

    DR_RESULT SetItemLink( const drItemLinkInfo* info );
    DR_RESULT ClearItemLink( drIItem* obj );

    void SetObjState( DWORD state, BYTE value ) { return _state_ctrl.SetState(state, value); }
    DWORD GetObjState( DWORD state ) const { return _state_ctrl.GetState(state); }

    drIPrimitive* GetPrimitive( DWORD id ) { return _obj_seq[ id ]; }
    drIAnimCtrlAgent* GetAnimCtrlAgent() { return _anim_agent; }

    DR_RESULT RegisterSceneMgr(drISceneMgr* scene_mgr) { _scene_mgr = scene_mgr; return DR_RET_OK; }
    DR_RESULT SetTextureLOD(DWORD level);
    float GetOpacity() { return _opacity; }

	virtual void Start() { _start = true; }
	virtual void End() { _end = true; }
	virtual bool isLoaded() { return true;/*_end && _count == 0;*/ }
	void incCount() { _count++; }
	void decCount() { _count--; }

	void setComponentColour( size_t index, D3DCOLOR colour, const std::string& filterTextureName )
	{
		mIndexColourFilterList[ index ] = ColourFilterPair( colour, filterTextureName );
	}

	void setTextureOperation( size_t index, D3DTEXTUREOP operation )
	{
		mIndexTextureOPList[ index ] = operation;
	}

	const char* getTextureOperationDescription( size_t operation )
	{
		return _res_mgr->getTextureOperationDescription( operation );
	}

	void setPixelShader( size_t index, const std::string& filename )
	{
		if( _obj_seq )
		{
			if( _obj_seq[ index ] )
			{
				_obj_seq[ index ]->setPixelShader( filename );
			}
		}
	}

private:
	typedef std::pair < D3DCOLOR, std::string > ColourFilterPair;
	typedef std::map < size_t, ColourFilterPair > IndexColourFilterPairList;
	IndexColourFilterPairList mIndexColourFilterList;

	typedef std::map < size_t, D3DTEXTUREOP > IndexTextureOPPairList;
	IndexTextureOPPairList mIndexTextureOPList;
};

DR_END
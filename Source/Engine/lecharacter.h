//
#pragma once
#include "drHeader.h"
#include "drMath.h"
#include "drInterface.h"
#include "drObjectMethod.h"
#include "LESceneItem.h"
#include "drFrontAPI.h"
#include <vector>
using namespace std;
DR_BEGIN

class drActionObjectImp;
class drActionSmith;

struct drSceneItemLinkInfo
{
    union
    {
        LESceneItem* obj;
        void* obj_void;
    };

    DWORD id;
    DWORD link_item_id;
    DWORD link_parent_id;
    DWORD data;
};

struct LEItemLinkInfo
{
    LESceneItem* obj;
    DWORD link_item_id;
    DWORD link_parent_id;
    DWORD data;
};
struct LEChaLoadInfo
{
    LEChaLoadInfo()
    {
        memset( this, 0, sizeof(LEChaLoadInfo) );

    }

	std::string pixelShader;
    char bone[64];
    char part[DR_MAX_SUBSKIN_NUM][64];
};

typedef LEChaLoadInfo mpChaLoadInfo;

class DR_FRONT_API LECharacter : public drMatrixCtrl
{
    struct LELinkInfo
    {
        LESceneItem* obj;
        DWORD data;
    };
private:
    drIPhysique* _physique;

//	LELinkInfo _link_item_seq[ DR_MAX_LINK_ITEM_NUM ];
//	DWORD _link_item_num;
//  这个变量游戏中大部分都没用到，改用vector能节省 (8*16)-16 = 112 的内存，仍然保证了效率 
    vector<LELinkInfo> _link_item_seq;

    drPoseKeyFrameProc _pose_proc;
    void* _proc_param;

public:
    LECharacter();
    LECharacter( drISysGraphics* sys_graphics );
    virtual ~LECharacter();

	void StartLoad();
	void EndLoad();
	bool IsLoaded();

	BOOL	  InitBone( const char* file );
    DR_RESULT LoadBone( const char* file );
    DR_RESULT Load( DWORD obj_id, DWORD group_id, DWORD* skin_id_seq, int load_bone = 1 );
    DR_RESULT Load( const LEChaLoadInfo* info );
    DR_RESULT LoadPart( DWORD part_id, DWORD file_id );
    DR_RESULT LoadPart( DWORD part_id, const char* file );
    DR_RESULT DestroyPart( DWORD part_id );

    DR_RESULT PlayPose( const drPlayPoseInfo* info );
    DR_RESULT PlayPose( DWORD pose_id, DWORD play_type, float start_frame = 0.0f, float velocity = 1.0f, DWORD blend_flag = 1, DWORD blend_src_num = 5);
    DR_RESULT SetPoseKeyFrameProc( drPoseKeyFrameProc proc, void* proc_param );
    DR_RESULT SetObjImpPoseKeyFrameProc( DWORD obj_id, DWORD ctrl_type, drPoseKeyFrameProc proc, void* proc_param);
    DR_RESULT PlayObjImpPose( DWORD obj_id, DWORD ctrl_type, const drPlayPoseInfo* info );
    DR_RESULT PlayObjImpPose( DWORD obj_id, DWORD ctrl_type, DWORD pose_id, DWORD play_type, float start_frame = 0.0f, float velocity = 1.0f );

    drPlayPoseInfo* GetPlayPoseInfo();
    drPlayPoseInfo* GetObjImpPlayPoseInfo( DWORD obj_id, DWORD ctrl_type );
    drIPoseCtrl* GetPoseCtrl();    
    drIPoseCtrl* GetObjImpPoseCtrl( DWORD skin_id, DWORD ctrl_type );

    DR_RESULT HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray );

    void FrameMove();
    void Render();

    void Destroy();


    DR_RESULT HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray );
    DR_RESULT HitTestPhysique( drPickInfo* info, const drVector3* org, const drVector3* ray );


    void ShowHelperObject( int show );
    void ShowBoundingObjectPhysique( int show );


    DR_RESULT SetSubObjItemLink( DWORD obj_id, const drSceneItemLinkInfo* info );

    DR_RESULT AttachItem( const LEItemLinkInfo* info );
    DR_RESULT SetItemLink( const drSceneItemLinkInfo* info );
    DR_RESULT ClearItemLink( DWORD type );
    DR_RESULT UnwieldItem( const LESceneItem* obj );
    DWORD GetLinkItemNum() const { return (DWORD)_link_item_seq.size(); }
    LESceneItem* GetLinkItem( DWORD id );

    DWORD CheckPosePlayingStatus();

    void SetObjState( DWORD state, BYTE value );
    DWORD GetObjState( DWORD state ) const;

    drIPhysique* GetPhysique() { return _physique; }

    DR_RESULT GetObjDummyRunTimeMatrix( drMatrix44* mat, DWORD obj_id, DWORD dummy_id );
    DR_RESULT GetObjDummyRunTimeMatrix( drMatrix44* mat, DWORD dummy_id );
    void SetMaterial(const D3DMATERIALX* mtl);
    void SetOpacity(float opacity);
    void SetTextureLOD(DWORD level);
    float GetOpacity();

	void setComponentColour( size_t index, D3DCOLOR colour, const std::string& filterTextureName = "" )
	{
		_physique->setComponentColour( index, colour, filterTextureName );
	}

	void setTextureOperation( size_t index, D3DTEXTUREOP operation )
	{
		_physique->setTextureOperation( index, operation );
	}

	const char* getTextureOperationDescription( size_t operation )
	{
		return _physique->getTextureOperationDescription( operation );
	}

	void setPixelShader( size_t index, const std::string& filename )
	{
		_physique->setPixelShader( index, filename );
	}
};

DR_END
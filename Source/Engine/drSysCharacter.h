//
#include "drHeader.h"
#include "drObjectPool.h"

DR_BEGIN

typedef drObjectPoolVoidPtr1024 drObjectPoolSkeleton;
typedef drObjectPoolVoidPtr1024 drObjectPoolSkin;


class drSysCharacter
{
private:
    drObjectPoolSkeleton* _pool_skeleton;
    drObjectPoolSkin* _pool_skinmesh;

public:
    drSysCharacter();
    ~drSysCharacter();

    DR_RESULT QuerySkeleton( DWORD* ret_id, const char* file );
};

DR_END

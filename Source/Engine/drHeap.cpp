//


#include "drHeap.h"

DR_BEGIN

// drHeap
DR_STD_ILELEMENTATION(drHeap);

DR_RESULT drHeap::Clone(drIHeap** out_heap)
{
    drHeap* o = DR_NEW(drHeap);

    o->_heap.Copy(&_heap);

    *out_heap = o;

    return DR_RET_OK;
}

DR_END

//
#include "drHeader.h"
#include "drPrimitive.h"
#include "drClassDecl.h"
#include "drITypes.h"
#include "drInterface.h"
#include "drFrontAPI.h"


DR_BEGIN
DR_FRONT_API DR_RESULT drLoadPrimitiveLineList(drINodePrimitive* obj, const char* name, DWORD vert_num, const drVector3* vert_buf, const DWORD* color_buf, const drSubsetInfo* subset_seq, DWORD subset_num);
DR_FRONT_API DR_RESULT drLoadPrimitiveLineList( drIPrimitive* obj, const char* name, DWORD vert_num, const drVector3* vert_buf, const DWORD* color_buf );
DR_FRONT_API DR_RESULT drLoadPrimitiveLineList( drIPrimitive* obj, const char* name, DWORD vert_num, const drVector3* vert_buf, const DWORD* color_buf, const drSubsetInfo* subset_seq, DWORD subset_num );
DR_FRONT_API DR_RESULT drLoadPrimitiveGrid( drIPrimitive* obj, const char* name, float width, float height, int row, int col, DWORD color );
DR_FRONT_API DR_RESULT drLoadPrimitiveAxis( drIPrimitive* obj, const char* name, float length );
DR_FRONT_API DR_RESULT drLoadPrimitiveLineSphere( drIPrimitive* obj, const char* name, DWORD color, float radius, int long_seg, int lat_seg );
DR_FRONT_API DR_RESULT drLoadPrimitiveLineCube(drIPrimitive* obj, const char* name, DWORD color, const drVector3* size);
DR_FRONT_API DR_RESULT drLoadPrimitivePlane(drIPrimitive* obj, const char* name, DWORD color, float width, float height, int seg_width, int seg_height, BOOL two_side, BOOL wire_frame);
DR_END 

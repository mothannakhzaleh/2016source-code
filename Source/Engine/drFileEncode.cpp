//
#include <memory.h>
#include "drFileEncode.h"

DR_BEGIN

DR_RESULT drTexEncode::_Encode0(drIBuffer* buf)
{
    const DWORD i = 44;
    BYTE tmp[i];

    BYTE* p;
    DWORD s;

    p = buf->GetData();
    s = buf->GetSize();

    if(s > i)
    {
        memcpy(tmp, p, i);
        memcpy(p, &p[s - i], i);
        memcpy(&p[s - i], tmp, i);
    }

    return DR_RET_OK;
}
DR_RESULT drTexEncode::_Decode0(drIBuffer* buf)
{
    return _Encode0(buf);
}
DR_RESULT drTexEncode::_Encode1(drIBuffer* buf)
{
    BYTE* p;
    DWORD s;

    drDwordByte4* sp;
    drDwordByte4 e;
    e.b[0] = 'm';
    e.b[1] = 'p';
    e.b[2] = '.';
    e.b[3] = 'x';


    p = buf->GetData();
    s = buf->GetSize();

    sp = (drDwordByte4*)&p[s - 4];

    if(sp->d == e.d)
        return DR_RET_OK;

    _Encode0(buf);

    buf->Realloc(s + 4);

    p = buf->GetData();
    s = buf->GetSize();

    memcpy(&p[s - 4], &e, sizeof(e));

    return DR_RET_OK;
}
DR_RESULT drTexEncode::_Decode1(drIBuffer* buf)
{
    BYTE* p;
    DWORD s;

    drDwordByte4* sp;
    drDwordByte4 e;
    e.b[0] = 'm';
    e.b[1] = 'p';
    e.b[2] = '.';
    e.b[3] = 'x';

    p = buf->GetData();
    s = buf->GetSize();

    sp = (drDwordByte4*)&p[s - 4];

    if(sp->d != e.d)
        return DR_RET_OK;

    buf->SetSizeArbitrary(s - 4);

    _Decode0(buf);


    return DR_RET_OK;
}
DR_RESULT drTexEncode::Encode(drIBuffer* buf)
{
    return _Encode1(buf);
}
DR_RESULT drTexEncode::Decode(drIBuffer* buf)
{
    return _Decode1(buf);
}


DR_END

//


#include "drAnimKeySetPRS.h"


DR_BEGIN

// drAnimKeySetPRS2
template< class T >
DR_RESULT drKeyDataSearch( DWORD* ret_min, DWORD* ret_max, DWORD key, T* data_seq, DWORD data_num )
{
    DWORD low = 0;
    DWORD high = data_num - 1;
    DWORD k, l;

    if(data_num == 0)
    {
        *ret_min = 0;
        *ret_max = 0;

        return DR_RET_OK;
    }

    while( high >= low )
    {
        k = ( low + high ) / 2;

        l = k + 1;

        if( l == data_num )
        {
            //if( key == data_seq[ k ].key )
            //{
            //    *ret_min = k;
            //    *ret_max = k;
            //    break;
            //}
            //else
            //{
            //    assert( 0 );
            //}
            *ret_min = k;
            *ret_max = k;
            break;
        }
        else
        {
            if( key >= data_seq[ k ].key && key < data_seq[ l ].key )
            {
                *ret_min = k;
                *ret_max = l;
                break;
            }
        }

        if( key < data_seq[ k ].key )
        {
            high = k - 1;
        }
        else
        {
            low = k + 1;
        }
    }

    return ( low <= high ) ? DR_RET_OK : DR_INVALID_INDEX;
}

DR_RESULT drGetKeySlerpCoefficent(float* out, DWORD slerp_type, float key, float k0, float k1)
{
    float t = 0.0f;

    t = (float)(key - k0) / (float)(k1 - k0);

    switch(slerp_type)
    {
    case AKST_LINEAR:
        break;
    case AKST_SIN1: // 0 - 90
        t = sinf(t * DR_HALF_PI);
        break;
    case AKST_SIN2: // 90 - 180
        t = sinf(DR_HALF_PI + t * DR_HALF_PI);
        break;
    case AKST_SIN3: // 180 - 270
        t = sinf(DR_PI + t * DR_HALF_PI);
        break;
    case AKST_SIN4: // 270 - 360
        t = sinf(DR_HALF_PI * 3 + t * DR_HALF_PI);
        break;
    case AKST_COS1: // 0 - 90
        t = cosf(t * DR_HALF_PI);
        break;
    case AKST_COS2: // 90 - 180
        t = cosf(DR_HALF_PI + t * DR_HALF_PI);
        break;
    case AKST_COS3: // 180 - 270
        t = cosf(DR_PI + t * DR_HALF_PI);
        break;
    case AKST_COS4: // 270 - 360
        t = cosf(DR_HALF_PI * 3 + t * DR_HALF_PI);
        break;
    case AKST_TAN1: // 0 - 45
        t = tanf(t * DR_HALF_PI * 0.5f);
        break;
    default:
        return DR_RET_FAILED;
    }

    *out = t;

    return DR_RET_OK;
}

//DWORD drKeyDataSearch< drKeyDataVector3 >;
//DWORD drKeyDataSearch< drKeyDataQuaternion >;

DR_STD_ILELEMENTATION(drAnimKeySetPRS2)

void drAnimKeySetPRS2::_ResetFrameNum()
{
    DWORD f = 0;

    if(_pos_num && _pos_seq[_pos_num-1].key > f)
    {
        f = _pos_seq[_pos_num-1].key;
    }
    if(_rot_num && _rot_seq[_rot_num-1].key > f)
    {
        f = _rot_seq[_rot_num-1].key;
    }
    if(_sca_num && _sca_seq[_sca_num-1].key > f)
    {
        f = _sca_seq[_sca_num-1].key;
    }

    _frame_num = f;
}

DR_RESULT drAnimKeySetPRS2::GetValue( drMatrix44* mat, float frame )
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD f = (DWORD)frame;
    if((float)f != frame)
    {
        f += 1;
    }

    drVector3 pos;
    drQuaternion quat;
    drVector3 scale;
    float t;

    drMatrix44 mat_pos;
    drMatrix44 mat_rot;
    drMatrix44 mat_sca;   

    if( f < 0 || f >= _frame_num )
        goto __ret;

    DWORD key_pos[ 2 ];
    DWORD key_rot[ 2 ];
    DWORD key_sca[ 2 ];

    if(_pos_num > 0)
    {
        if(DR_FAILED(drKeyDataSearch<drKeyVector3>(&key_pos[0], &key_pos[1], f, _pos_seq, _pos_num)))
        {
            assert( 0 );
            goto __ret;
        }
        if(key_pos[0] == key_pos[1])
        {
            pos = _pos_seq[key_pos[0]].data;
        }
        else
        {
            drKeyVector3* k0 = &_pos_seq[key_pos[0]];
            drKeyVector3* k1 = &_pos_seq[key_pos[1]];

            //t = (float)( f - k0->key ) / (float)( k1->key - k0->key );
            drGetKeySlerpCoefficent(&t, k0->slerp_type, frame, (float)k0->key, (float)k1->key);

            drVector3Slerp( &pos, &k0->data, &k1->data, t );
        }

        mat_pos = drMatrix44Translate(pos);
    }

    if(_rot_num > 0)
    {
        if(DR_FAILED(drKeyDataSearch<drKeyQuaternion>(&key_rot[0], &key_rot[1], f, _rot_seq, _rot_num)))
        {
            assert( 0 );
            goto __ret;
        }

        if( key_rot[0] == key_rot[1])
        {
            quat = _rot_seq[key_rot[0]].data;
        }
        else
        {
            drKeyQuaternion* k0 = &_rot_seq[key_rot[0]];
            drKeyQuaternion* k1 = &_rot_seq[key_rot[1]];

            //t = (float)( f - k0->key ) / (float)( k1->key - k0->key );
            drGetKeySlerpCoefficent(&t, k0->slerp_type, frame, (float)k0->key, (float)k1->key);

            drQuaternionSlerp(&quat, &k0->data, &k1->data, t);
        }

        drQuaternionToMatrix44(&mat_rot, &quat);
    }

    if(_sca_num > 0)
    {
        if(DR_FAILED(drKeyDataSearch<drKeyVector3>(&key_sca[0], &key_sca[1], f, _sca_seq, _sca_num)))
        {
            assert(0);
            goto __ret;
        }


        if(key_sca[0] == key_sca[1])
        {

            scale = _sca_seq[key_sca[0]].data;
        }
        else
        {
            drKeyVector3* k0 = &_sca_seq[key_sca[0]];
            drKeyVector3* k1 = &_sca_seq[key_sca[1]];

            //t = (float)(f - k0->key) / (float)(k1->key - k0->key);
            drGetKeySlerpCoefficent(&t, k0->slerp_type, frame, (float)k0->key, (float)k1->key);

            drVector3Slerp(&scale, &k0->data, &k1->data, t);
        }

        mat_sca = drMatrix44Scale(scale);
    }    

    drMatrix44Multiply(mat, mat, &drMatrix44Translate(pos));

    //drMatrix44Multiply( mat, &drMatrix44Scale( scale ), mat );


    //mat->_41 = pos.x;
    //mat->_42 = pos.y;
    //mat->_43 = pos.z;

    drMatrix44Identity(mat);

    if(_pos_num > 0)
    {
        drMatrix44Multiply(mat, &mat_pos, mat);
    }
    if(_rot_num > 0)
    {
        drMatrix44Multiply(mat, &mat_rot, mat);
    }
    if(_sca_num > 0)
    {
        drMatrix44Multiply(mat, &mat_sca, mat);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimKeySetPRS2::AddKeyPosition(DWORD id, const drKeyVector3* data, DWORD num)
{   
    drKeyVector3* buf = DR_NEW(drKeyVector3[_pos_num + num]);

    if(_pos_seq)
    {
        memcpy(buf, _pos_seq, sizeof(drKeyVector3) * id);
    }

    memcpy(&buf[id], data, sizeof(drKeyVector3) * num);

    if(_pos_num > id)
    {
        memcpy(&buf[id + num ], &_pos_seq[ id ], sizeof(drKeyVector3) * (_pos_num - id));
    }

    DR_IF_DELETE_A( _pos_seq );

    _pos_seq = buf;
    _pos_num += num;

    _ResetFrameNum();

    return DR_RET_OK;
}
DR_RESULT drAnimKeySetPRS2::AddKeyRotation(DWORD id, const drKeyQuaternion* data, DWORD num)
{
    drKeyQuaternion* buf = DR_NEW(drKeyQuaternion[_rot_num + num]);

    if(_rot_seq)
    {
        memcpy(buf, _rot_seq, sizeof(drKeyQuaternion) * id);
    }

    memcpy(&buf[id], data, sizeof(drKeyQuaternion) * num);

    if(_rot_num - id > 0)
    {
        memcpy(&buf[id + num ], &_rot_seq[ id ], sizeof(drKeyQuaternion) * (_rot_num - id));
    }

    DR_IF_DELETE_A( _rot_seq );

    _rot_seq = buf;
    _rot_num += num;

    _ResetFrameNum();

    return DR_RET_OK;
}

DR_RESULT drAnimKeySetPRS2::AddKeyScale(DWORD id, const drKeyVector3* data, DWORD num)
{
    drKeyVector3* buf = DR_NEW(drKeyVector3[_sca_num + num]);

    if(_sca_seq)
    {
        memcpy(buf, _sca_seq, sizeof(drKeyVector3) * id);
    }

    memcpy(&buf[id], data, sizeof(drKeyVector3) * num);

    if(_sca_num - id > 0)
    {
        memcpy(&buf[id + num ], &_sca_seq[ id ], sizeof(drKeyVector3) * (_sca_num - id));
    }

    DR_IF_DELETE_A(_sca_seq);

    _sca_seq = buf;
    _sca_num += num;

    _ResetFrameNum();

    return DR_RET_OK;
}
DR_RESULT drAnimKeySetPRS2::DelKeyPosition(DWORD id, DWORD num)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(num == 0xffffffff)
    {
        DR_SAFE_DELETE_A(_pos_seq);
        _pos_num = 0;
        goto __addr_ret_ok;
    }

    if((id + num) > _pos_num)
        goto __ret;

    drKeyVector3* buf = DR_NEW(drKeyVector3[_pos_num - num]);

    memcpy(&buf[0], &_pos_seq[0], sizeof(drKeyVector3) * id);
    memcpy(&buf[id], &_pos_seq[id + num], sizeof(drKeyVector3) * (_pos_num - id - num));

    _pos_seq = buf;
    _pos_num -= num;


__addr_ret_ok:
    _ResetFrameNum();
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimKeySetPRS2::DelKeyRotation(DWORD id, DWORD num)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(num == 0xffffffff)
    {
        DR_SAFE_DELETE_A(_rot_seq);
        _rot_num = 0;
        goto __addr_ret_ok;
    }

    if((id + num) > _rot_num)
        goto __ret;

    drKeyQuaternion* buf = DR_NEW(drKeyQuaternion[_rot_num - num]);

    memcpy(&buf[0], &_pos_seq[0], sizeof(drKeyQuaternion) * id);
    memcpy(&buf[id], &_pos_seq[id + num], sizeof(drKeyQuaternion) * (_rot_num - id - num));

    _rot_seq = buf;
    _rot_num -= num;

__addr_ret_ok:
    _ResetFrameNum();
    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drAnimKeySetPRS2::DelKeyScale(DWORD id, DWORD num)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(num == 0xffffffff)
    {
        DR_SAFE_DELETE_A(_sca_seq);
        _sca_num = 0;
        goto __addr_ret_ok;
    }

    if((id + num) > _sca_num)
        goto __ret;

    drKeyVector3* buf = DR_NEW(drKeyVector3[_sca_num - num]);

    memcpy(&buf[0], &_pos_seq[0], sizeof(drKeyVector3) * id);
    memcpy(&buf[id], &_pos_seq[id + num], sizeof(drKeyVector3) * (_sca_num - id - num));

    _sca_seq = buf;
    _sca_num -= num;

__addr_ret_ok:
    _ResetFrameNum();
    ret = DR_RET_OK;
__ret:
    return ret;

}


DR_RESULT drAnimKeySetPRS2::Destroy()
{
    DR_SAFE_DELETE_A(_pos_seq);
    DR_SAFE_DELETE_A(_rot_seq);
    DR_SAFE_DELETE_A(_sca_seq);

    _pos_num = 0;
    _rot_num = 0;
    _sca_num = 0;
    _frame_num = 0;

    return DR_RET_OK;
}


// drAnimKeySetFloat
DR_STD_ILELEMENTATION(drAnimKeySetFloat)

drAnimKeySetFloat::drAnimKeySetFloat()
: _data_seq(0), _data_num(0), _data_capacity(0)
{
}

drAnimKeySetFloat::~drAnimKeySetFloat()
{
    Clear();
}
DR_RESULT drAnimKeySetFloat::Allocate(DWORD key_capacity)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(Clear()))
        goto __ret;

    _data_num = 0;
    _data_capacity = key_capacity;
    _data_seq = DR_NEW(KEY_TYPE[_data_capacity]);
    memset(_data_seq, 0, sizeof(KEY_TYPE) * _data_capacity);

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimKeySetFloat::Clear()
{
    if(_data_capacity == 0)
        goto __ret;

    _data_num = 0;
    _data_capacity = 0;
    DR_SAFE_DELETE_A(_data_seq);

__ret:
    return DR_RET_OK;
}
DR_RESULT drAnimKeySetFloat::Clone(drIAnimKeySetFloat** obj)
{
    drAnimKeySetFloat* o = DR_NEW(drAnimKeySetFloat);
    o->_data_capacity = _data_capacity;
    o->_data_num = _data_num;

    if(_data_capacity)
    {
        o->_data_seq = DR_NEW(drKeyFloat[o->_data_capacity]);
        memset(o->_data_seq, 0, sizeof(KEY_TYPE) * o->_data_capacity);
        memcpy(o->_data_seq, _data_seq, sizeof(KEY_TYPE) * o->_data_num);
    }

    *obj = o;

    return DR_RET_OK;
}
DR_RESULT drAnimKeySetFloat::SetKeyData(DWORD key, float data, DWORD slerp_type, DWORD mask)
{
    DR_RESULT ret = DR_RET_FAILED;

	DWORD j = 0;
    for( j = 0; j < _data_num; j++)
    {
        if(_data_seq[j].key == key)
            break;
    }
    
    if(j == _data_num)
        goto __ret;

    if(mask & AKSM_DATA)
    {
        _data_seq[j].data = data;
    }
    if(mask & AKSM_SLERPTYPE)
    {
        if(!(slerp_type > __akst_begin && slerp_type < __akst_end))
            goto __ret;

        _data_seq[j].slerp_type = slerp_type;
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drAnimKeySetFloat::GetKeyData(DWORD key, float* data, DWORD* slerp_type)
{
    DR_RESULT ret = DR_RET_FAILED;

	DWORD j = 0;
    for( j = 0; j < _data_num; j++)
    {
        if(_data_seq[j].key == key)
            break;
    }
    
    if(j == _data_num)
        goto __ret;

    if(data)
    {
        *data = _data_seq[j].data;
    }
    if(slerp_type)
    {
        *slerp_type = _data_seq[j].slerp_type;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimKeySetFloat::InsertKey(DWORD key, float data, DWORD slerp_type)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_data_num == _data_capacity)
        goto __ret;

    if(!(slerp_type > __akst_begin && slerp_type < __akst_end))
        goto __ret;


	DWORD j = 0;
    for( j = 0; j < _data_num; j++)
    {
        if(_data_seq[j].key < key)
            continue;

        if(_data_seq[j].key == key)
            goto __ret;

        for(DWORD i = _data_num; i > j; i--)
        {
            _data_seq[i] = _data_seq[i - 1];
        }

    }
    
    _data_seq[j].key = key;
    _data_seq[j].data = data;
    _data_seq[j].slerp_type = slerp_type;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimKeySetFloat::RemoveKey(DWORD key)
{
    DR_RESULT ret = DR_RET_FAILED;

	DWORD i = 0;
    for( i = 0; i < _data_num; i++)
    {
        if(_data_seq[i].key == key)
            break;
    }

    if(i == _data_num)
        goto __ret;

    _data_num -= 1;

    for(; i < _data_num; i++)
    {
        _data_seq[i] = _data_seq[i + 1];
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimKeySetFloat::GetValue(float* data, float key)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_data_num == 0)
        goto __ret;

    DWORD i_key = (DWORD)key;
    if((float)i_key != key)
    {
        i_key += 1;
    }

    if(i_key > _data_seq[_data_num-1].key)
        goto __ret;

    DWORD prev_key, next_key;

    if(DR_FAILED(drKeyDataSearch(&prev_key, &next_key, i_key, _data_seq, _data_num)))
        goto __ret;

    drKeyFloat* k0 = &_data_seq[prev_key];
    drKeyFloat* k1 = &_data_seq[next_key];
    
    if(prev_key == next_key)
    {
        *data = k0->data;
    }
    else
    {
        float t;

        if(DR_FAILED(drGetKeySlerpCoefficent(&t, k0->slerp_type, key, (float)k0->key, (float)k1->key)))
            goto __ret;

        *data = drFloatSlerp(k0->data, k1->data, t);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimKeySetFloat::SetKeySequence(const drKeyFloat* seq, DWORD num)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(Clear()))
        goto __ret;

    _data_num = num;
    _data_capacity = num;
    _data_seq = DR_NEW(KEY_TYPE[_data_capacity]);
    memcpy(_data_seq, seq, sizeof(KEY_TYPE) * _data_num);

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_END

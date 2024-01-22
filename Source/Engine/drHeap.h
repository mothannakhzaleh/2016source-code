//
#pragma once

#include "drHeader.h"
#include "drInterfaceExt.h"
#include "drStdInc.h"
#include "drDirectX.h"
#include "drClassDecl.h"

DR_BEGIN

// this is a min-heap class
// if you want to get max-heap, pls wrap operator<() of T

template<typename T>
class drHeapT
{
public:
    typedef T value_type;
    typedef value_type* value_type_ptr;
    typedef value_type& value_type_ref;
    typedef BOOL (*drHeapTCompareProc)(const T& i, const T& j);
    typedef void (*drHeapTFilterProc)(const T& t, DWORD i);

    enum { DEFAULT_CHUNK_SIZE = 32 };

private:
    T* _buf;
    DWORD _buf_size;
    DWORD _num;

    drHeapTCompareProc _comp_proc;
    drHeapTFilterProc _filter_proc;

private:
    DWORD _Parent(DWORD i) { return (i - 1) / 2; }
    DWORD _Left(DWORD i) { return (2 * i + 1); }
    DWORD _Right(DWORD i) { return (2 * i + 2); }
    void _Place(DWORD i, const T& t) 
    { 
        _buf[i] = t; 
        if(_filter_proc) { (*_filter_proc)(t, i); }
    }
    void _Swap(DWORD i, DWORD j) { T t = _buf[i]; _buf[i] = _buf[j]; _buf[j] = t; }
    T _Value(DWORD i) { return _buf[i]; }
    T* _Ptr(DWORD i) { return &_buf[i]; }
    T& _Ref(DWORD i) { return _buf[i]; }
    BOOL _Comp(const T& i, const T& j)
    {
        return _comp_proc ? (*_comp_proc)(i, j) : (i) <= (j);
    }


    BOOL _CheckBufferState() { return (_num < _buf_size); }
    DR_RESULT _Allocate(DWORD buf_size);
    DR_RESULT _Free();
    DWORD _FilterDown(DWORD i);
    DWORD _FilterUp(DWORD i);
public:
    drHeapT()
        : _buf(0), _buf_size(0), _num(0), _comp_proc(0), _filter_proc(0)
    {}
    ~drHeapT()
    {
        Clear();
    }

    DR_RESULT Reserve(DWORD size);
    DR_RESULT Clear();
    DR_RESULT Push(const T& t);
    DR_RESULT Push(const T* buf, DWORD size);
    DR_RESULT Pop();
    DR_RESULT Top(T* t);
    DR_RESULT Find(DWORD* id, const T& t);
    DR_RESULT Update(DWORD id);
    DR_RESULT Remove(DWORD id);
    DR_RESULT Copy(drHeapT* src);

    void SetCompareProc(drHeapTCompareProc proc) { _comp_proc = proc; }
    void SetFilterProc(drHeapTFilterProc proc) { _filter_proc = proc; }
    drHeapTCompareProc GetCompareProc() { return _comp_proc; }
    drHeapTFilterProc GetFilterProc() { return _filter_proc; }
    DWORD GetHeapNum() { return _num; }
    DWORD GetHeapCapacity() { return _buf_size; }
    T* GetBuffer() { return _buf; }


};


template<typename T>
DR_RESULT drHeapT<T>::_Allocate(DWORD buf_size)
{
    if(buf_size < _buf_size)
        return DR_RET_FAILED;

    int size = (buf_size == 0xffffffff) ? DEFAULT_CHUNK_SIZE : (int)buf_size;

#if(defined USE_NEW_PLACEMENT)
    int new_size;
    // i cannot understand the error by ::new(&_buf[_buf_size+i]) T; ???
    if(_buf_size == 0)
    {
        _buf = (T*)DR_MALLOC(sizeof(T) * size);
    }
    else
    {
        while(size <= (int)_buf_size)
        {
            size *= 2;
        }
        _buf = (T*)DR_REALLOC(_buf, sizeof(T) * size);
    }

    new_size = size - _buf_size;

    for(int i = 0; i < new_size; i++)
    {
        ::new(&_buf[_buf_size+i]) T;
    }

    _buf_size = size;
#else
    if(_buf_size == 0)
    {
        _buf = DR_NEW(T[size]);
    }
    else
    {
        T* new_buf;

        while(size <= (int)_buf_size)
        {
            size *= 2;
        }
        new_buf = DR_NEW(T[size]);

        for(DWORD i = 0; i < _buf_size; i++)
        {
            new_buf[i] = _buf[i];
        }

        DR_DELETE_A(_buf);
        _buf = new_buf;
    }

    _buf_size = size;
#endif

    return DR_RET_OK;
}
template<typename T>
DR_RESULT drHeapT<T>::_Free()
{

    if(_buf_size > 0)
    {
#if(defined USE_NEW_PLACEMENT)
        for(DWORD i = 0; i < _buf_size; i++)
        {
            _buf[i].~T();
        }
        DR_FREE(_buf);
#else
        DR_DELETE_A(_buf);
#endif
        _buf = 0;
        _buf_size = 0;
        _num = 0;
    }

    return DR_RET_OK;
}
template<typename T>
DWORD drHeapT<T>::_FilterDown(DWORD i)
{
    T t = _Value(i);
    DWORD index = i;
    DWORD l = _Left(i);
    DWORD r = _Right(i);
    DWORD c;

    while(l < GetHeapNum())
    {
        if(r < GetHeapNum() && _Comp(_Ref(r), _Ref(l)))
            c = r;
        else
            c = l;

        if(_Comp(t, _Ref(c)))
            break;

        _Place(index, _buf[c]);
        //_buf[index] = _buf[c];

        index = c;
        l = _Left(index);
        r = _Right(index);
    }

    if(index != i)
    {
        _Place(index, t);
        //_buf[index] = t;
    }

    return index;
}

template<typename T>
DWORD drHeapT<T>::_FilterUp(DWORD i)
{
    T t = _Value(i);
    DWORD index = i;
    DWORD p = _Parent(i);

    while((index > 0) && _Comp(t, _Ref(p)))
    {
        _Place(index, _buf[p]);
        //_buf[index] = _buf[p];

        index = p;
        p = _Parent(p);
    }

    if(index != i)
    {
        _Place(index, t);
        //_buf[index] = t;
    }

    return index;
}


template<typename T>
DR_RESULT drHeapT<T>::Reserve(DWORD size)
{
    return _Allocate(size);
}

template<typename T>
DR_RESULT drHeapT<T>::Clear()
{
    return _Free();
}

template<typename T>
DR_RESULT drHeapT<T>::Push(const T& t)
{
    if(_num >= _buf_size)
    {
        if(DR_FAILED(_Allocate(0xffffffff)))
            return DR_RET_FAILED;
    }

    _Place(_num, t);
    _FilterUp(_num);
    _num += 1;
    
    return DR_RET_OK;
}
template<typename T>
DR_RESULT drHeapT<T>::Push(const T* buf, DWORD size)
{
    for(DWORD i = 0; i < size; i++)
    {
        Push(buf[i]);
    }

    return DR_RET_OK;
}

template<typename T>
DR_RESULT drHeapT<T>::Pop()
{
    if(_num == 0)
        return DR_RET_FAILED;

    _num -= 1;

    if(_num > 0)
    {
        _Place(0, _Value(_num));
        _FilterDown(0);
    }

    return DR_RET_OK;
}
template<typename T>
DR_RESULT drHeapT<T>::Top(T* t)
{
    if(_num == 0)
        return DR_RET_FAILED;

    *t = _Value(0);

    return DR_RET_OK;
}
template<typename T>
DR_RESULT drHeapT<T>::Find(DWORD* id, const T& t)
{
    if(_num == 0)
        return DR_RET_FAILED;

    for(DWORD i = 0; i < GetHeapNum(); i++)
    {
        if(_buf[i] == t)
        {
            *id = i;
            return DR_RET_OK;
        }
    }

    return DR_RET_FAILED;
}
template<typename T>
DR_RESULT drHeapT<T>::Update(DWORD id)
{
    if(id >= _num)
        return DR_RET_FAILED;
  
    if((id > 0) && _Comp(_Ref(id), _Ref(_Parent(id))))
    {
        _FilterUp(id);
    }
    else
    {
        _FilterDown(id);
    }

    return DR_RET_OK;
}
template<typename T>
DR_RESULT drHeapT<T>::Remove(DWORD id)
{
    if(id >= _num)
        return DR_RET_FAILED;

    _num -= 1;

    if(id < _num)
    {
        _Place(id, _buf[_num]);

        return Update(id);
    }
    
    return DR_RET_OK;
}
template<typename T>
DR_RESULT drHeapT<T>::Copy(drHeapT* src)
{
    Clear();

    _num = src->_num;
    _buf_size = src->_buf_size;
    _comp_proc = src->_comp_proc;
    _filter_proc = src->_filter_proc;
    _buf = DR_NEW(T[_buf_size]);
    memcpy(_buf, src->_buf, sizeof(T) * _num);

    return DR_RET_OK;
}

//
class drHeap : public drIHeap
{
    DR_STD_DECLARATION();

    typedef drHeapT<void*> T;

private:
    T _heap;

public:
    DR_RESULT Reserve(DWORD size) 
    { return _heap.Reserve(size); }
    DR_RESULT Clear() 
    { return _heap.Clear(); }
    DR_RESULT Push(const void* t) 
    { return _heap.Push((T::value_type_ref)t); }
    DR_RESULT Push(const void* buf, DWORD size) 
    { return _heap.Push((T::value_type_ptr)buf, size); }
    DR_RESULT Pop() 
    { return _heap.Pop(); }
    DR_RESULT Top(void** t) 
    { return _heap.Top(t); }
    DR_RESULT Find(DWORD* id, const void* t) 
    { return _heap.Find(id, (T::value_type_ref)t); }
    DR_RESULT Update(DWORD id) 
    { return _heap.Update(id); }
    DR_RESULT Remove(DWORD id)
    { return _heap.Remove(id); }

    void SetCompareProc(drHeapCompProc proc) 
    { _heap.SetCompareProc((T::drHeapTCompareProc)proc); }
    void SetFilterProc(drHeapFilterProc proc) 
    { _heap.SetFilterProc((T::drHeapTFilterProc)proc); }
    drHeapCompProc GetCompareProc() 
    { return (drHeapCompProc)_heap.GetCompareProc(); }
    drHeapFilterProc GetFilterProc() 
    { return (drHeapFilterProc)_heap.GetFilterProc(); }

    DWORD GetHeapNum() 
    { return _heap.GetHeapNum(); }
    DWORD GetHeapCapacity() 
    { return _heap.GetHeapCapacity(); }
    void* GetBuffer() 
    { return _heap.GetBuffer(); }

    DR_RESULT Clone(drIHeap** out_heap);
    
};

DR_END

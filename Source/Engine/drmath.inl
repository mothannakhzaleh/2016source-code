//
#pragma once

#include "drHeader.h"


DR_BEGIN

//#ifdef DR_USE_DRMATH_LIB

// _drVector2
DR_INLINE _drVector2::_drVector2() 
{}

DR_INLINE _drVector2::_drVector2(float xo, float yo) 
: x(xo), y(yo) 
{}

DR_INLINE _drVector2::_drVector2(const float* v) 
: x(v[0]), y(v[1])
{
}

DR_INLINE _drVector2::_drVector2(const _drVector2& v)
: x(v.x), y(v.y) 
{}

// casting
DR_INLINE _drVector2::operator float*()
{
    return (float *)&x;
}

DR_INLINE _drVector2::operator const float*() const
{
    return (const float *)&x;
}

// unary operators
DR_INLINE _drVector2 _drVector2::operator + () const
{
    return *this;
}

DR_INLINE _drVector2 _drVector2::operator - () const
{
    return _drVector2(-x, -y);
}

DR_INLINE _drVector2& _drVector2::operator+=(const _drVector2& v) 
{ 
    x += v.x; 
    y += v.y; 
    return *this; 
}
DR_INLINE _drVector2& _drVector2::operator-=(const _drVector2& v) 
{ 
    x -= v.x; 
    y -= v.y; 
    return *this; 
}

DR_INLINE _drVector2& _drVector2::operator*=(float f) 
{ 
    x *= f; 
    y *= f; 
    return *this; 
}

DR_INLINE _drVector2& _drVector2::operator/=(float f) 
{ 
    float inv = 1.0f / f;
    x *= inv;
    y *= inv;
    return *this;
}


DR_INLINE float _drVector2::operator[](int i) const 
{ 
    return ((float*)&x)[i]; 
}
DR_INLINE float& _drVector2::operator[](int i) 
{ 
    return ((float*)&x)[i]; 
}

// binary operators
DR_INLINE _drVector2 _drVector2::operator+(const _drVector2& v) const
{
    return _drVector2(x + v.x, y + v.y);
}

DR_INLINE _drVector2 _drVector2::operator-(const _drVector2& v) const
{
    return _drVector2(x - v.x, y - v.y);
}

DR_INLINE _drVector2 _drVector2::operator*(float v) const
{
    return _drVector2(x * v, y * v);
}

DR_INLINE _drVector2 _drVector2::operator/(float v) const
{
    float inv = 1.0f / v;
    return _drVector2(x * inv, y * inv);
}


DR_INLINE _drVector2 operator*(float f, const _drVector2& v)
{
    return _drVector2(f * v.x, f * v.y);
}

DR_INLINE BOOL _drVector2::operator==(const _drVector2& v) const
{
    return x == v.x && y == v.y;
}

DR_INLINE BOOL _drVector2::operator!=(const _drVector2& v) const
{
    return x != v.x || y != v.y;
}

// _drVector2i
DR_INLINE _drVector2i::_drVector2i() 
{}

DR_INLINE _drVector2i::_drVector2i(int xo, int yo) 
: x(xo), y(yo) 
{}

DR_INLINE _drVector2i::_drVector2i(const int* v) 
: x(v[0]), y(v[1])
{
}

DR_INLINE _drVector2i::_drVector2i(const _drVector2i& v)
: x(v.x), y(v.y) 
{}

// casting
DR_INLINE _drVector2i::operator int*()
{
    return (int *)&x;
}

DR_INLINE _drVector2i::operator const int*() const
{
    return (const int *)&x;
}

// unary operators
DR_INLINE _drVector2i _drVector2i::operator + () const
{
    return *this;
}

DR_INLINE _drVector2i _drVector2i::operator - () const
{
    return _drVector2i(-x, -y);
}

DR_INLINE _drVector2i& _drVector2i::operator+=(const _drVector2i& v) 
{ 
    x += v.x; 
    y += v.y; 
    return *this; 
}
DR_INLINE _drVector2i& _drVector2i::operator-=(const _drVector2i& v) 
{ 
    x -= v.x; 
    y -= v.y; 
    return *this; 
}

DR_INLINE _drVector2i& _drVector2i::operator*=(int f) 
{ 
    x *= f; 
    y *= f; 
    return *this; 
}

DR_INLINE _drVector2i& _drVector2i::operator/=(int f) 
{ 
    x /= f;
    y /= f;
    return *this;
}


DR_INLINE int _drVector2i::operator[](int i) const 
{ 
    return ((int*)&x)[i]; 
}
DR_INLINE int& _drVector2i::operator[](int i) 
{ 
    return ((int*)&x)[i]; 
}

// binary operators
DR_INLINE _drVector2i _drVector2i::operator+(const _drVector2i& v) const
{
    return _drVector2i(x + v.x, y + v.y);
}

DR_INLINE _drVector2i _drVector2i::operator-(const _drVector2i& v) const
{
    return _drVector2i(x - v.x, y - v.y);
}

DR_INLINE _drVector2i _drVector2i::operator*(int v) const
{
    return _drVector2i(x * v, y * v);
}

DR_INLINE _drVector2i _drVector2i::operator/(int v) const
{
    return _drVector2i(x / v, y / v);
}


DR_INLINE _drVector2i operator*(int f, const _drVector2i& v)
{
    return _drVector2i(f * v.x, f * v.y);
}

DR_INLINE BOOL _drVector2i::operator==(const _drVector2i& v) const
{
    return x == v.x && y == v.y;
}

DR_INLINE BOOL _drVector2i::operator!=(const _drVector2i& v) const
{
    return x != v.x || y != v.y;
}

// drVector3i
DR_INLINE _drVector3i::_drVector3i()
{}

DR_INLINE _drVector3i::_drVector3i(int fx, int fy, int fz)
: x(fx), y(fy), z(fz)
{
}
DR_INLINE _drVector3i::_drVector3i(const int *v)
: x(v[0]), y(v[1]), z(v[2])
{
}

DR_INLINE _drVector3i::_drVector3i(const _drVector3i& v)
: x(v.x), y(v.y), z(v.z)
{
}



// casting
DR_INLINE _drVector3i::operator int*()
{
    return (int *)&x;
}

DR_INLINE _drVector3i::operator const int*() const
{
    return (const int *)&x;
}


// assignment operators
DR_INLINE _drVector3i& _drVector3i::operator+=(const _drVector3i& v)
{
    x += v.x;
    y += v.y;
    z += v.z;
    return *this;
}

DR_INLINE _drVector3i& _drVector3i::operator-=(const _drVector3i& v)
{
    x -= v.x;
    y -= v.y;
    z -= v.z;
    return *this;
}

DR_INLINE _drVector3i& _drVector3i::operator*=(int v)
{
    x *= v;
    y *= v;
    z *= v;
    return *this;
}

DR_INLINE _drVector3i& _drVector3i::operator /= (int v)
{
    int inv = (int)(1.0f / v);
    x *= inv;
    y *= inv;
    z *= inv;
    return *this;
}


// unary operators
DR_INLINE _drVector3i _drVector3i::operator+() const
{
    return *this;
}

DR_INLINE _drVector3i _drVector3i::operator-() const
{
    return _drVector3i(-x, -y, -z);
}


// binary operators
DR_INLINE _drVector3i _drVector3i::operator+(const _drVector3i& v) const
{
    return _drVector3i(x + v.x, y + v.y, z + v.z);
}

DR_INLINE _drVector3i _drVector3i::operator-(const _drVector3i& v) const
{
    return _drVector3i(x - v.x, y - v.y, z - v.z);
}
DR_INLINE _drVector3i _drVector3i::operator*(const _drVector3i& v) const
{
    return _drVector3i(x * v.x, y * v.y, z * v.z);
}

DR_INLINE _drVector3i _drVector3i::operator/(const _drVector3i& v) const
{
    return _drVector3i(x / v.x, y / v.y, z / v.z);
}

DR_INLINE _drVector3i _drVector3i::operator*(int v) const
{
    return _drVector3i(x * v, y * v, z * v);
}

DR_INLINE _drVector3i _drVector3i::operator/(int v) const
{
    int inv = (int)(1.0f / v);
    return _drVector3i(x * inv, y * inv, z * inv);
}


DR_INLINE _drVector3i operator*(int f, const _drVector3i& v)
{
    return _drVector3i(f * v.x, f * v.y, f * v.z);
}


DR_INLINE BOOL _drVector3i::operator==(const _drVector3i& v) const
{
    return x == v.x && y == v.y && z == v.z;
}

DR_INLINE BOOL _drVector3i::operator!=(const _drVector3i& v) const
{
    return x != v.x || y != v.y || z != v.z;
}
DR_INLINE int _drVector3i::operator[](int i) const 
{ 
    return ((int*)&x)[i]; 
}
DR_INLINE int& _drVector3i::operator[](int i) 
{ 
    return ((int*)&x)[i]; 
}


// drVector3
DR_INLINE _drVector3::_drVector3()
{}

DR_INLINE _drVector3::_drVector3(float fx, float fy, float fz)
: x(fx), y(fy), z(fz)
{
}
DR_INLINE _drVector3::_drVector3(const float *v)
: x(v[0]), y(v[1]), z(v[2])
{
}

DR_INLINE _drVector3::_drVector3(const _drVector3& v)
: x(v.x), y(v.y), z(v.z)
{
}



// casting
DR_INLINE _drVector3::operator float*()
{
    return (float *)&x;
}

DR_INLINE _drVector3::operator const float*() const
{
    return (const float *)&x;
}


// assignment operators
DR_INLINE _drVector3& _drVector3::operator+=(const _drVector3& v)
{
    x += v.x;
    y += v.y;
    z += v.z;
    return *this;
}

DR_INLINE _drVector3& _drVector3::operator-=(const _drVector3& v)
{
    x -= v.x;
    y -= v.y;
    z -= v.z;
    return *this;
}

DR_INLINE _drVector3& _drVector3::operator*=(float v)
{
    x *= v;
    y *= v;
    z *= v;
    return *this;
}

DR_INLINE _drVector3& _drVector3::operator /= (float v)
{
    float inv = 1.0f / v;
    x *= inv;
    y *= inv;
    z *= inv;
    return *this;
}


// unary operators
DR_INLINE _drVector3 _drVector3::operator+() const
{
    return *this;
}

DR_INLINE _drVector3 _drVector3::operator-() const
{
    return _drVector3(-x, -y, -z);
}


// binary operators
DR_INLINE _drVector3 _drVector3::operator+(const _drVector3& v) const
{
    return _drVector3(x + v.x, y + v.y, z + v.z);
}

DR_INLINE _drVector3 _drVector3::operator-(const _drVector3& v) const
{
    return _drVector3(x - v.x, y - v.y, z - v.z);
}
DR_INLINE _drVector3 _drVector3::operator*(const _drVector3& v) const
{
    return _drVector3(x * v.x, y * v.y, z * v.z);
}

DR_INLINE _drVector3 _drVector3::operator/(const _drVector3& v) const
{
    return _drVector3(x / v.x, y / v.y, z / v.z);
}

DR_INLINE _drVector3 _drVector3::operator*(float v) const
{
    return _drVector3(x * v, y * v, z * v);
}

DR_INLINE _drVector3 _drVector3::operator/(float v) const
{
    float inv = 1.0f / v;
    return _drVector3(x * inv, y * inv, z * inv);
}


DR_INLINE _drVector3 operator*(float f, const _drVector3& v)
{
    return _drVector3(f * v.x, f * v.y, f * v.z);
}


DR_INLINE BOOL _drVector3::operator==(const _drVector3& v) const
{
    return x == v.x && y == v.y && z == v.z;
}

DR_INLINE BOOL _drVector3::operator!=(const _drVector3& v) const
{
    return x != v.x || y != v.y || z != v.z;
}
DR_INLINE float _drVector3::operator[](int i) const 
{ 
    return ((float*)&x)[i]; 
}
DR_INLINE float& _drVector3::operator[](int i) 
{ 
    return ((float*)&x)[i]; 
}


// drVector4
DR_INLINE _drVector4::_drVector4()
{}

DR_INLINE _drVector4::_drVector4(float fx, float fy, float fz, float fw)
: x(fx), y(fy), z(fz), w(fw)
{
}

DR_INLINE _drVector4::_drVector4(const float *v)
: x(v[0]), y(v[1]), z(v[2]), w(v[3])
{
}
DR_INLINE _drVector4::_drVector4(const drVector3& v)
: x(v.x), y(v.y), z(v.z), w(1.0f)
{
}
DR_INLINE _drVector4::_drVector4(const _drVector4& v)
: x(v.x), y(v.y), z(v.z), w(v.w)
{
}


// casting
DR_INLINE _drVector4::operator float*()
{
    return (float *)&x;
}

DR_INLINE _drVector4::operator const float*() const
{
    return (const float *)&x;
}


// assignment operators
DR_INLINE _drVector4& _drVector4::operator+=(const _drVector4& v)
{
    x += v.x;
    y += v.y;
    z += v.z;
    w += v.w;
    return *this;
}

DR_INLINE _drVector4& _drVector4::operator-=(const _drVector4& v)
{
    x -= v.x;
    y -= v.y;
    z -= v.z;
    w -= v.w;
    return *this;
}

DR_INLINE _drVector4& _drVector4::operator*=(float v)
{
    x *= v;
    y *= v;
    z *= v;
    w *= v;
    return *this;
}

DR_INLINE _drVector4& _drVector4::operator /= (float v)
{
    float inv = 1.0f / v;
    x *= inv;
    y *= inv;
    z *= inv;
    w *= inv;
    return *this;
}


// unary operators
DR_INLINE _drVector4 _drVector4::operator+() const
{
    return *this;
}

DR_INLINE _drVector4 _drVector4::operator-() const
{
    return _drVector4(-x, -y, -z, -w);
}


// binary operators
DR_INLINE _drVector4 _drVector4::operator+(const _drVector4& v) const
{
    return _drVector4(x + v.x, y + v.y, z + v.z, w + v.w);
}

DR_INLINE _drVector4 _drVector4::operator-(const _drVector4& v) const
{
    return _drVector4(x - v.x, y - v.y, z - v.z, w - v.w);
}

DR_INLINE _drVector4 _drVector4::operator*(float v) const
{
    return _drVector4(x * v, y * v, z * v, w * v);
}

DR_INLINE _drVector4 _drVector4::operator/(float v) const
{
    float inv = 1.0f / v;
    return _drVector4(x * inv, y * inv, z * inv, w * inv);
}


DR_INLINE _drVector4 operator*(float f, const _drVector4& v)
{
    return _drVector4(f * v.x, f * v.y, f * v.z, f * v.w);
}


DR_INLINE BOOL _drVector4::operator==(const _drVector4& v) const
{
    return x == v.x && y == v.y && z == v.z && w == v.w;
}

DR_INLINE BOOL _drVector4::operator!=(const _drVector4& v) const
{
    return x != v.x || y != v.y || z != v.z || w != v.w;
}
DR_INLINE float _drVector4::operator[](int i) const 
{ 
    return ((float*)&x)[i]; 
}
DR_INLINE float& _drVector4::operator[](int i) 
{ 
    return ((float*)&x)[i]; 
}

//--------------------------
// drMatrix44
//--------------------------
DR_INLINE _drMatrix44::_drMatrix44()
{}

DR_INLINE _drMatrix44::_drMatrix44(const float* v)
{
    memcpy(&_11, v, sizeof(_drMatrix44));
}

DR_INLINE _drMatrix44::_drMatrix44(const _drMatrix44& mat)
{
    memcpy(&_11, &mat, sizeof(_drMatrix44));
}

DR_INLINE _drMatrix44::_drMatrix44(float f11, float f12, float f13, float f14,
                        float f21, float f22, float f23, float f24,
                        float f31, float f32, float f33, float f34,
                        float f41, float f42, float f43, float f44)
{
    _11 = f11; _12 = f12; _13 = f13; _14 = f14;
    _21 = f21; _22 = f22; _23 = f23; _24 = f24;
    _31 = f31; _32 = f32; _33 = f33; _34 = f34;
    _41 = f41; _42 = f42; _43 = f43; _44 = f44;
}



// access grants
DR_INLINE float& _drMatrix44::operator()(int row, int col)
{
    return m[row][col];
}

DR_INLINE float _drMatrix44::operator()(int row, int col) const
{
    return m[row][col];
}


// casting operators
DR_INLINE _drMatrix44::operator float*()
{
    return (float *)&_11;
}

DR_INLINE _drMatrix44::operator const float*() const
{
    return (const float *)&_11;
}

DR_INLINE float _drMatrix44::operator[](int i) const 
{ 
    return ((float*)m)[i]; 
}
DR_INLINE float& _drMatrix44::operator[](int i) 
{ 
    return ((float*)m)[i]; 
}

// assignment operators
DR_INLINE _drMatrix44& _drMatrix44::operator*=(const _drMatrix44& mat)
{
    _drMatrix44Multiply((drMatrix44*)this, (drMatrix44*)this, (drMatrix44*)&mat);
    return *this;
}

DR_INLINE _drMatrix44& _drMatrix44::operator+=(const _drMatrix44& mat)
{
    _11 += mat._11; _12 += mat._12; _13 += mat._13; _14 += mat._14;
    _21 += mat._21; _22 += mat._22; _23 += mat._23; _24 += mat._24;
    _31 += mat._31; _32 += mat._32; _33 += mat._33; _34 += mat._34;
    _41 += mat._41; _42 += mat._42; _43 += mat._43; _44 += mat._44;
    return *this;
}

DR_INLINE _drMatrix44& _drMatrix44::operator-=(const _drMatrix44& mat)
{
    _11 -= mat._11; _12 -= mat._12; _13 -= mat._13; _14 -= mat._14;
    _21 -= mat._21; _22 -= mat._22; _23 -= mat._23; _24 -= mat._24;
    _31 -= mat._31; _32 -= mat._32; _33 -= mat._33; _34 -= mat._34;
    _41 -= mat._41; _42 -= mat._42; _43 -= mat._43; _44 -= mat._44;
    return *this;
}

DR_INLINE _drMatrix44& _drMatrix44::operator*=(float v)
{
    _11 *= v; _12 *= v; _13 *= v; _14 *= v;
    _21 *= v; _22 *= v; _23 *= v; _24 *= v;
    _31 *= v; _32 *= v; _33 *= v; _34 *= v;
    _41 *= v; _42 *= v; _43 *= v; _44 *= v;
    return *this;
}

DR_INLINE _drMatrix44& _drMatrix44::operator /= (float v)
{
    float inv = 1.0f / v;
    _11 *= inv; _12 *= inv; _13 *= inv; _14 *= inv;
    _21 *= inv; _22 *= inv; _23 *= inv; _24 *= inv;
    _31 *= inv; _32 *= inv; _33 *= inv; _34 *= inv;
    _41 *= inv; _42 *= inv; _43 *= inv; _44 *= inv;
    return *this;
}


// unary operators
DR_INLINE _drMatrix44 _drMatrix44::operator+() const
{
    return *this;
}

DR_INLINE _drMatrix44 _drMatrix44::operator-() const
{
    return _drMatrix44(-_11, -_12, -_13, -_14,
                      -_21, -_22, -_23, -_24,
                      -_31, -_32, -_33, -_34,
                      -_41, -_42, -_43, -_44);
}


// binary operators
DR_INLINE _drMatrix44 _drMatrix44::operator*(const _drMatrix44& mat) const
{
    _drMatrix44 ret;
    _drMatrix44Multiply((drMatrix44*)&ret, (drMatrix44*)this, (drMatrix44*)&mat);
    return ret;
}

DR_INLINE _drMatrix44 _drMatrix44::operator+(const _drMatrix44& mat) const
{
    return _drMatrix44(_11 + mat._11, _12 + mat._12, _13 + mat._13, _14 + mat._14,
                      _21 + mat._21, _22 + mat._22, _23 + mat._23, _24 + mat._24,
                      _31 + mat._31, _32 + mat._32, _33 + mat._33, _34 + mat._34,
                      _41 + mat._41, _42 + mat._42, _43 + mat._43, _44 + mat._44);
}

DR_INLINE _drMatrix44 _drMatrix44::operator-(const _drMatrix44& mat) const
{
    return _drMatrix44(_11 - mat._11, _12 - mat._12, _13 - mat._13, _14 - mat._14,
                      _21 - mat._21, _22 - mat._22, _23 - mat._23, _24 - mat._24,
                      _31 - mat._31, _32 - mat._32, _33 - mat._33, _34 - mat._34,
                      _41 - mat._41, _42 - mat._42, _43 - mat._43, _44 - mat._44);
}

DR_INLINE _drMatrix44 _drMatrix44::operator*(float v) const
{
    return _drMatrix44(_11 * v, _12 * v, _13 * v, _14 * v,
                      _21 * v, _22 * v, _23 * v, _24 * v,
                      _31 * v, _32 * v, _33 * v, _34 * v,
                      _41 * v, _42 * v, _43 * v, _44 * v);
}

DR_INLINE _drMatrix44 _drMatrix44::operator/(float v) const
{
    float inv = 1.0f / v;
    return _drMatrix44(_11 * inv, _12 * inv, _13 * inv, _14 * inv,
                      _21 * inv, _22 * inv, _23 * inv, _24 * inv,
                      _31 * inv, _32 * inv, _33 * inv, _34 * inv,
                      _41 * inv, _42 * inv, _43 * inv, _44 * inv);
}


DR_INLINE _drMatrix44 operator*(float f, const _drMatrix44& mat)
{
    return _drMatrix44(f * mat._11, f * mat._12, f * mat._13, f * mat._14,
                      f * mat._21, f * mat._22, f * mat._23, f * mat._24,
                      f * mat._31, f * mat._32, f * mat._33, f * mat._34,
                      f * mat._41, f * mat._42, f * mat._43, f * mat._44);
}


DR_INLINE BOOL _drMatrix44::operator == (const _drMatrix44& mat) const
{
    return 0 == memcmp(this, &mat, sizeof(_drMatrix44));
}

DR_INLINE BOOL _drMatrix44::operator!=(const _drMatrix44& mat) const
{
    return 0 != memcmp(this, &mat, sizeof(_drMatrix44));
}

//--------------------------
// Quaternion
//--------------------------
DR_INLINE _drQuaternion::_drQuaternion()
{}

DR_INLINE _drQuaternion::_drQuaternion(const float* v)
: x(v[0]), y(v[1]), z(v[2]), w(v[3])
{
}

DR_INLINE _drQuaternion::_drQuaternion(float fx, float fy, float fz, float fw)
: x(fx), y(fy), z(fz), w(fw)
{
}


// casting
DR_INLINE _drQuaternion::operator float*()
{
    return (float *)&x;
}

DR_INLINE _drQuaternion::operator const float*() const
{
    return (const float *)&x;
}


// assignment operators
DR_INLINE _drQuaternion& _drQuaternion::operator+=(const _drQuaternion& q)
{
    x += q.x;
    y += q.y;
    z += q.z;
    w += q.w;
    return *this;
}

DR_INLINE _drQuaternion& _drQuaternion::operator-=(const _drQuaternion& q)
{
    x -= q.x;
    y -= q.y;
    z -= q.z;
    w -= q.w;
    return *this;
}

DR_INLINE _drQuaternion& _drQuaternion::operator*=(const _drQuaternion& q)
{
    drQuaternionMultiply((drQuaternion*)this, (drQuaternion*)this, (drQuaternion*)&q);
    return *this;
}

DR_INLINE _drQuaternion& _drQuaternion::operator*=(float f)
{
    x *= f;
    y *= f;
    z *= f;
    w *= f;
    return *this;
}

DR_INLINE _drQuaternion& _drQuaternion::operator/=(float f)
{
    float inv = 1.0f / f;
    x *= inv;
    y *= inv;
    z *= inv;
    w *= inv;
    return *this;
}


// unary operators
DR_INLINE _drQuaternion _drQuaternion::operator+() const
{
    return *this;
}

DR_INLINE _drQuaternion _drQuaternion::operator-() const
{
    return _drQuaternion(-x, -y, -z, -w);
}

// binary operators
DR_INLINE _drQuaternion _drQuaternion::operator+(const _drQuaternion& q) const
{
    return _drQuaternion(x + q.x, y + q.y, z + q.z, w + q.w);
}

DR_INLINE _drQuaternion _drQuaternion::operator-(const _drQuaternion& q) const
{
    return _drQuaternion(x - q.x, y - q.y, z - q.z, w - q.w);
}

DR_INLINE _drQuaternion _drQuaternion::operator*(const _drQuaternion& q) const
{
    _drQuaternion ret;
    _drQuaternionMultiply((drQuaternion*)&ret, (drQuaternion*)this, (drQuaternion*)&q);
    return ret;
}

DR_INLINE _drQuaternion _drQuaternion::operator*(float f) const
{
    return _drQuaternion(x * f, y * f, z * f, w * f);
}

DR_INLINE _drQuaternion _drQuaternion::operator/(float f) const
{
    float inv = 1.0f / f;
    return _drQuaternion(x * inv, y * inv, z * inv, w * inv);
}


DR_INLINE _drQuaternion operator*(float f, const _drQuaternion& q)
{
    return _drQuaternion(f * q.x, f * q.y, f * q.z, f * q.w);
}


DR_INLINE BOOL _drQuaternion::operator==(const _drQuaternion& q) const
{
    return x == q.x && y == q.y && z == q.z && w == q.w;
}

DR_INLINE BOOL _drQuaternion::operator!=(const _drQuaternion& q) const
{
    return x != q.x || y != q.y || z != q.z || w != q.w;
}


//#endif
//--------------------------
// drMatrix33
//--------------------------
DR_INLINE drMatrix33::drMatrix33()
{}

DR_INLINE drMatrix33::drMatrix33(const float* v)
{
    memcpy(&_11, v, sizeof(drMatrix33));
}

DR_INLINE drMatrix33::drMatrix33(const drMatrix33& mat)
{
    memcpy(&_11, &mat, sizeof(drMatrix33));
}

DR_INLINE drMatrix33::drMatrix33(float f11, float f12, float f13,
                                  float f21, float f22, float f23,
                                  float f31, float f32, float f33)
{
    _11 = f11; _12 = f12; _13 = f13; 
    _21 = f21; _22 = f22; _23 = f23; 
    _31 = f31; _32 = f32; _33 = f33;
}



// access grants
DR_INLINE float& drMatrix33::operator()(int row, int col)
{
    return m[row][col];
}

DR_INLINE float drMatrix33::operator()(int row, int col) const
{
    return m[row][col];
}
DR_INLINE float drMatrix33::operator[](int i) const 
{ 
    return ((float*)m)[i]; 
}
DR_INLINE float& drMatrix33::operator[](int i) 
{ 
    return ((float*)m)[i]; 
}

// casting operators
DR_INLINE drMatrix33::operator float*()
{
    return (float *)&_11;
}

DR_INLINE drMatrix33::operator const float*() const
{
    return (const float *)&_11;
}


// assignment operators
DR_INLINE drMatrix33& drMatrix33::operator*=(const drMatrix33& mat)
{
    drMatrix33Multiply(this, this, &mat);
    return *this;
}

DR_INLINE drMatrix33& drMatrix33::operator+=(const drMatrix33& mat)
{
    _11 += mat._11; _12 += mat._12; _13 += mat._13;
    _21 += mat._21; _22 += mat._22; _23 += mat._23;
    _31 += mat._31; _32 += mat._32; _33 += mat._33;
    return *this;
}

DR_INLINE drMatrix33& drMatrix33::operator-=(const drMatrix33& mat)
{
    _11 -= mat._11; _12 -= mat._12; _13 -= mat._13;
    _21 -= mat._21; _22 -= mat._22; _23 -= mat._23;
    _31 -= mat._31; _32 -= mat._32; _33 -= mat._33;
    return *this;
}

DR_INLINE drMatrix33& drMatrix33::operator*=(float v)
{
    _11 *= v; _12 *= v; _13 *= v;
    _21 *= v; _22 *= v; _23 *= v;
    _31 *= v; _32 *= v; _33 *= v;
    return *this;
}

DR_INLINE drMatrix33& drMatrix33::operator /= (float v)
{
    float inv = 1.0f / v;
    _11 *= inv; _12 *= inv; _13 *= inv;
    _21 *= inv; _22 *= inv; _23 *= inv;
    _31 *= inv; _32 *= inv; _33 *= inv;
    return *this;
}


// unary operators
DR_INLINE drMatrix33 drMatrix33::operator+() const
{
    return *this;
}

DR_INLINE drMatrix33 drMatrix33::operator-() const
{
    return drMatrix33(-_11, -_12, -_13,
                      -_21, -_22, -_23,
                      -_31, -_32, -_33);
}


// binary operators
DR_INLINE drMatrix33 drMatrix33::operator*(const drMatrix33& mat) const
{
    drMatrix33 ret;
    drMatrix33Multiply(&ret, this, &mat);
    return ret;
}

DR_INLINE drMatrix33 drMatrix33::operator+(const drMatrix33& mat) const
{
    return drMatrix33(_11 + mat._11, _12 + mat._12, _13 + mat._13,
                      _21 + mat._21, _22 + mat._22, _23 + mat._23, 
                      _31 + mat._31, _32 + mat._32, _33 + mat._33); 
}

DR_INLINE drMatrix33 drMatrix33::operator-(const drMatrix33& mat) const
{
    return drMatrix33(_11 - mat._11, _12 - mat._12, _13 - mat._13, 
                      _21 - mat._21, _22 - mat._22, _23 - mat._23, 
                      _31 - mat._31, _32 - mat._32, _33 - mat._33);
}

DR_INLINE drMatrix33 drMatrix33::operator*(float v) const
{
    return drMatrix33(_11 * v, _12 * v, _13 * v, 
                      _21 * v, _22 * v, _23 * v, 
                      _31 * v, _32 * v, _33 * v);
}

DR_INLINE drMatrix33 drMatrix33::operator/(float v) const
{
    float inv = 1.0f / v;
    return drMatrix33(_11 * inv, _12 * inv, _13 * inv,
                      _21 * inv, _22 * inv, _23 * inv,
                      _31 * inv, _32 * inv, _33 * inv);
}


DR_INLINE drMatrix33 operator*(float f, const drMatrix33& mat)
{
    return drMatrix33(f * mat._11, f * mat._12, f * mat._13,
                      f * mat._21, f * mat._22, f * mat._23,
                      f * mat._31, f * mat._32, f * mat._33);
}


DR_INLINE BOOL drMatrix33::operator == (const drMatrix33& mat) const
{
    return 0 == memcmp(this, &mat, sizeof(drMatrix33));
}

DR_INLINE BOOL drMatrix33::operator!=(const drMatrix33& mat) const
{
    return 0 != memcmp(this, &mat, sizeof(drMatrix33));
}

//--------------------------
// Plane
//--------------------------

DR_INLINE _drPlane::_drPlane()
{}

DR_INLINE _drPlane::_drPlane(const float* v)
{
    a = v[0];
    b = v[1];
    c = v[2];
    d = v[3];
}

DR_INLINE _drPlane::_drPlane(float fa, float fb, float fc, float fd)
{
    a = fa;
    b = fb;
    c = fc;
    d = fd;
}


// casting
DR_INLINE _drPlane::operator float*()
{
    return (float *)&a;
}

DR_INLINE _drPlane::operator const float*() const
{
    return (const float *)&a;
}


// unary operators
DR_INLINE _drPlane _drPlane::operator+() const
{
    return *this;
}

DR_INLINE _drPlane _drPlane::operator-() const
{
    return _drPlane(-a, -b, -c, -d);
}


// binary operators
DR_INLINE BOOL _drPlane::operator==(const _drPlane& p) const
{
    return a == p.a && b == p.b && c == p.c && d == p.d;
}

DR_INLINE BOOL _drPlane::operator!=(const _drPlane& p) const
{
    return a != p.a || b != p.b || c != p.c || d != p.d;
}


// ----------------------------------------
// DR_INLINE method
// ----------------------------------------

// drVector2
DR_INLINE drVector2* drVec2Add(drVector2* dst, const drVector2* v1, const drVector2* v2)
{
	dst->x = v1->x + v2->x;
	dst->y = v1->y + v2->y;

	return dst;	
}
DR_INLINE drVector2* drVec2Sub(drVector2* dst, const drVector2* v1, const drVector2* v2)
{
	dst->x = v1->x - v2->x;
	dst->y = v1->y - v2->y;

	return dst;	
}
DR_INLINE drVector2* drVec2Scale(drVector2* dst, const drVector2* vec, float s)
{
	dst->x = vec->x * s;
	dst->y = vec->y * s;
	return dst;	
}
DR_INLINE float drVec2Cross(const drVector2* v1, const drVector2* v2)
{
    return v1->x * v2->y - v1->y * v2->x;
}

DR_INLINE float drVec2Dot(const drVector2* v1, const drVector2* v2)
{
	return (v1->x*v2->x) + (v1->y*v2->y);
}

DR_INLINE drVector2* drVec2Normalize(drVector2* dst, const drVector2* src)
{
	float len = 1.0f / (float)sqrt(src->x * src->x + src->y * src->y);

	dst->x = src->x * len;
	dst->y = src->y * len;

	return dst;
}
DR_INLINE drVector2* drVec2Normalize(drVector2* vec)
{
    return drVec2Normalize(vec, vec);
}

DR_INLINE float drVec2SquareMagnitude(const drVector2* vec)
{
	return vec->x * vec->x + vec->y * vec->y;
}
DR_INLINE float drVec2Magnitude(const drVector2* vec)
{
	return (float)sqrt(drVec2SquareMagnitude(vec));
}
DR_INLINE float drVec2SquareMagnitude(const drVector2* v1, const drVector2* v2)
{
	float x = v2->x - v1->x;
	float y = v2->y - v1->y;
	return x * x + y * y;
}
DR_INLINE float drVec2Magnitude(const drVector2* v1, const drVector2* v2)
{
	return (float)sqrt(drVec2SquareMagnitude(v1,v2));
}
DR_INLINE int drVec2Equal(const drVector2* v1, const drVector2* v2)
{
    return (drFloatEqual(v1->x,v2->x) && drFloatEqual(v1->y,v2->y));
}
DR_INLINE int drVec2Equal(const drVector2* v1,const drVector2* v2, float esp)
{
    return (drFloatEqual(v1->x,v2->x, esp) && drFloatEqual(v1->y,v2->y, esp));
}

DR_INLINE drVector2* drConvertAngleToVector2(drVector2* v, float radian)
{
    v->x = cosf(radian);
    v->y = sinf(radian);
    return v;
}

///////////////////////////////////////////
// drVector3
DR_INLINE drVector3* drVector3Add(drVector3* v1, const drVector3* v2)
{
	v1->x += v2->x;
	v1->y += v2->y;
	v1->z += v2->z;
	return v1;
}
DR_INLINE drVector3* drVector3Add(drVector3* ret,const drVector3* v1,const drVector3* v2)
{
	ret->x = v1->x + v2->x;
	ret->y = v1->y + v2->y;
	ret->z = v1->z + v2->z;

	return ret;	
}
DR_INLINE drVector3* drVector3Sub(drVector3* v1,const drVector3* v2)
{
	v1->x -= v2->x;
	v1->y -= v2->y;
	v1->z -= v2->z;
	return v1;
}

DR_INLINE drVector3* drVector3Sub(drVector3* ret,const drVector3* v1,const drVector3* v2)
{
	ret->x = v1->x - v2->x;
	ret->y = v1->y - v2->y;
	ret->z = v1->z - v2->z;

	return ret;	
}
DR_INLINE drVector3* drVector3Scale(drVector3* vec, float s)
{
	vec->x *= s;
	vec->y *= s;
	vec->z *= s;

	return vec;	
}
DR_INLINE drVector3* drVector3Scale(drVector3* v, const drVector3* s)
{
    v->x *= s->x;
    v->y *= s->y;
    v->z *= s->z;

    return v;
}
DR_INLINE drVector3* drVector3Cross(drVector3* ret,const drVector3* v1,const drVector3* v2)
{
    ret->x = v1->y * v2->z - v1->z * v2->y;
    ret->y = v1->z * v2->x - v1->x * v2->z;
    ret->z = v1->x * v2->y - v1->y * v2->x;
	return ret;
}

DR_INLINE float drVector3Dot(const drVector3* v1,const drVector3* v2)
{
	return (v1->x*v2->x) + (v1->y*v2->y) + (v1->z*v2->z);
}
DR_INLINE float drVector3SquareMagnitude(const drVector3* vec) 
{ 
	return vec->x * vec->x + vec->y * vec->y + vec->z * vec->z; 
}
DR_INLINE float drVector3SquareMagnitude(const drVector3* v1,const drVector3* v2)
{
    return drVector3SquareMagnitude(&drVector3(*v1 - *v2));
}
DR_INLINE float drVector3Magnitude(const drVector3* vec)
{ 
	return (float)sqrt(drVector3SquareMagnitude(vec)); 
}
DR_INLINE float drVector3Magnitude(const drVector3* v1,const drVector3* v2)
{
    return (float)sqrt(drVector3SquareMagnitude(v1,v2));
}
DR_INLINE drVector3* drVector3Normalize(drVector3* vec)
{
	return drVector3Scale(vec, 1.0f / drVector3Magnitude(vec));
}

DR_INLINE int drVector3Zero(const drVector3* vec,float eps=1e-3f)
{
    return (drFloatZero(vec->x,eps) 
        && drFloatZero(vec->y,eps) 
        && drFloatZero(vec->z,eps));
}
DR_INLINE int drVector3Equal(const drVector3* v1,const drVector3* v2,float eps=1e-3f)
{
    return (drFloatZero(v1->x - v2->x,eps)
        && drFloatZero(v1->y - v2->y,eps)
        && drFloatZero(v1->z - v2->z,eps));
}

DR_INLINE drVector3* drVector3Slerp(drVector3* ret, const drVector3* v0, const drVector3* v1, float t)
{
    *ret = (1.0f - t) * (*v0) + t * (*v1);
    return ret;
}
// drVector4
//////////////////////////////////////
DR_INLINE drVector4* drVec4Add(drVector4* ret, const drVector4* v1, const drVector4* v2)
{
	ret->x = v1->x + v2->x;
	ret->y = v1->y + v2->y;
	ret->z = v1->z + v2->z;
    ret->w = v1->w + v2->w;

	return ret;	
}

DR_INLINE drVector4* drVec4Sub(drVector4* ret,const drVector4* v1,const drVector4* v2)
{
	ret->x = v1->x - v2->x;
	ret->y = v1->y - v2->y;
	ret->z = v1->z - v2->z;
    ret->w = v1->w - v2->w;
	return ret;	
}
DR_INLINE drVector4* drVec4Scale(drVector4* v, float s)
{
	v->x *= s;
	v->y *= s;
	v->z *= s;
    v->w *= s;
	return v;	
}
DR_INLINE drVector4* drVec4Scale(drVector4* v, const drVector4* s)
{
    v->x *= s->x;
    v->y *= s->y;
    v->z *= s->z;
    v->w *= s->w;
    return v;
}

DR_INLINE int drVec4Equal(const drVector4* v1, const drVector4* v2,float eps=1e-3f)
{
    return (drFloatZero(v1->x - v2->x,eps)
        && drFloatZero(v1->y - v2->y,eps)
        && drFloatZero(v1->z - v2->z,eps)
        && drFloatZero(v1->w - v2->w,eps));
}

// drMatrix33
////////////////////////////////////////
DR_INLINE drMatrix33* drMatrix33Identity(drMatrix33* m)
{
    return &(*m = drMatrix33(1.0f, 0.0f, 0.0f,
                              0.0f, 1.0f, 0.0f,
                              0.0f, 0.0f, 1.0f));

}


DR_INLINE drMatrix33 drMatrix33Translate(float x,float y)
{
  return drMatrix33(1.0f, 0.0f, 0.0f,
                     0.0f, 1.0f, 0.0f,
                        x,   y,  1.0f);
}
DR_INLINE drMatrix33 drMatrix33Translate(const drVector2& v)
{
	return drMatrix33Translate(v.x, v.y);
}
DR_INLINE drMatrix33* drMatrix33Translate(drMatrix33* mat, float x, float y) 
{
    mat->_31 = x;
	mat->_32 = y;
	return mat;
}

DR_INLINE drMatrix33 drMatrix33Scale(float x, float y)
{
   return drMatrix33(   x, 0.0f, 0.0f,
                      0.0f,    y, 0.0f,
                      0.0f, 0.0f, 1.0f);
}


DR_INLINE drMatrix33 drMatrix33Scale(const float s)
{
   return drMatrix33Scale(s, s);
}
DR_INLINE drMatrix33* drMatrix33Scale(drMatrix33* mat, float x, float y)
{
	mat->_11 = x;
	mat->_22 = y;
	return mat;
}
DR_INLINE drMatrix33* drMatrix33Scale(drMatrix33* mat, float s)
{
	return drMatrix33Scale(mat, s, s);
}

// @@ All rotate operation is in the Right-Hand-Coordinates System
DR_INLINE drMatrix33 drMatrix33Rotate(const float c, const float s)
{
   return drMatrix33(   c,    s, 0.0f,
					    -s,    c, 0.0f,
					  0.0f, 0.0f, 1.0f);
}
DR_INLINE drMatrix33 drMatrix33Rotate(const float theta)
{
   return drMatrix33Rotate(cosf(theta), sinf(theta));
}

DR_INLINE drVector2* drMatrix33GetRow(const drMatrix33* mat, int row)
{
    return (drVector2*)mat->m[row];
}

DR_INLINE drMatrix33* drMatrix33Rotate(drMatrix33* mat, float radian)
{
	return drMatrix33Multiply(mat, mat, &drMatrix33Rotate(radian));
}

// drMatrix44
DR_INLINE drMatrix44* drMatrix44Identity(drMatrix44* m)
{
	return &(*m = drMatrix44_Identity);
}

DR_INLINE drMatrix44 drMatrix44Translate(float x,float y,float z)
{
  return drMatrix44(1.0f, 0.0f, 0.0f, 0.0f,
                    0.0f, 1.0f, 0.0f, 0.0f,
                    0.0f, 0.0f, 1.0f, 0.0f,
                       x,   y,   z,   1.0f);
}
DR_INLINE drMatrix44 drMatrix44Translate(const drVector3& v)
{
	return drMatrix44Translate(v.x,v.y,v.z);
}
DR_INLINE drMatrix44* drMatrix44Translate(drMatrix44* matrix,float x,float y,float z) 
{
	matrix->_41 = x;
	matrix->_42 = y;
	matrix->_43 = z;
	return matrix;
}

DR_INLINE drMatrix44 drMatrix44Scale(float x, float y, float z)
{
   return drMatrix44(
       x,    0.0f, 0.0f, 0.0f,
       0.0f, y,    0.0f, 0.0f,
       0.0f, 0.0f, z,    0.0f,
       0.0f, 0.0f, 0.0f, 1.0f
       );
}

DR_INLINE drMatrix44 drMatrix44Scale(const drVector3& v)
{
    return drMatrix44Scale(v.x, v.y, v.z);
}

DR_INLINE drMatrix44* drMatrix44Scale(drMatrix44* matrix,float x,float y,float z)
{
	matrix->_11 = x;
	matrix->_22 = y;
	matrix->_33 = z;
	return matrix;
}
DR_INLINE drMatrix44* drMatrix44Scale(drMatrix44* matrix,float s)
{
    matrix->_11 *= s;
    matrix->_12 *= s;
    matrix->_13 *= s;
    matrix->_14 *= s;

    matrix->_21 *= s;
    matrix->_22 *= s;
    matrix->_23 *= s;
    matrix->_24 *= s;

    matrix->_31 *= s;
    matrix->_32 *= s;
    matrix->_33 *= s;
    matrix->_34 *= s;

    return matrix;
}

// @@ All ratate operation is in the Right-Hand-Coordinates System
DR_INLINE drMatrix44 drMatrix44RotateX(const float c, const float s)
{
   return drMatrix44(1.0f, 0.0f, 0.0f, 0.0f,
                     0.0f,    c,   -s, 0.0f,
					 0.0f,    s,    c, 0.0f,
					 0.0f, 0.0f, 0.0f, 1.0f);
}
DR_INLINE drMatrix44 drMatrix44RotateX(const float theta)
{
   return drMatrix44RotateX((float) cos(theta), (float) sin(theta));
}


DR_INLINE drMatrix44 drMatrix44RotateY(const float c, const float s)
{
   return drMatrix44(c,    0.0f,    s,    0.0f,
                     0.0f, 1.0f,    0.0f, 0.0f,
                     -s,   0.0f,    c,    0.0f,
                     0.0f, 0.0f,    0.0f, 1.0f);
}

DR_INLINE drMatrix44 drMatrix44RotateY(const float theta)
{
   return drMatrix44RotateY((float) cos(theta), (float) sin(theta));
}

DR_INLINE drMatrix44 drMatrix44RotateZ(const float c, const float s)
{
   return drMatrix44(c,   -s,    0.0f, 0.0f,
                     s,    c,    0.0f, 0.0f,
                     0.0f, 0.0f, 1.0f, 0.0f,
                     0.0f, 0.0f, 0.0f, 1.0f);
}

DR_INLINE drMatrix44 drMatrix44RotateZ(const float theta)
{
   return drMatrix44RotateZ((float) cos(theta), (float) sin(theta));
}
DR_INLINE drMatrix44* drMatrix44RotateX(drMatrix44* matrix,float angle) 
{
	return drMatrix44Multiply(matrix,matrix,&drMatrix44RotateX(angle));
}
DR_INLINE drMatrix44* drMatrix44RotateY(drMatrix44* matrix,float angle) 
{
	return drMatrix44Multiply(matrix,matrix,&drMatrix44RotateY(angle));
}
DR_INLINE drMatrix44* drMatrix44RotateZ(drMatrix44* matrix,float angle) 
{
	return drMatrix44Multiply(matrix,matrix,&drMatrix44RotateZ(angle));
}

DR_INLINE drVector3* drMat44GetRow(const drMatrix44* mat, int row)
{
    return (drVector3*)mat->m[row];
}

DR_INLINE drMatrix44* drMat44SetRow(drMatrix44* mat, const drVector3* v, int row)
{
    mat->m[row][0] = v->x;
    mat->m[row][1] = v->y;
    mat->m[row][2] = v->z;
	return mat;
}

// convert matrix
DR_INLINE drMatrix44* drConvertMat43ToMat44(drMatrix44* mat44, const drMatrix43* mat43)
{
    mat44->_11 = mat43->_11; mat44->_12 = mat43->_12; mat44->_13 = mat43->_13;
    mat44->_21 = mat43->_21; mat44->_22 = mat43->_22; mat44->_23 = mat43->_23;
    mat44->_31 = mat43->_31; mat44->_32 = mat43->_32; mat44->_33 = mat43->_33;
    mat44->_41 = mat43->_41; mat44->_42 = mat43->_42; mat44->_43 = mat43->_43;

    mat44->_14 = mat44->_24 = mat44->_34 = 0.0f;
    mat44->_44 = 1.0f;

    return mat44;
}

DR_INLINE drMatrix43* drConvertMat44ToMat43(drMatrix43* mat43, const drMatrix44* mat44)
{
    mat43->_11 = mat44->_11; mat43->_12 = mat44->_12; mat43->_13 = mat44->_13;
    mat43->_21 = mat44->_21; mat43->_22 = mat44->_22; mat43->_23 = mat44->_23;
    mat43->_31 = mat44->_31; mat43->_32 = mat44->_32; mat43->_33 = mat44->_33;
    mat43->_41 = mat44->_41; mat43->_42 = mat44->_42; mat43->_43 = mat44->_43;

    return mat43;
}

// ----------------------
// drQuaternion
// ----------------------
DR_INLINE drQuaternion* drQuaternionIdentity(drQuaternion* q)
{
    q->x = q->y = q->z = 0.0f;
    q->w = 1.0f;
    return q;
}
DR_INLINE drQuaternion* drQuaternionConjugate(drQuaternion* ret, const drQuaternion* q)
{
    ret->x = -q->x;
    ret->y = -q->y;
    ret->z = -q->z;
    ret->w = q->w;
    return ret;
}

DR_INLINE float drQuaternionSquareMagnitude(const drQuaternion* q)
{
    return q->x * q->x + q->y * q->y + q->z * q->z + q->w * q->w;
}
DR_INLINE float drQuaternionMagnitude(const drQuaternion* q)
{
    return sqrtf(drQuaternionSquareMagnitude(q));
}
DR_INLINE drQuaternion* drQuaternionNormalize(drQuaternion* ret, const drQuaternion* q)
{
    // q / magnitude
    float inv_m = 1.0f / drQuaternionMagnitude(q);
    ret->x = q->x * inv_m;
    ret->y = q->y * inv_m;
    ret->z = q->z * inv_m;
    ret->w = q->w * inv_m;

    return ret;
}
DR_INLINE drQuaternion* drQuaternionInverse(drQuaternion* ret, const drQuaternion* q)
{
    // inverse q^ = conjugate q / normalize q
    // if q is a unit quaternion then q^ = conjugate q
    drQuaternionNormalize(ret, q);
    drQuaternionConjugate(ret, ret);

    return ret;
}
// ----------------------
// drPlane
// ----------------------

// ax + by + cz + dw
DR_INLINE float drPlaneDot(const drPlane* p, const drVector4* v)
{
    return p->a * v->x + p->b * v->y + p->c * v->z + p->d * v->w;
}

// ax + by + cz + d
DR_INLINE float drPlaneDotCoord(const drPlane *p, const drVector3 *v)
{
    return p->a * v->x + p->b * v->y + p->c * v->z + p->d;
}

// ax + by + cz
DR_INLINE float drPlaneDotNormal(const drPlane *p, const drVector3 *v)
{
    return p->a * v->x + p->b * v->y + p->c * v->z;
}

DR_INLINE DWORD drPlaneClassifyVertex(const drPlane* p, const drVector3* v)
{
    float d = drPlaneDotCoord(p, v);
    return (d == 0.0f) ? PLANE_ON_SIDE : ((d > 0.0f) ? PLANE_FRONT_SIDE : PLANE_BACK_SIDE);
}
// > 0.0f: up
// == 0.0f: on
// < 0.0f: below
#define drPlaneClassify drPlaneDotCoord

DR_INLINE int drPlaneGetVectorWeight(drVector3* v, int flag, const drPlane* p)
{
	(*v)[flag] = 0.0f;

	float w = drPlaneClassify(p, v);
    float k = ((float*)&p->a)[flag];

    if(k != 0.0f) 
    {
		(*v)[flag] = -w / k;		
		return 1;
	}

	return (w == 0.0f);
}


DR_END

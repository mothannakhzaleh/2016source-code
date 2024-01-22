//
#pragma once

#include <math.h>
#include "drHeader.h"
#include "drStdInc.h"

#include "drFrontAPI.h"
//

// =============================
#define DR_USE_DXMATH_LIB
// =============================


#ifdef DR_USE_DXMATH_LIB

#include "drDirectX.h"

// dll-interface to be used by clients
#pragma warning(disable : 4251)

#define DRVECTOR2_DECL
#define DRVECTOR3_DECL
#define DRVECTOR4_DECL
#define DRMATRIX44_DECL
#define DRQUATERNION_DECL

typedef D3DXVECTOR2 drVector2;
typedef D3DXVECTOR3 drVector3;
typedef D3DXVECTOR4 drVector4;
typedef D3DXMATRIX drMatrix44;
typedef D3DXQUATERNION drQuaternion;

#define drMatrix44Multiply D3DXMatrixMultiply
#define drMatrix44Inverse D3DXMatrixInverse
#define drMatrix44Transpose D3DXMatrixTranspose
#define drQuaternionMultiply(ret, q1, q2) \
    D3DXQuaternionMultiply(ret, q2, q1)


#endif

DR_BEGIN


/////////

#define OP_MATRIX_REPLACE		0
#define OP_MATRIX_LOCAL			1
#define OP_MATRIX_GLOBAL		2

// axes ID
enum drAxisDef 
{ 
	DR_AXIS_X = 0,
	DR_AXIS_Y = 1,
	DR_AXIS_Z = 2,
	DR_AXIS_INVALID = 0xffffffff
};


// define pi value
const float DR_PI = 3.1415926535897f;
const float DR_HALF_PI = DR_PI * 0.5f;
const float DR_2_PI = DR_PI * 2.0f;
const float DR_ANGLE_TO_RADIAN = (DR_PI / 180.0f);
const float DR_RADIAN_TO_ANGLE = (180.0f / DR_PI);

const float epsilon = 1e-6f;
inline int drFloatZero(float f,float e) { return fabsf(f)<e; }
inline int drFloatEqual(float f1,float f2,float e) { return drFloatZero(f1-f2,e); }
inline int drFloatZero(float f) { return drFloatZero(f,epsilon); }
inline int drFloatEqual(float f1,float f2) { return drFloatZero(f1-f2,epsilon); }
inline int drFloatZero(double f, double e) { return fabs(f) < e; }
inline int drFloatEqual(double f1, double f2, double e) { return drFloatZero(f1 - f2, e); }

enum drPlaneClassifyType
{
    PLANE_ON_SIDE =          0,
    PLANE_FRONT_SIDE =       1,
    PLANE_BACK_SIDE =        2,
};
///////////
//////////////////



//#ifdef DR_USE_DRMATH_LIB

//class drVector3;
//class drMatrix33;
//class drMatrix44;
//class drPlane;

class _drVector2
{
public:
  float x, y;

public:
    _drVector2();
    _drVector2(float x, float y);
    _drVector2(const float* v);
    _drVector2(const _drVector2& v);

    // casting
    operator float*();
    operator const float*() const;

    // assignment operators
    _drVector2& operator+=(const _drVector2& v);
    _drVector2& operator-=(const _drVector2& v);
    _drVector2& operator*=(float v);
    _drVector2& operator/=(float v);

    // unary operators
    _drVector2 operator+() const;
    _drVector2 operator-() const;

    // binary operators
    _drVector2 operator+(const _drVector2& v) const;
    _drVector2 operator-(const _drVector2& v) const;
    _drVector2 operator*(float v) const;
    _drVector2 operator/(float v) const;

    friend _drVector2 operator * (float, const _drVector2& v);

    BOOL operator == (const _drVector2& v) const;
    BOOL operator != (const _drVector2& v) const;

    float operator[](int i) const;
    float& operator[](int i);
};

#ifndef DRVECTOR2_DECL
#define DRVECTOR2_DECL
typedef _drVector2 drVector2;
#endif


class _drVector2i
{
public:
    int x, y;

public:
    _drVector2i();
    _drVector2i(int x, int y);
    _drVector2i(const int* v);
    _drVector2i(const _drVector2i& v);

    // casting
    operator int*();
    operator const int*() const;

    // assignment operators
    _drVector2i& operator+=(const _drVector2i& v);
    _drVector2i& operator-=(const _drVector2i& v);
    _drVector2i& operator*=(int v);
    _drVector2i& operator/=(int v);

    // unary operators
    _drVector2i operator+() const;
    _drVector2i operator-() const;

    // binary operators
    _drVector2i operator+(const _drVector2i& v) const;
    _drVector2i operator-(const _drVector2i& v) const;
    _drVector2i operator*(int v) const;
    _drVector2i operator/(int v) const;

    friend _drVector2i operator * (int, const _drVector2i& v);

    BOOL operator == (const _drVector2i& v) const;
    BOOL operator != (const _drVector2i& v) const;

    int operator[](int i) const;
    int& operator[](int i);

};
#ifndef DRVECTOR2I_DECL
#define DRVECTOR2I_DECL
typedef _drVector2i drVector2i;
#endif

class _drVector3i
{
public:
    int x, y, z;

public:
    _drVector3i();
    _drVector3i(const int * v);
    _drVector3i(const _drVector3i& v);
    _drVector3i(int x, int y, int z);

    // casting
    operator int* ();
    operator const int* () const;

    // assignment operators
    _drVector3i& operator+=(const _drVector3i& v);
    _drVector3i& operator-=(const _drVector3i& v);
    _drVector3i& operator*=(int v);
    _drVector3i& operator/=(int v);

    // unary operators
    _drVector3i operator+() const;
    _drVector3i operator-() const;

    // binary operators
    _drVector3i operator+(const _drVector3i& v) const;
    _drVector3i operator-(const _drVector3i& v) const;
    _drVector3i operator*(const _drVector3i& v) const;
    _drVector3i operator/(const _drVector3i& v) const;
    _drVector3i operator*(int v) const;
    _drVector3i operator/(int v) const;

    friend _drVector3i operator*(int f, const _drVector3i& v);

    BOOL operator==(const _drVector3i& v) const;
    BOOL operator!=(const _drVector3i& v) const;

    int operator[](int i) const;
    int& operator[](int i);
};

#ifndef DRVECTOR3I_DECL
#define DRVECTOR3I_DECL
typedef _drVector3i drVector3i;
#endif

// drVector3
/////////////////////////////////////
class _drVector3
{
public:
    float x, y, z;

public:
    _drVector3();
    _drVector3(const float * v);
    _drVector3(const _drVector3& v);
    _drVector3(float x, float y, float z);

    // casting
    operator float* ();
    operator const float* () const;

    // assignment operators
    _drVector3& operator+=(const _drVector3& v);
    _drVector3& operator-=(const _drVector3& v);
    _drVector3& operator*=(float v);
    _drVector3& operator/=(float v);

    // unary operators
    _drVector3 operator+() const;
    _drVector3 operator-() const;

    // binary operators
    _drVector3 operator+(const _drVector3& v) const;
    _drVector3 operator-(const _drVector3& v) const;
    _drVector3 operator*(const _drVector3& v) const;
    _drVector3 operator/(const _drVector3& v) const;
    _drVector3 operator*(float v) const;
    _drVector3 operator/(float v) const;

    friend _drVector3 operator*(float f, const _drVector3& v);

    BOOL operator==(const _drVector3& v) const;
    BOOL operator!=(const _drVector3& v) const;

    float operator[](int i) const;
    float& operator[](int i);
};

#ifndef DRVECTOR3_DECL
#define DRVECTOR3_DECL
typedef _drVector3 drVector3;
#endif


// drVector4
/////////////////////////////////
class _drVector4
{
public:
  float x, y, z, w;


public:
    _drVector4();
    _drVector4(float xo, float yo, float zo, float wo);
    _drVector4(const float* v);
    _drVector4(const drVector3& v);
    _drVector4(const _drVector4& v);

    // casting
    operator float* ();
    operator const float* () const;

    // assignment operators
    _drVector4& operator+=(const _drVector4& v);
    _drVector4& operator-=(const _drVector4& v);
    _drVector4& operator*=(float v);
    _drVector4& operator/=(float v);

    // unary operators
    _drVector4 operator+() const;
    _drVector4 operator-() const;

    // binary operators
    _drVector4 operator+(const _drVector4& v) const;
    _drVector4 operator-(const _drVector4& v) const;
    _drVector4 operator*(float v) const;
    _drVector4 operator/(float v) const;

    friend _drVector4 operator*(float f, const _drVector4& v);

    BOOL operator==(const _drVector4& v) const;
    BOOL operator!=(const _drVector4& v) const;

    float operator[](int i) const;
    float& operator[](int i);
};

#ifndef DRVECTOR4_DECL
#define DRVECTOR4_DECL
typedef _drVector4 drVector4;
#endif

// drMatrix44
///////////////////////
class _drMatrix44
{
public:
    union 
    {
        struct 
        {
            float _11, _12, _13, _14;
            float _21, _22, _23, _24;
            float _31, _32, _33, _34;
            float _41, _42, _43, _44;
        };
        float m[4][4];
    };

public:
    _drMatrix44();
    _drMatrix44(const float *v);
    _drMatrix44(const _drMatrix44& v);
    _drMatrix44(float _11, float _12, float _13, float _14,
                float _21, float _22, float _23, float _24,
                float _31, float _32, float _33, float _34,
                float _41, float _42, float _43, float _44);


    // access grants
    float& operator()(int row, int col);
    float operator()(int row, int col) const;

    float operator[] (int i) const;
    float& operator[] (int i);

    // casting operators
    operator float*();
    operator const float*() const;

    // assignment operators
    _drMatrix44& operator*=(const _drMatrix44& v);
    _drMatrix44& operator+=(const _drMatrix44& v);
    _drMatrix44& operator-=(const _drMatrix44& v);
    _drMatrix44& operator*=(float v);
    _drMatrix44& operator/=(float v);

    // unary operators
    _drMatrix44 operator+() const;
    _drMatrix44 operator-() const;

    // binary operators
    _drMatrix44 operator*(const _drMatrix44& v) const;
    _drMatrix44 operator+(const _drMatrix44& v) const;
    _drMatrix44 operator-(const _drMatrix44& v) const;
    _drMatrix44 operator*(float v) const;
    _drMatrix44 operator/(float v) const;

    friend _drMatrix44 operator*(float f, const _drMatrix44& v);

    BOOL operator==(const _drMatrix44& v) const;
    BOOL operator!=(const _drMatrix44& v) const;
};

#ifndef DRMATRIX44_DECL
#define DRMATRIX44_DECL
typedef _drMatrix44 drMatrix44;
#endif


//--------------------------
// Quaternion
//--------------------------

class _drQuaternion
{
public:
    float x, y, z, w;
    
public:
    _drQuaternion();
    _drQuaternion(const float * v);
    _drQuaternion(float x, float y, float z, float w);

    // casting
    operator float*();
    operator const float*() const;

    // assignment operators
    _drQuaternion& operator+=(const _drQuaternion& q);
    _drQuaternion& operator-=(const _drQuaternion& q);
    _drQuaternion& operator*=(const _drQuaternion& q);
    _drQuaternion& operator*=(float f);
    _drQuaternion& operator/=(float f);

    // unary operators
    _drQuaternion operator+() const;
    _drQuaternion operator-() const;

    // binary operators
    _drQuaternion operator+(const _drQuaternion& q) const;
    _drQuaternion operator-(const _drQuaternion& q) const;
    _drQuaternion operator*(const _drQuaternion& q) const;
    _drQuaternion operator*(float f) const;
    _drQuaternion operator/(float f) const;

    friend _drQuaternion operator*(float f, const _drQuaternion& q);

    BOOL operator==(const _drQuaternion& q) const;
    BOOL operator!=(const _drQuaternion& q) const;

};
#ifndef DRQUATERNION_DECL
#define DRQUATERNION_DECL
typedef _drQuaternion drQuaternion;
#endif



//#endif

// drMatrix33
///////////////////////
class drMatrix33
{
public:
    union 
    {
        struct 
        {
            float _11, _12, _13;
            float _21, _22, _23;
            float _31, _32, _33;
        };
        float m[3][3];
    };

public:
    drMatrix33();
    drMatrix33(const float *v);
    drMatrix33(const drMatrix33& v);
    drMatrix33(float _11, float _12, float _13, 
                float _21, float _22, float _23, 
                float _31, float _32, float _33);


    // access grants
    float& operator()(int row, int col);
    float operator()(int row, int col) const;

    float operator[](int i) const;
    float& operator[](int i);

    // casting operators
    operator float*();
    operator const float*() const;

    // assignment operators
    drMatrix33& operator*=(const drMatrix33& v);
    drMatrix33& operator+=(const drMatrix33& v);
    drMatrix33& operator-=(const drMatrix33& v);
    drMatrix33& operator*=(float v);
    drMatrix33& operator/=(float v);

    // unary operators
    drMatrix33 operator+() const;
    drMatrix33 operator-() const;

    // binary operators
    drMatrix33 operator*(const drMatrix33& v) const;
    drMatrix33 operator+(const drMatrix33& v) const;
    drMatrix33 operator-(const drMatrix33& v) const;
    drMatrix33 operator*(float v) const;
    drMatrix33 operator/(float v) const;

    friend drMatrix33 operator*(float f, const drMatrix33& v);

    BOOL operator==(const drMatrix33& v) const;
    BOOL operator!=(const drMatrix33& v) const;

};

// drMatrix43
///////////////////////
class drMatrix43
{
public:
    union {
        struct {
            float _11, _12, _13;
            float _21, _22, _23;
            float _31, _32, _33;
            float _41, _42, _43;
        };
        float m[4][3];
    };

public:
  //static const drMatrix43 Identity;

  drMatrix43() {}

  drMatrix43(float f11, float f12, float f13,
             float f21, float f22, float f23,
             float f31, float f32, float f33,
             float f41, float f42, float f43)
  {
    _11=f11; _12=f12; _13=f13;
    _21=f21; _22=f22; _23=f23;
    _31=f31; _32=f32; _33=f33;
    _41=f41; _42=f42; _43=f43;
  }

  drMatrix43(const drMatrix43& m)
  {
      *this = m;
  }
  //drMatrix43(const drMatrix44& m)
  //{
  //    _11 = m._11; _12 = m._12; _13 = m._13;
  //    _21 = m._21; _22 = m._22; _23 = m._23;
  //    _31 = m._31; _32 = m._32; _33 = m._33;
  //    _41 = m._41; _42 = m._42; _43 = m._43;
  //}

  inline float operator() (int i, int j) const { return m[i][j]; }
  inline float& operator() (int i, int j) { return m[i][j]; }

  inline float operator[] (int i) const { return ((float*)m)[i]; }
  inline float& operator[] (int i) { return ((float*)m)[i]; }

};


// plane
class _drPlane
{
public:
    float a, b, c, d;

    _drPlane();
    _drPlane(const float* v);
    _drPlane(float fa, float fb, float fc, float fd);

    // casting
    operator float*();
    operator const float*() const;

    // unary operators
    _drPlane operator+() const;
    _drPlane operator-() const;

    // binary operators
    BOOL operator==(const _drPlane& p) const;
    BOOL operator!=(const _drPlane& p) const;
};
#ifndef DRPLANE_DECL
#define DRPLANE_DECL
typedef _drPlane drPlane;
#endif


// triangle
class drTriangle
{
public:
    union {
        struct {
            drVector3 v0, v1, v2; // vector
        };
        struct {
            drVector3 v[3];
        };
    };

  drVector3 c; // center
  drVector3 n; // normal

public:
  drTriangle() {}
  drTriangle(const drVector3& v0_, const drVector3& v1_, const drVector3& v2_)
	  : v0(v0_), v1(v1_), v2(v2_)
  {
      // do not use  outside funciton, expand vector cross
	  //drVector3Cross(&n, &drVector3(v1_ - v0_), &drVector3(v2_ - v0_));
      drVector3 c0(v1_ - v0_);
      drVector3 c1(v2_ - v0_);
      n.x = c0.y * c1.z - c0.z * c1.y;
      n.y = c0.z * c1.x - c0.x * c1.z;
      n.z = c0.x * c1.y - c0.y * c1.x;

	  c = (v0 + v1 + v2);
      c *= (1.0f / 3);
  }
};

class drBox
{
public:
    drVector3 c;
    drVector3 r;

public:
    drBox() {}
    drBox(float cx,float cy,float cz,float rx,float ry,float rz)
        : c(cx,cy,cz), r(rx,ry,rz) 
    {}
    drBox(const drVector3& center,const drVector3& radius)
        : c(center), r(radius) 
    {}
    drBox(const drBox& box)
        : c(box.c),r(box.r) 
    {}

    drVector3* GetPointWithMask(drVector3* out_v, DWORD mask) const
    {
        out_v->x = (mask & 0x100) ? (c.x + r.x) : (c.x - r.x);
        out_v->y = (mask & 0x010) ? (c.y + r.y) : (c.y - r.y);
        out_v->z = (mask & 0x001) ? (c.z + r.z) : (c.z - r.z);

        return out_v;
    }
};


class drRound
{
public:
    drVector2 c;
    float r;

public:
    drRound() {}
    drRound(const drVector2& c_, float r_) : c(c_), r(r_) {}
};

class drSphere
{
public:
    drVector3 c;
    float r;

    drSphere() {}
    drSphere(const drVector3& c_, float r_) : c(c_), r(r_) {}
};

class _drRect
{
public:
    int left;
    int top;
    int right;
    int bottom;

public:
    _drRect()
        :left(0), top(0), right(0), bottom(0)
    {}
    _drRect(int l, int t, int r, int b)
        : left(l), top(t), right(r), bottom(b)
    {}
    _drRect(const drVector2i& lt, const drVector2i& rb)
        : left(lt.x), top(lt.y), right(rb.x), bottom(rb.y)
    {}
    _drRect(const _drRect& s)
        : left(s.left), top(s.top), right(s.right), bottom(s.bottom)
    {}

    // 0: not in, 1: in rect area, 2: on the side, 3: on the corner
    DWORD PointInRect(const drVector2i* p) const
    {
        DWORD ret;
        BOOL mask = 0;

        if((p->x < left || p->x > right) || (p->y < top || p->y > bottom))
            ret = 0;
        else
        {
            if(p->x == left || p->x == right)
                mask = 0x0001;
            if(p->y == top || p->y == bottom)
                mask |= 0x0002;

            if(mask == 0)
                ret = 1;
            else if(mask == 3)
                ret = 3;
            else
                ret = 2;
        }

        return ret;
    }
    BOOL PointInRect2(const drVector2i* p) const
    {
        return (p->x >= left && p->x < right) && (p->y >= top && p->y < bottom);
    }

    void Extend(const _drRect* rc)
    {
        if(left > rc->left)
            left = rc->left;
        if(right < rc->right)
            right = rc->right;
        if(top > rc->top)
            top = rc->top;
        if(bottom < rc->bottom)
            bottom = rc->bottom;
    }
};

#ifndef DRRECT_DECL
#define DRRECT_DECL
typedef _drRect drRect;
#endif





// ====================
const static drMatrix33 drMatrix33_Identity(1.0f, 0.0f, 0.0f,
                                            0.0f, 1.0f, 0.0f,
                                            0.0f, 0.0f, 1.0f);

const static drMatrix43 drMatrix43_Identity(1.0f, 0.0f, 0.0f,
                                            0.0f, 1.0f, 0.0f,
                                            0.0f, 0.0f, 1.0f,
                                            0.0f, 0.0f, 0.0f);

const static drMatrix44 drMatrix44_Identity(1.0f, 0.0f, 0.0f, 0.0f,
                                            0.0f, 1.0f, 0.0f, 0.0f,
                                            0.0f, 0.0f, 1.0f, 0.0f,
                                            0.0f, 0.0f, 0.0f, 1.0f);
// ---------------------------------------
// inline method
// ---------------------------------------
DR_INLINE float drFloatSlerp(float v0, float v1, float t)
{
    return (1.0f - t) * v0 + t * v1;
}
DR_INLINE int drVector2iCross(const drVector2i* v1, const drVector2i* v2)
{
    return (v1->x * v2->y - v1->y * v2->x);
}

// ---------------------------------------
// non-inline method
// ---------------------------------------
DR_FRONT_API drVector2* drVec2Mat33Mul(drVector2* vec, const drMatrix33* mat);

// drMatrix33 method
DR_FRONT_API drMatrix33* _drMatrix33Multiply(drMatrix33* out, const drMatrix33* m1,const drMatrix33* m2);
DR_FRONT_API drMatrix33* _drMatrix33Transpose( drMatrix33* out, const drMatrix33* m );
DR_FRONT_API drMatrix33* _drMatrix33Inverse(drMatrix33* out, float* determinant, const drMatrix33* m);
DR_FRONT_API drMatrix33* drMatrix33Adjoint(drMatrix33* out, const drMatrix33* m);


DR_FRONT_API drMatrix33* drMatrix33Translate(drMatrix33* mat, float x, float y, DWORD op);
DR_FRONT_API drMatrix33* drMatrix33Rotate(drMatrix33* mat, float radian, DWORD op);
DR_FRONT_API drMatrix33* drMatrix33Scale(drMatrix33* mat, float x, float y, DWORD op);

DR_FRONT_API drMatrix33* drMatrix33ReflectWithPoint(drMatrix33* mat, const drVector2* pt);
DR_FRONT_API drMatrix33* drMatrix33ReflectWithAxis(drMatrix33* mat, const drVector2* axis);
DR_FRONT_API drMatrix33* drMatrix33ReflectWithAxis(drMatrix33* mat, const drVector2* v1, const drVector2* v2);

// drMatrix44
DR_FRONT_API drMatrix44* _drMatrix44Multiply(drMatrix44* out,const drMatrix44* m1,const drMatrix44* m2);
DR_FRONT_API drMatrix44* drMatrix44MultiplyScale(drMatrix44* ret,const drMatrix44* mat_scale,const drMatrix44* mat);

DR_FRONT_API drMatrix44* _drMatrix44Inverse(drMatrix44* ret, float* determinant, const drMatrix44* m);
DR_FRONT_API drMatrix44* _drMatrix44InverseNoScaleFactor(drMatrix44* ret,const drMatrix44* m);
DR_FRONT_API drMatrix44* _drMatrix44Transpose(drMatrix44* ret, const drMatrix44* m);

DR_FRONT_API drMatrix44* drMatrix44Translate(drMatrix44* matrix,float x,float y,float z,DWORD op);
DR_FRONT_API drMatrix44* drMatrix44RotateAxis(drMatrix44* matrix,DWORD axis,float angle,DWORD op);
DR_FRONT_API drMatrix44* drMatrix44Scale(drMatrix44* matrix,float x,float y,float z,DWORD op);

DR_FRONT_API drMatrix44* drMatrix44Adjoint(drMatrix44* out, const drMatrix44* m);

DR_FRONT_API drMatrix44* drMatrix44Compose(drMatrix44* matrix,const drVector3* pos,const drVector3* face,const drVector3* up);
DR_FRONT_API drMatrix44* drMatrix44MetathesisYZ(drMatrix44* mat_lh, const drMatrix44* mat_rh);
DR_FRONT_API drMatrix44* drMatrix44MetathesisLightEngine(drMatrix44* dst, const drMatrix44* src);

DR_FRONT_API drMatrix43* drMatrix43MetathesisYZ(drMatrix43* mat_lh, const drMatrix43* mat_rh);
DR_FRONT_API drMatrix43* drMatrix43MetathesisLightEngine(drMatrix43* dst, const drMatrix43* src);

DR_FRONT_API drVector3* drVector3Transform(drVector3* out, const drVector3* v, const drMatrix33* mat);
DR_FRONT_API drVector3* drVector3Transform(drVector3* out, const drVector3* v, const drQuaternion* nrm_q);
DR_FRONT_API drVector3* drVector3Transform(drVector3* out, const drVector3* v, const drVector3* nrm_axis, float angle);
DR_FRONT_API drVector3* drVector3Transform(drVector3* out, const drVector3* v, const drMatrix44* mat);
DR_FRONT_API drVector3* drVector3RotateAxisAngle(drVector3* out, const drVector3* v, const drVector3* axis_v0, const drVector3* axis_v1, float angle);
DR_FRONT_API drVector3* drVec3Mat44Mul(drVector3* vec,const drMatrix44* mat);
DR_FRONT_API drVector3* drVec3Mat44MulNormal(drVector3* vec,const drMatrix44* mat);

DR_FRONT_API drMatrix44* drMat44ReflectWithPoint(drMatrix44* mat, const drVector3* pt);
DR_FRONT_API drMatrix44* drMat44ReflectWithAxis(drMatrix44* mat, const drVector3* axis);
DR_FRONT_API drMatrix44* drMat44ReflectWithPlane(drMatrix44* mat, const drPlane* plane);
DR_FRONT_API drMatrix44* drMat44Slerp(drMatrix44* ret, const drMatrix44* m1, const drMatrix44* m2, float v);
DR_FRONT_API drMatrix44* drMatrix44Slerp(const drMatrix44* m0, const drMatrix44* m1, float t, drMatrix44* mat);
DR_FRONT_API drMatrix44* drMatrix44Slerp(const drVector3* p0, const drVector3* p1, const drVector3* s0, const drVector3* s1, const drQuaternion* r0, const drQuaternion* r1, float t, drMatrix44* mat);
DR_FRONT_API DR_RESULT drMatrix44ConvertPRS(const drMatrix44* mat, drVector3* pos, drQuaternion* rotation, drVector3* scale);

// quaternion
DR_FRONT_API drMatrix44* drQuaternionToMatrix44(drMatrix44* matrix,drQuaternion* quat);
DR_FRONT_API drMatrix44* drQuaternionToMatrix44Inv(drMatrix44* matrix,drQuaternion* quat);
DR_FRONT_API drQuaternion* drMatrix44ToQuaternion(drQuaternion* quat,const drMatrix44* matrix);
DR_FRONT_API drQuaternion* drEulerAngleToQuaternion(drQuaternion* quat,float roll,float pitch,float yaw);
DR_FRONT_API drQuaternion* _drQuaternionMultiply(drQuaternion* ret, const drQuaternion* q1, const drQuaternion* q2);
DR_FRONT_API drQuaternion* drQuaternionSlerp(drQuaternion* res, const drQuaternion* from, const drQuaternion* to, float t);
DR_FRONT_API drQuaternion* drQuaternionRotationAxis(drQuaternion* quat, const drVector3* std_axis, float angle);
DR_FRONT_API void drQuaternionToAxisAngle(drVector3* axis, float* angle, const drQuaternion* quat);
DR_FRONT_API drQuaternion* drQuaternionRotationSpherical(drQuaternion* quat, float longitude, float latitude, float angle);

DR_FRONT_API int drCheckVectorInBox(const drVector3* v, const drBox* b);
// mat_box[in]: scale factor forbidden
DR_FRONT_API int drCheckVectorInBox(const drVector3* v, const drBox* b, const drMatrix44* mat_box);

// vp[in]: checked vector;
// v1, v2, v3[in]: triangle vector
DR_FRONT_API int drCheckVectorInTriangle2D(const drVector2* vp,const drVector2* v1,const drVector2* v2,const drVector2* v3);

// extension above functoin 
// return: 3: the same vertices; 2: in the sides; 1: in it; 0:outside it
// flag represents index of vertices or sides
DR_FRONT_API int drCheckVectorInTriangle2D2(int* flag, const drVector2* vp, const drVector2* v1, const drVector2* v2, const drVector2* v3);

// check vector in triangle
DR_FRONT_API int drCheckVectorInTriangle3D(const drVector3* v, const drVector3* v0, const drVector3* v1, const drVector3* v2, const drVector3* n);
inline int drCheckVectorInTriangle3D(const drVector3* v, const drTriangle* t)
{
	return drCheckVectorInTriangle3D(v, &t->v0, &t->v1, &t->v2, &t->n);
}

// return: 2: in vertices; 3: in sides; 1: in it; 0: outside
// flag: which vertix or side vp is in
DR_FRONT_API int drCheckVectorInTriangle3D2(int* flag, const drVector3* v, const drVector3* v0, const drVector3* v1, const drVector3* v2, const drVector3* n);
inline int drCheckVectorInTriangle3D2(int* flag, const drVector3* v, const drTriangle* t)
{
	return drCheckVectorInTriangle3D2(flag, v, &t->v0, &t->v1, &t->v2, &t->n);
}

inline int drCheckVectorInRound(const drVector2* v, const drRound* r)
{
    float xo = (v->x - r->c.x);
    float yo = (v->y - r->c.y);

    return ((xo * xo + yo * yo) < (r->r * r->r));
}

inline int drCheckVectorInSphere(const drVector3* v, const drSphere* s)
{
    float xo = (v->x - s->c.x);
    float yo = (v->y - s->c.y);
    float zo = (v->z - s->c.z);

    return ((xo * xo + yo * yo + zo * zo) < (s->r * s->r));
}

DR_FRONT_API int drIntersectLineLine2D(drVector2* v, const drVector2* u1, const drVector2* u2, const drVector2* v1, const drVector2* v2, int be_ray);
DR_FRONT_API int drIntersectLineLine3D(drVector3* v, const drVector3* u1, const drVector3* u2, const drVector3* v1, const drVector3* v2, int be_ray);

DR_FRONT_API int drIntersectBoxBoxAABB(const drBox* b1, const drBox* b2);
DR_FRONT_API int drIntersectBoxBoxOBB(const drBox* b1, const drBox* b2, const drMatrix44* mat);
DR_FRONT_API DR_RESULT drIntersectLineRect(drVector2* o_v, int* o_n, const drVector2* u1, const drVector2* u2, const drVector2* rc_v1, const drVector2* rc_v2, int is_segment);
DR_FRONT_API int drIntersectRaySphere(drVector3* ret, const drSphere* sphere, const drVector3* org, const drVector3* ray);
DR_FRONT_API int drIntersectSphereSphere(drVector3* ret, const drSphere* s1, const drSphere* s2);

// ray intersect with triangle
// v[out]: intersect point
// d[out]: distance from org to v
// ray[in]: ray dir
// org[in]: orginal point
// t[in]: triangle 
DR_FRONT_API int drIntersectRayTriangle(drVector3* v, float* d, const drVector3* org,const drVector3* ray, const drTriangle* tri);

////////////
//////////////////////////////////
DR_FRONT_API drVector3* drGetTriangleNormal(drVector3* n,const drVector3* v0,const drVector3* v1,const drVector3* v2);

//
// i1,i2: mapping axis, ret: exclude axis , vec: donot need normalized
DR_FRONT_API int drGetVecNormalAxisMapping(int* i1,int* i2,const drVector3* vec); 


// get a vector 's weight by another normal vector
//            ^ n    ^ up
// face\     /      /
//      \   /      /
// v<---/--/------/---> v
//     /          \
//  up/            \
//                  \ face
// understand? ^_^
// return value: if vec-normal angle < 90 return 1, 90-180 return 0
// remarks: vec and normal must be normalized first
DR_FRONT_API int drGetVec3WeightWithNormal(drVector3* face,drVector3* up,const drVector3* vec,const drVector3* normal);

// drGetEquation2 要比 drGetEquation2f快一些
// ret[out]: x, y
// e1,e2[in]: coefficient x, y and equation result
DR_FRONT_API void drGetEquation2(float* ret, const float* e1, const float* e2);

// ret[out]: x1, x2
// equation: a1 * x1 + b1 * x2 = c1
// e1: (a1, b1, c1); e2: (a2, b2, c2)
DR_FRONT_API void drGetEquation2f(float* ret, const float* e1, const float* e2);

// ret[out]: x, y, z
// e1,e2,e3[in]: coefficient x, y, z and equation result
DR_FRONT_API void drGetEquation3(float* ret, const float* e1, const float* e2, const float* e3);

inline int drFloatRoundDec(float f) { return static_cast<int>(f); }
inline int drFloatRoundInc(float f) { return drFloatRoundDec(f) + 1; }
inline float drFloatDecimal(float f) { return (f - (float)drFloatRoundDec(f)); }

inline DWORD drConvertColor3fToDWORD(const float* c) 
{ 
    return (0xff000000 | (unsigned char)(c[0] * 255) | ((unsigned char)(c[1] * 255)<< 8) | ((unsigned char)(c[2] * 255)<<16)); 
}
inline drVector3 drConvertDWORDToColor3f(DWORD c) 
{
    float f = 1.0f / 255;
    return drVector3((c & 0xff) * f, ((c>>8) & 0xff) * f, ((c>>16) & 0xff) * f);
}


DR_FRONT_API float drGetLineOriginDistance2(const drVector2* v1, const drVector2* v2);

// [in]: src_dir, dst_dir must be unit-vector
DR_FRONT_API float drGetDirTurnAngle(const drVector2* src_dir, const drVector2* dst_dir);

// linear transform: y = A * x + B
// x range: (x_var[0], x_var[1])
// y range: (y_var[0], y_var[1])
// ret_param[out]: coefficient A, B
// x_var, y_var,[in]: transform range
DR_FRONT_API void drGetLinearTransformParam(float* ret_param, const float* x_var, const float* y_var);

// drPlane
// Normalize plane (so that |a,b,c| == 1)
DR_FRONT_API drPlane* WINAPI drPlaneNormalize(drPlane *p_out, const drPlane *p);

// Find the intersection between a plane and a line.  If the line is
// parallel to the plane, NULL is returned.
DR_FRONT_API drVector3* WINAPI drPlaneIntersectLine(drVector3 *p_out, const drPlane *p, const drVector3 *v1, const drVector3 *v2);

// Construct a plane from a point and a normal
DR_FRONT_API drPlane* WINAPI drPlaneFromPointNormal(drPlane *p_out, const drVector3 *v, const drVector3 *n);

// Construct a plane from 3 points
DR_FRONT_API drPlane* WINAPI drPlaneFromPoints(drPlane *p_out, const drVector3 *v1, const drVector3 *v2, const drVector3 *v3);

DR_FRONT_API DWORD WINAPI drPlaneClassifyBox(const drPlane* p, const drBox* b);
DR_FRONT_API DWORD WINAPI drPlaneClassifyBox(const drPlane* p, const drBox* b, const drMatrix44* b_mat);
// extension class

//class drMatrix44X : public drMatrix44
//{
//public:
//
//	inline void Translate(float x, float y, float z, DWORD op) { drMatrix44Translate(this, x, y, z, op); }
//	inline void RotateAxis(DWORD axis, float angle, DWORD op) { drMatrix44RotateAxis(this, axis, angle, op); }
//	inline void Scale(float x, float y, float z, DWORD op) { drMatrix44Scale(this, x, y, z, op); }
//    inline drVector3* GetRow(int row) { return (drVector3*)m[row]; }
//    inline void SetRow(const drVector3* ver, int row) { drMat44SetRow(this, ver, row); }
//	inline void Identity() { drMatrix44Identity(this); }
//
//    inline drMatrix44X& operator=(const drMatrix44& mat) { *(static_cast<drMatrix44*>(this)) = mat; return *this; }
//
//};


// compatiable old method
//#define drMat44GetLinearValue drMat44Slerp
//#define CheckVertexInPolygon2D drCheckVectorInTriangle2D
//#define drCheckVectorInTriangle2D2 drCheckVectorInTriangle2D2
//#define drLineIntersect2D drIntersectLineLine2D
//#define drLineIntersect3D drIntersectLineLine3D
// end namesapce lsh
DR_END

#ifndef drMatrix33Multiply
#define drMatrix33Multiply _drMatrix33Multiply
#endif

#ifndef drMatrix33Inverse
#define drMatrix33Inverse _drMatrix33Inverse
#endif

#ifndef drMatrix33Transpose
#define drMatrix33Transpose _drMatrix33Transpose
#endif

#ifndef drMatrix33Multiply
#define drMatrix33Multiply _drMatrix33Multiply
#endif

#ifndef drMatrix44Inverse
#define drMatrix44Inverse _drMatrix44Inverse
#endif

#ifndef drMatrix44InverseNoScaleFactor
#define drMatrix44InverseNoScaleFactor _drMatrix44InverseNoScaleFactor
#endif

#ifndef drMatrix44Transpose
#define drMatrix44Transpose _drMatrix44Transpose
#endif

#ifndef drQuaternionMultiply
#define drQuaternionMultiply _drQuaternionMultiply
#endif 

#include "drMath.inl"


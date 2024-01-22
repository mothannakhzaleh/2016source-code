//
#pragma once

#include "drHeader.h"
#include "drMath.h"
#include "drFrontAPI.h"
#include "drDirectX.h"

DR_BEGIN



class DR_FRONT_API drCamera
{
public:
	static void GetMatrixCameraToView( drMatrix44* mat, const drMatrix44* cam_mat );
	static void GetMatrixViewToCamera( drMatrix44* mat, const drMatrix44* mat_view);

private:
	drMatrix44 _m;

public:
	float _fov;
	float _aspect;
	float _znear;
	float _zfar;

public:
	drCamera();

	int SetPerspectiveFov(float fov,float aspect,float zn,float zf);

	void SetPosition(drVector3* pos);
	void SetPosition(drVector3* face,drVector3* up);
	void SetPosition(drVector3* pos,drVector3* face,drVector3* up);
	void SetPosition(const drMatrix44* m) { _m = *m; }

	void Rotate(DWORD axis,float angle);

	void SetTransform();
	drMatrix44* GetMatrix() { return &_m; }

	void GetMatrixView( drMatrix44* mat );
	void GetMatrixProj( drMatrix44* mat );
     
};

DR_END

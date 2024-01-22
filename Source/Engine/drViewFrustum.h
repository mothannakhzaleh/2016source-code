//
/*============================================================================
This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 59 Temple
Place - Suite 330, Boston, MA 02111-1307, USA, or go to
http://www.gnu.org/copyleft/gpl.html.

// You can get more details from Plane Collision tutorial at www.GameTutorials.com

last modified: 01/02/2004, Michael Yao
last modified: 2004-10-26, Jack li
============================================================================*/
#pragma once

#include "drHeader.h"
#include "drMath.h"
#include "drInterfaceExt.h"
#include "drDirectX.h"

DR_BEGIN


enum drViewFrustumPlaneEnum
{
    VIEWFRUSTUM_TOP =         0,
    VIEWFRUSTUM_BOTTOM =      1,
    VIEWFRUSTUM_LEFT =        2,
    VIEWFRUSTUM_RIGHT =       3,
    VIEWFRUSTUM_FRONT =       4,
    VIEWFRUSTUM_BACK =        5,
};

class drViewFrustum : public drIViewFrustum
{
DR_STD_DECLARATION()

public:
    drPlane _plane_seq[6];

public:
    void Update(const drMatrix44* mat_viewproj);
    drPlane* GetPlane(DWORD type) { return &_plane_seq[type]; }
    BOOL IsPointInFrustum(const drVector3* v);
    BOOL IsSphereInFrustum(const drSphere* s);
    BOOL IsSphereInFrustum(const drSphere* s, DWORD* last_check_plane);
    BOOL IsBoxInFrustum(const drBox* b, const drMatrix44* b_mat, DWORD* last_check_plane);
    float GetDistanceFromNearPlane(const drVector3* v);
};

DR_END

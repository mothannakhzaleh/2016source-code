//
#include "drMath.h"

DR_BEGIN
////////////////
////////////////////////////////
//const drVector2 drVector2::Zero(0.0f,0.0f);
//
//const drVector3 drVector3::Zero(0.0f,0.0f,0.0f);
//
/////////////
/////////////////////////////
//const drMatrix33 drMatrix33::Identity( 1.0f, 0.0f, 0.0f,
//                                       0.0f, 1.0f, 0.0f,
//                                       0.0f, 0.0f, 1.0f );
//
//const drMatrix43 drMatrix43::Identity( 1.0f, 0.0f, 0.0f,
//                                       0.0f, 1.0f, 0.0f,
//                                       0.0f, 0.0f, 1.0f,
//                                       0.0f, 0.0f, 0.0f );
//
//const drMatrix44 drMatrix44::Identity( 1.0f, 0.0f, 0.0f, 0.0f,
//                                       0.0f, 1.0f, 0.0f, 0.0f,
//                                       0.0f, 0.0f, 1.0f, 0.0f,
//                                       0.0f, 0.0f, 0.0f, 1.0f );

// =========

// drMatrix33
///////////////////////
drMatrix33* _drMatrix33Transpose( drMatrix33* ret, const drMatrix33* m )
{
    drMatrix33 tmp( *m );

	tmp._12 = m->_21;
    tmp._21 = m->_12;

	tmp._13 = m->_31;
	tmp._31 = m->_13;

	tmp._23 = m->_32;
	tmp._32 = m->_23;

    *ret = tmp;

	return ret;
}


drMatrix33* _drMatrix33Multiply( drMatrix33* ret, const drMatrix33* m1, const drMatrix33* m2 )
{
   drMatrix33 tmp;

   tmp._11 = m1->_11*m2->_11 + m1->_12*m2->_21 + m1->_13*m2->_31;
   tmp._12 = m1->_11*m2->_12 + m1->_12*m2->_22 + m1->_13*m2->_32;
   tmp._13 = m1->_11*m2->_13 + m1->_12*m2->_23 + m1->_13*m2->_33;

   tmp._21 = m1->_21*m2->_11 + m1->_22*m2->_21 + m1->_23*m2->_31;
   tmp._22 = m1->_21*m2->_12 + m1->_22*m2->_22 + m1->_23*m2->_32;
   tmp._23 = m1->_21*m2->_13 + m1->_22*m2->_23 + m1->_23*m2->_33;

   tmp._31 = m1->_31*m2->_11 + m1->_32*m2->_21 + m1->_33*m2->_31;
   tmp._32 = m1->_31*m2->_12 + m1->_32*m2->_22 + m1->_33*m2->_32;
   tmp._33 = m1->_31*m2->_13 + m1->_32*m2->_23 + m1->_33*m2->_33;


   memcpy( ret, &tmp, sizeof(drMatrix33) );

	return ret;

}

drMatrix33* drMatrix33Translate( drMatrix33* mat, float x, float y, DWORD op )
{
   if (op == OP_MATRIX_REPLACE) {
       // replace the working one
       mat->_11 = 1.0f; mat->_12 = 0.0f; mat->_13 = 0.0f;
       mat->_21 = 0.0f; mat->_22 = 1.0f; mat->_23 = 0.0f;
       mat->_31 = x;    mat->_32 = y;    mat->_33 = 1.0f;
   }
   else if (op == OP_MATRIX_LOCAL) {
       // post-multiply the mat to the working one to 
       // perform the transformation to local coordinate system of the node
       mat->_31 += x * mat->_11 + y * mat->_21;
       mat->_32 += x * mat->_12 + y * mat->_22;
   }
   else if (op == OP_MATRIX_GLOBAL) {
       mat->_31 += x;
       mat->_32 += y;
   }

   return mat;
}


drMatrix33* drMatrix33Rotate( drMatrix33* mat, float radian, DWORD op )
{
	// compute the rotation values
	float csv = cosf( radian );
	float snv = sinf( radian );

	if( op == OP_MATRIX_REPLACE ) {
		// replace the working one
        mat->_11 = csv;  mat->_12 = -snv; mat->_13 = 0.0f;
        mat->_21 = snv;  mat->_22 =  csv; mat->_23 = 0.0f;
        mat->_31 = 0.0f; mat->_32 = 0.0f; mat->_33 = 1.0f;
	}
	else {
		// form the rotation matrix
        drMatrix33 tmp( csv, -snv, 0.0f,
                        snv,  csv, 0.0f,
                        0.0f, 0.0f,1.0f );

		if (op == OP_MATRIX_LOCAL) {
			// pre-multiply the matrix to the working one to perform
			// the transformation to local coordinate system of the node
			drMatrix33Multiply( mat, &tmp, mat );
		}
		else if (op == OP_MATRIX_GLOBAL) {
			// post-multiply the matrix to the working one to perform
			// the transformation to global coordinate system of the node
			drMatrix33Multiply( mat, mat, &tmp );
		}
	}

	return mat;

}


drMatrix33* drMatrix33Scale( drMatrix33* mat, float x, float y, DWORD op )
{
	
	if( op == OP_MATRIX_REPLACE ) {
		// replace the working one
        mat->_11 = x;    mat->_12 = 0.0f; mat->_13 = 0.0f;
        mat->_21 = 0.0f; mat->_22 = y;    mat->_23 = 0.0f;
        mat->_31 = 0.0f; mat->_32 = 0.0f; mat->_33 = 1.0f;
	}
	else {
		// setup the matrix
        drMatrix33 tmp( x,    0.0f, 0.0f,
                        0.0f,    y, 0.0f,
                        0.0f, 0.0f, 1.0f );

		if (op == OP_MATRIX_LOCAL) {

			// pre-multiply the matrix to the working one to perform
			// the transformation to local coordinate system of the node
			drMatrix33Multiply( mat, &tmp, mat );
		}
		else if (op == OP_MATRIX_GLOBAL) {
			// post-multiply the matrix to the working one to perform
			// the transformation to global coordinate system of the node
			drMatrix33Multiply( mat, mat, &tmp );
		}
	}

	return mat;
}

drVector2* drVec2Mat33Mul( drVector2* vec, const drMatrix33* mat )
{
    drVector2 v(*vec);

    v.x = vec->x * mat->_11 + vec->y * mat->_21 + mat->_31;
    v.y = vec->x * mat->_12 + vec->y * mat->_22 + mat->_32;

    *vec = v;
	return vec;

}
drVector3* drVector3Transform(drVector3* ret, const drVector3* v, const drMatrix33* mat)
{
    drVector3 u(*v);

    ret->x = u.x * mat->_11 + u.y * mat->_21 + u.z * mat->_31;
    ret->y = u.x * mat->_12 + u.y * mat->_22 + u.z * mat->_32;
    ret->z = u.x * mat->_13 + u.y * mat->_23 + u.z * mat->_33;

    return ret;
}

drMatrix33* drMatrix33ReflectWithPoint( drMatrix33* mat, const drVector2* pt )
{
    // Mt(-pt) * Mt( -1 ) * Mt( pt )

    *mat = drMatrix33( -1.0f,  0.0f,  0.0f, 
                        0.0f, -1.0f,  0.0f,
                        2 * pt->x, 2 * pt->y, 1.0f );
    return mat;

}
drMatrix33* drMatrix33ReflectWithAxis( drMatrix33* mat, const drVector2* axis )
{
    // Mr(-angle) * Mt(axis_x) * Mr(angle)
    float cosv = drVec2Dot( axis, &drVector2( 1.0f, 0.0f ) );
    float sinv = (cosv == 0.0f) ? 1.0f : axis->y * cosv / axis->x;
    float cosvcosv = cosv * cosv;
    float sinvsinv = sinv * sinv;
    float cosvsinv = cosv * sinv;

    *mat = drMatrix33( cosvcosv - sinvsinv, 2 * cosvsinv,        0.0f,
                       2 * cosvsinv,        sinvsinv - cosvcosv, 0.0f,
                       0.0f,                0.0f,                1.0f );
    return mat;
}

// 1. translate axis to origin; 2. rotate axis; 3. untraslate axis with origin
// 
drMatrix33* drMatrix33ReflectWithAxis( drMatrix33* mat, const drVector2* v1, const drVector2* v2 )
{
    drVector2 axis( v2->x - v1->x, v2->y - v1->y );
    drVec2Normalize( &axis );

    drVector2 pt( -axis.y, axis.x );

    float s = drGetLineOriginDistance2( v1, v2 );

    drVec2Scale( &pt, &pt, s );

    drMatrix33ReflectWithAxis( mat, &axis );

    mat->_31 = - pt.x * mat->_11 - pt.y * mat->_21 + pt.x;
    mat->_32 = - pt.x * mat->_12 - pt.y * mat->_22 + pt.y;

    return mat;
}

drMatrix33* drMatrix33Adjoint(drMatrix33* out, const drMatrix33* m)
{
    drVector3* v = (drVector3*)out;

    drVector3Cross(&v[0], (drVector3*)&m->_21, (drVector3*)&m->_31);
    drVector3Cross(&v[1], (drVector3*)&m->_31, (drVector3*)&m->_11);
    drVector3Cross(&v[2], (drVector3*)&m->_11, (drVector3*)&m->_21);

    return out;
}

drMatrix33* _drMatrix33Inverse(drMatrix33* ret, float* determinant, const drMatrix33* m)
{
    drMatrix33 mat;

    drMatrix33Adjoint(&mat, m);

    float d = drVector3Dot((drVector3*)&mat._11, (drVector3*)&m->_11);
    if(d != 0.0f)
    {
        mat /= d;
        _drMatrix33Transpose(ret, &mat);
    }

    if(determinant)
    {
        *determinant = d;
    }

    return ret;
}
// drMatrix44
///////////////////////
drMatrix44* _drMatrix44Multiply( drMatrix44* ret,const drMatrix44* m1,const drMatrix44* m2)
{
   drMatrix44 tmp;

   tmp._11 = m1->_11*m2->_11 + m1->_12*m2->_21 + m1->_13*m2->_31 + m1->_14*m2->_41;
   tmp._12 = m1->_11*m2->_12 + m1->_12*m2->_22 + m1->_13*m2->_32 + m1->_14*m2->_42;
   tmp._13 = m1->_11*m2->_13 + m1->_12*m2->_23 + m1->_13*m2->_33 + m1->_14*m2->_43;
   tmp._14 = m1->_11*m2->_14 + m1->_12*m2->_24 + m1->_13*m2->_34 + m1->_14*m2->_44;

   tmp._21 = m1->_21*m2->_11 + m1->_22*m2->_21 + m1->_23*m2->_31 + m1->_24*m2->_41;
   tmp._22 = m1->_21*m2->_12 + m1->_22*m2->_22 + m1->_23*m2->_32 + m1->_24*m2->_42;
   tmp._23 = m1->_21*m2->_13 + m1->_22*m2->_23 + m1->_23*m2->_33 + m1->_24*m2->_43;
   tmp._24 = m1->_21*m2->_14 + m1->_22*m2->_24 + m1->_23*m2->_34 + m1->_24*m2->_44;

   tmp._31 = m1->_31*m2->_11 + m1->_32*m2->_21 + m1->_33*m2->_31 + m1->_34*m2->_41;
   tmp._32 = m1->_31*m2->_12 + m1->_32*m2->_22 + m1->_33*m2->_32 + m1->_34*m2->_42;
   tmp._33 = m1->_31*m2->_13 + m1->_32*m2->_23 + m1->_33*m2->_33 + m1->_34*m2->_43;
   tmp._34 = m1->_31*m2->_14 + m1->_32*m2->_24 + m1->_33*m2->_34 + m1->_34*m2->_44;

   tmp._41 = m1->_41*m2->_11 + m1->_42*m2->_21 + m1->_43*m2->_31 + m1->_44*m2->_41;
   tmp._42 = m1->_41*m2->_12 + m1->_42*m2->_22 + m1->_43*m2->_32 + m1->_44*m2->_42;
   tmp._43 = m1->_41*m2->_13 + m1->_42*m2->_23 + m1->_43*m2->_33 + m1->_44*m2->_43;
   tmp._44 = m1->_41*m2->_14 + m1->_42*m2->_24 + m1->_43*m2->_34 + m1->_44*m2->_44;

	
	memcpy(ret, &tmp, sizeof(drMatrix44));

	return ret;

}

DR_FRONT_API drMatrix44* drMatrix44MultiplyScale(drMatrix44* ret,const drMatrix44* mat_scale,const drMatrix44* mat)
{
   ret->_11 = mat_scale->_11 * mat->_11;
   ret->_12 = mat_scale->_11 * mat->_12;
   ret->_13 = mat_scale->_11 * mat->_13;
   ret->_14 = mat_scale->_11 * mat->_14;

   ret->_21 = mat_scale->_22 * mat->_21;
   ret->_22 = mat_scale->_22 * mat->_22;
   ret->_23 = mat_scale->_22 * mat->_23;
   ret->_24 = mat_scale->_22 * mat->_24;

   ret->_31 = mat_scale->_33 * mat->_31;
   ret->_32 = mat_scale->_33 * mat->_32;
   ret->_33 = mat_scale->_33 * mat->_33;
   ret->_34 = mat_scale->_33 * mat->_34;

	
	return ret;
}

///////////////
drMatrix44* drMatrix44Translate(drMatrix44* matrix,float x,float y,float z,DWORD op)
{

   float *m = (float*)matrix->m;


   if (op == OP_MATRIX_REPLACE) {
      /* replace the working one */

      //drMatrix44Identity(matrix);
	  
      m[12] = x;
      m[13] = y;
      m[14] = z;
   }
   else if (op == OP_MATRIX_LOCAL) {
      /* post-multiply the matrix to the working one to perform
         the transformation to local coordinate system of the node */
      m[12] = x * m[0] + y * m[4] + z * m[8] + m[12];
      m[13] = x * m[1] + y * m[5] + z * m[9] + m[13];
      m[14] = x * m[2] + y * m[6] + z * m[10] + m[14];
   }
   else if (op == OP_MATRIX_GLOBAL) {
      /* post-multiply the matrix to the working one to perform
         the transformation to global coordinate system of the node */
      m[12] += x;
      m[13] += y;
      m[14] += z;
   }

   return matrix;
}


drMatrix44* drMatrix44RotateAxis(drMatrix44* matrix,DWORD axis,float angle,DWORD op)
{
	int next[3], nax1, nax2;

	float csv, snv, tmp[16], *m;


	// create next table
	next[0] = 1; next[1] = 2; next[2] = 0;

	// get the axes
	nax1 = next[axis];
	nax2 = next[nax1];

	// compute the rotation values
	csv = (float) cos(angle);
	snv = (float) sin(angle);

	// get the working transformation matrix
	m = (float*)matrix->m;

	if (op == OP_MATRIX_REPLACE) {
		// replace the working one
		//drMatrix44Identity(matrix);

		m[4*nax1+nax1] = csv;
		m[4*nax2+nax2] = csv;
		m[4*nax1+nax2] = -snv;
		m[4*nax2+nax1] = snv;
	}
	else {
		// form the rotation matrix
		drMatrix44Identity((drMatrix44*)tmp);
		tmp[4*nax1+nax1] = csv;
		tmp[4*nax2+nax2] = csv;
		tmp[4*nax1+nax2] = -snv;
		tmp[4*nax2+nax1] = snv;

		if (op == OP_MATRIX_LOCAL) {
			// post-multiply the matrix to the working one to perform
			// the transformation to local coordinate system of the node
			drMatrix44Multiply(matrix,(drMatrix44*)tmp,matrix);
		}
		else if (op == OP_MATRIX_GLOBAL) {
			// post-multiply the matrix to the working one to perform
			// the transformation to global coordinate system of the node
			drMatrix44Multiply(matrix, matrix,(drMatrix44*)tmp);
		}
	}

	return matrix;

}


drMatrix44* drMatrix44Scale(drMatrix44* matrix,float x,float y,float z,DWORD op)
{
	float *m, tmp[16];

	m = (float*)matrix->m;

	if( op == OP_MATRIX_REPLACE ) {
		// replace the working one
		//drMatrix44Identity((drMatrix44*)m);
		m[0] = x;
		m[5] = y;
		m[10] = z;
	}
	else {
		// setup the matrix
		drMatrix44Identity((drMatrix44*)tmp);
		tmp[0] = x;
		tmp[5] = y;
		tmp[10] = z;

		if (op == OP_MATRIX_LOCAL) {

			// pre-multiply the matrix to the working one to perform
			// the transformation to local coordinate system of the node
			drMatrix44Multiply(matrix,(drMatrix44*)tmp,matrix);
		}
		else if (op == OP_MATRIX_GLOBAL) {
			// post-multiply the matrix to the working one to perform
			// the transformation to global coordinate system of the node
			drMatrix44Multiply(matrix,matrix,(drMatrix44*)tmp);
		}
	}

	return matrix;
}


drMatrix43* drMatrix43MetathesisYZ( drMatrix43* mat_lh, const drMatrix43* mat_rh )
{
	drMatrix43 mat( mat_rh->_11, mat_rh->_13, mat_rh->_12,
					mat_rh->_31, mat_rh->_33, mat_rh->_32,
					mat_rh->_21, mat_rh->_23, mat_rh->_22,
					mat_rh->_41, mat_rh->_43, mat_rh->_42 );

	memcpy( mat_lh, &mat, sizeof(drMatrix43) );

	return mat_lh;
}

drMatrix43* drMatrix43MetathesisLightEngine( drMatrix43* dst, const drMatrix43* src )
{
	drMatrix43 mat( src->_11,-src->_13, src->_12,
				   -src->_31, src->_33,-src->_32,
					src->_21,-src->_23, src->_22,
					src->_41,-src->_43, src->_42 );

	memcpy( dst, &mat, sizeof(drMatrix43) );

	return dst;
}

drMatrix44* drMatrix44MetathesisYZ( drMatrix44* mat_lh, const drMatrix44* mat_rh )
{
	drMatrix44 mat( mat_rh->_11, mat_rh->_13, mat_rh->_12, mat_rh->_14,
					mat_rh->_31, mat_rh->_33, mat_rh->_32, mat_rh->_24,
					mat_rh->_21, mat_rh->_23, mat_rh->_22, mat_rh->_34,
					mat_rh->_41, mat_rh->_43, mat_rh->_42, mat_rh->_44 );

	memcpy( mat_lh, &mat, sizeof(drMatrix44) );

	return mat_lh;
}

drMatrix44* drMatrix44MetathesisLightEngine( drMatrix44* dst, const drMatrix44* src )
{
	drMatrix44 mat( src->_11,-src->_13, src->_12, src->_14,
				   -src->_31, src->_33,-src->_32, src->_24,
					src->_21,-src->_23, src->_22, src->_34,
					src->_41,-src->_43, src->_42, src->_44 );

	memcpy( dst, &mat, sizeof(drMatrix44) );

	return dst;
}

drMatrix44* drMatrix44Compose(drMatrix44* matrix,const drVector3* pos,const drVector3* face,const drVector3* up)
{
	// identity
	drMatrix44Identity(matrix);

	// get right vector
	drVector3Cross((drVector3*)(&matrix->m[0][0]),up,face);

	// up vector
	matrix->m[1][0] = up->x;
	matrix->m[1][1] = up->y;
	matrix->m[1][2] = up->z;

	// face vector
	matrix->m[2][0] = face->x;
	matrix->m[2][1] = face->y;
	matrix->m[2][2] = face->z;

	// position
	matrix->m[3][0] = pos->x;
	matrix->m[3][1] = pos->y;
	matrix->m[3][2] = pos->z;


	return matrix;
}


inline float MINOR(const drMatrix44& m, const int r0, const int r1, const int r2, const int c0, const int c1, const int c2)
{
   return m(r0,c0) * (m(r1,c1) * m(r2,c2) - m(r2,c1) * m(r1,c2)) -
          m(r0,c1) * (m(r1,c0) * m(r2,c2) - m(r2,c0) * m(r1,c2)) +
          m(r0,c2) * (m(r1,c0) * m(r2,c1) - m(r2,c0) * m(r1,c1));
}


drMatrix44 Adjoint(const drMatrix44* m)
{
   return drMatrix44( MINOR(*m, 1, 2, 3, 1, 2, 3),
                   -MINOR(*m, 0, 2, 3, 1, 2, 3),
                    MINOR(*m, 0, 1, 3, 1, 2, 3),
                   -MINOR(*m, 0, 1, 2, 1, 2, 3),

                   -MINOR(*m, 1, 2, 3, 0, 2, 3),
                    MINOR(*m, 0, 2, 3, 0, 2, 3),
                   -MINOR(*m, 0, 1, 3, 0, 2, 3),
                    MINOR(*m, 0, 1, 2, 0, 2, 3),

                    MINOR(*m, 1, 2, 3, 0, 1, 3),
                   -MINOR(*m, 0, 2, 3, 0, 1, 3),
                    MINOR(*m, 0, 1, 3, 0, 1, 3),
                   -MINOR(*m, 0, 1, 2, 0, 1, 3),

                   -MINOR(*m, 1, 2, 3, 0, 1, 2),
                    MINOR(*m, 0, 2, 3, 0, 1, 2),
                   -MINOR(*m, 0, 1, 3, 0, 1, 2),
                    MINOR(*m, 0, 1, 2, 0, 1, 2));
}


inline float Determinant(const drMatrix44* m)
{
	return m->_11 * MINOR(*m, 1, 2, 3, 1, 2, 3) -
		   m->_12 * MINOR(*m, 1, 2, 3, 0, 2, 3) +
		   m->_13 * MINOR(*m, 1, 2, 3, 0, 1, 3) -
		   m->_14 * MINOR(*m, 1, 2, 3, 0, 1, 2);
}

drMatrix44* _drMatrix44Inverse(drMatrix44* ret, float* determinant, const drMatrix44* m)
{
   //*ret = Adjoint(m);
   //return drMatrix44Scale(ret, 1.0f / Determinant(m) );
	
    float d = Determinant( m );
	*ret = (1.0f / d) * Adjoint(m);
    if( determinant )
    {
        *determinant = d;
    }
	return ret;
}

drMatrix44* _drMatrix44InverseNoScaleFactor(drMatrix44* ret,const drMatrix44* m)
{
	drMatrix44 tmp( *m );

	ret->m[0][0] = tmp.m[0][0];
	ret->m[1][0] = tmp.m[0][1];
	ret->m[2][0] = tmp.m[0][2];
	
	ret->m[0][1] = tmp.m[1][0];
	ret->m[1][1] = tmp.m[1][1];
	ret->m[2][1] = tmp.m[1][2];

	ret->m[0][2] = tmp.m[2][0];
	ret->m[1][2] = tmp.m[2][1];
	ret->m[2][2] = tmp.m[2][2];

	ret->m[3][0] = -drVector3Dot((const drVector3*)&tmp.m[0][0],(const drVector3*)&tmp.m[3][0]);
	ret->m[3][1] = -drVector3Dot((const drVector3*)&tmp.m[1][0],(const drVector3*)&tmp.m[3][0]);
	ret->m[3][2] = -drVector3Dot((const drVector3*)&tmp.m[2][0],(const drVector3*)&tmp.m[3][0]);

	ret->m[0][3] = 0.0f;
	ret->m[1][3] = 0.0f;
	ret->m[2][3] = 0.0f;
	ret->m[3][3] = 1.0f;

	return ret;

}


drMatrix44* _drMatrix44Transpose( drMatrix44* ret, const drMatrix44* m )
{
    drMatrix44 tmp( *m );

	tmp._12 = m->_21;
    tmp._21 = m->_12;

	tmp._13 = m->_31;
	tmp._31 = m->_13;

	tmp._14 = m->_41;
	tmp._41 = m->_14;

	tmp._23 = m->_32;
	tmp._32 = m->_23;

	tmp._24 = m->_42;
	tmp._42 = m->_24;

	tmp._34 = m->_43;
	tmp._43 = m->_34;


    *ret = tmp;

	return ret;
}

drMatrix44* drMatrix44Adjoint(drMatrix44* out, const drMatrix44* m)
{
    *out = Adjoint(m);

    return out;
}

drVector3* drVec3Mat44Mul(drVector3* vec,const drMatrix44* mat)
{
    drVector3 v(*vec);

	v[0] = vec->x*mat->_11 + vec->y*mat->_21 + vec->z*mat->_31 + mat->_41;
    v[1] = vec->x*mat->_12 + vec->y*mat->_22 + vec->z*mat->_32 + mat->_42;
    v[2] = vec->x*mat->_13 + vec->y*mat->_23 + vec->z*mat->_33 + mat->_43;

    *vec = v;
	return vec;
}

drVector3* drVec3Mat44MulNormal(drVector3* vec,const drMatrix44* mat)
{
    drVector3 v(*vec);

	v[0] = vec->x*mat->_11 + vec->y*mat->_21 + vec->z*mat->_31;
    v[1] = vec->x*mat->_12 + vec->y*mat->_22 + vec->z*mat->_32;
    v[2] = vec->x*mat->_13 + vec->y*mat->_23 + vec->z*mat->_33;

    *vec = v;
	return vec;
}

drMatrix44* drMat44ReflectWithPoint( drMatrix44* mat, const drVector3* pt )
{
    // Mt(-pt) * Mt( -1 ) * Mt( pt )

    *mat = drMatrix44( -1.0f,  0.0f,  0.0f,  0.0f,
                        0.0f, -1.0f,  0.0f,  0.0f,
                        0.0f,  0.0f, -1.0f,  0.0f,
                        2 * pt->x, 2 * pt->y, 2 * pt->z, 1.0f );
    return mat;
}

drMatrix44* drMat44ReflectWithAxis( drMatrix44* mat, const drVector3* axis )
{
    // quaternion rotate axis with 180 degree
    //drQuaternion quat = { axis->x, axis->y, axis->z, 0.0f };
    drQuaternion quat;
    quat.x = axis->x;
    quat.y = axis->y;
    quat.z = axis->z;
    quat.w = 0.0f;

    return drQuaternionToMatrix44( mat, &quat );
}

drMatrix44* drMat44ReflectWithPlane( drMatrix44* mat, const drPlane* p )
{
    *mat = drMatrix44( -2 * p->a * p->a + 1,  -2 * p->b * p->a,     -2 * p->c * p->a,       0,
                       -2 * p->a * p->b,      -2 * p->b * p->b + 1, -2 * p->c * p->b,       0,
                       -2 * p->a * p->c,      -2 * p->b * p->c,     -2 * p->c * p->c + 1,   0,
                       -2 * p->a * p->d,      -2 * p->b * p->d,     -2 * p->c * p->d,       1.0f );
    return mat;
}
drMatrix44* drMat44Slerp( drMatrix44* ret, const drMatrix44* m1, const drMatrix44* m2, float v )
{
    if( v == 0.0f )
    {
        *ret = *m1;
    }
    else if( v == 1.0f )
    {
        *ret = *m2;
    }
    else
    {
        float u = 1.0f - v;
        // use linear interpolate    
        for(int i = 0; i < 16; i++)
        {
            (*ret)[i] = u * (*m1)[i] + v * (*m2)[i];
        }
    }

    return ret;
}

drMatrix44* drMatrix44Slerp(const drVector3* p0, const drVector3* p1, const drVector3* s0, const drVector3* s1, const drQuaternion* r0, const drQuaternion* r1, float t, drMatrix44* mat)
{
    const float e = 1e-5f;

    drVector3 p;
    drVector3 s;
    drQuaternion r;
    drMatrix44 m;

    if(mat == 0)
        goto __ret;

    drMatrix44Identity(mat);

    if(r0 && r1)
    {
        drQuaternionSlerp(&r, r0, r1, t);
        drQuaternionToMatrix44(mat, &r);
    }

    if(s0 && s1)
    {
        drVector3Slerp(&s, s0, s1, t);

        if(!drFloatEqual(s.x, 1.0f, e)
            || !drFloatEqual(s.y, 1.0f, e)
            || !drFloatEqual(s.z, 1.0f, e))
        {
            m = drMatrix44Scale(s);
            drMatrix44Multiply(mat, &m, mat);
        }
    }

    if(p0 && p1)
    {
        drVector3Slerp(&p, p0, p1, t);
        mat->_41 = p.x;
        mat->_42 = p.y;
        mat->_43 = p.z;
    }

__ret:
    return mat;
}

drMatrix44* drMatrix44Slerp(const drMatrix44* m0, const drMatrix44* m1, float t, drMatrix44* mat)
{
    const float e = 1e-5f;

    drVector3 p0, p1;
    drVector3 s0, s1;
    drQuaternion r0, r1;

    if(mat == 0 || m0 == 0 || m1 == 0)
        return 0;

    if(drFloatEqual(t, 0.0f, e))
    {
        *mat = *m0;
    }
    else if(drFloatEqual(t, 1.0f, e))
    {
        *mat = *m1;
    }
    else
    {
        drMatrix44ConvertPRS(m0, &p0, &r0, &s0);
        drMatrix44ConvertPRS(m1, &p1, &r1, &s1);

        drMatrix44Slerp(&p0, &p1, &s0, &s1, &r0, &r1, t, mat);
    }

    return mat;
}

DR_RESULT drMatrix44ConvertPRS(const drMatrix44* mat, drVector3* pos, drQuaternion* rotation, drVector3* scale)
{
    const float e = 1e-5f;
    drVector3 s;
    drMatrix44 m, m0;

    if(mat == 0)
        return DR_RET_FAILED;
    
    if(pos)
    {
        pos->x = mat->_41;
        pos->y = mat->_42;
        pos->z = mat->_43;
    }

    if(rotation || scale)
    {
        s.x = drVector3Magnitude((drVector3*)&mat->_11);
        s.y = drVector3Magnitude((drVector3*)&mat->_21);
        s.z = drVector3Magnitude((drVector3*)&mat->_31);
    }

    if(scale)
    {
        *scale = s;
    }

    if(rotation)
    {
        if(drFloatEqual(s.x, 1.0f, e) 
            && drFloatEqual(s.y, 1.0f, e)
            && drFloatEqual(s.z, 1.0f, e))
        {
            drMatrix44ToQuaternion(rotation, mat);
        }
        else
        {
            m0 = drMatrix44Scale(1.0f/s.x, 1.0f/s.y, 1.0f/s.z);
            drMatrix44Multiply(&m, &m0, mat);
            drMatrix44ToQuaternion(rotation, &m);
        }
    }

    
    return DR_RET_OK;
}

drVector3* drGetTriangleNormal( drVector3* n,const drVector3* v0,const drVector3* v1,const drVector3* v2 )
{
	drVector3Cross( n, &drVector3( *v1 - *v0 ), &drVector3( *v2 - *v0 ) );
	drVector3Normalize( n );
	return n;
}

// for triangle
int drCheckVectorInTriangle2D(const drVector2* vp,const drVector2* v1,const drVector2* v2,const drVector2* v3)
{

#if 1
	drVector2 vec_1, vec_2, vec_3;

	drVec2Sub(&vec_1,v1,vp);
	drVec2Sub(&vec_2,v2,vp);
	drVec2Sub(&vec_3,v3,vp);

    float vz1 = drVec2Cross(&vec_1,&vec_2);
    float vz2 = drVec2Cross(&vec_2,&vec_3);
    float vz3 = drVec2Cross(&vec_3,&vec_1);

	// if the vp is on the side of triangle then return 0
    if( (vz1<0.0f && vz2<0.0f && vz3<0.0f) || (vz1>0.0f && vz2>0.0f && vz3>0.0f) )
        return 1;
    else
        return 0;
#else
	drVector2 vec_1, vec_2, vec_3, vec_4, vec_5;

	drVec2Sub( &vec_1, vp, v1 );
	drVec2Sub( &vec_2, vp, v2 );
	drVec2Sub( &vec_3, v2, v1 );
	drVec2Sub( &vec_4, v3, v1 );
	drVec2Sub( &vec_5, v3, v2 );

	float s = drVec2Cross( &vec_3, &vec_4 );
	float p1 = drVec2Cross( &vec_1, &vec_3 );
	float p2 = drVec2Cross( &vec_1, &vec_4 );
	float p3 = drVec2Cross( &vec_2, &vec_5 );

	return drFloatEqual( fabsf(s) , fabsf(p1) + fabsf(p2) + fabsf(p3) );
	

#endif

}
int drCheckVectorInTriangle2D2(int* flag,const drVector2* vp,const drVector2* v1,const drVector2* v2,const drVector2* v3)
{
    float vz1,vz2,vz3;
	drVector2 vec_1, vec_2, vec_3;

	drVec2Sub(&vec_1,v1,vp);
	drVec2Sub(&vec_2,v2,vp);
	drVec2Sub(&vec_3,v3,vp);

	if( *vp == *v1 ) {		
		*flag = 0; // 点重合
		return 3;
	}
	else if( *vp == *v2 ) {
		*flag = 1;
		return 3;
	}
	else if( *vp == *v3 ) {
		*flag = 2;
		return 3;
	}

    vz1 = drVec2Cross(&vec_1,&vec_2);
    vz2 = drVec2Cross(&vec_2,&vec_3);
    vz3 = drVec2Cross(&vec_3,&vec_1);

    const float esp = 1e-3f;
	if( drFloatZero(vz1,esp) )  {
		if( drVec2Dot( &vec_1, &vec_2 ) > 0 )
			return 0;
		*flag = 0; // 边重合
		return 2;
	}
	else if( drFloatZero(vz2,esp) ) {
		if( drVec2Dot( &vec_2, &vec_3 ) > 0 )
			return 0;
		*flag = 1;
		return 2;
	}
	else if( drFloatZero(vz3,esp) ) {
		if( drVec2Dot( &vec_3, &vec_1 ) > 0 )
			return 0;
		*flag = 2;
		return 2;
	}

	if( (vz1<0.0f && vz2<0.0f && vz3<0.0f) || (vz1>0.0f && vz2>0.0f && vz3>0.0f) ) {		 
        return 1;// 里面
	}
    else
        return 0;

}
/////////
/////////////////
drQuaternion* drMatrix44ToQuaternion(drQuaternion* quat,const drMatrix44* matrix)
{
    float  tr, s, q[4];
    int    i, j, k;

    int nxt[3] = {1, 2, 0};


    tr = matrix->m[0][0] + matrix->m[1][1] + matrix->m[2][2];


    // check the diagonal
    if ( tr > 0.0f ) {
        s = (float)sqrt(tr + 1.0f);
        quat->w = s / 2.0f;
        s = 0.5f / s;
        quat->x = (matrix->m[1][2] - matrix->m[2][1]) * s;
        quat->y = (matrix->m[2][0] - matrix->m[0][2]) * s;
        quat->z = (matrix->m[0][1] - matrix->m[1][0]) * s;
    } 
    else {		
        // diagonal is negative
        i = 0;
        if (matrix->m[1][1] > matrix->m[0][0]) i = 1;
        if (matrix->m[2][2] > matrix->m[i][i]) i = 2;
        j = nxt[i];
        k = nxt[j];


        s = (float)sqrt( (matrix->m[i][i] - (matrix->m[j][j] + matrix->m[k][k])) + 1.0f );

        q[i] = s * 0.5f;

        if( s != 0.0f )
            s = 0.5f / s;


        q[3] = (matrix->m[j][k] - matrix->m[k][j]) * s;
        q[j] = (matrix->m[i][j] + matrix->m[j][i]) * s;
        q[k] = (matrix->m[i][k] + matrix->m[k][i]) * s;


        quat->x = q[0];
        quat->y = q[1];
        quat->z = q[2];
        quat->w = q[3];
    }

    return quat;
}

//drQuaternion* drMatrix44ToQuaternionLH(drQuaternion* quat,const drMatrix44* matrix)
//{
//    drMatrix44ToQuaternionRH(quat,matrix);
//    quat->x = - quat->x;
//    quat->y = - quat->y;
//    quat->z = - quat->z;
//
//    return quat;
//}
//
drMatrix44* drQuaternionToMatrix44(drMatrix44* matrix,drQuaternion* quat)
{
    float wx, wy, wz, xx, yy, yz, xy, xz, zz, x2, y2, z2;

    // calculate coefficients
    x2 = quat->x + quat->x; 
    y2 = quat->y + quat->y; 
    z2 = quat->z + quat->z;

    xx = quat->x * x2;   
    xy = quat->x * y2;   
    xz = quat->x * z2;

    yy = quat->y * y2;   
    yz = quat->y * z2;   
    zz = quat->z * z2;

    wx = quat->w * x2;   
    wy = quat->w * y2;   
    wz = quat->w * z2;


    matrix->m[0][0] = 1.0f - (yy + zz); 	
    matrix->m[0][1] = xy + wz;
    matrix->m[0][2] = xz - wy;		
    matrix->m[0][3] = 0.0;

    matrix->m[1][0] = xy - wz;		
    matrix->m[1][1] = 1.0f - (xx + zz);
    matrix->m[1][2] = yz + wx;		
    matrix->m[1][3] = 0.0f;


    matrix->m[2][0] = xz + wy;		
    matrix->m[2][1] = yz - wx;
    matrix->m[2][2] = 1.0f - (xx + yy);		
    matrix->m[2][3] = 0.0f;


    matrix->m[3][0] = 0;			
    matrix->m[3][1] = 0;
    matrix->m[3][2] = 0;			
    matrix->m[3][3] = 1.0f;

    return matrix;
}
drMatrix44* drQuaternionToMatrix44Inv(drMatrix44* matrix,drQuaternion* quat)
{
    drQuaternion q;
    q.x = - quat->x;
    q.y = - quat->y;
    q.z = - quat->z;
    q.w = quat->w;
    return drQuaternionToMatrix44(matrix,&q);

}

drQuaternion* drEulerAngleToQuaternion(drQuaternion* quat,float roll,float pitch,float yaw)
{
    float cr, cp, cy, sr, sp, sy, cpcy, spsy;


    // calculate trig identities
    cr = cosf(roll/2);

    cp = cosf(pitch/2);
    cy = cosf(yaw/2);


    sr = sinf(roll/2);
    sp = sinf(pitch/2);
    sy = sinf(yaw/2);

    cpcy = cp * cy;
    spsy = sp * sy;


    quat->w = cr * cpcy + sr * spsy;
    quat->x = sr * cpcy - cr * spsy;
    quat->y = cr * sp * cy + sr * cp * sy;
    quat->z = cr * cp * sy - sr * sp * cy;

    return quat;
}
//drQuaternion* drEulerAngleToQuaternionLH(drQuaternion* quat,float roll,float pitch,float yaw)
//{
//    drEulerAngleToQuaternionRH(quat,roll,pitch,yaw);
//    quat->x = - quat->x;
//    quat->y = - quat->y;
//    quat->z = - quat->z;
//
//    return quat;
//}
drQuaternion* _drQuaternionMultiply( drQuaternion* ret, const drQuaternion* q1, const drQuaternion* q2 )
{

    float A, B, C, D, E, F, G, H;


    A = (q1->w + q1->x) * (q2->w + q2->x);
    B = (q1->z - q1->y) * (q2->y - q2->z);
    C = (q1->w - q1->x) * (q2->y + q2->z); 
    D = (q1->y + q1->z) * (q2->w - q2->x);
    E = (q1->x + q1->z) * (q2->x + q2->y);
    F = (q1->x - q1->z) * (q2->x - q2->y);
    G = (q1->w + q1->y) * (q2->w - q2->z);
    H = (q1->w - q1->y) * (q2->w + q2->z);


    ret->w = B + (-E - F + G + H) / 2;
    ret->x = A - (E + F + G + H) / 2; 
    ret->y = C + (E - F + G - H) / 2; 
    ret->z = D + (E - F - G + H) / 2;

    return ret;
}

drQuaternion* drQuaternionSlerp(drQuaternion* res, const drQuaternion* from, const drQuaternion* to, float t)
{
    float           to1[4];
    double        omega, cosom, sinom, scale0, scale1;


    // calc cosine
    cosom = from->x * to->x 
        + from->y * to->y 
        + from->z * to->z
        + from->w * to->w;


    // adjust signs (if necessary)
    if ( cosom <0.0f ) { 
        cosom = -cosom; 
        to1[0] = - to->x;
        to1[1] = - to->y;
        to1[2] = - to->z;
        to1[3] = - to->w;
    } 
    else {
        to1[0] = to->x;
        to1[1] = to->y;
        to1[2] = to->z;
        to1[3] = to->w;
    }


    // calculate coefficients


    if ( (1.0f - cosom) > 0.001f/*DELTA*/ ) {
        // standard case (slerp)
        omega = acos(cosom);
        sinom = sin(omega);
        scale0 = sin((1.0f - t) * omega) / sinom;
        scale1 = sin(t * omega) / sinom;


    } else {        
        // "from" and "to" quaternions are very close 
        //  ... so we can do a linear interpolation
        scale0 = 1.0f - t;
        scale1 = t;
    }

    // calculate final values
    res->x = (float)(scale0 * from->x + scale1 * to1[0]);
    res->y = (float)(scale0 * from->y + scale1 * to1[1]);
    res->z = (float)(scale0 * from->z + scale1 * to1[2]);
    res->w = (float)(scale0 * from->w + scale1 * to1[3]);

    return res;
}


drQuaternion* drQuaternionRotationAxis( drQuaternion* quat, const drVector3* std_axis, float angle )
{
    float cosv = cosf( angle * 0.5f );
    float sinv = sinf( angle * 0.5f );

    quat->w = cosv;
    quat->x = std_axis->x * sinv;
    quat->y = std_axis->y * sinv;
    quat->z = std_axis->z * sinv;


    return quat;
}

void drQuaternionToAxisAngle( drVector3* axis, float* angle, const drQuaternion* quat )
{
    float acosv = acosf( quat->w );
    float count_sinv = 1.0f / sqrtf( 1.0f - quat->w * quat->w );

    axis->x = quat->x * count_sinv;
    axis->y = quat->y * count_sinv;
    axis->z = quat->z * count_sinv;

    *angle = acosv * 2.0f;
}

// s: s->x: longitude, s->y: latitude, s->z: angle
drQuaternion* drQuaternionRotationSpherical( drQuaternion* quat, float longitude, float latitude, float angle )
{
    float sin_a = sinf( angle * 0.5f );
    float cos_a = sqrtf( 1.0f - sin_a * sin_a );
    float sin_lat = sinf( latitude );
    float cos_lat = sqrtf( 1.0f - sin_lat * sin_lat );
    float sin_long = sinf( longitude );
    float cos_long = sqrtf( 1.0f - sin_long * sin_long );

    quat->x = sin_a * sin_lat * cos_long;
    quat->y = sin_a * cos_lat;
    quat->z = sin_a * sin_lat * sin_long;
    quat->w = cos_a;

    return quat;
}

drVector3* drVector3Transform(drVector3* out, const drVector3* v, const drQuaternion* nrm_q)
{
    // normalize N(q) = 
    // conjugate q* = [-v, w];
    // inverse q^ = q* / N(q);
    drQuaternion inv_q(-nrm_q->x, -nrm_q->y, -nrm_q->z, nrm_q->w);
    drQuaternion vec_q(v->x, v->y, v->z, 0);
    drQuaternion t;

    drQuaternionMultiply(&t, nrm_q, &vec_q);
    drQuaternionMultiply(&t, &t, &inv_q);

    out->x = t.x;
    out->y = t.y;
    out->z = t.z;

    return out;
}
drVector3* drVector3Transform(drVector3* out, const drVector3* v, const drVector3* nrm_axis, float angle)
{
    //
    float cosv = cosf(angle);
    float sinv = sinf(angle);
    float d = drVector3Dot(v, nrm_axis);
    drVector3 c;
    drVector3Cross(&c, nrm_axis, v);

    *out = cosv * (*v) + (1-cosv) * d * (*nrm_axis) + sinv * c;

    return out;
}
DR_FRONT_API drVector3* drVector3Transform(drVector3* out, const drVector3* v, const drMatrix44* mat)
{

	out->x = v->x * mat->_11 + v->y * mat->_21 + v->z * mat->_31 + mat->_41;
    out->y = v->x * mat->_12 + v->y * mat->_22 + v->z * mat->_32 + mat->_42;
    out->z = v->x * mat->_13 + v->y * mat->_23 + v->z * mat->_33 + mat->_43;

	return out;
}

drVector3* drVector3RotateAxisAngle(drVector3* out, const drVector3* v, const drVector3* axis_v0, const drVector3* axis_v1, float angle)
{
    // offset to origion coord
    drVector3 o_axis(*axis_v1 - *axis_v0);
    drVector3 o_v(*v - *axis_v0);

    drVector3Normalize(&o_axis);
    drVector3Transform(out, &o_v, &o_axis, angle);
    // revert
    drVector3Add(out, axis_v0);

    return out;
}

// ---------------------
// drPlane
// ---------------------
drPlane* WINAPI drPlaneNormalize(drPlane *p_out, const drPlane *p)
{
    float m = drVector3Magnitude((drVector3*)&p->a);
    m = 1.0f / m;
    p_out->a = p->a * m;
    p_out->b = p->b * m;
    p_out->c = p->c * m;
    p_out->d = p->d * m;
    return p_out;
}

// Find the intersection between a plane and a line.  If the line is
// parallel to the plane, NULL is returned.
drVector3* WINAPI drPlaneIntersectLine(drVector3 *p_out, const drPlane *p, const drVector3 *v1, const drVector3 *v2)
{
    return NULL;
}
// Construct a plane from a point and a normal
drPlane* WINAPI drPlaneFromPointNormal(drPlane *p_out, const drVector3 *v, const drVector3 *n)
{
    p_out->a = n->x;
    p_out->b = n->y;
    p_out->c = n->z;
    p_out->d = -drVector3Dot(v, n);
    return p_out;
}

// Construct a plane from 3 points
drPlane* WINAPI drPlaneFromPoints(drPlane *p_out, const drVector3 *v1, const drVector3 *v2, const drVector3 *v3)
{
    drVector3 normal;
    drVector3 p1 = *v2 - *v1;
    drVector3 p2 = *v3 - *v1;
    drVector3Cross(&normal, &p1, &p2);
    drVector3Normalize(&normal);
    return drPlaneFromPointNormal(p_out, v1, &normal);
}

DWORD WINAPI drPlaneClassifyBox(const drPlane* p, const drBox* b)
{
    DWORD id = 0;
    DWORD nor_tab[3] = { 0x01, 0x02, 0x04 }; // x, y, z mask
    DWORD axis_tab[8][2] =
    {
        {0x000, 0x111}, // ---
        {0x100, 0x011}, // +--
        {0x010, 0x101}, // -+-
        {0x110, 0x001}, // ++-

        {0x001, 0x110}, // --+
        {0x101, 0x010}, // +-+
        {0x011, 0x100}, // -++
        {0x111, 0x000}, // +++
    };

    if(p->a >= 0.0f)
        id |= nor_tab[0];

    if(p->b >= 0.0f)
        id |= nor_tab[1];

    if(p->c >= 0.0f)
        id |= nor_tab[2];

    drVector3 v;

    b->GetPointWithMask(&v, axis_tab[id][0]);
    if(drPlaneClassifyVertex(p, &v) == PLANE_BACK_SIDE)
        return PLANE_BACK_SIDE;

    b->GetPointWithMask(&v, axis_tab[id][1]);
    if(drPlaneClassifyVertex(p, &v) == PLANE_FRONT_SIDE)
        return PLANE_FRONT_SIDE;

    return PLANE_ON_SIDE;
}

DWORD WINAPI drPlaneClassifyBox(const drPlane* p, const drBox* b, const drMatrix44* b_mat)
{
    drVector3 p_n = drVector3(p->a, p->b, p->c);
    drVector3 p_p = drVector3(0.0f, 0.0f, -p->d / p->c);

    drPlane inv_p;
    drMatrix44 inv_mat;
    drMatrix44Inverse(&inv_mat, NULL, b_mat);

    drVec3Mat44Mul(&p_p, &inv_mat);
    drVec3Mat44MulNormal(&p_n, &inv_mat);
    
    drPlaneFromPointNormal(&inv_p, &p_p, &p_n);

    return drPlaneClassifyBox(&inv_p, b);
}

int drCheckVectorInBox( const drVector3* v, const drBox* b )
{
    if((v->x < (b->c.x - b->r.x)) || (v->x > (b->c.x + b->r.x)))
        return 0;
    if((v->y < (b->c.y - b->r.y)) || (v->y > (b->c.y + b->r.y)))
        return 0;
    if((v->z < (b->c.z - b->r.z)) || (v->z > (b->c.z + b->r.z)))
        return 0;

    return 1;
}

int drCheckVectorInBox( const drVector3* v, const drBox* b, const drMatrix44* mat_box )
{
    drMatrix44 mat_inv;
    drMatrix44InverseNoScaleFactor( &mat_inv, mat_box );

    drVector3 v_inv( *v );
    drVec3Mat44Mul( &v_inv, &mat_inv );

    return drCheckVectorInBox( &v_inv, b );

}

int drIntersectBoxBoxAABB( const drBox* b1, const drBox* b2 )
{
    drVector3 s1 = b1->c - b1->r;
	drVector3 s2 = b1->c + b1->r;
	drVector3 d1 = b2->c - b2->r;
	drVector3 d2 = b2->c + b2->r;

    return ( max(s1.x,d1.x) <= min(s2.x,d2.x)
          && max(s1.y,d1.y) <= min(s2.y,d2.y)
          && max(s1.z,d1.z) <= min(s2.z,d2.z) );
}
int drIntersectBoxBoxOBB( const drBox* b1, const drBox* b2, const drMatrix44* mat )
{
    //方法一 先分别做3个面的投影判断，最后做内法线判断
    //方法二 得到中心点连线向量，判断该向量和box的half_size的关系
    //drVector3 b_cen( b.GetCenter() );
    //drVec3Mat44Mul( &b_cen, mat );
    //drVector3 vec_cen;
    //drVector3Sub( &vec_cen, &b_cen, &GetCenter() );

    //drVector3 ea = 0.5f * GetSize();
    //drVector3 eb = 0.5f * b.GetSize();

    //for( int i = 0; i < 3; i++ ) {
    //    float ro = fabsf( vec_cen[i] );
    //    drVector3 vv( fabsf(mat->o
    //    float r1 = ea[i];
    //    float r2 = b.GetCenter()
    //}
    ////方法三 将b中的八个点乘以mat矩阵，然后判断这八个点是否在box中
    //drMatrix44 mat_inv;
    //drMatrix44Inverse( &mat_inv, mat );

    //drVector3& p( b.GetPosition() );
    //drVector3& s( b.GetSize() );


    //drVector3 pt[] = {

    //    drVector3( p.x, p.y, p.z ) ,
    //    drVector3( p.x, p.y, p.z + s.z ),
    //    drVector3( p.x + s.x, p.y, p.z + s.z ),
    //    drVector3( p.x + s.x, p.y, p.z ),

    //    drVector3( p.x, p.y + s.y, p.z ),
    //    drVector3( p.x, p.y + s.y, p.z + s.z ),
    //    drVector3( p.x + s.x, p.y + s.y, p.z + s.z ),
    //    drVector3( p.x + s.x, p.y + s.y, p.z )

    //};

    //int r = 0;

    //for( int i = 0; i < 8; i++ ) {
    //    drVec3Mat44Mul( &pt[i], mat );
    //    r += PointInBox( &pt[i] );
    //}

    //if( r == 0 ) {
    //    drVector3 cen( b.GetCenter() );
    //    drVec3Mat44Mul( &cen, &mat );
    //    if( PointInBox( &cen ) )
    //        return 1;
    //    cen = GetCenter();
    //    return 1;
    //}
    //else {
    //    return 1;
    //}

    return 1;
    
}
// vector, line equation API
//////////////////////////////////
int drIntersectLineLine2D( drVector2* v, const drVector2* u1, const drVector2* u2, const drVector2* v1, const drVector2* v2, int be_ray )
{
    float t1, t2;

    float a1, a2, b1, b2, c1, c2, d1, d2;


    a1 = (*u2)[0] - (*u1)[0];
    b1 = (*u1)[0];
    c1 = (*u2)[1] - (*u1)[1];
    d1 = (*u1)[1];

    a2 = (*v2)[0] - (*v1)[0];
    b2 = (*v1)[0];
    c2 = (*v2)[1] - (*v1)[1];
    d2 = (*v1)[1];

    // t1, t2 range [0,1]
    // l1 :  x = a1 * t1 + b1;
    //       y = c1 * t1 + d1;
    // l2 :  x = a2 * t2 + b2;
    //       y = c2 * t2 + d2;

    if( a1*c2 == a2*c1 )
		return 0;


    t2 = (b1*c1 + a1*d2 - a1*d1 - b2*c1) / (a2*c1 - a1*c2);

    if( fabsf(a1)>1e-3f )
        t1 = (a2*t2 + b2 - b1) / a1;
    else if( c1 )
        t1 = (c2*t2 + d2 - d1) / c1;
    else
        return 0;

    if( !be_ray ) {

		if( t1<0.0f || t1>1.0f || t2<0.0f || t2>1.0f )
			return 0;
    }

	if( v ) {
		v->x = a1*t1 + b1;
		v->y = c1*t1 + d1;
	}

	return 1;

}

int drIntersectLineLine3D( drVector3* v, const drVector3* u1, const drVector3* u2, const drVector3* v1, const drVector3* v2, int be_ray )
{
    int i1, i2, i3;

    drVector3 nor;
    drVector3Cross( &nor, &( drVector3( *u2 - *u1 ) ), &( drVector3( *v2 - *v1 ) ) );

    i3 = drGetVecNormalAxisMapping( &i1, &i2, &nor );

    float t1, t2;

    float a1, a2, b1, b2, c1, c2, d1, d2, e1, e2, f1, f2;


    a1 = (*u2)[i1] - (*u1)[i1];
    b1 = (*u1)[i1];
    c1 = (*u2)[i2] - (*u1)[i2];
    d1 = (*u1)[i2];
    e1 = (*u2)[i3] - (*u1)[i3];
    f1 = (*u1)[i3];

    a2 = (*v2)[i1] - (*v1)[i1];
    b2 = (*v1)[i1];
    c2 = (*v2)[i2] - (*v1)[i2];
    d2 = (*v1)[i2];
    e2 = (*v2)[i3] - (*v1)[i3];
    f2 = (*v1)[i3];

    // t1, t2 range [0,1]
    // l1 :  x = a1 * t1 + b1;
    //       y = c1 * t1 + d1;
    // l2 :  x = a2 * t2 + b2;
    //       y = c2 * t2 + d2;

    if( a1*c2 == a2*c1 )
		return 0;


    t2 = (b1*c1 + a1*d2 - a1*d1 - b2*c1) / (a2*c1 - a1*c2);

    //if( fabsf(a1)>1e-3f )
    //    t1 = (a2*t2 + b2 - b1) / a1;
    //else if( c1 )
    //    t1 = (c2*t2 + d2 - d1) / c1;
    //else
    //    return 0;
    if( fabsf( a1 ) > fabsf( c1 ) )
        t1 = (a2*t2 + b2 - b1) / a1;
    else 
        t1 = (c2*t2 + d2 - d1) / c1;

    if( !be_ray ) {

		if( t1<0.0f || t1>1.0f || t2<0.0f || t2>1.0f )
			return 0;
    }

    float z1 = e1 * t1 + f1;
    float z2 = e2 * t2 + f2;

    if( !drFloatEqual(z1,z2,1e-2f) )
        return 0;

	if( v ) {
		(*v)[i1] = a1*t1 + b1;
		(*v)[i2] = c1*t1 + d1;
        (*v)[i3] = e1*t1 + f1;
	}

	return 1;
}
DR_RESULT drIntersectLineRect(drVector2* o_v, int* o_n, const drVector2* u1, const drVector2* u2, const drVector2* rc_v1, const drVector2* rc_v2, int is_segment)
{
    DR_RESULT ret = DR_RET_OK;

    // line u: (u2 - u1) * t + u1
    // line rc_horizon: (rc_v2->x - rc_v1->x) * th + (rc_v1->x)
    // line rc_vertical: (rc_v2->y - rc_v1->y) * tv + (rc_v1->y)
    
    float ta, tb;
    float ux, uy, vx, vy;
    float t1, t2;
    float a, b;
    float m;
   
    int i = 0;

    ux = (u2->x - u1->x);
    uy = (u2->y - u1->y);
    vx = (rc_v2->x - rc_v1->x);
    vy = (rc_v2->y - rc_v1->y);

    // horizon intersect
    a = rc_v1->y - u1->y;
    b = rc_v2->y - u1->y;

    if(!drFloatZero(uy, 1e-3f))
    {
        ta = a / uy;

        if(is_segment && (ta < 0.0f || ta > 1.0f))
            goto __i_1;

        m = ux * ta + u1->x;
        t1 = (m - rc_v1->x) / vx;

        if(t1 >= 0.0f && t1 <= 1.0f)
        {
            if(o_v == 0)
                goto __ret_ok;

            o_v[i].x = m;
            o_v[i].y = rc_v1->y;
            i++;

            if(i >= *o_n)
                goto __ret_ok;
        }

__i_1:
        tb = b / uy;

        if(is_segment && (tb < 0.0f || tb > 1.0f))
            goto __i_2;

        m = ux * tb + u1->x;
        t2 = (m - rc_v1->x) / vx;

        if(t2 >= 0.0f && t2 <= 1.0f)
        {
            if(o_v == 0)
                goto __ret_ok;

            o_v[i].x = m;
            o_v[i].y = rc_v2->y;
            i++;

            if(i >= *o_n)
                goto __ret_ok;
        }
__i_2:
        ;
    }


    // vertical intersect

    a = rc_v1->x - u1->x;
    b = rc_v2->x - u1->x;

    if(!drFloatZero(ux, 1e-3f))
    {
        ta = a / ux;

        if(is_segment && (ta < 0.0f || ta > 1.0f))
            goto __i_3;

        m = uy * ta + u1->y;
        t1 = (m - rc_v1->y) / vy;

        if(t1 >= 0.0f && t1 <= 1.0f)
        {
            if(o_v == 0)
                goto __ret_ok;

            o_v[i].x = rc_v1->x;
            o_v[i].y = m;
            i++;

            if(i >= *o_n)
                goto __ret_ok;

        }
__i_3:
        tb = b / ux;

        if(is_segment && (tb < 0.0f || tb > 1.0f))
            goto __i_4;

        m = uy * tb + u1->y;
        t2 = (m - rc_v1->y) / vy;

        if(t2 >= 0.0f && t2 <= 1.0f)
        {
            if(o_v == 0)
                goto __ret_ok;

            o_v[i].x = rc_v2->x;
            o_v[i].y = m;
            i++;

            if(i >= *o_n)
                goto __ret_ok;
        }
__i_4:
        ;
    }

    ret = DR_RET_FAILED;
__ret_ok:
    *o_n = i;
    return ret;

}

int drGetVec3WeightWithNormal(drVector3* face,drVector3* up,const drVector3* vec,const drVector3* normal)
{
	int ret = 1;
	float cs = drVector3Dot(vec,normal);
	if( cs < 0.0f ) {
		// if the angle between vector and normal is exceed 90 degree , we set negative cos value
		//cs = -cs;
		ret = 0;
	}

	*up = *normal;
	drVector3Scale(up,cs);
	*face = *vec - *up;

	return ret;
}

int drGetVecNormalAxisMapping(int* i1,int* i2,const drVector3* vec)
{
	int t1, t2;
	int ret;
    drVector3 vn( fabsf(vec->x),fabsf(vec->y),fabsf(vec->z) );

	// 如果法向量三维坐标的某个分量的绝对值最大，我们就可以选择与该坐标轴垂直的平面作为投影平面
    if( vn.x > vn.y ) {
      if( vn.x > vn.z ) { 
		  t1 = 1; 
		  t2 = 2;
		  ret = 0;
	  }
	  else { 
		  t1 = 0; 
		  t2 = 1;
		  ret = 2;
	  }
    } 
	else {
      if( vn.y > vn.z ) { 
		  t1 = 0; 
		  t2 = 2;
		  ret = 1;
	  }
      else {
		  t1 = 0;
		  t2 = 1;
		  ret = 2;
	  }
    }

	if( i1 && i2 ) {
		*i1 = t1;
		*i2 = t2;
	}

	return ret;
}

int drCheckVectorInTriangle3D( const drVector3* v, const drVector3* v0, const drVector3* v1, const drVector3* v2, const drVector3* n )
{
	int i1, i2;

	drGetVecNormalAxisMapping( &i1, &i2, n );

	// begin 以下代码一知半解,不明白的是a,b代表的意义	
#if 1
    drVector3 p( (*v)[i1] - (*v0)[i1],
                (*v1)[i1] - (*v0)[i1],
                (*v2)[i1] - (*v0)[i1] );
    drVector3 q( (*v)[i2] - (*v0)[i2],
                (*v1)[i2] - (*v0)[i2],
                (*v2)[i2] - (*v0)[i2] );
    float a,b;
    if( p.y == 0.0f ) {
      b=p.x / p.z;
      if( b>=0.0f && b<=1.0f) 
		  a = ( q.x-b * q.z ) / q.y;
      else 
		  return 0;
    }
    else {
      b = ( q.x * p.y - p.x * q.y ) / ( q.z * p.y - p.z * q.y );
      if( b>=0.0f && b<=1.0f ) 
		  a = ( p.x - b * p.z ) / p.y;
      else 
		  return 0;
    }

    return (a>=0 && (a+b)<=1);
	// end
#else
	// begin 第二种方法
	drVector2 vh( (*v)[i1], (*v)[i2] );
	drVector2 v1( (*v0)[i1], (*v0)[i2] );
	drVector2 v2( (*v1)[i1], (*v1)[i2] );
	drVector2 v3( (*v2)[i1], (*v2)[i2] );

	return drCheckVectorInTriangle2D( &vh, &v1, &v2, &v3 );
	// end
#endif

}


///////
int drCheckVectorInTriangle3D2( int* flag, const drVector3* v, const drVector3* v0, const drVector3* v1, const drVector3* v2, const drVector3* n )
{
	// begin
	// first check vector in triangle plane
	drPlane p;
    drPlaneFromPointNormal(&p, v0, n);

	if( drFloatZero( drPlaneClassify(&p, v), 1e-3f ) == 0 )
		return 0;
	// end

	// 2d mapping
	int i1, i2;

	drGetVecNormalAxisMapping( &i1, &i2, n );
	
	drVector2 vh( (*v)[i1], (*v)[i2] );
	drVector2 va( (*v0)[i1], (*v0)[i2] );
	drVector2 vb( (*v1)[i1], (*v1)[i2] );
	drVector2 vc( (*v2)[i1], (*v2)[i2] );
	// 这儿我希望返回值中包含该点的位置信息,所以用drCheckVectorInTriangle2D2
	return drCheckVectorInTriangle2D2( flag, &vh, &va, &vb, &vc );
}


int drIntersectRayTriangle( drVector3* v, float* d, const drVector3* org,const drVector3* ray, const drTriangle* tri )
{
	float dot = drVector3Dot( &tri->n, ray );

	if( drFloatZero( dot ) )
		return 0; // parellel

	drPlane p;
    drPlaneFromPointNormal(&p, &tri->v0, &tri->n);

	float t = - drPlaneClassify(&p, org) / dot;

	if( t <= 0 )
		return 0; // ray is neg-direction

	drVector3 ip_vec;
	drVector3 rs( *ray );

	// get intersect point
	drVector3Add( &ip_vec, org, drVector3Scale( &rs, t ) );

	if( drCheckVectorInTriangle3D( &ip_vec, tri ) )  
	{
		// get output data
		if( v )
			*v = ip_vec;
		if( d )
			*d = t;

		return 1;
	}

	return 0;

}

// ret[out]: x, y
// e1,e2[in]: coefficient x, y and equation result
void drGetEquation2( float* ret, const float* e1, const float* e2 )
{
	float delta = 1.0f / ( e1[0] * e2[1] - e1[1] * e2[0] );
	float dx = e1[2] * e2[1] - e2[2] * e1[1];
	float dy = e1[0] * e2[2] - e1[2] * e2[0];
	
	ret[0] = dx * delta;
	ret[1] = dy * delta;
}

// ret[out]: x1, x2
// equation: a1 * x1 + b1 * x2 = c1
// e1: ( a1, b1, c1 ); e2: ( a2, b2, c2 )
void drGetEquation2f( float* ret, const float* e1, const float* e2 )
{
	if( e1[0] == 0.0f )
	{
		ret[0] = e1[2] / e1[1];
		ret[1] = (e2[2] - e2[1] * ret[0]) / e2[0];
	}
	else
	{
		ret[1] = (e2[0] * e1[2] - e1[0] * e2[2]) / (e2[0] * e1[1] - e1[0] * e2[1] );
		ret[0] = (e1[2] - e1[1] * ret[1]) / e1[0];
	}
}

// ret[out]: x, y, z
// e1,e2,e3[in]: coefficient x, y, z and equation result
void drGetEquation3( float* ret, const float* e1, const float* e2, const float* e3 )
{
	float d1 = e2[1] * e3[2] - e2[2] * e3[1];
	float d2 = e1[1] * e3[2] - e1[2] * e3[1];
	float d3 = e1[1] * e2[2] - e1[2] * e2[1];

	float delta = e1[0] * d1 - e2[0] * d2 + e3[0] * d3;

	float dx = e1[3] * d1 - e2[3] * d2 + e3[3] * d3;

    assert( delta != 0.0f );

	ret[0] = dx / delta;

	float q1[3] = { e1[1], e1[2], e1[3] - ret[0] * e1[0] };
	float q2[3] = { e2[1], e2[2], e2[3] - ret[0] * e2[0] };

	if( q1[0] * q2[1] == q1[1] * q2[0] ) {

		float q3[3] = { e3[1], e3[2], e3[3] - ret[0] * e3[0] };

		if( q1[0] * q3[1] == q1[1] * q3[0] ) {

			if( q2[0] * q3[1] == q2[1] * q3[0] ) {
				assert( 0 );
			}
			else {
				drGetEquation2( &ret[1], q2, q3 );
			}
		}
		else {
			drGetEquation2( &ret[1], q1, q3 );
		}
	}
	else {
		drGetEquation2( &ret[1], q1, q2 );
	}
		
	
}

// use equation paramters
// if v1 == v2 then the distance is point to point
float drGetLineOriginDistance2( const drVector2* v1, const drVector2* v2 )
{
    drVector2 k( v2->x - v1->x, v2->y - v1->y );
    float s;

    drVec2Normalize( &k );

    if( k.y != 0.0f )
    {
        s = (k.x * v1->y - k.y * v1->x) / (k.x * k.x + k.y * k.y);
    }
    else if( k.x != 0.0f )
    {
        s = v1->y / k.x;
    }
    else
    {
        // v1, v2 degenerate one point
        s = sqrtf( v1->x * v1->x + v1->y * v1->y );
    }

    return s;
}

int drIntersectRaySphere( drVector3* ret, const drSphere* sphere, const drVector3* org, const drVector3* ray )
{
    drVector3* cen = (drVector3*)&sphere->c;
    drVector3 cen_org( *cen - *org );

    float ray_dis = drVector3Dot( &cen_org, ray );

    float rd = sphere->r * sphere->r - ( drVector3Dot( &cen_org, &cen_org ) - ray_dis * ray_dis );

    if( rd < 0.0f )
        return 0;


	if( ret )
	{
        float d = sqrtf( rd );

		*ret = (*org) + ( ray_dis - d ) * (*ray);
	}

    return 1;
}

int drIntersectSphereSphere( drVector3* ret, const drSphere* s1, const drSphere* s2 )
{
    drVector3 cc = s1->c - s2->c;

    float ss = drVector3SquareMagnitude( &cc);

    float rr = s1->r + s2->r; 

    if( ss >= rr * rr )
        return 0;

    if( ret )
    {
        *ret = cc;

        drVector3Normalize( ret );
        drVector3Scale( ret, s2->r );
        drVector3Add( ret, &s2->c );
    }

    return 1;
}

float drGetDirTurnAngle( const drVector2* src_dir, const drVector2* dst_dir )
{   
    // check dir
    float dotv = drVec2Dot( src_dir, dst_dir );
    // float计算存在细微误差出现1.0000113类似情况，而在acosf(1.0000113)计算得到非法的值
    if( dotv > 1.0f )
        dotv = 1.0f;
    float acsv = acosf( dotv );

    if( drVec2Cross( src_dir, dst_dir ) < 0 )
    {
        acsv = -acsv;
    }

    return acsv;
}

void drGetLinearTransformParam( float* ret_param, const float* x_var, const float* y_var )
{
	float delta = 1.0f / (x_var[0] - x_var[1]);

	ret_param[0] = (y_var[0] - y_var[1]) * delta;
	ret_param[1] = (x_var[0] * y_var[1] - x_var[1] * y_var[0]) * delta;
}

// end namesapce lsh
DR_END

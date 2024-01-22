#pragma once

#include "TableData.h"

#define TERRAIN_TYPE_NORMAL			0
#define TERRAIN_TYPE_UNDERWATER		1
#define MAX_WATER_LOOP				30

#pragma warning(disable: 4275)

class LIGHTENGINE_API LETerrainInfo : public CRawDataInfo
{
public:
	
	LETerrainInfo()
	{
		btType		= TERRAIN_TYPE_NORMAL;
		nTextureID	= 0;
		btAttr = 0;
	}

public:	

	BYTE    btType;
	int		nTextureID;
	BYTE	btAttr;
};


class LIGHTENGINE_API LETerrainSet : public CRawDataSet
{
public:
	
	static LETerrainSet* I() { return _Instance; }

    LETerrainSet(int nIDStart, int nIDCnt)
	:CRawDataSet(nIDStart, nIDCnt)
	{
	    _Init();
        _Instance = this;

		int i;
		char szName[64];
		for(i = 0; i < MAX_WATER_LOOP; i++)
		{
			//_snprintf_s(szName, "texture/terrain/water/waterbump%04d.bmp", i);
			_snprintf_s(szName, 64 ,_TRUNCATE,"texture/terrain/water/ocean_h.%02d.bmp", i + 1);
			_nWaterBumpTexture[i] = GetTextureID(szName);
		}

		for(i = 1; i < 15; i++)
		{
			_snprintf_s(szName,64 ,_TRUNCATE, "texture/terrain/alpha/%d.tga", i);
			_nAlphaTexture[i] = GetTextureID(szName);
		}

        m_nAlphaTextureI = GetTextureID("texture/terrain/alpha/total.tga");
	}

	int GetWaterBumpTextureID(int nFrame)
	{
		return _nWaterBumpTexture[nFrame];
	}

	int GetAlphaTextureID(int nAlphaNo)
	{
		return _nAlphaTexture[nAlphaNo];
	}

    int     m_nAlphaTextureI;

    int GetIDStart() { return _nIDStart; }
    int GetIDCnt() { return _nIDCnt; }


protected:

	static LETerrainSet* _Instance; // 相当于单键, 把自己记住
    
    virtual CRawDataInfo* _CreateRawDataArray(int nIDCnt)
	{
		return new LETerrainInfo[nIDCnt];
	}
	
	virtual void _DeleteRawDataArray()
	{
		delete[] (LETerrainInfo*)_RawDataArray;
	}
	
	virtual int _GetRawDataInfoSize()
	{
		return sizeof(LETerrainInfo);
	}

	
    virtual void* _CreateNewRawData(CRawDataInfo *pInfo)
	{
        LETerrainInfo *pTerrainInfo = (LETerrainInfo*)pInfo;
	    return NULL; // pTerrainInfo;
	}

	virtual void  _DeleteRawData(CRawDataInfo *pInfo)
	{
	}
	
	virtual BOOL _ReadRawDataInfo(CRawDataInfo *pRawDataInfo, vector<string> &ParamList)
	{
        if(ParamList.size()==0) return FALSE;
		
		LETerrainInfo *pTerrainInfo = (LETerrainInfo*)pRawDataInfo;
		
		string &str = ParamList.front();

		pTerrainInfo->btType = (BYTE)(Str2Int(str));
		str = ParamList[1];
		pTerrainInfo->btAttr = (BYTE)(Str2Int(str));

	    return TRUE;
    }

	virtual void _ProcessRawDataInfo(CRawDataInfo *pRawDataInfo)
	{
		LETerrainInfo *pTerrainInfo = (LETerrainInfo*)pRawDataInfo;
		pTerrainInfo->nTextureID = GetTextureID(pTerrainInfo->szDataName);
	
//		LG("terrain", "Load Terrain [%s], ID = %d, Type = %d, Texture ID = %d\n", pTerrainInfo->szDataName, pTerrainInfo->nID, pTerrainInfo->btType, pTerrainInfo->nTextureID);
    }

protected:
	
	int		_nWaterBumpTexture[MAX_WATER_LOOP];
	int		_nAlphaTexture[40];
};

//--------------
// 快捷全局函数:
//--------------
inline LETerrainInfo* GetTerrainInfo(int nID) // 通过ID取得TerrainInfo表面
{
    return (LETerrainInfo*)LETerrainSet::I()->GetRawDataInfo(nID);
}

inline int GetTerrainTextureID(int nID)
{
	LETerrainInfo *pInfo = (LETerrainInfo*)LETerrainSet::I()->GetRawDataInfo(nID);	
	if(!pInfo) 
	{
		return 0;
	}
	return pInfo->nTextureID;
}

inline int GetWaterBumpTextureID(int nFrame)
{
	return LETerrainSet::I()->GetWaterBumpTextureID(nFrame);
}

inline int GetTerrainAlphaTextureID(int nAlphaNo)
{
	return LETerrainSet::I()->GetAlphaTextureID(nAlphaNo);
}

inline int GetTerrainAlphaTextureID_I() { return LETerrainSet::I()->m_nAlphaTextureI; }

#pragma warning(default: 4275)

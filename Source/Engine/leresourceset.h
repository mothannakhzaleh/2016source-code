#pragma once

#include "LightEngineAPI.h"
#include <TableData.h>

//如果定义了该宏资源文件将按照脚本文件加载
//#define USE_RESOURCE_SCRIPT
#define RESOURCE_SCRIPT 0		// 0-不使用资源脚本，1-资源脚本定义，2-资源脚本使用测试时， 3-正式使用资源脚本文件

#pragma warning(disable: 4275)

class LIGHTENGINE_API LEResourceInfo : public CRawDataInfo
{
public:
	enum {	// ResourceType (.Abbr RT)
		RT_PAR = 0,
		RT_PATH = 1,
		RT_EFF = 2,
		RT_MESH = 3,
		RT_TEXTURE = 4,
		RT_UNKNOWN = -1,
	};
public:

	LEResourceInfo() : m_iType(RT_UNKNOWN) {}

	int GetType() const { return m_iType; }

public:	

	int    m_iType;
};

class LIGHTENGINE_API LEResourceSet : public CRawDataSet
{
public:

	static LEResourceSet& GetInstance()
	{
		assert(m_pInstance); 
		return *m_pInstance; 
	}

	static LEResourceSet* GetInstancePtr()
	{
		return m_pInstance; 
	}

	static LEResourceSet* m_pInstance; // 相当于单键, 把自己记住

public:
	LEResourceSet(int nIDStart, int nIDCnt) : CRawDataSet(nIDStart, nIDCnt)
	{
		m_pInstance = this;
		_Init();
	}

	LEResourceInfo* GetResourceInfoByID(int nID)
	{
		return (LEResourceInfo*)GetRawDataInfo(nID);
	}

	

protected:
	virtual CRawDataInfo* _CreateRawDataArray(int nCnt)
	{
		return new LEResourceInfo[nCnt];
	}

	virtual void _DeleteRawDataArray()
	{
		delete[] (LEResourceInfo*)_RawDataArray;
	}

	virtual int _GetRawDataInfoSize()
	{
		return sizeof(LEResourceInfo);
	}

	virtual void* _CreateNewRawData(CRawDataInfo *pInfo)
	{
		return NULL;
	}

	virtual void  _DeleteRawData(CRawDataInfo *pInfo)
	{
		////SAFE_DELETE(pInfo->pData);
	}

	virtual BOOL _ReadRawDataInfo(CRawDataInfo *pRawDataInfo, vector<string> &ParamList)
	{   
		if(ParamList.size()==0) return FALSE;

		LEResourceInfo *pInfo = (LEResourceInfo*)pRawDataInfo;

		pInfo->m_iType = Str2Int(ParamList[0]);

		return TRUE;
	}

};

#pragma warning(default: 4275)

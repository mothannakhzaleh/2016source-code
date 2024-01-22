//=============================================================================
// FileName: Expand.h
// Creater: 
// Date: 2004.11.22
// Comment: 
//=============================================================================

#ifndef TIMER_H
#define TIMER_H

/**
 * @class CTimer 
 * @author 
 * @brief 简单定时器，不是使用回调机制，只能单线程使用
 *					只能手动调用IsOK来判断时间是否到期		
 */
class CTimer
{
public:

	/**
	* @brif 开始
	* @param[in]  dwInterval  时间间隔
	*/
    void Begin(DWORD dwInterval)
    {
        _dwLastTick = GetTickCount();
        _dwInterval = dwInterval;
    }

	/**
	* @brif 是否到定时时间
	* @param[in]  dwCurTime  现在时间
	*
	* @return DWORD 到时时返回到时的倍数
	*/
	DWORD IsOK(DWORD dwCurTime)
    {
		if (dwCurTime < _dwLastTick)
		{
			_dwLastTick = dwCurTime;
			return 0;
		}
		DWORD	dwExecTime = (dwCurTime - _dwLastTick) / _dwInterval;
		if (dwExecTime)
			_dwLastTick = dwCurTime - ((dwCurTime - _dwLastTick) % _dwInterval);

		return dwExecTime;
    }

	/**
	* @brif 重置
	*/
	void Reset(void) {_dwLastTick = GetTickCount();}

	/**
	* @brif 返回间隔
	*/
	DWORD GetInterval(void) {return _dwInterval;}

	/**
	* @brif 设定间隔
	* @param[in]  dwInterval  时间间隔
	*/
	void SetInterval(DWORD dwInterval) {_dwInterval = dwInterval;}

protected:

    DWORD _dwLastTick;
    DWORD _dwInterval;
};

#endif // TIMER_H
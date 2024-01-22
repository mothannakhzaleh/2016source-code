//#include "stdafx.h"
#include "CPerformance.h"

#ifdef __FPS_DEBUG__
STickRecord CPerformance::m_Record[PR_MAX];
LONGLONG CPerformance::m_llStartSecond = 0;

static double secondsPerTick = 1.0f;
void CPerformance::InitPerformance()
{
	ZeroMemory(m_Record, _countof(m_Record));
	m_llStartSecond = 0;
	LARGE_INTEGER lv;
	QueryPerformanceFrequency(&lv);
	secondsPerTick = 1.0 / lv.QuadPart;
}

void  CPerformance::BeginTick(EPRecord eType, LONGLONG* pllLastTick)
{
	if( eType>=PR_MAX )
	{
		*pllLastTick = 0;
		return;
	}
	if( eType!=PR_APP_LOOP )
	{
		if( m_Record[eType].pllTicking )
		{
			*pllLastTick = 0;
			return;
		}
	}
	else //每次APP Loop 初始所有计时
	{
		for(int i=0; i<PR_MAX; i++)
			m_Record[i].pllTicking = 0;
	}

	LARGE_INTEGER lv;
	QueryPerformanceCounter( &lv );
	*pllLastTick = lv.QuadPart;
	m_Record[eType].pllTicking = pllLastTick;
}

void CPerformance::EndTick(EPRecord eType, LONGLONG* pllLastTick)
{
	if( eType>=PR_MAX )
		return;
	if( m_Record[eType].pllTicking==0 || m_Record[eType].pllTicking!=pllLastTick )
		return; //已经在上一层记录了时间
	m_Record[eType].pllTicking = 0;
	LARGE_INTEGER lv;
	QueryPerformanceCounter( &lv );
//	LONGLONG llCurrent = timeGetTime();
	LONGLONG llCurrent = lv.QuadPart;
	m_Record[eType].llTotalTick += llCurrent - *pllLastTick;
	if( eType==PR_APP_LOOP )
	{
		if( m_llStartSecond==0 )
			m_llStartSecond = *pllLastTick;

		LONGLONG llElapsed = llCurrent - m_llStartSecond;
		if( llElapsed * secondsPerTick > 15.0 )
		{
			for(int i=0; i<PR_MAX; i++)
				m_Record[i].llTotalTick -= LONGLONG(GetTPS(i) * 3 / secondsPerTick);
			m_llStartSecond += LONGLONG(3 / secondsPerTick);
		}
	}
}

FLOAT CPerformance::GetTPS(int eType)
{
	if( eType>=PR_MAX )
		return 0.0f;

	if( m_llStartSecond==0 )
		return 0.0f;

	LARGE_INTEGER lv;
	QueryPerformanceCounter( &lv );
	LONGLONG llElapsed = (lv.QuadPart - m_llStartSecond);
	if( llElapsed==0 )
		return 0.0f;

	return (FLOAT)m_Record[eType].llTotalTick / llElapsed;
}
#endif//__FPS_DEBUG__

void IP(const char* msg, ...)
{
	char buf[200];
	va_list args;
	va_start(args, msg);
	vsnprintf_s(buf, _countof(buf), _TRUNCATE, msg, args);
	va_end(args);
	OutputDebugString(buf);
}

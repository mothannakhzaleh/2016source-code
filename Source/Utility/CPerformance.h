#ifndef __CPERFORMANCE_H
#define __CPERFORMANCE_H

#include <windows.h>
#include <vector>
using namespace std;

#ifdef __FPS_DEBUG__
enum EPRecord
{
	PR_APP_LOOP,
	PR_MESSAGE,
	PR_FRAME_MOVE,
	PR_RENDER,
	PR_NET,
	PR_MEMORY,
	PR_LOADING,
	PR_IO,
	PR_AI,
	PR_PATH,
	PR_LOG,
	PR_MAX,
};

struct STickRecord
{
	LONGLONG	llTotalTick;
	LONGLONG*	pllTicking;
};

class CPerformance
{
public:
	static void  InitPerformance();
	static void  BeginTick(EPRecord eType, LONGLONG* pllLastTick);
	static void  EndTick(EPRecord eType, LONGLONG* pllLastTick);
	static FLOAT GetTPS(int eType);
	static LONGLONG GetTicks(int eType) { return m_Record[eType].llTotalTick; }

private:
	static STickRecord m_Record[PR_MAX];
	static LONGLONG	   m_llStartSecond;
};

#define BEGIN_TICK(x)	LONGLONG llTick##x; \
						CPerformance::BeginTick(x, &llTick##x);
#define END_TICK(x)		CPerformance::EndTick(x, &llTick##x);
#else//Release
#define BEGIN_TICK(x)	
#define END_TICK(x)		
#endif//__FPS_DEBUG__

#ifdef __FPS_DEBUG__
#define TInit	LARGE_INTEGER s, e; char szDebugInfo[500];
#define TBegin	QueryPerformanceCounter(&s);
#define TEnd	\
{\
	QueryPerformanceCounter(&e);\
	_snprintf_s(szDebugInfo, _countof(szDebugInfo), "%s (%d): %u\n", __FILE__, __LINE__, e.QuadPart - s.QuadPart);\
	OutputDebugString(szDebugInfo);\
}
#else
#define TInit	
#define TBegin	
#define TEnd	
#endif

extern void IP(const char* msg, ...);

#endif//__CPERFORMANCE_H
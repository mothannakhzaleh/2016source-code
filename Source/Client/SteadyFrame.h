#ifndef __CSTEADY_FRAME_H
#define __CSTEADY_FRAME_H

#define DefaultFPS 30
enum EShowWhat
{
  eShowNo,
  eShowSome,
  eShowAll,
};

// 用于稳定帧数,并且不超帧
// 实现方法:降低渲染次数
class CSteadyFrame
{
  public:
  CSteadyFrame() :
	  _eShowWhat(eShowNo)
  {
	SetFPS(DefaultFPS);
  }

  bool Init();

  static DWORD GetFPS() { return _dwFPS; }
  void		   SetFPS(DWORD v)
  {
	_dwFPS		 = v;
	_dwTimeSpace = (int)(1000.0f / (float)_dwFPS);
  }

  bool Run();

  // 取得现在Windows窗口是如何的显示 Add by Waiting 2009-06-21
  EShowWhat GetShowWhat() { return _eShowWhat; }

  // Add by lark.li 20080923 begin
  void Exit();
  // End

  DWORD GetTick() { return _dwCurTime; }
  void	End();

  void RefreshFPS()
  {
	if(_dwFPS != _dwRefreshFPS) SetFPS(_dwRefreshFPS);
  }

  private:
  static DWORD WINAPI _SleepThreadProc(LPVOID lpParameter)
  {
	((CSteadyFrame*)lpParameter)->_Sleep();
	return 0;
  }

  void _Sleep();

  private:
  static DWORD _dwFPS; // 设定的FPS,一秒要渲染多少帧

  long _lRun;

  DWORD _dwCurTime;
  DWORD _dwTimeSpace;

  DWORD _dwTotalTime;
  DWORD _dwRunCount;

  DWORD _dwRefreshFPS;

  // Add by lark.li 20080923 begin
  HANDLE hThread;
  // End
  EShowWhat _eShowWhat;
};
#endif //__CSTEADY_FRAME_H
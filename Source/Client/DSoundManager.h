#ifndef __DSOUNDMANAGER_H__
#define __DSOUNDMANAGER_H__

#include "SoundManager.h"

class DSoundInstance;

class DSoundManager : public SoundManager
{
  friend class DSoundInstance;
  friend class DSoundMusicInterface;

  protected:
  HMODULE			  mDSoundDLL;
  LPDIRECTSOUNDBUFFER mSourceSounds[MAX_SOURCE_SOUNDS];
  string			  mSourceFileNames[MAX_SOURCE_SOUNDS];
  LPDIRECTSOUNDBUFFER mPrimaryBuffer;
  ulong				  mSourceDataSizes[MAX_SOURCE_SOUNDS];
  double			  mBaseVolumes[MAX_SOURCE_SOUNDS];
  int				  mBasePans[MAX_SOURCE_SOUNDS];
  DSoundInstance*	  mPlayingSounds[MAX_CHANNELS];
  double			  mMasterVolume;
  DWORD				  mLastReleaseTick;
  float				  m_fFadeByWindow;

  protected:
  int  FindFreeChannel();
  int  VolumeToDB(double theVolume);
  bool LoadOGGSound(unsigned int theSfxID, const string& theFilename);
  bool LoadWAVSound(unsigned int theSfxID, const string& theFilename);
  bool LoadAUSound(unsigned int theSfxID, const string& theFilename);
  bool WriteWAV(unsigned int theSfxID, const string& theFilename, const string& theDepFile);
  bool GetTheFileTime(const string& theDepFile, FILETIME* theFileTime);
  void ReleaseFreeChannels();

  public:
  LPDIRECTSOUND mDirectSound;

  DSoundManager(HWND theHWnd);
  virtual ~DSoundManager();

  virtual bool Initialized();

  virtual bool LoadSound(int theSfxID, const string& theFilename);
  virtual int  LoadSound(const string& theFilename);
  virtual void ReleaseSound(unsigned int theSfxID);

  virtual void SetVolume(double theVolume);
  virtual bool SetBaseVolume(unsigned int theSfxID, double theBaseVolume);
  virtual bool SetBasePan(unsigned int theSfxID, int theBasePan);

  virtual SoundInstance* GetSoundInstance(unsigned int theSfxID);

  virtual void ReleaseSounds();
  virtual void ReleaseChannels();

  virtual double GetMasterVolume();
  virtual void	 SetMasterVolume(double theVolume);

  virtual void Flush();

  virtual void SetCooperativeWindow(HWND theHWnd, bool isWindowed);
  virtual void StopAllSounds();

  /*--------------------------------------------------------------------------
	应用程序切换到背景时，将音量适当降低，使用这个命令 by Waiting 2009-06-22
	1.0f 正常播放		应用程序在前景
	0.0f 静音			缩到最小,或完全被其它应用程序遮挡
	0.5f 一半的音量		应用程序露出了一部分
	--------------------------------------------------------------------------*/
  virtual void FadeByWindow(float fFade);
};

#endif //__DSOUNDMANAGER_H__
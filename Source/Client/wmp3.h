/*
 * WMp3 class - free C++ class for playing mp3 files
 * Copyright (C) 2003-2008 Zoran Cindori ( zcindori@inet.hr )
 *
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *
 */

#ifndef _WMP3_Z_
#define _WMP3_Z_

#include "wwave.h"
#include "wmp3decoder.h"
#include "wequ.h"

typedef struct
{
  int h;
  int m;
  int s;
  int ms;
} MP3_TIME;

struct tag_xing
{
  long			flags;	  /* valid fields (see above) */
  unsigned long frames;	  /* total number of frames */
  unsigned long bytes;	  /* total number of bytes */
  unsigned char toc[100]; /* 100-point seek table */
  long			scale;	  /* VBR quality indicator (0 best - 100 worst) */
};

enum rgain_name
{
  RGAIN_NAME_NOT_SET	= 0x0,
  RGAIN_NAME_RADIO		= 0x1,
  RGAIN_NAME_AUDIOPHILE = 0x2
};

enum rgain_originator
{
  RGAIN_ORIGINATOR_UNSPECIFIED = 0x0,
  RGAIN_ORIGINATOR_PRESET	   = 0x1,
  RGAIN_ORIGINATOR_USER		   = 0x2,
  RGAIN_ORIGINATOR_AUTOMATIC   = 0x3
};

struct rgain
{
  enum rgain_name		name;		/* profile (see above) */
  enum rgain_originator originator; /* source (see above) */
  signed short			adjustment; /* in units of 0.1 dB */
};

enum tag_lame_vbr
{
  TAG_LAME_VBR_CONSTANT		 = 1,
  TAG_LAME_VBR_ABR			 = 2,
  TAG_LAME_VBR_METHOD1		 = 3,
  TAG_LAME_VBR_METHOD2		 = 4,
  TAG_LAME_VBR_METHOD3		 = 5,
  TAG_LAME_VBR_METHOD4		 = 6,
  TAG_LAME_VBR_CONSTANT2PASS = 8,
  TAG_LAME_VBR_ABR2PASS		 = 9
};

enum tag_lame_source
{
  TAG_LAME_SOURCE_32LOWER  = 0x00,
  TAG_LAME_SOURCE_44_1	   = 0x01,
  TAG_LAME_SOURCE_48	   = 0x02,
  TAG_LAME_SOURCE_HIGHER48 = 0x03
};

enum tag_lame_mode
{
  TAG_LAME_MODE_MONO	  = 0x00,
  TAG_LAME_MODE_STEREO	  = 0x01,
  TAG_LAME_MODE_DUAL	  = 0x02,
  TAG_LAME_MODE_JOINT	  = 0x03,
  TAG_LAME_MODE_FORCE	  = 0x04,
  TAG_LAME_MODE_AUTO	  = 0x05,
  TAG_LAME_MODE_INTENSITY = 0x06,
  TAG_LAME_MODE_UNDEFINED = 0x07
};

enum tag_lame_surround
{
  TAG_LAME_SURROUND_NONE	  = 0,
  TAG_LAME_SURROUND_DPL		  = 1,
  TAG_LAME_SURROUND_DPL2	  = 2,
  TAG_LAME_SURROUND_AMBISONIC = 3
};

enum tag_lame_preset
{
  TAG_LAME_PRESET_NONE			= 0,
  TAG_LAME_PRESET_V9			= 410,
  TAG_LAME_PRESET_V8			= 420,
  TAG_LAME_PRESET_V7			= 430,
  TAG_LAME_PRESET_V6			= 440,
  TAG_LAME_PRESET_V5			= 450,
  TAG_LAME_PRESET_V4			= 460,
  TAG_LAME_PRESET_V3			= 470,
  TAG_LAME_PRESET_V2			= 480,
  TAG_LAME_PRESET_V1			= 490,
  TAG_LAME_PRESET_V0			= 500,
  TAG_LAME_PRESET_R3MIX			= 1000,
  TAG_LAME_PRESET_STANDARD		= 1001,
  TAG_LAME_PRESET_EXTREME		= 1002,
  TAG_LAME_PRESET_INSANE		= 1003,
  TAG_LAME_PRESET_STANDARD_FAST = 1004,
  TAG_LAME_PRESET_EXTREME_FAST	= 1005,
  TAG_LAME_PRESET_MEDIUM		= 1006,
  TAG_LAME_PRESET_MEDIUM_FAST	= 1007,
  TAG_LAME_PRESET_PORTABLE		= 1010,
  TAG_LAME_PRESET_RADIO			= 1015
};

struct tag_lame
{
  unsigned char revision;
  unsigned char flags;

  enum tag_lame_vbr vbr_method;
  unsigned short	lowpass_filter;

  mad_fixed_t  peak;
  struct rgain replay_gain[2];

  unsigned char ath_type;
  unsigned char bitrate;

  int start_delay;
  int end_padding;

  enum tag_lame_source source_samplerate;
  enum tag_lame_mode   stereo_mode;
  unsigned char		   noise_shaping;

  signed char			 gain;
  enum tag_lame_surround surround;
  enum tag_lame_preset	 preset;

  unsigned long	 music_length;
  unsigned short music_crc;
};

struct tag_xl
{
  int			  flags;
  struct tag_xing xing;
  struct tag_lame lame;
  char			  encoder[21];
};

#define ERRORMESSAGE_SIZE 1024 // max error message string siz

#define ECHO_BUFFER_NUMBER	  40
#define ECHO_MAX_DELAY_NUMBER 20
typedef int		  weq_param[10];
typedef weq_param EQ_PARAM;

#define MPEG1  0
#define MPEG2  1
#define MPEG25 2

// ID3 TAG
#define ID3_VERSION2 2
#define ID3_VERSION1 1

typedef struct
{
  BOOL		   play;
  BOOL		   pause;
  BOOL		   stop;
  BOOL		   echo;
  unsigned int echo_mode;
  BOOL		   eq_external;
  BOOL		   eq_internal;
  BOOL		   vocal_cut;
  BOOL		   channel_mix;
  BOOL		   fade_in;
  BOOL		   fade_out;
  BOOL		   internal_volume;
  BOOL		   loop;
} MP3_STATUS;

#define real double

static unsigned long get32bits(unsigned char* buf);
typedef real		 SFX_MODE[ECHO_MAX_DELAY_NUMBER];

#define mad_fixed_t signed int

typedef struct audio_dither
{
  mad_fixed_t error[3];
  mad_fixed_t random;
} AUTODITHER_STRUCT;

typedef struct
{
  char	Header[10];
  DWORD MajorVersion;
  DWORD RevisionNumber;
  DWORD _flags;
  struct
  {
	BOOL Unsync;
	BOOL Extended;
	BOOL Experimental;
	BOOL Footer;
  } Flags;
  DWORD Size;

} ID3v2STRUCT;

typedef struct
{
  DWORD Size;
  DWORD _flags;
  struct
  {
	BOOL Tag_alter_preservation;
	BOOL File_alter_preservation;
	BOOL Read_only;
	BOOL Grouping_identity;
	BOOL Compression;
	BOOL Encryption;
	BOOL Unsynchronisation;
	BOOL Data_length_indicator;
  } Flags;
} ID3v2FRAME;

typedef struct
{
  char* artist;
  char* album;
  char* title;
  char* comment;
  char* genre;
  char* year;
  char* tracknum;
  char* ID3TAG;
  char* NEWID3;
  char	header[10];
  int	currsize;
  int	currpos;
  int	size;
  int	ready;
  int	dynbuffer;
  int	footer, extended, experimental;
  DWORD flags;

  ID3v2STRUCT Id3v2;
} ID3STRUCT;

// WMP3 CLASS  ------------------------------------------------------------------------

class WMp3
{
  public:
  WMp3();  // constructor
  ~WMp3(); // destructor

  // ----------------------------------------------------------------------------------------
  //
  //    CLASS INTERFACE FUNCTIONS
  //
  // ----------------------------------------------------------------------------------------

  // get last error string
  //
  //

  char* GetError() { return _lpErrorMessage; };

  //
  // e.g.
  //
  // MessageBox(0,mp3->GetError(),"Error",0);
  //

  // ----------------------------------------------------------------------------------------

  // open mp3 file
  //
  // INPUT:
  //			const char *filename - mp3 file name
  //			int WaveBufferLength - wave buffer in milliseconds, minimal 200 ms
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL OpenMp3File(const char* filename, int WaveBufferLengthMs);

  // e.g.
  //
  // 	if(!mp3->OpenMp3File("mySong.mp3",2000)) {
  //		MessageBox(0,mp3->GetError(),"Error",MB_APPLMODAL|MB_ICONSTOP);
  //		return 0;
  //	}

  // ----------------------------------------------------------------------------------------

  // open mp3 file, seek from begining of file, set custom file size
  //
  // INPUT:
  //			const char *filename - mp3 file name
  //			int WaveBufferLength - wave buffer in milliseconds, minimal 200 ms
  //			DWORD seekfromstart	 - seek custom number of bytes from beginning of file
  //			DWORD size			 - size of file
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  int OpenMp3File(const char* filename, int WaveBufferLengthMs, DWORD seek, DWORD size);

  // e.g.
  //
  // 	if(!mp3->OpenMp3File("mySong.mp3",2000, 48,10000)) {
  //		MessageBox(0,mp3->GetError(),"Error",MB_APPLMODAL|MB_ICONSTOP);
  //		return 0;
  //	}

  // ----------------------------------------------------------------------------------------

  // open memory mp3 stream
  //
  // INPUT:
  //			char* mem_stream - pointer to memory
  //			DWORD size - size of mem_stream,
  //          int WaveBufferLength - wave buffer in milliseconds, minimal 200 ms
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL OpenMp3Stream(char* mem_stream, DWORD size, int WaveBufferLengthMs);

  //
  // e.g.
  //
  //	FILE* in;
  //	in = fopen("mysong.mp3","rb");
  //	unsigned char* tmp = (unsigned char*) malloc(400000);
  //	fread(tmp, 4000000,1,in);
  //	if(!mp3->OpenMp3Stream((char*) tmp,40000,2000)) {
  //		MessageBox(0,mp3->GetError(),"Error",MB_APPLMODAL|MB_ICONSTOP);
  //		return 0;
  //	}

  // ----------------------------------------------------------------------------------------

  // open resource mp3 stream, to play mp3 from exe resource
  //
  // INPUT:
  //			hModule - instance of exe file,
  //			LPCTSTR lpName - name of resource ( string or MAKEINTRESOURCE(..) )
  //			int WaveBufferLength - wave buffer in milliseconds, minimal 200 ms
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL OpenMp3Resource(HMODULE hModule, LPCTSTR lpName, LPCTSTR lpType, int WaveBufferLengthMs);

  //
  // e.g.

  //	if(!mp3->OpenMp3Resource(GetModuleHandle(NULL),"MYSONG",RT_RCDATA, 2000) {
  //		MessageBox(0,mp3->GetError(),"Error",MB_APPLMODAL|MB_ICONSTOP);
  //		return 0;
  //	}

  // ----------------------------------------------------------------------------------------

  // open resource mp3 stream, to play mp3 from exe resource
  // you can seek from begining of file and set custom stream size
  //
  // INPUT:
  //			hModule - instance of exe file,
  //			LPCTSTR lpName - name of resource ( string or MAKEINTRESOURCE )
  //			int WaveBufferLength - wave buffer in milliseconds, minimal 200 ms
  //			DWORD seekfromstart	 - seek from beginning of file
  //			DWORD size			 - size of file
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL OpenMp3Resource(HMODULE hModule, LPCTSTR lpName, LPCTSTR lpType, int WaveBufferLengthMs, DWORD seekfromstart, DWORD dwSize);

  //
  // e.g.

  //	if(!mp3->OpenMp3Resource(GetModuleHandle(NULL),"MYSONG",RT_RCDATA, 2000, 2500, 400000) {
  //		MessageBox(0,mp3->GetError(),"Error",MB_APPLMODAL|MB_ICONSTOP);
  //		return 0;
  //	}

  // ----------------------------------------------------------------------------------------

  // close mp3 file, free memory ...
  //
  //

  void Close();

  // ----------------------------------------------------------------------------------------

  // start playing from current position
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL Play();

  // ----------------------------------------------------------------------------------------

  // play loop
  //
  // INPUT:
  //			unsigned int start_s  - starting position of loop in seconds
  //			unsigned int length_s - length of loop in seconds
  //			unsigned int n_times   - loop will play n_times
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL PlayLoop(unsigned int start_s, unsigned int length_s, unsigned int n_times);

  // ----------------------------------------------------------------------------------------

  // play loop, milliseconds version
  //
  // INPUT:
  //			unsigned int start_ms  - starting position of loop in milliseconds
  //			unsigned int length_ms - length of loop in milliseconds
  //			unsigned int n_times   - loop will play n_times
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL PlayLoopM(unsigned int start_ms, unsigned int length_ms, unsigned int n_times);

  // ----------------------------------------------------------------------------------------

  // seek position
  //
  // INPUT:
  //			unsigned int seconds - number of seconds to seek
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string
  //
  // REMARK: this function call Stop(); You need to call Play() to start playing after Seek
  //
  //

  BOOL Seek(unsigned int seconds);

  // ----------------------------------------------------------------------------------------

  // seek to position, millseconds version
  //
  // INPUT:
  //			unsigned int milliseconds - number of milliseconds to seek
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string
  //
  // REMARK: this function call Stop(); You need to call Play() to start playing after Seek
  //

  BOOL SeekM(unsigned int milliseconds);

  // ----------------------------------------------------------------------------------------

  // stop playing
  //
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL Stop();

  // ----------------------------------------------------------------------------------------

  // pause playing
  //
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL Pause();

  // ----------------------------------------------------------------------------------------

  // continue paused playing
  //
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL Resume();
  // ----------------------------------------------------------------------------------------

  // get current position in MP3_TIME format
  //
  // typedef struct {
  //	int h;      // hour
  //	int m;		// minute
  //	int s;		// second
  //	int ms;		// millisecond
  // } MP3_TIME;
  //
  //
  // RETURN: pointer on MP3_TIME structure

  MP3_TIME* GetPositionHMS();

  //
  // e.g.
  //
  // MP3_TIME* myTime* = mp3->GetPositionHMS();
  //
  //	printf("Position: %i:%i", myTime->m; myTime->s);

  // ----------------------------------------------------------------------------------------

  // get current position in seconds

  unsigned int GetPosition();

  // ----------------------------------------------------------------------------------------

  // get current position in milliseconds

  unsigned int GetPositionM();

  // ----------------------------------------------------------------------------------------

  // use internal volume control, modify wave samples, don't
  // change wave out mixer volume
  //
  // INPUT:
  //			BOOL fEnable - TRUE enable, FALSE disable (default)

  void InternalVolume(BOOL fEnable);

  // ----------------------------------------------------------------------------------------

  // Set output volume
  //
  // INPUT:
  //			unsigned int lvolume - left channel volume ( 0 - 100 )
  //			unsigned int rvolume - right channel volume ( 0 - 100 )

  void SetVolume(unsigned int lvolume, unsigned int rvolume);

  // ----------------------------------------------------------------------------------------

  // get output volume
  //
  // INPUT:
  //			unsigned int* lvolume - pointer to variable for left channel volume ( 0 - 100 )
  //			unsigned int* rvolume - pointer to variable for right channel volume ( 0 - 100 )

  void GetVolume(unsigned int* lvolume, unsigned int* rvolume);

  // ----------------------------------------------------------------------------------------

  // mp3 infos, return string description

  char* GetMpegVersion(); // mpeg version
  char* GetMpegLayer();	  // layer version
  char* GetChannelMode(); // stereo, mono ot dual stereo
  char* GetEmphasis();

  // ----------------------------------------------------------------------------------------

  // get sampling rate ( 44100, 32000, 16000 ....)

  unsigned int GetSamplingRate();

  // ----------------------------------------------------------------------------------------

  // get position of first valid mp3 frame

  unsigned int GetHeaderStart();

  // ----------------------------------------------------------------------------------------

  // get song length in seconds

  unsigned int GetSongLength();

  // ----------------------------------------------------------------------------------------

  // get song length in milliseconds

  unsigned int GetSongLengthM();

  // ----------------------------------------------------------------------------------------

  // get file bitrate for CBR, average bitrate of VBR file ( kbps )

  unsigned int GetFileBitrate();

  // ----------------------------------------------------------------------------------------

  // get bitrate of currently decoded frame ( kbps )

  unsigned int GetCurrentBitrate();

  // ----------------------------------------------------------------------------------------

  // get average bitrate of currently decoded frame ( kbps )

  unsigned int GetAvgBitrate();

  // ----------------------------------------------------------------------------------------

  // get current status
  //
  //
  // RETURN: pointer to MP3_STATUS structure
  //
  //	typedef struct {
  //		BOOL play;
  //		BOOL pause;
  //		BOOL stop;
  //		BOOL echo;
  //		unsigned int echo_mode;
  //		BOOL eq_external;
  //		BOOL eq_internal;
  //		BOOL vocal_cut;
  //		BOOL channel_mix;
  //		BOOL fade_in;
  //		BOOL fade_out;
  //		BOOL internal_volume;
  //		BOOL loop;
  //	} MP3_STATUS;

  MP3_STATUS* GetStatus();

  //
  // e.g.
  //
  // MP3_STATUS* status = mp3->GetStatus();
  //
  // if(status->play)
  //	printf("Playing song");

  // ----------------------------------------------------------------------------------------

  // check is song is VBR

  BOOL IsVBR() { return c_vbr; };

  // ----------------------------------------------------------------------------------------

  // mix left and right channel into one mono channel
  //
  // INPUT:
  //			BOOL fEnable - TRUE enable, FALSE disable mixing
  //			unsigned int left_percent - percent of left channel in resulting sound
  //			unsigned int right_percent - percent of right channel in resulting sound
  //
  // REMARK: if you mix 50 % left and 50 % right you get MONO output
  //		   if you mix 100 % left and 0 % right you get LEFT channel output
  //		   if you mix 0 % left and 100 % right you get RIGHT channel output

  void MixChannels(BOOL fEnable, unsigned int left_percent, unsigned int right_percent);
  //
  // e.g.
  //
  //	mp3->MixChannels(TRUE, 50,50); // this will convert stereo to mono
  //
  //

  // ----------------------------------------------------------------------------------------

  // return VU data for left and right channel
  // call this function and draw VU meter with this values
  //
  //
  // INPUT:
  //			unsigned int* left  - pointer to variable for left channel
  //			unsigned int* right - pointer to variable for left channel
  //
  //			range of vu data is from 0 to 100

  void GetVUData(unsigned int* left, unsigned int* right);

  // ----------------------------------------------------------------------------------------

  // enable simple vocal cut
  //
  // INPUT:
  //			BOOL fEnable - TRUE enable, FALSE disable (default)

  void VocalCut(BOOL fEnable);

  // ----------------------------------------------------------------------------------------

  // fade out ( milliseconds version )
  //
  // INPUT:
  //			unsigned int length_ms - fade interval i n milliseconds
  //
  // REMARK:
  //			call this function before or after Play();
  //			Stop() and Seek() functions cancels fade effect

  void FadeOutM(unsigned int length_ms);

  // ----------------------------------------------------------------------------------------

  // fade out
  //
  // INPUT:
  //			unsigned int length_seconds - fade interval in seconds
  //
  // REMARK:
  //			call this function before or after Play();
  //			Stop() and Seek() functions cancels fade effect

  void FadeOut(unsigned int length_seconds);

  // ----------------------------------------------------------------------------------------

  // fade in
  //
  // INPUT:
  //			unsigned int length_seconds - fade interval in seconds
  //
  // REMARK:
  //			call this function before or after Play();
  //			Stop() and Seek() functions cancels fade effect

  void FadeIn(unsigned int length_seconds);

  // ----------------------------------------------------------------------------------------

  // fade in
  //
  // INPUT:
  //			unsigned int length_seconds - fade interval in milliseconds
  //
  // REMARK:
  //			call this function before or after Play();
  //			Stop() and Seek() functions cancels fade effect

  void FadeInM(unsigned int length_ms);

  /*-------------------------------------------------------------------------------
		应用程序切换到背景时，将音量适当降低，使用这个命令 by Waiting 2009-06-22
		1.0f 正常播放		应用程序在前景
		0.0f 静音			缩到最小,或完全被其它应用程序遮挡
		0.5f 一半的音量		应用程序露出了一部分
		-------------------------------------------------------------------------------*/
  void FadeByWindow(float fFade);

  // ----------------------------------------------------------------------------------------

  // enable equalizer ( internal or external, or both
  //
  //
  // INPUT:
  //			BOOL fEnable - TRUE enable, FALSE disable (default)
  //			BOOL fExternal - TRUE = use external built-in Shibatch Super Equalizer, slow but accurate
  //						   - FALSE = use libmad internal subband equalizer, fast equalizer, not accurate
  //
  //
  void EnableEQ(BOOL fEnable, BOOL fExternal);

  // ----------------------------------------------------------------------------------------

  // set equalizer data
  //
  // INPUT:
  //			BOOL fExternal   - TRUE for external eqalizer, FALSE for internal equalizer
  //			int iPreAmpValue - preamp decibel value ( min: -12, max: 12, neutral: 0)
  //			EQ_PARAM  values - array of 10 frequency band decibel values ( min: -12, max: 12, neutral: 0)
  //
  //
  //			SUBBAND FREQUENCY for external Shibatch Super Equalizer
  //
  //			index:		0    1    2    3    4    5     6    7      8     9
  //			freq (Hz):  70  200  350  700  1500 3000  5000 7000  10000 16000
  //
  //
  //
  //			SUBBAND FREQUENCY for libmad internal subband equalizer
  //
  //			index:		 0     1     2     3     4    5     6     7      8     9
  //			freq (Hz):  300  1000  1600  2000  3000  5000  7000 10000  12000 16000

  void SetEQParam(BOOL fExternal, int iPreAmpValue, EQ_PARAM values);

  // e.g.
  //
  // EQ_PARAM eq_values;
  // eq_values[0] = -12;
  // eq_values[1] = -12;  cut bas
  // eq_values[2] = 0;
  // eq_values[3] = 0;
  // eq_values[4] = 0;
  // eq_values[5] = 0;
  // eq_values[6] = 0;
  // eq_values[7] = 12; boost high tones
  // eq_values[8] = 12;
  // eq_values[9] = 0;
  // setEQ(TRUE,eq_params);

  // ----------------------------------------------------------------------------------------

  // load ID3 data
  //
  // INPUT:
  //			int id3Version - ID3 version: ID3_VERSION1 or ID3_VERSION2
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string
  //

  BOOL LoadID3(int id3Version);

  // ----------------------------------------------------------------------------------------

  // get ID3 strings

  char* GetArtist();
  char* GetTrackTitle();
  char* GetTrackNum();
  char* GetAlbum();
  char* GetYear();
  char* GetComment();
  char* GetGenre();

  // e.g.
  //
  // if(LoadID3(ID3_VERSION1)) {
  //    printf("Title: %s\r\n", mp3->GetTrackTitle());
  //	  printf("Artist: %s\r\n", mp3->GetArtist());
  // }

  // ----------------------------------------------------------------------------------------

  // sound processing echo and reverb
  // enable echo and set parematers
  //
  // INPUT:
  //			BOOL fEnable   - TRUE enable sfx, FALSE disable sfx ( default )
  //			int iMode      - echo mode ( 0 - 9) , change SFX_MODE sfx_mode[NUM_SFX_MODE * 2] in Wmp3.cpp to create new echo mode
  //			int uDelayMs   - echo delay in millisecond ( 50 milliseconds ) step, max 1000 ms
  //			int InputGain  - volume of input sound in decibels ( min: -12, max: +12, no change: 0)
  //			int EchoGain   - volume of added echo sound in decibels ( min: -12, max: +12, no change: 0)
  //			int OutputGain - volume of output sound in decibels ( min: -12, max: +12, no change: 0)
  //
  // RETURN: TRUE - all OK, FALSE - error, call GetError() to get error string

  BOOL SetSfxParam(BOOL fEnable, int iMode, int uDelayMs, int InputGain, int EchoGain, int OutputGain);

  // ----------------------------------------------------------------------------------------

  // get current sfx mode

  int GetSfxMode() { return c_echo_mode; };

  // ----------------------------------------------------------------------------------------

  private:
  struct mad_stream c_stream;
  struct mad_frame	c_frame;
  struct mad_synth	c_synth;

  unsigned char* c_stream_start; // first byte of input stream ( including ID3 tag )
  unsigned int	 c_stream_size;	 // size of input mp3 stream ( whole stream with ID3 tags )
  unsigned char* c_stream_end;	 // last byte of input stream ( including ID3 tag )

  unsigned char* c_start;	 // first valid frame
  unsigned char* c_end;		 // last byte of stream without ID3 tag
  unsigned char* c_position; // current position in stream
  unsigned int	 c_size;	 // size of stream (without ID3 tags )

  BOOL c_ID3v1; // ID3v1 tag present
  BOOL c_ID3v2; // ID3v2 tag present

  unsigned int c_old_sampling_rate;

  unsigned int c_sampling_rate; // sampling rate frequency  ( Hz )
  int		   c_layer;			// layer  1, 2, 3
  int		   c_mode;			// MAD_MODE_SINGLE_CHANNEL,MAD_MODE_DUAL_CHANNEL,MAD_MODE_JOINT_STEREO,MAD_MODE_STEREO
  int		   c_channel;		// number of channels
  int		   c_emphasis;
  int		   c_mode_extension;
  unsigned int c_bitrate;		  // bitrate of first frame
  float		   c_avg_bitrate;	  // average bitrate
  unsigned int c_current_bitrate; // bitrate of decoding frame
  unsigned int c_frame_counter;	  // number of decoded frames
  unsigned int c_bitrate_sum;	  // sum of all decoded bitrates
  unsigned int c_nPosition;		  // seek position in milliseconds

  MP3_TIME c_hms_pos;

  float c_avg_frame_size; // average frame size

  mad_timer_t  c_duration;		   // audio playing time of frame
  unsigned int c_sample_per_frame; // number of wave samples in one frame
  int		   c_flags;
  unsigned int c_mpeg_version;	   // MPEG1, MPEG2, MPEG25
  char*		   c_mpeg_version_str; //
  char*		   c_channel_str;
  char*		   c_emphasis_str;
  char*		   c_layer_str;

  unsigned int	c_xing_frame_size;
  struct tag_xl xing;
  BOOL			c_valid_xing;

  unsigned int c_song_length_samples; // length of song in samples
  unsigned int c_song_length_ms;	  // length of song in milliseconds
  unsigned int c_song_length_bytes;	  // length of song in bytes
  unsigned int c_song_length_frames;  // length of song in mp3 frames

  unsigned int c_input_buffer_size; // size of input buffer ( frame number )

  unsigned char* c_tmp;

  unsigned int c_play;	// playing flag
  unsigned int c_vbr;	// file is vbr or cbr
  BOOL		   c_pause; // pause flag, control Pause() and Reset()

  // VU meter
  DWORD c_dwPos;		// position in current playing wave buffer, need to get corect VU data
  DWORD c_dwIndex;		// index of current playing wave buffer
  BOOL	c_vudata_ready; // get VU data only when playing

  // loop playing
  BOOL		   c_bLoop;					 // indicate loop playing
  unsigned int c_nLoopCount;			 // repeat loop n times
  unsigned int c_nLoop;					 // number of played loops
  unsigned int c_nLoopFrameNum;			 // number of mp3 frames needed for one loop
  unsigned int c_nLoopFramePlayed;		 // number of played mp3 frames in one loop
  BOOL		   c_bLoopIgnoreFrame;		 // ignore all frames in this input buffer
  unsigned int c_dLoopPositionCorrector; // korektor pozicije u pjesmi kad se ponavlja loop

  // fade out, fade in
  BOOL		   c_bFadeOut;
  BOOL		   c_bFadeIn;
  unsigned int c_nFadeOutFrameNum;
  unsigned int c_nFadeInFrameNum;
  double	   c_fadeOutStep;
  double	   c_fadeInStep;
  unsigned int c_fade_frame_count;
  mad_fixed_t  fadeout_gain[2];

  // vocal cut
  BOOL c_bVocalCut; // enable/disable vocal cut processing

  // echo and reverb
  BOOL		   c_echo; // enable echo processing
  real		   c_rIgOg;
  real		   c_rEgOg;
  unsigned int c_delay;							// echo delay
  int		   c_old_echo_buffer_size;			// use to check if we need to allocate new echo buffers
  int		   c_echo_alloc_buffer_size;		// size of allocated echo buffer
  SFX_MODE	   c_sfx_mode_l;					// SFX_MODE data, use this data to add echo
  SFX_MODE	   c_sfx_mode_r;					// SFX_MODE data, use this data to add echo
  int		   c_echo_mode;						// current echo_mode
  int		   c_sfx_offset;					// offset ( number of echo buffers to skip into past )
  short*	   sfx_buffer[ECHO_BUFFER_NUMBER];	// circular echo wave buffers, each buffer contains small wave chunk ( about 50 ms )
  short*	   sfx_buffer1[ECHO_BUFFER_NUMBER]; // there are 40 buffers ( 40 * 50 ms = 2 sec )

  // equalizer

  REAL		   c_lbands[18]; // eqalizer param
  REAL		   c_rbands[18]; // eqalizer param
  paramlist	   c_paramroot;	 // eqalizer param
  int		   c_eq[18];	 // equalizer data
  mad_fixed_t  c_EqFilter[32];
  BOOL		   c_bUseInternalEQ; // enable internal equalizer
  BOOL		   c_bUseExternalEQ; // enable external equalizer
  BOOL		   c_bEQIn;
  BOOL		   c_bChangeEQ; // trigger for EQ parameter change
  char*		   c_gapless_buffer;
  unsigned int c_byte_to_skip;

  // internal volume
  BOOL	c_internalVolume; // adjust internal volume ( process wave samples )
  short c_lvolume;		  // left channel volume for internal volume control
  short c_rvolume;		  // right channel volume for internal volume control

  mad_fixed_t gain[2]; // internal gain
  float		  m_fFadeByWindow;

  // channel mixer
  BOOL		  c_mix_channels; // enable channel mixing
  mad_fixed_t c_l_mix;
  mad_fixed_t c_r_mix;

  // dithering
  AUTODITHER_STRUCT left_dither;
  AUTODITHER_STRUCT right_dither;

  // disk file mapping
  HANDLE		 w_hFile; // handle of opened mp3 file
  HANDLE		 w_hFileMap;
  unsigned char* w_mapping;

  WWaveOut*		   w_wave;			// wave out class, initialize wave out, play wave data to soundcard
  HANDLE		   w_hThread;		// playing thread, decode mp3, run sound processing, send wave data to soundcard
  DWORD			   w_hThreadID;		// playing thread ID
  HANDLE		   w_hEvent;		// event, trigger on wave header DONE, decode new mp3 data and send buffer to soundcard
  CRITICAL_SECTION c_wcsThreadDone; // assurance for Stop() function, when Stop() function exits, playing thread must be dead
  CRITICAL_SECTION c_wcsSfx;		//  protect sound processing functions ( allocation and deallocation of buffers ) from SetSfxParam

  ID3STRUCT	 w_myID3;	 // ID3 structure, LoadID3(...) fill this structure with ID3 data
  ID3v2FRAME w_ID3frame; // ID3v2 support

  MP3_STATUS c_status;

  void		  ClearSfxBuffers();							   // clear all echo buffers
  static void DoEcho(WMp3* mp3, short* buf, unsigned int len); // process adion data and add echo

  static BOOL  _LoadID3(WMp3* mp3, int id3Version); // load ID3 data
  static char* _RetrField(WMp3* mp3, char* identifier, DWORD* Size);

  static void		   _ThreadFunc(void* lpdwParam);
  static void CALLBACK _WaveOutProc(HWAVEOUT hwo, UINT uMsg, DWORD dwInstance,
									DWORD dwParam1, DWORD dwParam2);

  static int reallocate_sfx_buffers(WMp3* mp3);

  static unsigned long _Get32bits(unsigned char* buf);

  static DWORD _RemoveLeadingNULL(char* str, DWORD size);
  static BOOL  _DecodeFrameHeader(WMp3* mp3, char* header, char* identifier);
  static DWORD _DecodeUnsync(unsigned char* header, DWORD size);

  char _lpErrorMessage[ERRORMESSAGE_SIZE];
  void error(char* err_message);

  static void init(WMp3* mp3); // initialize all parameters

  static int _OpenMp3(WMp3* mp3, int WaveBufferLength);
};

#endif

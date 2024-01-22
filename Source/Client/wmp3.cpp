/*
 * WMp3 C++ class - _FREE C++ class for playing mp3 files
 * Copyright (C) 2003-2008 Zoran Cindori ( zcindori@inet.hr )
 *
 *
 *
 * This program is _FREE software; you can redistribute it and/or modify
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

#include "stdafx.h"
#include <windows.h>

#include <stdio.h>
#include <math.h>

#include "wmp3decoder.h"
#include "wmp3.h"

#include "CPerformance.h"

/*
			 #define mad_f_mul(x, y)	(((x) >> 12) * ((y) >> 16))
		*/
#define mad_f_mul(x, y) ((((x) + (1L << 11)) >> 12) * \
						 (((y) + (1L << 15)) >> 16))

#define MAX_ERROR_STR MAX_PATH * 2

#define RGAIN_REFERENCE 83 /* reference level (dB SPL) */

// skip ID3v2 tag at the beginning of file
#define SKIP_ID3TAG_AT_BEGINNING 1

#define RGAIN_SET(rgain) ((rgain)->name != RGAIN_NAME_NOT_SET)

#define RGAIN_VALID(rgain)                     \
  (((rgain)->name == RGAIN_NAME_RADIO ||       \
	(rgain)->name == RGAIN_NAME_AUDIOPHILE) && \
   (rgain)->originator != RGAIN_ORIGINATOR_UNSPECIFIED)

#define RGAIN_DB(rgain) ((rgain)->adjustment / 10.0)

void		rgain_parse(struct rgain*, struct mad_bitptr*);
char const* rgain_originator(struct rgain const*);

unsigned short crc_compute(char const* data, unsigned int length, unsigned short init);

enum
{
  TAG_XING = 0x0001,
  TAG_LAME = 0x0002,
  TAG_VBRI = 0x0004,
  TAG_VBR  = 0x0100
};

enum
{
  TAG_XING_FRAMES = 0x00000001L,
  TAG_XING_BYTES  = 0x00000002L,
  TAG_XING_TOC	  = 0x00000004L,
  TAG_XING_SCALE  = 0x00000008L
};

enum
{
  TAG_LAME_NSPSYTUNE   = 0x01,
  TAG_LAME_NSSAFEJOINT = 0x02,
  TAG_LAME_NOGAP_NEXT  = 0x04,
  TAG_LAME_NOGAP_PREV  = 0x08,

  TAG_LAME_UNWISE = 0x10
};

void tag_init(struct tag_xl*);

#define tag_finish(tag) /* nothing */

int tag_parse(struct tag_xl*, struct mad_stream const*, struct mad_frame const*);

void mono_filter(struct mad_frame* frame);
void gain_filter(struct mad_frame* frame, mad_fixed_t gain[2]);
void experimental_filter(struct mad_frame* frame);

void mix_filter(struct mad_frame* frame, mad_fixed_t left_p, mad_fixed_t right_p);
void vocal_cut_filter(struct mad_frame* frame);

void alert(char* str)
{
  MessageBox(0, str, "char", MB_OK);
}
void alert(unsigned char* str)
{
  MessageBox(0, (char*)str, "unsigned char", MB_OK);
}

void alert(int num)
{
  char tmp[100];
  _snprintf_s(tmp, _countof(tmp), _TRUNCATE, "%i", num);
  MessageBox(0, tmp, "int", MB_OK);
}

void alert(unsigned int num)
{
  char tmp[100];
  _snprintf_s(tmp, _countof(tmp), _TRUNCATE, "%u", num);
  MessageBox(0, tmp, "unsigned int", MB_OK);
}

void alert(float num)
{
  char tmp[100];
  _snprintf_s(tmp, _countof(tmp), _TRUNCATE, "%f", num);
  MessageBox(0, tmp, "float", MB_OK);
}

void alert(double num)
{
  char tmp[100];
  _snprintf_s(tmp, _countof(tmp), _TRUNCATE, "%f", num);
  MessageBox(0, tmp, "double", MB_OK);
}

void alerti(int num)
{
  char tmp[100];
  _snprintf_s(tmp, _countof(tmp), _TRUNCATE, "%i", num);
  MessageBox(0, tmp, "Message", MB_OK);
}

void alertn(unsigned int num)
{
  char tmp[100];
  _snprintf_s(tmp, _countof(tmp), _TRUNCATE, "%u", num);
  MessageBox(0, tmp, "Message", MB_OK);
}

void alertf(float num)
{
  char tmp[100];
  _snprintf_s(tmp, _countof(tmp), _TRUNCATE, "%f", num);
  MessageBox(0, tmp, "Message", MB_OK);
}

void beep()
{
  MessageBeep(0);
}

#define AVG_SINE_16 23169.0 // average sine size in 16 bit audio data, need to calculate VU data

#define SINGLE_AUDIO_BUFFER_SIZE 100 // single suio buffer size in ms ( 100 ms each buffer )

#define SEARCH_DEEP_VBR 200 // check next 200 mp3 frames to determine constant or variable bitrate if no XING header found

#define MIN_FRAME_SIZE 24	// minimal mp3 frame size
#define MAX_FRAME_SIZE 5761 // max frame size

const char empty_string[2] = "\0";

void		  RemoveEndingSpaces(char* buff);
unsigned long Get32bits(unsigned char* buf);

// echo processing

#define NUM_SFX_MODE 10	  // number of ECHO modes
#define MAX_DELAY	 1000 // max echo delay in ms ( 1000 ms = 1 sec )

// SFX_MODE
// 10 echo modes, separate left and right channel.
// there are 20 echo buffers, each buffer has about 50 milliseconds audio data.
// 20 bufers * 50 ms = 1 second past audio data.
// first value represents current playing buffer, second is 50 ms old, third is 100 ms old ....
// buffer contains half volume audio data.
// value in sfx_mode multiply each audio sample volume
// example
// for 50 ms delay set { 0, 0.7, 0, 0, 0, 0, ......
// for e.g. 150 ms delay set {0, 0, 0, 0.6, 0, 0, ....
// for multiple echo set e.g. {0.5, 0.2, 0, 0, 0, 0.3, 0.2, .....
//
// delay value in SetSfxParam determines delay for first value in sfx_mode
//
// changing values in sfx_mode you can create varios reverb and multiple echo effects

SFX_MODE sfx_mode[NUM_SFX_MODE * 2] = {
	// mode 0
	{0.5, 0.2, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // left channel
	{0.5, 0.2, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, // right channel
	// mode 1
	{0.2, 0.3, 0.2, 0.1, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0.2, 0.3, 0.2, 0.1, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	// mode 2
	{0.5, 0.3, 0.1, 0.3, 0.2, 0.1, 0.2, 0.1, 0.3, 0.2, 0.1, 0.1, 0.05, 0.03, 0.2, 0.1, 0.05, 0.1, 0.02, 0.01},
	{0.5, 0.3, 0.1, 0.3, 0.2, 0.1, 0.2, 0.1, 0.3, 0.2, 0.1, 0.1, 0.05, 0.03, 0.2, 0.1, 0.05, 0.1, 0.02, 0.01},
	// mode 3
	{0.5, 0.3, 0.2, 0.1, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, 0.15, 0.1, 0.07, 0.05},
	{0, 0, 0.5, 0.3, 0.2, 0.1, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, 0.15, 0.02},
	// mode 4
	{0.5, 0.3, 0.2, 0.1, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.2, 0.15, 0.1, 0.07, 0.05},
	{0.5, 0.1, 0, 0, 0, 0, 0, 0, 0, 0.5, 0.2, 0.1, 0, 0, 0, 0, 0, 0.3, 0.2, 0.04},
	// mode 5
	{0.5, 0.2, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.3, 0.2, 0.1},
	{0.5, 0.2, 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.3, 0.2, 0.1},
	// mode 6
	{0.3, 0.1, 0.2, 0.05, 0.1, 0.05, 0.05, 0.025, 0.1, 0.05, 0.1, 0.05, 0.1, 0.01, 0.05, 0.01, 0.1, 0.01, 0.1, 0.01},
	{0.3, 0.1, 0.2, 0.05, 0.1, 0.05, 0.05, 0.025, 0.1, 0.05, 0.1, 0.05, 0.1, 0.01, 0.05, 0.01, 0.1, 0.01, 0.1, 0.01},
	// mode 7
	{0.5, 0.4, 0.2, 0.1, 0.025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.3, 0.2, 0.1, 0.05, 0.01},
	{0, 0, 0, 0.5, 0.2, 0.1, 0.05, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.3, 0.2, 0.05, 0.01},
	// mode 8
	{0.5, 0.3, 0.2, 0.1, 0.05, 0.025, 0.017, 0.005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0.05, 0.025},
	{0.5, 0.3, 0.2, 0.1, 0.05, 0.025, 0.017, 0.005, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.1, 0.05, 0.025},
	// mode 9
	{0.5, 0.2, 0.1, 0.3, 0.2, 0.1, 0.2, 0.1, 0.05, 0.1, 0.05, 0.025, 0.1, 0.05, 0.05, 0.025, 0.1, 0.05, 0.025, 0.01},
	{0.5, 0.2, 0.1, 0.3, 0.2, 0.1, 0.2, 0.1, 0.05, 0.1, 0.05, 0.025, 0.1, 0.05, 0.05, 0.025, 0.1, 0.05, 0.025, 0.01}

};

const char* sGenres[] =
	{
		"Blues",
		"Classic Rock",
		"Country",
		"Dance",
		"Disco",
		"Funk",
		"Grunge",
		"Hip-Hop",
		"Jazz",
		"Metal",
		"New Age",
		"Oldies",
		"Other",
		"Pop",
		"R&B",
		"Rap",
		"Reggae",
		"Rock",
		"Techno",
		"Industrial",
		"Alternative",
		"Ska",
		"Death Metal",
		"Pranks",
		"Soundtrack",
		"Euro-Techno",
		"Ambient",
		"Trip Hop",
		"Vocal",
		"Jazz+Funk",
		"Fusion",
		"Trance",
		"Classical",
		"Instrumental",
		"Acid",
		"House",
		"Game",
		"Sound Clip",
		"Gospel",
		"Noise",
		"Alternative Rock",
		"Bass",
		"Soul",
		"Punk",
		"Space",
		"Meditative",
		"Instrumental Pop",
		"Instrumental Rock",
		"Ethnic",
		"Gothic",
		"Darkwave",
		"Techno-Industrial",
		"Electronic",
		"Pop-Folk",
		"Eurodance",
		"Dream",
		"Southern Rock",
		"Comedy",
		"Cult",
		"Gangsta Rap",
		"Top 40",
		"Christian Rap",
		"Pop/Punk",
		"Jungle",
		"Native American",
		"Cabaret",
		"New Wave",
		"Phychedelic",
		"Rave",
		"Showtunes",
		"Trailer",
		"Lo-Fi",
		"Tribal",
		"Acid Punk",
		"Acid Jazz",
		"Polka",
		"Retro",
		"Musical",
		"Rock & Roll",
		"Hard Rock",
		"Folk",
		"Folk/Rock",
		"National Folk",
		"Swing",
		"Fast-Fusion",
		"Bebob",
		"Latin",
		"Revival",
		"Celtic",
		"Blue Grass",
		"Avantegarde",
		"Gothic Rock",
		"Progressive Rock",
		"Psychedelic Rock",
		"Symphonic Rock",
		"Slow Rock",
		"Big Band",
		"Chorus",
		"Easy Listening",
		"Acoustic",
		"Humour",
		"Speech",
		"Chanson",
		"Opera",
		"Chamber Music",
		"Sonata",
		"Symphony",
		"Booty Bass",
		"Primus",
		"Porn Groove",
		"Satire",
		"Slow Jam",
		"Club",
		"Tango",
		"Samba",
		"Folklore",
		"Ballad",
		"power Ballad",
		"Rhythmic Soul",
		"Freestyle",
		"Duet",
		"Punk Rock",
		"Drum Solo",
		"A Capella",
		"Euro-House",
		"Dance Hall",
		"Goa",
		"Drum & Bass",
		"Club-House",
		"Hardcore",
		"Terror",
		"indie",
		"Brit Pop",
		"Negerpunk",
		"Polsk Punk",
		"Beat",
		"Christian Gangsta Rap",
		"Heavy Metal",
		"Black Metal",
		"Crossover",
		"Comteporary Christian",
		"Christian Rock",
		"Merengue",
		"Salsa",
		"Trash Metal",
		"Anime",
		"JPop",
		"Synth Pop"};

#define GetFourByteSyncSafe(value1, value2, value3, value4) (((value1 & 255) << 21) | ((value2 & 255) << 14) | ((value3 & 255) << 7) | (value4 & 255))
#define CreateFourByteField(value1, value2, value3, value4) (((value1 & 255) << 24) | ((value2 & 255) << 16) | ((value3 & 255) << 8) | (value4 & 255))
#define ExtractBits(value, start, length)					((value >> start) & ((1 << length) - 1))

WMp3::WMp3()
{
  m_fFadeByWindow = 1.0f;
  c_mix_channels  = FALSE;

  gain[0] = MAD_F_ONE;
  gain[1] = MAD_F_ONE;

  w_hFile	 = INVALID_HANDLE_VALUE; // handle of opened mp3 file
  w_hFileMap = NULL;

  c_bUseInternalEQ = FALSE;
  c_internalVolume = FALSE;

  c_bEQIn = FALSE;

  c_bChangeEQ = FALSE;

  int n;

  c_bUseExternalEQ = FALSE; // use external equalizer

  // initialize eq parameters
  for(n = 0; n < 18; n++)
  {
	c_lbands[n] = 1.0;
	c_rbands[n] = 1.0;
  };

  for(n = 0; n < 32; n++)
  {
	c_EqFilter[n] = MAD_F_ONE;
  }

  c_bVocalCut = FALSE; // start with disabled echo cut

  // sfx
  c_echo	  = 0; // start with disabled echo processing
  c_echo_mode = 0; // starting echo mode

  c_delay = 0; // delay 0 ms, but some echo modes produces delay with this value set to 0

  c_rIgOg = 1.0;
  c_rEgOg = 1.0;

  // set all pointers to echo buffers to 0, there is no alocated buffer
  for(int i = 0; i < ECHO_BUFFER_NUMBER; i++)
	sfx_buffer[i] = 0;

  c_echo_alloc_buffer_size = 0; // size of single circular echo buffer
  c_old_echo_buffer_size   = 0; // need this to check if we need to reallocate memory for echo buffers

  // sfx end

  // VU data variables
  c_dwPos		 = 0;
  c_dwIndex		 = 0;
  c_vudata_ready = FALSE;

  // internal volume control
  c_lvolume = 100;
  c_rvolume = 100;

  InitializeCriticalSection(&c_wcsThreadDone);
  InitializeCriticalSection(&c_wcsSfx);

  w_wave = new WWaveOut(); // class for playing wave buffers to soundcard

  w_hThread = 0; // playing thread handle
  w_hEvent	= 0; // event handle

  // initialize ID3 fielda
  w_myID3.album		= (char*)_ALLOC(2);
  *w_myID3.album	= 0;
  w_myID3.artist	= (char*)_ALLOC(2);
  *w_myID3.artist	= 0;
  w_myID3.comment	= (char*)_ALLOC(2);
  *w_myID3.comment	= 0;
  w_myID3.genre		= (char*)_ALLOC(2);
  *w_myID3.genre	= 0;
  w_myID3.title		= (char*)_ALLOC(2);
  *w_myID3.title	= 0;
  w_myID3.year		= (char*)_ALLOC(2);
  *w_myID3.year		= 0;
  w_myID3.tracknum	= (char*)_ALLOC(2);
  *w_myID3.tracknum = 0;

  // initialize equalizer

  c_old_sampling_rate = 0;

  c_gapless_buffer = 0;

  equ_init(14);

  init(this);
}

WMp3::~WMp3()
{
  // class destructor

  Stop(); // stop playing

  if(w_myID3.album)
	_FREE(w_myID3.album);

  if(w_myID3.artist)
	_FREE(w_myID3.artist);

  if(w_myID3.comment)
	_FREE(w_myID3.comment);

  if(w_myID3.title)
	_FREE(w_myID3.title);

  if(w_myID3.year)
	_FREE(w_myID3.year);

  if(w_myID3.tracknum)
	_FREE(w_myID3.tracknum);

  if(w_myID3.genre)
	_FREE(w_myID3.genre);

  if(w_hEvent)
	CloseHandle(w_hEvent);

  for(int i = 0; i < ECHO_BUFFER_NUMBER; i++)
	if(sfx_buffer[i])
	  _FREE(sfx_buffer[i]);

  // _FREE critical sections

  DeleteCriticalSection(&c_wcsThreadDone);
  DeleteCriticalSection(&c_wcsSfx);

  if(w_wave) // delete wwaveoutclass
	delete w_wave;

  // _FREE equalizer

  equ_quit();

  if(c_gapless_buffer)
	_FREE(c_gapless_buffer);
}

BOOL WMp3::OpenMp3File(const char* filename, int WaveBufferLengthMs)
{
  // open mp3 file from disk
  // INPUT:	const char *filename	- filename
  //			int WaveBufferLength
  return OpenMp3File(filename, WaveBufferLengthMs, 0, 0);
}

int WMp3::OpenMp3File(const char* filename, int WaveBufferLengthMs, DWORD seek, DWORD size)
{
  // open mp3 file
  // INPUT:	const char *filename		- filename
  //			int WaveBufferLengthMs		- length of wave buffer in milliseconds

  // check if stream already open
  if(c_stream_start)
  {
	error("WMp3::OpenMp3File->You need to close mp3 file before open new one");
	return 0;
  }

  // create file mapping

  w_hFile = CreateFile(filename, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, NULL, NULL);
  if(w_hFile == INVALID_HANDLE_VALUE)
  {
	_snprintf_s(_lpErrorMessage, _countof(_lpErrorMessage), _TRUNCATE, "WMp3::OpenMp3File->Can't open file: \" %s \"",
				filename);
	return 0;
  }

  c_stream_size = GetFileSize(w_hFile, NULL);
  if(c_stream_size == 0xFFFFFFFF)
  {
	_snprintf_s(_lpErrorMessage, _countof(_lpErrorMessage), _TRUNCATE, "WMp3::OpenMp3File->Can't open file: \" %s \"",
				filename);
	CloseHandle(w_hFile);
	w_hFile		  = INVALID_HANDLE_VALUE;
	c_stream_size = 0;
	return 0;
  }

  if(seek >= c_stream_size)
  {
	error("WMp3::OpenMp3File->Seek value out of range");
	CloseHandle(w_hFile);
	w_hFile		  = INVALID_HANDLE_VALUE;
	c_stream_size = 0;
	return 0;
  }

  if(size > (c_stream_size - seek))
  {
	error("WMp3::OpenMp3File->Size value out of range");
	CloseHandle(w_hFile);
	w_hFile		  = INVALID_HANDLE_VALUE;
	c_stream_size = 0;
	return 0;
  }

  w_hFileMap = CreateFileMapping(w_hFile, NULL, PAGE_READONLY, 0, 0, NULL);
  if(w_hFileMap == NULL)
  {
	error("WMp3::OpenMp3File->Can't create file mapping");
	CloseHandle(w_hFile);
	w_hFile		  = INVALID_HANDLE_VALUE;
	c_stream_size = 0;
	return 0;
  }

  w_mapping = (unsigned char*)MapViewOfFile(w_hFileMap, FILE_MAP_READ, 0, 0, 0);
  if(w_mapping == NULL)
  {
	error("WMp3::OpenMp3File->Can't create file view");
	CloseHandle(w_hFileMap);
	CloseHandle(w_hFile);
	w_hFile		  = INVALID_HANDLE_VALUE;
	c_stream_size = 0;
	return 0;
  }

  c_stream_start = w_mapping + seek;
  if(size)
	c_stream_size = size;

  c_stream_end = c_stream_start + c_stream_size - 1;

  return _OpenMp3(this, WaveBufferLengthMs);
}

BOOL WMp3::Stop()
{
  // stop playing

  // prevent program crash if we call this function on empty ( not opened ) mp3
  if(!c_start)
  {
	error("WMp3::Stop->Stream isn't open!");
	return 0;
  }

  if(!c_play)
	return FALSE;

  // disable VU data, don't waste processor (CPU) time
  c_vudata_ready = FALSE;

  c_bLoop = FALSE;

  // pause playing,
  w_wave->Pause();

  // stop decoder loop and decoding thread
  c_play  = FALSE;
  c_pause = FALSE;

  w_wave->Stop(); // stop wave playing

  // ensure that thread will end
  SetEvent(w_hEvent);

  // be sure that playing thread is ended

  EnterCriticalSection(&c_wcsThreadDone);
  LeaveCriticalSection(&c_wcsThreadDone);

  return TRUE;
}

BOOL WMp3::Play()
{
  // start playing mp3 stream
  // this function starts decoding thread but
  // waits to end of previous decoding thread

  // prevent program crash if we call this function on empty stream
  if(!c_start)
  {
	error("WMp3::Play->Strean isn't open!");
	return 0;
  }

  if(c_pause)
	return Resume();

  if(c_play)
	return FALSE;

  // previous playing thread must be terminated
  EnterCriticalSection(&c_wcsThreadDone);
  LeaveCriticalSection(&c_wcsThreadDone);

  c_bLoop = FALSE; // dont play loop

  c_pause = FALSE; // reset pause indicator

  // initialize VU meter
  c_vudata_ready = FALSE;
  c_dwPos		 = 0;
  c_dwIndex		 = 0;

  // main decoding thread switch
  c_play = TRUE; // enable decoding thread

  // create playing thread
  if(!w_hThread)
	w_hThread = (HANDLE)CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)_ThreadFunc, (void*)this, 0, &w_hThreadID);

  if(w_hThread == NULL)
  {
	error("WMp3::Play->Can't create decoding thread!");
	return FALSE;
  }

  return TRUE;
}

void WMp3::_ThreadFunc(void* lpdwParam)
{
  // main decoding thread
  // when this thread ends wave output is closed, position is set to 0

  WMp3* mp3 = (WMp3*)lpdwParam;

  // Play, Seek, Stop function can execute only if this thread is finished
  EnterCriticalSection(&mp3->c_wcsThreadDone);

  // initalize values

  mp3->c_current_bitrate = 0; // bitrate of decoding frame
  mp3->c_frame_counter	 = 0; // number of decoded frames
  mp3->c_bitrate_sum	 = 0; // sum of all decoded bitrates

  mp3->c_bEQIn = FALSE;

  unsigned int size;

  if(mp3->c_size < (unsigned int)((mp3->c_position - mp3->c_start + MAD_BUFFER_GUARD)))
  {
	LeaveCriticalSection(&mp3->c_wcsThreadDone);
	mp3->error("WMp3::_ThreadFunc->Stream too small");
	return;
  }

  if(mp3->c_position + MAD_BUFFER_GUARD > mp3->c_end)
  {
	LeaveCriticalSection(&mp3->c_wcsThreadDone);
	return;
  }

  size = mp3->c_size - (mp3->c_position - mp3->c_start + MAD_BUFFER_GUARD);

  unsigned int i;

  if(mp3->c_tmp)
	LocalFree(mp3->c_tmp);

  mp3->c_tmp = 0;

  struct mad_stream* stream = &mp3->c_stream;
  struct mad_frame*	 frame	= &mp3->c_frame;
  struct mad_synth*	 synth	= &mp3->c_synth;

  int skip_byte = mp3->c_byte_to_skip;

  unsigned int frame_count	   = 0;
  int		   output_size	   = 0;
  unsigned int output_index	   = 0;
  unsigned int frame_count_sum = 0;

  char* output_buf = mp3->w_wave->GetBufferData(output_index);

  AUTODITHER_STRUCT* left_dither  = &mp3->left_dither;
  AUTODITHER_STRUCT* right_dither = &mp3->right_dither;
  ZeroMemory(left_dither, sizeof(AUTODITHER_STRUCT));
  ZeroMemory(right_dither, sizeof(AUTODITHER_STRUCT));

  register mad_fixed_t* left_ch;
  register mad_fixed_t* right_ch;
  register mad_fixed_t	sample;
  register mad_fixed_t	output;

  mad_fixed_t random;

  unsigned int nchannels, nsamples1;

  // open wave output
  if(!mp3->w_wave->OpenAudioOutput(WAVE_MAPPER, (DWORD)mp3->_WaveOutProc, (DWORD)mp3, CALLBACK_FUNCTION))
  {
	LeaveCriticalSection(&mp3->c_wcsThreadDone);
	mp3->error("WMp3::_ThreadFunc->Can't open wave output");
	return;
  }

  // unprepare wave buffers, all buffers must be _FREE
  for(i = 0; i < mp3->w_wave->GetNumOfBuffers(); i++)
  {
	mp3->w_wave->SetBufferDone(i);
	mp3->w_wave->UnprepareHeader(i);
  }

  mad_stream_init(stream);
  mad_frame_init(frame);
  mad_synth_init(synth);

  // clear sfx buffers
  EnterCriticalSection(&mp3->c_wcsSfx);

  if(mp3->c_echo)
	mp3->ClearSfxBuffers();

  LeaveCriticalSection(&mp3->c_wcsSfx);

  if(mp3->c_bUseExternalEQ)
	equ_clearbuf(mp3->c_sampling_rate);

  // set stream to starting position

  mad_stream_buffer(stream, mp3->c_position, size);

  // main playing thread
  while(mp3->c_play)
  {
	if(mad_frame_decode(frame, stream))
	{									 // if some error occurs
	  if(MAD_RECOVERABLE(stream->error)) // if recoverable error continue
		continue;

	  if(stream->error == MAD_ERROR_BUFLEN)
	  { // if buffer end
		if(mp3->c_tmp)
		{
		  LocalFree(mp3->c_tmp);
		  mp3->c_tmp = 0;

		  if(mp3->c_bLoop)
		  {
			if(mp3->c_nLoop < mp3->c_nLoopCount)
			{ // repeat loop ?
			  mp3->c_nLoop++;
			  mp3->c_nLoopFramePlayed = 0;
			  mad_stream_buffer(stream, mp3->c_position, size);
			  continue;
			} else
			  break;

		  } else
			break; // stop decoding, last frame decoded
		} else
		{ // if(mp3->c_tmp) {
		  // fix MAD_BUFFER_GUARD problem
		  unsigned int len = (unsigned int)(mp3->c_end + 1 - stream->this_frame);
		  mp3->c_tmp	   = (unsigned char*)LocalAlloc(0, len + MAD_BUFFER_GUARD + 1);

		  if(!mp3->c_tmp)
			break;

		  // copy last frame into buffer and add MAD_BUFFER_GUARD zero bytes to end
		  CopyMemory(mp3->c_tmp, stream->this_frame, len);
		  FillMemory(mp3->c_tmp + len, MAD_BUFFER_GUARD, 0);
		  mad_stream_buffer(stream, mp3->c_tmp, len + MAD_BUFFER_GUARD);
		  continue;
		}
	  }
	}

	// loop processing
	if(mp3->c_bLoop)
	{
	  if(mp3->c_nLoop < mp3->c_nLoopCount)
	  { // repeat loop ?
		if(mp3->c_nLoopFramePlayed >= mp3->c_nLoopFrameNum)
		{ // loop end
		  mp3->c_nLoop++;

		  mp3->c_nLoopFramePlayed = 0;
		  mad_stream_buffer(stream, mp3->c_position, size);
		}
	  } else
		break;

	  mp3->c_nLoopFramePlayed++;
	}
	// end of loop processing

	// mix channel filter
	if(mp3->c_mix_channels)
	  mix_filter(frame, mp3->c_l_mix, mp3->c_r_mix);

	// internal subband equalizer

	if(mp3->c_bUseInternalEQ)
	{
	  int Channel;
	  int Sample;
	  int Samples;
	  int SubBand;

	  Samples = MAD_NSBSAMPLES(&frame->header);

	  // strereo

	  if(frame->header.mode != MAD_MODE_SINGLE_CHANNEL)
	  {
		for(Channel = 0; Channel < 2; Channel++)
		  for(Sample = 0; Sample < Samples; Sample++)
			for(SubBand = 0; SubBand < 32; SubBand++)
			  frame->sbsample[Channel][Sample][SubBand] =
				  mad_f_mul(frame->sbsample[Channel][Sample][SubBand],
							mp3->c_EqFilter[SubBand]);

	  } else
	  {
		// mono

		for(Sample = 0; Sample < Samples; Sample++)
		  for(SubBand = 0; SubBand < 32; SubBand++)
			frame->sbsample[0][Sample][SubBand] =
				mad_f_mul(frame->sbsample[0][Sample][SubBand],
						  mp3->c_EqFilter[SubBand]);
	  }
	}

	// end of internal subband equalizer

	if(mp3->c_bVocalCut)
	  vocal_cut_filter(frame);

	// internal volume control

	if(mp3->c_internalVolume)
	{
	  gain_filter(frame, mp3->gain);
	}

	// fadeout processing
	if(mp3->c_bFadeOut)
	{
	  if(mp3->c_fade_frame_count < mp3->c_nFadeOutFrameNum)
	  {
		mp3->fadeout_gain[0] = MAD_F_ONE - mad_f_tofixed(((double)mp3->c_fade_frame_count * mp3->c_fadeOutStep) / 100.0);
		mp3->fadeout_gain[1] = mp3->fadeout_gain[0];
		gain_filter(frame, mp3->fadeout_gain);
		mp3->c_fade_frame_count++;
	  } else
		mad_frame_mute(frame);
	}

	// fadein processing
	if(mp3->c_bFadeIn)
	{
	  if(mp3->c_fade_frame_count < mp3->c_nFadeInFrameNum)
	  {
		mp3->fadeout_gain[0] = mad_f_tofixed(((double)mp3->c_fade_frame_count * mp3->c_fadeInStep) / 100.0);
		mp3->fadeout_gain[1] = mp3->fadeout_gain[0];
		gain_filter(frame, mp3->fadeout_gain);
		mp3->c_fade_frame_count++;

	  } else
		mp3->c_bFadeIn = FALSE;
	}

	mp3->c_current_bitrate = frame->header.bitrate;
	mp3->c_frame_counter++;
	mp3->c_bitrate_sum += mp3->c_current_bitrate / 1000;

	// synth
	mad_synth_frame(synth, frame);

	if(!mp3->c_play)
	  break;

	// dither, resample ...
	nchannels = synth->pcm.channels;
	nsamples1 = synth->pcm.length;
	left_ch	  = synth->pcm.samples[0];
	right_ch  = synth->pcm.samples[1];

	if(nchannels == 2)
	{ // stereo
	  while(nsamples1--)
	  {
		// left channel

		sample = *left_ch++;

		// noise shape

		sample += left_dither->error[0] - left_dither->error[1] + left_dither->error[2];

		left_dither->error[2] = left_dither->error[1];
		left_dither->error[1] = left_dither->error[0] / 2;

		// bias
		output = sample + 4096;

		// dither
		random = ((unsigned long)left_dither->random * 0x0019660dL + 0x3c6ef35fL) & 0xffffffffL;

		output += (random & 8191) - (left_dither->random & 8191);

		// clip
		if(output >= MAD_F_ONE)
		  output = MAD_F_ONE - 1;
		else if(output < -MAD_F_ONE)
		  output = -MAD_F_ONE;

		// quantize
		output &= ~8191;

		// error feedback
		left_dither->error[0] = sample - output;

		output_buf[0] = (char)(output >> 13);
		output_buf[1] = (char)(output >> 21);

		// right channel
		sample = *right_ch++;

		// noise shape
		sample += right_dither->error[0] - right_dither->error[1] + right_dither->error[2];

		right_dither->error[2] = right_dither->error[1];
		right_dither->error[1] = right_dither->error[0] / 2;

		// bias
		output = sample + 4096;

		// dither
		random = ((unsigned long)right_dither->random * 0x0019660dL + 0x3c6ef35fL) & 0xffffffffL;

		output += (random & 8191) - (right_dither->random & 8191);

		if(output >= MAD_F_ONE)
		  output = MAD_F_ONE - 1;
		else if(output < -MAD_F_ONE)
		  output = -MAD_F_ONE;

		// quantize
		output &= ~8191;

		// error feedback
		right_dither->error[0] = sample - output;

		output_buf[2] = (char)(output >> 13);
		output_buf[3] = (char)(output >> 21);

		output_buf += 4;

	  } // while (nsamples--)

	  output_size += synth->pcm.length * 4;

	}

	else
	{ // mono
	  while(nsamples1--)
	  {
		// left channel

		sample = *left_ch++;

		// noise shape

		sample += left_dither->error[0] - left_dither->error[1] + left_dither->error[2];

		left_dither->error[2] = left_dither->error[1];
		left_dither->error[1] = left_dither->error[0] / 2;

		// bias
		output = sample + 4096;

		// dither
		random = ((unsigned long)left_dither->random * 0x0019660dL + 0x3c6ef35fL) & 0xffffffffL;

		output += (random & 8191) - (left_dither->random & 8191);

		// clip
		if(output >= MAD_F_ONE)
		  output = MAD_F_ONE - 1;
		else if(output < -MAD_F_ONE)
		  output = -MAD_F_ONE;

		// quantize
		output &= ~8191;

		// error feedback
		left_dither->error[0] = sample - output;

		output_buf[0] = (char)(output >> 13);
		output_buf[1] = (char)(output >> 21);
		output_buf += 2;
	  }

	  output_size += synth->pcm.length * 2;
	}

	frame_count++;
	frame_count_sum++;

	if(frame_count == mp3->c_input_buffer_size)
	{
	  // output buffer is full

	  if(output_size)
	  {
		// echo processing
		if(mp3->c_echo)
		{
		  if(!mp3->c_play)
			break;

		  // protect SetSfxParam(...) function from deallocating working buffers

		  EnterCriticalSection(&mp3->c_wcsSfx);

		  int	size	 = output_size;
		  int	buf_size = size / 2;
		  char* buf		 = (char*)mp3->w_wave->GetBufferData(output_index);

		  // split each ( 100 ms ) wave buffer int 2 ( 50 ms ) echo buffers
		  DoEcho(mp3, (short*)buf, buf_size);
		  DoEcho(mp3, (short*)(buf + buf_size), buf_size);

		  LeaveCriticalSection(&mp3->c_wcsSfx);
		}

		// end of echo processing

		// external equalizer processing

		if(mp3->c_bUseExternalEQ)
		{
		  if(!mp3->c_play)
			break;

		  mp3->c_bEQIn = TRUE;

		  int samples_num;
		  if(mp3->c_channel == 2)
			samples_num = output_size / 4;
		  else
			samples_num = output_size / 2;

		  if(mp3->c_bChangeEQ)
		  { // change equ tables
			equ_makeTable(mp3->c_lbands, mp3->c_rbands, &mp3->c_paramroot, (REAL)mp3->c_sampling_rate);
			mp3->c_old_sampling_rate = mp3->c_sampling_rate;
			mp3->c_bChangeEQ		 = FALSE;
		  }

		  if(skip_byte)
		  { // need to skip bytes for gapless playing
			if(skip_byte > output_size)
			{ // not in these buffer

			  equ_modifySamples((char*)mp3->w_wave->GetBufferData(output_index),
								samples_num, mp3->c_channel);

			  skip_byte -= output_size;
			  // get next buffer
			  output_buf  = mp3->w_wave->GetBufferData(output_index);
			  output_size = 0;
			  frame_count = 0;

			  continue;

			} else
			{ // skip bytes

			  equ_modifySamples((char*)mp3->w_wave->GetBufferData(output_index),
								samples_num, mp3->c_channel);

			  char* data = mp3->w_wave->GetBufferData(output_index);
			  output_size -= skip_byte;
			  MoveMemory(data, data + skip_byte, output_size);
			  skip_byte = 0; // no more skip

			  // play this bufer
			}
		  } else
		  { // not skiping, play normal

			equ_modifySamples((char*)mp3->w_wave->GetBufferData(output_index),
							  samples_num, mp3->c_channel);
		  }
		} else
		{ // disable equalizer, flush equalizer buffers

		  if(mp3->c_bEQIn)
		  {
			mp3->c_bEQIn = FALSE;

			int samples_num;
			if(mp3->c_channel == 2)
			  samples_num = output_size / 4;
			else
			  samples_num = output_size / 2;

			// we need tu flush equ buffer

			CopyMemory(mp3->c_gapless_buffer,
					   mp3->w_wave->GetBufferData(output_index),
					   output_size);

			int o_size = output_size;
			skip_byte  = mp3->c_byte_to_skip;

			//
			while(skip_byte)
			{
			  equ_modifySamples(mp3->w_wave->GetBufferData(output_index),
								samples_num, mp3->c_channel);

			  if(skip_byte > o_size)
			  {
				skip_byte -= o_size;

			  } else
			  {
				o_size	  = skip_byte;
				skip_byte = 0;
			  }

			  mp3->w_wave->SetBufferSize(output_index, o_size);
			  mp3->w_wave->PlayBuffer(output_index);

			  // get new buffer
			  output_index++;
			  if(output_index == mp3->w_wave->GetNumOfBuffers())
				output_index = 0;

			  output_buf = mp3->w_wave->GetBufferData(output_index);

			  while(!mp3->w_wave->IsBufferDone(output_index))
			  {
				if(!mp3->c_play)
				  break;
				WaitForSingleObject(mp3->w_hEvent, INFINITE);
			  }
			}

			CopyMemory(output_buf, mp3->c_gapless_buffer, output_size);
			skip_byte = mp3->c_byte_to_skip;
		  }
		}

		// end of external equalizer

		if(!mp3->c_play)
		  break;

		mp3->w_wave->SetBufferSize(output_index, output_size);

		mp3->w_wave->PlayBuffer(output_index);

		output_index++;
		if(output_index == mp3->w_wave->GetNumOfBuffers())
		  output_index = 0;

		output_buf	= mp3->w_wave->GetBufferData(output_index);
		output_size = 0;
		frame_count = 0;

		while(!mp3->w_wave->IsBufferDone(output_index))
		{
		  if(!mp3->c_play)
			break;
		  WaitForSingleObject(mp3->w_hEvent, INFINITE);
		}

		mp3->w_wave->UnprepareHeader(output_index);

	  } else
	  {
		output_buf	= mp3->w_wave->GetBufferData(output_index);
		frame_count = 0;
	  }
	}

  } // while(mp3->c_play) { end of playing therad

  // flush eq buffer to soundcard
  if(mp3->c_bEQIn && mp3->c_play)
  {
	// size of one wave buffer
	int out_size = mp3->c_input_buffer_size * mp3->c_sample_per_frame *
				   2 * mp3->c_channel;

	// sum of all played samples
	unsigned int sum_samples = frame_count_sum * mp3->c_sample_per_frame;

	// number of samples in one buffer
	int samples_num = mp3->c_input_buffer_size * mp3->c_sample_per_frame;

	int have_byte = sum_samples * 2 * mp3->c_channel;

	skip_byte = mp3->c_byte_to_skip;

	if(have_byte < skip_byte)
	  skip_byte = have_byte;

	while(!mp3->w_wave->IsBufferDone(output_index))
	{
	  if(!mp3->c_play)
		break;
	  WaitForSingleObject(mp3->w_hEvent, INFINITE);
	}

	while(skip_byte)
	{ // flush eq bufers
	  if(skip_byte > out_size)
	  {
		skip_byte -= out_size;

	  } else
	  {
		out_size  = skip_byte;
		skip_byte = 0;
	  }

	  equ_modifySamples(mp3->w_wave->GetBufferData(output_index),
						samples_num, mp3->c_channel);

	  mp3->w_wave->SetBufferSize(output_index, out_size);
	  mp3->w_wave->PlayBuffer(output_index);

	  // get new buffer
	  output_index++;
	  if(output_index == mp3->w_wave->GetNumOfBuffers())
		output_index = 0;

	  while(!mp3->w_wave->IsBufferDone(output_index))
	  {
		if(!mp3->c_play)
		  break;
		WaitForSingleObject(mp3->w_hEvent, INFINITE);
	  }
	}
  }

  if(mp3->c_tmp)
	LocalFree(mp3->c_tmp);

  mp3->c_tmp = 0;

  // wait for all wave buffers to end

  for(int j = 0; j < (int)mp3->w_wave->GetNumOfBuffers(); j++)
  {
	if(mp3->w_wave->IsBufferDone(j))
	{
	  mp3->w_wave->UnprepareHeader(j);
	} else
	{
	  if(!mp3->c_play)
		break;
	  j--;
	  WaitForSingleObject(mp3->w_hEvent, SINGLE_AUDIO_BUFFER_SIZE);
	}
  }

  // stop playing, reset wave position indicator to 0
  mp3->w_wave->Stop();

  // close wave output
  mp3->w_wave->Close();

  mp3->c_bFadeOut = FALSE;
  mp3->c_bFadeIn  = FALSE;

  mp3->c_play  = FALSE;
  mp3->c_pause = FALSE;

  // initialize VU data
  mp3->c_vudata_ready = FALSE;
  mp3->c_dwPos		  = 0; // VU data
  mp3->c_dwIndex	  = 0; // VU data

  mad_stream_finish(stream);
  mad_frame_finish(frame);
  mad_synth_finish(synth);

  mp3->c_current_bitrate = 0;
  mp3->c_frame_counter	 = 0;
  mp3->c_bitrate_sum	 = 0;

  // seek stream to begining of mp3 data ( to first frame )

  mp3->c_position = mp3->c_start;

  // set seek position to 0

  mp3->c_nPosition = 0;

  // stop loop playing, need this to get correct position
  // without loop position corrector

  mp3->c_bLoop = FALSE;

  // thread is ended
  mp3->w_hThread = 0;
  LeaveCriticalSection(&mp3->c_wcsThreadDone);
  return;
}

unsigned int WMp3::GetPosition()
{
  return (GetPositionM() / 1000);
}

unsigned int WMp3::GetPositionM()
{
  // return current playing position i seconds
  if(!c_start)
  {
	error("WMp3::GetPosition->Strean isn't open!");
	return 0;
  }

  // seek position + wave position

  unsigned int pos;

  if(c_bLoop)
  {
	if(c_nLoop)
	{
	  pos = (unsigned int)w_wave->GetPosition(SAMPLES);
	  if(pos >= (c_dLoopPositionCorrector * c_nLoop))
	  {
		pos -= (c_dLoopPositionCorrector * c_nLoop);

	  } else
	  {
		pos -= (c_dLoopPositionCorrector * (c_nLoop - 1));
	  }

	  return (c_nPosition + (unsigned int)((double)pos * 1000.0 / (double)c_sampling_rate));
	}
  }

  pos = w_wave->GetPosition(MILLISECONDS);
  return (c_nPosition + pos);
}

BOOL WMp3::LoadID3(int id3Version)
{
  if(!c_start)
  {
	error("WMp3::LoadID3->Strean isn't open!");
	return 0;
  }

  return _LoadID3(this, id3Version);
}

BOOL WMp3::_LoadID3(WMp3* mp3, int id3Version)
{
  // load ID3 data into id3 structure

  switch(id3Version)
  {
  case ID3_VERSION1:
  {
	if(mp3->w_myID3.album)
	{
	  _FREE(mp3->w_myID3.album);
	  mp3->w_myID3.album = 0;
	}

	mp3->w_myID3.album	= (char*)_ALLOC(31);
	*mp3->w_myID3.album = 0;

	if(mp3->w_myID3.artist)
	{
	  _FREE(mp3->w_myID3.artist);
	  mp3->w_myID3.artist = 0;
	}

	mp3->w_myID3.artist	 = (char*)_ALLOC(31);
	*mp3->w_myID3.artist = 0;

	if(mp3->w_myID3.comment)
	{
	  _FREE(mp3->w_myID3.comment);
	  mp3->w_myID3.comment = 0;
	}

	mp3->w_myID3.comment  = (char*)_ALLOC(31);
	*mp3->w_myID3.comment = 0;

	if(mp3->w_myID3.title)
	{
	  _FREE(mp3->w_myID3.title);
	  mp3->w_myID3.title = 0;
	}

	mp3->w_myID3.title	= (char*)_ALLOC(31);
	*mp3->w_myID3.title = 0;

	if(mp3->w_myID3.year)
	{
	  _FREE(mp3->w_myID3.year);
	  mp3->w_myID3.year = 0;
	}

	mp3->w_myID3.year  = (char*)_ALLOC(5);
	*mp3->w_myID3.year = 0;

	if(mp3->w_myID3.tracknum)
	{
	  _FREE(mp3->w_myID3.tracknum);
	  mp3->w_myID3.tracknum = 0;
	}

	mp3->w_myID3.tracknum  = (char*)_ALLOC(4);
	*mp3->w_myID3.tracknum = 0;

	if(mp3->w_myID3.genre)
	{
	  _FREE(mp3->w_myID3.genre);
	  mp3->w_myID3.genre = 0;
	}

	mp3->w_myID3.genre	= (char*)_ALLOC(1);
	*mp3->w_myID3.genre = 0;

	if(!mp3->c_ID3v1)
	{
	  mp3->error("WMp3::LoadID3->There is no ID3v1 tag");
	  return FALSE;
	}

	memcpy(mp3->w_myID3.title, mp3->c_stream_end - 124, 30);
	mp3->w_myID3.title[30] = 0;
	RemoveEndingSpaces(mp3->w_myID3.title);

	memcpy(mp3->w_myID3.artist, mp3->c_stream_end - 94, 30);
	mp3->w_myID3.artist[30] = 0;
	RemoveEndingSpaces(mp3->w_myID3.artist);

	memcpy(mp3->w_myID3.album, mp3->c_stream_end - 64, 30);
	mp3->w_myID3.album[30] = 0;
	RemoveEndingSpaces(mp3->w_myID3.album);

	memcpy(mp3->w_myID3.year, mp3->c_stream_end - 34, 4);
	mp3->w_myID3.year[4] = 0;
	RemoveEndingSpaces(mp3->w_myID3.year);

	memcpy(mp3->w_myID3.comment, mp3->c_stream_end - 30, 30);
	mp3->w_myID3.comment[30] = 0;

	memcpy(mp3->w_myID3.genre, mp3->c_stream_end, 1);

	if((unsigned char)mp3->w_myID3.genre[0] > 146)
	{
	  *mp3->w_myID3.genre = 0;
	} else
	{
	  unsigned char tmp = mp3->w_myID3.genre[0];
	  _FREE(mp3->w_myID3.genre);
	  if(tmp > 147) tmp = 0;
	  mp3->w_myID3.genre = (char*)_ALLOC(strlen(sGenres[(BYTE)tmp]) + 1);
	  //strcpy(mp3->w_myID3.genre,sGenres[(BYTE) tmp]);
	  strncpy_s(mp3->w_myID3.genre, sizeof(mp3->w_myID3.genre), sGenres[(BYTE)tmp], _TRUNCATE);
	}

	BYTE tracknum = 0;
	if(mp3->w_myID3.comment[28] == 0)
	  tracknum = mp3->w_myID3.comment[29];
	_snprintf_s(mp3->w_myID3.tracknum, 4, _TRUNCATE, "%u", tracknum);
  }
	return TRUE;

  case ID3_VERSION2:
  {
	if(!mp3->c_ID3v2)
	{
	  mp3->error("WMp3::LoadID3->There is no ID3v2 tag");
	  return FALSE;
	}

	char tmpHeader[10];
	tmpHeader[0] = 0;
	DWORD dwRead;

	memcpy(mp3->w_myID3.Id3v2.Header, mp3->c_stream_start, 10);

	// check if correct header
	if(memcmp(mp3->w_myID3.Id3v2.Header, "ID3", 3) != 0)
	{
	  mp3->error("WMp3::LoadID3->There is no ID3v2 tag");

	  return FALSE;
	}

	// read flag field
	mp3->w_myID3.Id3v2._flags			  = (mp3->w_myID3.Id3v2.Header[5] & 255);
	mp3->w_myID3.Id3v2.Flags.Unsync		  = ExtractBits(mp3->w_myID3.Id3v2._flags, 7, 1);
	mp3->w_myID3.Id3v2.Flags.Extended	  = ExtractBits(mp3->w_myID3.Id3v2._flags, 6, 1);
	mp3->w_myID3.Id3v2.Flags.Experimental = ExtractBits(mp3->w_myID3.Id3v2._flags, 5, 1);
	mp3->w_myID3.Id3v2.Flags.Footer		  = ExtractBits(mp3->w_myID3.Id3v2._flags, 4, 1);

	// read size of tag
	mp3->w_myID3.Id3v2.Size = GetFourByteSyncSafe(mp3->w_myID3.Id3v2.Header[6], mp3->w_myID3.Id3v2.Header[7], mp3->w_myID3.Id3v2.Header[8], mp3->w_myID3.Id3v2.Header[9]);

	if(mp3->w_myID3.album) _FREE(mp3->w_myID3.album);
	mp3->w_myID3.album = 0;
	mp3->w_myID3.album = _RetrField(mp3, "TALB", &dwRead);
	_RemoveLeadingNULL(mp3->w_myID3.album, dwRead);

	if(mp3->w_myID3.artist) _FREE(mp3->w_myID3.artist);
	mp3->w_myID3.artist = 0;
	mp3->w_myID3.artist = _RetrField(mp3, "TPE1", &dwRead);
	_RemoveLeadingNULL(mp3->w_myID3.artist, dwRead);

	if(mp3->w_myID3.comment) _FREE(mp3->w_myID3.comment);
	mp3->w_myID3.comment = 0;
	mp3->w_myID3.comment = _RetrField(mp3, "COMM", &dwRead);
	DWORD newsize		 = _RemoveLeadingNULL(mp3->w_myID3.comment, dwRead);

	if(newsize < 2)
	{
	  _FREE(mp3->w_myID3.comment);
	  mp3->w_myID3.comment = 0;
	  mp3->w_myID3.comment = (char*)_ALLOC(2);
	  strncpy_s(mp3->w_myID3.comment, sizeof(mp3->w_myID3.comment), "", _TRUNCATE);
	  //strcpy(mp3->w_myID3.comment,"");
	} else
	{
	  char* tmp = (char*)memchr(mp3->w_myID3.comment, '\0', newsize - 1);
	  if(tmp)
	  {
		//strcpy(mp3->w_myID3.comment, tmp +1);
		strncpy_s(mp3->w_myID3.comment, sizeof(mp3->w_myID3.comment), tmp + 1, _TRUNCATE);
	  }
	}

	if(mp3->w_myID3.genre) _FREE(mp3->w_myID3.genre);
	mp3->w_myID3.genre = 0;
	mp3->w_myID3.genre = _RetrField(mp3, "TCON", &dwRead);
	_RemoveLeadingNULL(mp3->w_myID3.genre, dwRead);

	if(mp3->w_myID3.title) _FREE(mp3->w_myID3.title);
	mp3->w_myID3.title = 0;
	mp3->w_myID3.title = _RetrField(mp3, "TIT2", &dwRead);
	_RemoveLeadingNULL(mp3->w_myID3.title, dwRead);

	if(mp3->w_myID3.tracknum) _FREE(mp3->w_myID3.tracknum);
	mp3->w_myID3.tracknum = 0;
	mp3->w_myID3.tracknum = _RetrField(mp3, "TRCK", &dwRead);
	_RemoveLeadingNULL(mp3->w_myID3.tracknum, dwRead);

	if(mp3->w_myID3.year) _FREE(mp3->w_myID3.year);
	mp3->w_myID3.year = 0;
	mp3->w_myID3.year = _RetrField(mp3, "TYER", &dwRead);
	_RemoveLeadingNULL(mp3->w_myID3.year, dwRead);
  }
	return TRUE;
  }

  return FALSE;
}

char* WMp3::_RetrField(WMp3* mp3, char* identifier, DWORD* Size)
{
  //	return ID3v2 field
  // INPUT:   char *identifier		- field identifier
  //
  // OUTPUT:  DWORD& Size				- size of returned field
  // RETURN char*						- pointer to allocated memory with content of fiels
  //
  // REMARK:	if fiels isn't found function returns 0, and DWORD* Size is 0
  // user needs to _FREE memory returned from this function

  //int pointer = mp3->w_stream->GetStreamPointer();

  char tmpHeader[10];

  DWORD			 framesize;
  unsigned char* field;

  //	DWORD dwRead;

  DWORD			 dwSize = mp3->w_myID3.Id3v2.Size;
  unsigned char* pos	= mp3->c_stream_start + 10;

  // skip Extended header
  if(mp3->w_myID3.Id3v2.Flags.Extended)
  {
	memcpy(tmpHeader, pos, 4);
	pos += 4;
	DWORD extHdrSize = GetFourByteSyncSafe(tmpHeader[0], tmpHeader[1], tmpHeader[2], tmpHeader[3]);
	pos += extHdrSize;
	dwSize -= extHdrSize;
  }

  *Size = 0;
  BOOL ret;

  while(1)
  {
	// read frame header

	memcpy(tmpHeader, pos, 10);
	pos += 10;

	if(tmpHeader[0] == 0 || dwSize <= 0)
	{
	  char* tmp = (char*)_ALLOC(2);
	  tmp[0]	= 0;
	  return tmp;
	}
	// check frame ID
	ret = _DecodeFrameHeader(mp3, tmpHeader, identifier);
	if(ret)
	{
	  field = (unsigned char*)_ALLOC(mp3->w_ID3frame.Size + 1);

	  field[mp3->w_ID3frame.Size] = 0;

	  memcpy((char*)field, pos, mp3->w_ID3frame.Size);
	  pos += mp3->w_ID3frame.Size;

	  if(mp3->w_ID3frame.Flags.Unsynchronisation)
		*Size = _DecodeUnsync(field, mp3->w_ID3frame.Size);
	  else
		*Size = mp3->w_ID3frame.Size;

	  return (char*)field;
	} else
	{
	  // get frame size
	  if(mp3->w_ID3frame.Flags.Unsynchronisation)
		framesize = GetFourByteSyncSafe(tmpHeader[4], tmpHeader[5], tmpHeader[6], tmpHeader[7]);

	  else
		framesize = CreateFourByteField(tmpHeader[4], tmpHeader[5], tmpHeader[6], tmpHeader[7]);

	  pos += framesize;
	  dwSize -= (framesize + 10);
	}
  }

  char* tmp = (char*)_ALLOC(2);
  tmp[0]	= 0;

  return tmp;
}

DWORD WMp3::_RemoveLeadingNULL(char* str, DWORD size)
{
  // remove leading NULL from array - shift not NULL substr to left
  // INPUT: 	char *str		- input stream
  //          DWORD size		- size of input stream
  // RETURN: new size of input stream;
  if(!str)
	return 0;
  for(DWORD i = 0; i < size; i++)
  {
	if(str[i] > 0)
	{
	  for(DWORD j = 0; j < size - i; j++)
	  {
		str[j] = str[i + j];
	  }
	  for(DWORD k = size - i; k < size; k++)
		str[k] = 0;

	  return (size - i);
	}
  }

  return 0;
}

BOOL WMp3::_DecodeFrameHeader(WMp3* mp3, char* header, char* identifier)
{
  // decode frame header ( check FRAME ID, decode FLAG bits, get frame size)
  // frame header:
  // FRAME ID:	 $xx xx xx xx   ( 4 byte )
  // FRAME SIZE:   4 * %0xxxxxxx ( 4 byte )
  // FRAME FLAGS:	 $xx xx			( 2 bytes )
  //
  mp3->w_ID3frame.Flags.Tag_alter_preservation	= ExtractBits(header[8], 6, 1);
  mp3->w_ID3frame.Flags.File_alter_preservation = ExtractBits(header[8], 5, 1);
  mp3->w_ID3frame.Flags.Read_only				= ExtractBits(header[8], 4, 1);
  mp3->w_ID3frame.Flags.Grouping_identity		= ExtractBits(header[9], 6, 1);
  mp3->w_ID3frame.Flags.Compression				= ExtractBits(header[9], 3, 1);
  mp3->w_ID3frame.Flags.Encryption				= ExtractBits(header[9], 2, 1);
  mp3->w_ID3frame.Flags.Unsynchronisation		= ExtractBits(header[9], 1, 1);
  mp3->w_ID3frame.Flags.Data_length_indicator	= ExtractBits(header[9], 0, 1);

  mp3->w_ID3frame.Size = GetFourByteSyncSafe(header[4], header[5], header[6], header[7]);

  CreateFourByteField(header[4], header[5], header[6], header[7]);
  if(strncmp(header, identifier, 4) != 0)
	return FALSE;
  if(ExtractBits(header[9], 7, 1) || ExtractBits(header[9], 5, 1) || ExtractBits(header[9], 4, 1))
	return FALSE;

  return TRUE;
}

DWORD WMp3::_DecodeUnsync(unsigned char* header, DWORD size)
{
  DWORD count = 0;
  for(UINT i = 0; i < size - 2; i++)
  {
	if(header[i] == 0xFF && header[i + 1] == 0)
	{
	  header[i + 1] = header[i + 2];
	  count++;
	}
  }
  return count;
}

char* WMp3::GetMpegVersion()
{
  return c_mpeg_version_str;
}

char* WMp3::GetMpegLayer()
{
  return c_layer_str;
}

char* WMp3::GetChannelMode()
{
  return c_channel_str;
}

char* WMp3::GetEmphasis()
{
  return c_emphasis_str;
}

unsigned int WMp3::GetSamplingRate()
{
  return c_sampling_rate;
}

unsigned int WMp3::GetHeaderStart()
{
  return (unsigned int)(c_start - c_stream_start);
}

unsigned long Get32bits(unsigned char* buf)
{
  unsigned long ret;
  ret = (((unsigned long)buf[0]) << 24) |
		(((unsigned long)buf[1]) << 16) |
		(((unsigned long)buf[2]) << 8) |
		((unsigned long)buf[3]);

  return ret;
}

BOOL WMp3::Pause()
{
  if(!c_start)
  {
	error("WMp3::Pause->Strean isn't open!");
	return 0;
  }

  w_wave->Pause();
  c_pause = TRUE;
  return TRUE;
}

BOOL WMp3::Resume()
{
  if(!c_start)
  {
	error("WMp3::Pause->Strean isn't open!");
	return 0;
  }

  w_wave->Resume();
  c_pause = FALSE;
  return TRUE;
}

BOOL WMp3::Seek(unsigned int seconds)
{
  return SeekM(seconds * 1000);
}

BOOL WMp3::SeekM(unsigned int milliseconds)
{
  if(!c_start)
  {
	error("WMp3::SeekM->Strean isn't open!");
	return 0;
  }

  if(c_play)
  {
	Stop();
  }

  if(milliseconds > c_song_length_ms)
	milliseconds = c_song_length_ms;

  if(milliseconds == 0)
  {
  }

  if(c_valid_xing)
  {
	if((xing.flags & TAG_XING) && (xing.xing.flags & TAG_XING_TOC))
	{
	  double pa, pb, px;
	  double percentage = 100.0 * (double)milliseconds / (double)c_song_length_ms;

	  int perc = (int)percentage;
	  if(perc > 99) perc = 99;
	  pa = xing.xing.toc[perc];
	  if(perc < 99)
	  {
		pb = xing.xing.toc[perc + 1];
	  } else
	  {
		pb = 256;
	  }

	  px		 = pa + (pb - pa) * (percentage - perc);
	  c_position = c_start + (unsigned int)(((double)(c_size + c_xing_frame_size) / 256.0) * px);

	} else
	{
	  c_position = c_start + (unsigned int)((double)milliseconds / (double)c_song_length_ms * (double)c_size);
	}

  } else
  {
	c_position = c_start + (unsigned int)((double)milliseconds / (double)c_song_length_ms * (double)c_size);
  }

  c_nPosition = milliseconds;

  return TRUE;
}

unsigned int WMp3::GetCurrentBitrate()
{
  if(!c_start)
	return 0;

  return c_current_bitrate / 1000;
}

unsigned int WMp3::GetAvgBitrate()
{
  if(!c_start)
	return 0;

  if(c_frame_counter == 0)
	return 0;

  return c_bitrate_sum / c_frame_counter;
}

MP3_STATUS* WMp3::GetStatus()
{
  // status

  memset(&c_status, 0, sizeof(MP3_STATUS));

  c_status.stop = TRUE;

  if(c_play)
  {
	c_status.play = TRUE;
	c_status.stop = FALSE;
  }

  if(c_pause)
  {
	c_status.pause = TRUE;
	c_status.play  = FALSE;
	c_status.stop  = FALSE;
  }

  c_status.echo			   = c_echo;
  c_status.echo_mode	   = c_echo_mode;
  c_status.eq_external	   = c_bUseExternalEQ;
  c_status.eq_internal	   = c_bUseInternalEQ;
  c_status.vocal_cut	   = c_bVocalCut;
  c_status.channel_mix	   = c_mix_channels;
  c_status.fade_in		   = c_bFadeIn;
  c_status.fade_out		   = c_bFadeOut;
  c_status.internal_volume = c_internalVolume;
  c_status.loop			   = c_bLoop;

  return &c_status;
}

unsigned int WMp3::GetSongLength()
{
  return GetSongLengthM() / 1000;
}

unsigned int WMp3::GetSongLengthM()
{
  return c_song_length_ms;
}

unsigned int WMp3::GetFileBitrate()
{
  if(c_vbr)
	return (unsigned int)c_avg_bitrate / 1000;

  return c_bitrate / 1000;
}

char* WMp3::GetArtist() { return w_myID3.artist; }
char* WMp3::GetTrackTitle() { return w_myID3.title; }
char* WMp3::GetTrackNum() { return w_myID3.tracknum; }
char* WMp3::GetAlbum() { return w_myID3.album; }
char* WMp3::GetYear() { return w_myID3.year; }
char* WMp3::GetComment() { return w_myID3.comment; }

char* WMp3::GetGenre()
{
  if(w_myID3.genre)
	return w_myID3.genre;
  else
	return (char*)empty_string;
};

BOOL WMp3::OpenMp3Stream(char* memw_stream, DWORD size, int WaveBufferLength)
{
  if(c_stream_start)
  {
	error("WMp3::OpenMp3Stream->You need to close mp3 stream before open new one");
	return FALSE;
  }

  if(!memw_stream)
  {
	error("WMp3::OpenMp3Stream->Can't open NULL stream!");
	return FALSE;
  }

  c_stream_start = (unsigned char*)memw_stream;
  c_stream_size	 = size;
  c_stream_end	 = c_stream_start + c_stream_size - 1;

  return _OpenMp3(this, WaveBufferLength);
}

void WMp3::Close()
{
  if(!c_start) return;

  Stop();

  w_wave->Uninitialize();

  CloseHandle(w_hEvent);
  w_hEvent = 0;

  if(w_hFile != INVALID_HANDLE_VALUE)
  {
	UnmapViewOfFile(w_mapping);
	w_mapping = 0;
	CloseHandle(w_hFileMap);
	w_hFileMap = NULL;
	CloseHandle(w_hFile);
	w_hFile = INVALID_HANDLE_VALUE;
  }

  if(c_gapless_buffer)
	_FREE(c_gapless_buffer);

  c_gapless_buffer = 0;

  init(this);
}

BOOL WMp3::OpenMp3Resource(HMODULE hModule, LPCTSTR lpName, LPCTSTR lpType, int WaveBufferLength)
{
  return OpenMp3Resource(hModule, lpName, lpType, WaveBufferLength, 0, 0);
}

BOOL WMp3::OpenMp3Resource(HMODULE hModule, LPCTSTR lpName, LPCTSTR lpType, int WaveBufferLength, DWORD seek, DWORD size)
{
  if(c_stream_start)
  {
	error("WMp3::OpenMp3Resource->You need to close mp3 stream before open new one");
	return FALSE;
  }

  HRSRC hrSrc = FindResource(hModule, lpName, lpType);
  if(!hrSrc)
  {
	error("WMp3::OpenMp3Resource->Can't find resource!");
	return FALSE;
  }

  HGLOBAL hRes = LoadResource(hModule, hrSrc);

  if(!hRes)
  {
	error("WMp3::OpenMp3Resource->Can't load resource!");
	return FALSE;
  }

  char* res = (char*)LockResource(hRes);

  if(!res)
  {
	error("WMp3::OpenMp3Resource->Can't lock resource");
	return FALSE;
  }

  c_stream_size = SizeofResource(hModule, hrSrc);
  if(c_stream_size == 0)
  {
	error("WMp3::OpenMp3Resource->Can't get resource size!");
	return FALSE;
  }

  if(seek >= c_stream_size)
  {
	error("WMp3::OpenMp3Resource->Seek value out of range");
	c_stream_size = 0;
	return 0;
  }

  if(size > (c_stream_size - seek))
  {
	error("WMp3::OpenMp3Resource->Size value out of range");
	c_stream_size = 0;
	return 0;
  }

  c_stream_start = (unsigned char*)res;
  if(size)
	c_stream_size = size;

  c_stream_end = c_stream_start + c_stream_size - 1;

  return _OpenMp3(this, WaveBufferLength);
}

void WMp3::SetVolume(unsigned int lvolume, unsigned int rvolume)
{
  if(lvolume > 100)
	lvolume = 100;

  if(rvolume > 100)
	rvolume = 100;

  if(c_internalVolume)
  {
	c_lvolume = (short)lvolume;
	c_rvolume = (short)rvolume;
	gain[0]	  = lvolume * m_fFadeByWindow < 100 ? mad_f_tofixed(pow(10.0, (double)lvolume * m_fFadeByWindow / 100) / 10.0 - 0.1) : MAD_F_ONE;
	gain[1]	  = rvolume * m_fFadeByWindow < 100 ? mad_f_tofixed(pow(10.0, (double)rvolume * m_fFadeByWindow / 100) / 10.0 - 0.1) : MAD_F_ONE;

  } else
  {
	unsigned int l = (unsigned int)(lvolume < 100 ? ((pow(10.0, (double)lvolume / 100) / 10.0 - 0.1) * 65535.0) : 65535);
	unsigned int r = (unsigned int)(rvolume < 100 ? ((pow(10.0, (double)rvolume / 100) / 10.0 - 0.1) * 65535.0) : 65535);
	w_wave->SetVolume((unsigned short)l, (unsigned short)r);
  }
}

/*-------------------------------------------------------------------------------
应用程序切换到背景时，将音量适当降低，使用这个命令 by Waiting 2009-06-22
1.0f 正常播放		应用程序在前景
0.0f 静音			缩到最小,或完全被其它应用程序遮挡
0.5f 一半的音量		应用程序露出了一部分
-------------------------------------------------------------------------------*/
void WMp3::FadeByWindow(float fFade)
{
  if(m_fFadeByWindow != fFade)
  {
	m_fFadeByWindow += (fFade - m_fFadeByWindow) / 4; //平滑关掉背景音乐
	if(abs(m_fFadeByWindow - fFade) < 0.1f)
	  m_fFadeByWindow = fFade;

	if(c_internalVolume)
	{
	  gain[0] = c_lvolume * m_fFadeByWindow < 100 ? mad_f_tofixed(pow(10.0, (double)c_lvolume * m_fFadeByWindow / 100) / 10.0 - 0.1) : MAD_F_ONE;
	  gain[1] = c_rvolume * m_fFadeByWindow < 100 ? mad_f_tofixed(pow(10.0, (double)c_rvolume * m_fFadeByWindow / 100) / 10.0 - 0.1) : MAD_F_ONE;
	} else
	{
	  //not support!
	}
  }
}

void WMp3::GetVolume(unsigned int* lvolume, unsigned int* rvolume)
{
  if(c_internalVolume)
  {
	*lvolume = c_lvolume;
	*rvolume = c_rvolume;

  } else
  {
	w_wave->GetVolume((WORD*)lvolume, (WORD*)rvolume);
	*lvolume = *lvolume * 100 / 65535;
	*rvolume = *rvolume * 100 / 65535;
  }
}

void CALLBACK WMp3::_WaveOutProc(HWAVEOUT hwo, UINT uMsg, DWORD dwInstance,
								 DWORD dwParam1, DWORD dwParam2)
{
  WMp3*	   mp3	  = (WMp3*)dwInstance;
  WAVEHDR* header = (WAVEHDR*)dwParam1;
  switch(uMsg)
  {
  case WOM_OPEN:
	break;

  case WOM_CLOSE:
	break;

  case WOM_DONE:
  {
	mp3->c_dwPos += header->dwBufferLength;

	if(header->dwUser == mp3->w_wave->GetNumOfBuffers() - 1)
	  mp3->c_dwIndex = 0;
	else
	  mp3->c_dwIndex = (DWORD)header->dwUser + 1;

	::SetEvent(mp3->w_hEvent);
	mp3->c_vudata_ready = TRUE;
  }
  break;
  }
}

void WMp3::error(char* err_message)
{
  size_t size = 0;
  if(err_message != 0)
  {
	size = strlen(err_message);
	size = (size > ERRORMESSAGE_SIZE) ? (ERRORMESSAGE_SIZE - 1) : size;
	//strncpy(_lpErrorMessage, err_message, size);
	strncpy_s(_lpErrorMessage, size, err_message, _TRUNCATE);
	if(size >= 1024)
	{
	  IP("III_sideinfo error4 %d", size);
	}
	_lpErrorMessage[size] = 0;
  }
  _lpErrorMessage[size] = 0;
}

unsigned long WMp3::_Get32bits(unsigned char* buf)
{
  unsigned long ret;
  ret = (((unsigned long)buf[0]) << 24) |
		(((unsigned long)buf[1]) << 16) |
		(((unsigned long)buf[2]) << 8) |
		((unsigned long)buf[3]);

  return ret;
}

void WMp3::GetVUData(unsigned int* left, unsigned int* right)
{
  // return data for VU meter
  *left	 = 0;
  *right = 0;

  if(!c_start || !c_play || !c_vudata_ready)
	return;

  short* left1;
  short* right1;
  real	 sum_left = 0;
  real	 avg_left;
  real	 sumww_right = 0;
  real	 avgww_right;
  real	 num = 0;
  real	 la;
  real	 ra;

  // current playing position ( bytes )
  unsigned int pos = w_wave->GetPosition(BYTES);
  // wave output buffer size ( bytes )
  unsigned int buff_size = w_wave->GetBufferSize(c_dwIndex);

  // current playing wave buffer
  char* data = w_wave->GetBufferData(c_dwIndex);

  unsigned int num_chunk = 2;

  unsigned int size = buff_size / num_chunk;

  DWORD offset;

  if(c_channel == 2)
  {
	if(num_chunk >= 2)
	{
	  offset = pos - c_dwPos;
	  if(offset > buff_size)
	  {
		if(c_dwIndex == w_wave->GetNumOfBuffers() - 1)
		  c_dwIndex = 0;
		else
		  c_dwIndex++;

		offset = 0;
		data   = w_wave->GetBufferData(c_dwIndex);
	  }

	  if(offset + size + 4 > buff_size)
	  {
		offset = buff_size - size - 4;
	  }

	} else
	{
	  offset = 0;
	}

	for(DWORD i = 0; i < size; i += 4)
	{
	  left1 = (short*)(data + i + offset);
	  sum_left += (real)abs(*left1);
	  right1 = (short*)(data + i + offset + 2);
	  sumww_right += (real)abs(*right1);
	  num++;
	}

	avg_left	= sum_left / num;
	avgww_right = sumww_right / num;

	if(avg_left < 21.61)
	  *left = 0;
	else
	{
	  la	= avg_left / AVG_SINE_16;
	  *left = (unsigned int)(100 + (33.0 * log10(la)));
	  if(*left > 100)
		*left = 100;
	}

	if(avgww_right < 21.61)
	  *right = 0;
	else
	{
	  ra	 = avgww_right / AVG_SINE_16;
	  *right = (unsigned int)(100 + (33.0 * log10(ra)));
	  if(*right > 100)
		*right = 100;
	}

  } else if(c_channel == 1)
  {
	if(num_chunk >= 2)
	{
	  offset = pos - c_dwPos;
	  if(offset > buff_size)
	  {
		if(c_dwIndex == w_wave->GetNumOfBuffers() - 1)
		  c_dwIndex = 0;
		else
		  c_dwIndex++;

		offset = 0;
		data   = w_wave->GetBufferData(c_dwIndex);
	  }

	  if(offset + size + 2 > buff_size)
	  {
		offset = buff_size - size - 2;
	  }

	} else
	{
	  offset = 0;
	}

	for(DWORD i = 0; i < size; i += 2)
	{
	  left1 = (short*)(data + i + offset);
	  sum_left += (real)abs(*left1);
	  num++;
	}

	avg_left = sum_left / num;

	if(avg_left < 21.61)
	{
	  *left	 = 0;
	  *right = 0;
	} else
	{
	  la	= avg_left / AVG_SINE_16;
	  *left = (unsigned int)(100 + (33 * log10(la)));
	  if(*left > 100)
		*left = 100;

	  *right = *left;
	}
  }
}

void RemoveEndingSpaces(char* buff)
{
  //int size = strlen(buff);
  int size = (int)strlen(buff);
  for(int i = size - 1; i >= 0; i--)
  {
	if(buff[i] == ' ')
	  buff[i] = 0;
	else
	  return;
  }
}

void WMp3::DoEcho(WMp3* mp3, short* buf, unsigned int len)
{
  unsigned int i;
  unsigned int j;
  unsigned int sample_num = len / 2;

  for(i = ECHO_BUFFER_NUMBER - 1; i > 0; i--)
  {
	mp3->sfx_buffer1[i] = mp3->sfx_buffer1[i - 1];
  }

  mp3->sfx_buffer1[0] = mp3->sfx_buffer1[ECHO_BUFFER_NUMBER - 1];

  for(i = 0; i < sample_num; i++)
  {
	buf[i] /= 2;
  }

  CopyMemory(mp3->sfx_buffer1[0], buf, len);

  // do echo efect

  real e;
  real f;
  int  a;

  for(i = 0; i < sample_num; i++)
  {
	e = 0;
	f = 0;

	for(j = 0; j < ECHO_MAX_DELAY_NUMBER; j++)
	{
	  if(mp3->c_sfx_mode_l[j])
		e += (real)mp3->sfx_buffer1[j + mp3->c_sfx_offset][i] * mp3->c_sfx_mode_l[j];

	  if(mp3->c_sfx_mode_r[j])
		f += (real)mp3->sfx_buffer1[j + mp3->c_sfx_offset][i + 1] * mp3->c_sfx_mode_r[j];
	}

	a = (int)(e * mp3->c_rEgOg + (real)buf[i] * mp3->c_rIgOg);

	if(a > 32767)
	  a = 32767;

	if(a < -32768)
	  a = -32768;

	buf[i] = (short)a;

	i++;

	a = (int)(f * mp3->c_rEgOg + (real)buf[i] * mp3->c_rIgOg);

	if(a > 32767)
	  a = 32767;

	if(a < -32768)
	  a = -32768;

	buf[i] = (short)a;
  }
}

void WMp3::ClearSfxBuffers()
{
  // clear all buffers to 0
  if(sfx_buffer[0] != NULL)
  {
	for(unsigned int i = 0; i < ECHO_BUFFER_NUMBER; i++)
	  ZeroMemory(sfx_buffer[i], c_echo_alloc_buffer_size);
  }
}

BOOL WMp3::SetSfxParam(BOOL fEnable, int iMode, int uDelayMs, int InputGain, int EchoGain, int OutputGain)
{
  c_echo = FALSE;

  EnterCriticalSection(&c_wcsSfx);

  if(uDelayMs < 0)
	uDelayMs = 0;

  if(uDelayMs > MAX_DELAY)
	uDelayMs = MAX_DELAY;

  if(iMode > NUM_SFX_MODE - 1)
	iMode = NUM_SFX_MODE - 1;

  int i;

  int mode = iMode * 2;

  for(i = 0; i < ECHO_MAX_DELAY_NUMBER; i++)
  {
	c_sfx_mode_l[i] = sfx_mode[mode][i];
	if(c_channel > 1)
	  c_sfx_mode_r[i] = sfx_mode[mode + 1][i];
	else
	  c_sfx_mode_r[i] = c_sfx_mode_l[i];
  }

  c_echo_mode = iMode;

  if(fEnable)
  { // need echo
	// if buffer size changed allocate new buffer
	if(reallocate_sfx_buffers(this) == 0)
	  return FALSE;

	if(InputGain < -12)
	  InputGain = -12;

	if(InputGain > 12)
	  InputGain = 12;

	if(EchoGain < -12)
	  EchoGain = -12;

	if(EchoGain > 12)
	  EchoGain = 12;

	if(OutputGain < -12)
	  OutputGain = -12;

	if(OutputGain > 12)
	  OutputGain = 12;

	c_rIgOg = pow(10.0, (double)((double)(InputGain + OutputGain) / 20));
	c_rEgOg = pow(10.0, (double)((double)(EchoGain + OutputGain) / 20));

	c_delay = uDelayMs;

	c_sfx_offset = ECHO_MAX_DELAY_NUMBER * c_delay / MAX_DELAY;

	ClearSfxBuffers();

  } else
  { // disable echo
	c_echo				   = fEnable;
	c_old_echo_buffer_size = 0;
	// _FREE buffers

	if(sfx_buffer[0])
	{
	  for(int i = 0; i < ECHO_BUFFER_NUMBER; i++)
	  {
		_FREE(sfx_buffer[i]);
		sfx_buffer[i]  = 0;
		sfx_buffer1[i] = 0;
	  }
	}
  }

  LeaveCriticalSection(&c_wcsSfx);
  c_echo = fEnable;

  return TRUE;
}

void WMp3::EnableEQ(BOOL fEnable, BOOL fExternal)
{
  if(fEnable)
  {
	if(fExternal)
	{ // enable external equalizer
	  c_bUseExternalEQ = TRUE;

	} else
	{ // enable internal libmad equalizer
	  c_bUseInternalEQ = TRUE;
	}
  } else
  {
	if(fExternal)
	{
	  c_bUseExternalEQ = FALSE;
	} else
	{
	  c_bUseInternalEQ = FALSE;
	}
  }
}

void WMp3::SetEQParam(BOOL fExternal, int iPreAmpValue, EQ_PARAM values)
{
  // iPreAmpValue: -dB, 0, + dB
  // iValue:		-dB, 0, +dB

  int	 i;
  double AmpFactor;
  double max = mad_f_todouble(MAD_F_MAX);

  if(iPreAmpValue < -12)
	iPreAmpValue = -12;

  if(iPreAmpValue > 12)
	iPreAmpValue = 12;

  for(i = 0; i < 10; i++)
  {
	if(values[i] < -12)
	  values[i] = -12;

	if(values[i] > 12)
	  values[i] = 12;
  }

  if(!fExternal)
  { // set parameters for internal equalizer

	c_EqFilter[0]  = values[0];
	c_EqFilter[1]  = values[1];
	c_EqFilter[2]  = values[2];
	c_EqFilter[3]  = values[3];
	c_EqFilter[4]  = values[4];
	c_EqFilter[5]  = values[5];
	c_EqFilter[6]  = values[5];
	c_EqFilter[7]  = values[5];
	c_EqFilter[8]  = values[6];
	c_EqFilter[9]  = values[6];
	c_EqFilter[10] = values[6];
	c_EqFilter[11] = values[6];
	c_EqFilter[12] = values[6];
	c_EqFilter[13] = values[6];
	c_EqFilter[14] = values[7];
	c_EqFilter[15] = values[7];
	c_EqFilter[16] = values[7];
	c_EqFilter[17] = values[7];
	c_EqFilter[18] = values[7];
	c_EqFilter[19] = values[8];
	c_EqFilter[20] = values[8];
	c_EqFilter[21] = values[8];
	c_EqFilter[22] = values[8];
	c_EqFilter[23] = values[8];
	c_EqFilter[24] = values[9];
	c_EqFilter[25] = values[9];
	c_EqFilter[26] = values[9];
	c_EqFilter[27] = values[9];
	c_EqFilter[28] = values[9];
	c_EqFilter[29] = values[9];
	c_EqFilter[30] = values[9];
	c_EqFilter[31] = values[9];

	for(i = 0; i < 32; i++)
	{
	  AmpFactor = pow(10.0, (double)((double)(c_EqFilter[i] + iPreAmpValue) / 20));
	  if(AmpFactor > max)
		AmpFactor = max;

	  c_EqFilter[i] = mad_f_tofixed(AmpFactor);
	}

	return;
  }

  // set parameters for internal equalizer

  // 55,77,110
  c_eq[0] = values[0];
  c_eq[1] = values[0];
  c_eq[2] = values[0];
  // 156, 220
  c_eq[3] = values[1];
  c_eq[4] = values[1];
  // 311,440
  c_eq[5] = values[2];
  c_eq[6] = values[2];
  // 622,880
  c_eq[7] = values[3];
  c_eq[8] = values[3];
  // 1244,1760
  c_eq[9]  = values[4];
  c_eq[10] = values[4];
  // 2489,3520
  c_eq[11] = values[5];
  c_eq[12] = values[5];
  // 4978
  c_eq[13] = values[6];
  // 	7040
  c_eq[14] = values[7];
  // 9956
  c_eq[15] = values[8];
  // 14080,19912
  c_eq[16] = values[9];
  c_eq[17] = values[9];

  for(i = 0; i < 18; i++)
  {
	AmpFactor	= pow(10.0, (double)((double)(c_eq[i] + iPreAmpValue) / 20));
	c_lbands[i] = (REAL)AmpFactor;
	c_rbands[i] = (REAL)AmpFactor;
  }

  c_bChangeEQ = TRUE;
}

void WMp3::VocalCut(BOOL fEnable)
{
  c_bVocalCut = fEnable;
}

void WMp3::InternalVolume(BOOL fEnable)
{
  c_internalVolume = fEnable;
}

int WMp3::_OpenMp3(WMp3* mp3, int WaveBufferLength)
{
  // open mp3 file
  // INPUT:	WMp3* mp3	- valid mp3 class pointer
  //			char* stream	- mp3 memory stream
  //			WaveBufferLength	- wave buffer length in milliseconds ( this value will be divided into small 100 ms buffers
  //			DWORD seek			- if you need to skip some data in stream, e.g. set real stream beginning to new position
  //			DWORD size			- size of stream, if you seek stream, set correct size, if size = 0 stream size is calculated

  unsigned char* tmp = 0;

  struct mad_stream stream;
  struct mad_frame	frame;
  struct mad_header header;

  mp3->c_ID3v1 = FALSE;
  mp3->c_ID3v2 = FALSE;

  mp3->c_start	  = mp3->c_stream_start;
  mp3->c_end	  = mp3->c_stream_end;
  mp3->c_position = mp3->c_stream_start;
  mp3->c_size	  = mp3->c_stream_size;

  // now we need to find first valid mp3 frame

  // 1. check for ID3 tags
  //
  // 1.1 check for ID3v1 tag

  if(mp3->c_size > 128 && memcmp(mp3->c_end - 127, "TAG", 3) == 0)
  { // we found ID3v1 tag
	mp3->c_end -= 128;
	mp3->c_size -= 128;
	mp3->c_ID3v1 = TRUE;
  }

  // 1.2 check for ID3v2 tag

  if((mp3->c_size > 10) && (memcmp(mp3->c_start, "ID3", 3) == 0) &&
	 mp3->c_start[6] < 0x80 && mp3->c_start[7] < 0x80 &&
	 mp3->c_start[8] < 0x80 && mp3->c_start[9] < 0x80)
  { // we found ID3v1 tag
	// calculate ID3v2 frame size
	unsigned int id3v2_size = GetFourByteSyncSafe(mp3->c_start[6],
												  mp3->c_start[7], mp3->c_start[8], mp3->c_start[9]);

	// add ID3v2 header
	id3v2_size += 10;
	if(mp3->c_size > (id3v2_size + MIN_FRAME_SIZE))
	{
	  mp3->c_ID3v2 = TRUE;

	  if(SKIP_ID3TAG_AT_BEGINNING && (*(mp3->c_start + id3v2_size) == 0xFF) && ((*(mp3->c_start + id3v2_size + 1) & 0xE0) == 0xE0))
	  {
		mp3->c_start += id3v2_size;
		mp3->c_size -= id3v2_size;
	  }
	}
  }

  // now we have clear mp3 stream without ID3 tags
  //
  // 2. seek across the stream and find first valid mp3 frame

  if(mp3->c_size < MAD_BUFFER_GUARD)
  {
	mp3->error("WMp3::_OpenMp3->Invalid stream!");
	mp3->init(mp3);
	return FALSE;
  }

  mad_stream_init(&stream);
  mad_frame_init(&frame);
  mad_header_init(&header);

  mad_stream_buffer(&stream, mp3->c_start, mp3->c_size - MAD_BUFFER_GUARD);

  unsigned char* first_frame = mp3->c_start;

  // searching for first mp3 frame
  while(1)
  {
	while(mad_frame_decode(&frame, &stream))
	{
	  if(MAD_RECOVERABLE(stream.error))
		continue;

	  mp3->error("WMp3::_OpenMp3->Can't find first valid mp3 frame");
	  mad_stream_finish(&stream);
	  mad_frame_finish(&frame);
	  mad_header_finish(&header);

	  mp3->init(mp3);
	  return FALSE;
	}

	first_frame = (unsigned char*)stream.this_frame;

	// we have possible first frame, but we need more checking, now we will check more frames

	// remember some infos about stream

	mp3->c_sampling_rate	= frame.header.samplerate;
	mp3->c_layer			= frame.header.layer;
	mp3->c_mode				= frame.header.mode;
	mp3->c_channel			= (frame.header.mode == MAD_MODE_SINGLE_CHANNEL) ? 1 : 2;
	mp3->c_emphasis			= frame.header.emphasis;
	mp3->c_mode_extension	= frame.header.mode_extension;
	mp3->c_bitrate			= frame.header.bitrate;
	mp3->c_flags			= frame.header.flags;
	mp3->c_avg_bitrate		= 0;
	mp3->c_duration			= frame.header.duration;
	mp3->c_sample_per_frame = (frame.header.flags & MAD_FLAG_LSF_EXT) ? 576 : 1152;

	if((mp3->c_flags & MAD_FLAG_MPEG_2_5_EXT))
	{
	  mp3->c_mpeg_version	  = MPEG25;
	  mp3->c_mpeg_version_str = "MPEG Version 2.5";
	} else if((mp3->c_flags & MAD_FLAG_LSF_EXT))
	{
	  mp3->c_mpeg_version	  = MPEG2;
	  mp3->c_mpeg_version_str = "MPEG Version 2";
	} else
	{
	  mp3->c_mpeg_version	  = MPEG1;
	  mp3->c_mpeg_version_str = "MPEG Version 1";
	}

	switch(mp3->c_layer)
	{
	case MAD_LAYER_I:
	  mp3->c_layer_str = "Layer I";
	  break;

	case MAD_LAYER_II:
	  mp3->c_layer_str = "Layer II";
	  break;

	case MAD_LAYER_III:
	  mp3->c_layer_str = "Layer III";
	  break;

	default:
	  mp3->c_layer_str = "reserved";
	  break;
	}

	switch(mp3->c_mode)
	{
	case MAD_MODE_SINGLE_CHANNEL:
	  mp3->c_channel_str = "Single channel (Mono)";
	  break;

	case MAD_MODE_DUAL_CHANNEL:
	  mp3->c_channel_str = "Dual channel (Stereo)";
	  break;

	case MAD_MODE_JOINT_STEREO:
	  mp3->c_channel_str = "Joint stereo (Stereo)";
	  break;

	case MAD_MODE_STEREO:
	  mp3->c_channel_str = "Stereo";
	  break;
	}

	switch(mp3->c_emphasis)
	{
	case MAD_EMPHASIS_NONE:
	  mp3->c_emphasis_str = "none";
	  break;

	case MAD_EMPHASIS_50_15_US:
	  mp3->c_emphasis_str = "50/15 ms";
	  break;

	case MAD_EMPHASIS_CCITT_J_17:
	  mp3->c_emphasis_str = "CCIT J.17";
	  break;

	case MAD_EMPHASIS_RESERVED:
	  mp3->c_emphasis_str = "reserved";
	  break;
	}

	// check next frame
	if(mad_frame_decode(&frame, &stream))
	{
	  if(MAD_RECOVERABLE(stream.error))
		continue;

	  mp3->error("WMp3::_OpenMp3->Can't find first valid mp3 frame");
	  mad_stream_finish(&stream);
	  mad_frame_finish(&frame);
	  mad_header_finish(&header);
	  mp3->init(mp3);
	  return FALSE;
	} else
	{
	  // more checkinh
	  if(mp3->c_sampling_rate != frame.header.samplerate ||
		 mp3->c_layer != frame.header.layer)
		continue;

	  break;
	}
  }

  // now we have valid first frame

  //mp3->c_size -= (first_frame - mp3->c_start);
  mp3->c_size -= (unsigned int)(first_frame - mp3->c_start);

  mp3->c_start = first_frame;

  if(mp3->c_size < MAD_BUFFER_GUARD)
  {
	mp3->error("WMp3::_OpenMp3->Can't find first valid mp3 frame");
	mad_stream_finish(&stream);
	mad_frame_finish(&frame);
	mad_header_finish(&header);
	mp3->init(mp3);
	return FALSE;
  }

  // 3. calculate length of stream
  //
  // 3.1. check if first frame is XING frame

  // set stream to beginning

  mp3->c_valid_xing = FALSE;

  mad_stream_buffer(&stream, mp3->c_start, mp3->c_size - MAD_BUFFER_GUARD);

  if(mad_frame_decode(&frame, &stream) == 0)
  {
	// check if first frame is XING frame

	if(tag_parse(&mp3->xing, &stream, &frame) == 0)
	{
	  if(mp3->xing.flags & TAG_XING)
	  { // we have XING frame
		// calculate song length
		if((mp3->xing.xing.flags & TAG_XING_FRAMES) && mp3->xing.xing.flags & TAG_XING_TOC)
		{
		  mp3->c_song_length_frames	 = (unsigned int)mp3->xing.xing.frames;
		  mp3->c_song_length_samples = mp3->c_song_length_frames * mp3->c_sample_per_frame;
		  mp3->c_song_length_ms		 = (unsigned int)(1000.0 * (double)mp3->c_song_length_frames * (double)mp3->c_sample_per_frame / (double)mp3->c_sampling_rate);

		  // skip XING frame

		  //mp3->c_size -= ( stream.next_frame - mp3->c_start);
		  mp3->c_size -= (unsigned int)(stream.next_frame - mp3->c_start);
		  mp3->c_start = (unsigned char*)stream.next_frame;

		  mp3->c_song_length_bytes = mp3->c_size;
		  mp3->c_avg_frame_size	   = (float)((double)mp3->c_song_length_bytes / (double)mp3->c_song_length_frames);
		  mp3->c_avg_bitrate	   = (float)((double)mp3->c_song_length_bytes * 8 / (double)mp3->c_song_length_frames * (double)mp3->c_sampling_rate / (double)mp3->c_sample_per_frame);

		  //mp3->c_xing_frame_size = stream.next_frame - stream.this_frame;
		  mp3->c_xing_frame_size = (unsigned int)(stream.next_frame - stream.this_frame);
		  //mp3->c_vbr = 1;
		  mp3->c_valid_xing = TRUE;
		}
	  }
	}
  }

  if(mp3->c_size < MAD_BUFFER_GUARD)
  {
	mp3->error("WMp3::_OpenMp3->Can't find first valid mp3 frame");
	mad_stream_finish(&stream);
	mad_frame_finish(&frame);
	mad_header_finish(&header);
	mp3->init(mp3);
	return FALSE;
  }

  //	if(!mp3->c_valid_xing) { // we don't have valid XING frame
  if(1)
  {
	// scan mp3 file and check if CBR or VBR

	mad_stream_buffer(&stream, mp3->c_start, mp3->c_size);

	unsigned int frame_num = 0;
	mp3->c_vbr			   = 0;
	unsigned int size	   = 0;

	tmp = 0;
	while(frame_num < SEARCH_DEEP_VBR)
	{
	  if(mad_header_decode(&header, &stream))
	  {									  // if some error
		if(MAD_RECOVERABLE(stream.error)) // if recoverable error continue
		  continue;

		if(stream.error == MAD_ERROR_BUFLEN)
		{ // if buffer end
		  if(tmp)
		  {
			_FREE(tmp);
			tmp = 0;
			break;
		  }
		  // fix MAD_BUFFER_GUARD problem
		  //unsigned int len = mp3->c_end + 1 - stream.this_frame;
		  unsigned int len = (unsigned int)(mp3->c_end + 1 - stream.this_frame);
		  tmp			   = (unsigned char*)_ALLOC(len + MAD_BUFFER_GUARD);
		  if(!tmp)
			break;

		  // copy last frame into buffer and add MAD_BUFFER_GUARD zero bytes to end
		  memcpy(tmp, stream.this_frame, len);
		  memset(tmp + len, 0, MAD_BUFFER_GUARD);
		  mad_stream_buffer(&stream, tmp, len + MAD_BUFFER_GUARD);
		  continue;
		}
	  }

	  if(header.bitrate != mp3->c_bitrate) // bitrate changed
		mp3->c_vbr = 1;

	  size += header.size;
	  frame_num++;
	}

	if(tmp)
	  _FREE(tmp);

	tmp = 0;

	if(!mp3->c_valid_xing && mp3->c_vbr)
	{
	  mp3->c_song_length_frames	 = (unsigned int)((double)frame_num * (double)mp3->c_size / (double)size);
	  mp3->c_song_length_samples = mp3->c_song_length_frames * mp3->c_sample_per_frame;
	  mp3->c_song_length_ms		 = (unsigned int)(1000.0 * (double)mp3->c_song_length_frames * (double)mp3->c_sample_per_frame / (double)mp3->c_sampling_rate);
	  mp3->c_song_length_bytes	 = mp3->c_size;
	  mp3->c_avg_frame_size		 = (float)((double)size / (double)frame_num);
	  mp3->c_avg_bitrate		 = (float)((double)mp3->c_song_length_bytes * 8 / (double)mp3->c_song_length_frames * (double)mp3->c_sampling_rate / (double)mp3->c_sample_per_frame);
	} else if(!mp3->c_valid_xing)
	{
	  // CBR file
	  mp3->c_avg_bitrate		 = (float)mp3->c_bitrate;
	  double length				 = (double)mp3->c_size * 8.0 / ((double)mp3->c_avg_bitrate / 1000.0);
	  mp3->c_song_length_ms		 = (unsigned int)length;
	  mp3->c_song_length_frames	 = (unsigned int)ceil(length / 1000 * (double)mp3->c_sampling_rate / (double)mp3->c_sample_per_frame);
	  mp3->c_song_length_samples = mp3->c_song_length_frames * mp3->c_sample_per_frame;
	  mp3->c_song_length_bytes	 = mp3->c_size;
	  mp3->c_avg_frame_size		 = (float)((double)mp3->c_size / (double)mp3->c_song_length_frames);
	}
  }

  mad_stream_finish(&stream);
  mad_frame_finish(&frame);
  mad_header_finish(&header);

  // initalize wave out

  // check buffer length, we need at least 200 ms,
  if(WaveBufferLength < 200)
  {
	mp3->error("WMp3::_Open->Buffer can't be smaller than 200 ms");
	mp3->init(mp3);
	return FALSE;
  }

  // create event, this event controls playing thread
  if((mp3->w_hEvent = CreateEvent(NULL, FALSE, FALSE, NULL)) == NULL)
  {
	mp3->error("WMp3::_Open->Can't create event");
	mp3->init(mp3);
	return FALSE;
  }

  // calculate number of mp3 frames to fill one internal wave buffer ( ~ 100 ms )

  mp3->c_input_buffer_size = MulDiv(SINGLE_AUDIO_BUFFER_SIZE, mp3->c_sampling_rate, 1000 * mp3->c_sample_per_frame);

  if(mp3->c_input_buffer_size == 0)
  {
	mp3->error("WMp3::_Open->SINGLE_AUDIO_BUFFER_SIZE is too small!");
	CloseHandle(mp3->w_hEvent);
	mp3->init(mp3);
	return FALSE;
  }

  // calculate size of single wave buffer ( in milliseconds )
  int single_audio_buffer_len = MulDiv(mp3->c_input_buffer_size, mp3->c_sample_per_frame * 1000, mp3->c_sampling_rate) + 1;

  // now, divide wave buffer length into number of small wave buffers
  int WaveBufferNum = MulDiv(WaveBufferLength, 1, single_audio_buffer_len - 1);

  // initialize wave out, sampling rate, channel, bits per sample, ...
  if(!mp3->w_wave->Initialize(WAVE_FORMAT_PCM, (WORD)mp3->c_channel, mp3->c_sampling_rate, 16,
							  WaveBufferNum, single_audio_buffer_len))
  {
	mp3->error("WMp3::_Open->Can't initialize wave out");
	CloseHandle(mp3->w_hEvent);
	mp3->init(mp3);
	return FALSE;
  }

  // calculate size for one echo buffer ( ~ 50 ms )
  mp3->c_echo_alloc_buffer_size = mp3->w_wave->GetBufferAllocSize() / 2 + 2;

  if(mp3->c_echo)
  {
	if(reallocate_sfx_buffers(mp3) == 0)
	{
	  mp3->error("WMp3::_Open->Can't allocate echo buffer");
	  CloseHandle(mp3->w_hEvent);
	  mp3->init(mp3);
	  return FALSE;
	}
  }

  mp3->c_gapless_buffer = (char*)_ALLOC(mp3->w_wave->GetBufferAllocSize());
  if(!mp3->c_gapless_buffer)
  {
	mp3->error("WMp3::_Open->Can't allocate gapless buffer");
	CloseHandle(mp3->w_hEvent);
	mp3->init(mp3);
	return FALSE;
  }

  // change or not change external equalizer tables
  if(mp3->c_old_sampling_rate != mp3->c_sampling_rate)
	mp3->c_bChangeEQ = TRUE;

  int mode = mp3->c_echo_mode * 2;

  for(int i = 0; i < ECHO_MAX_DELAY_NUMBER; i++)
  {
	mp3->c_sfx_mode_l[i] = sfx_mode[mode][i];
	if(mp3->c_channel > 1)
	  mp3->c_sfx_mode_r[i] = sfx_mode[mode + 1][i];
	else
	  mp3->c_sfx_mode_r[i] = mp3->c_sfx_mode_l[i];
  }

  // latency of external equalizer
  mp3->c_byte_to_skip = equ_latency() * 2 * mp3->c_channel;

  // set position to first frame
  mp3->c_position = mp3->c_start;

  return TRUE;
}

BOOL WMp3::PlayLoop(unsigned int start_s, unsigned int length_s, unsigned int n_times)
{
  return PlayLoopM(start_s * 1000, length_s * 1000, n_times);
}

BOOL WMp3::PlayLoopM(unsigned int start_ms, unsigned int length_ms, unsigned int n_times)
{
  // start playing mp3 stream
  // this function starts decoding thread but
  // waits to end of previous decoding thread

  // prevent program crash if we call this function on empty stream
  if(!c_start)
  {
	error("WMp3::PlayLoopM->Strean isn't open!");
	return 0;
  }

  if(c_pause)
	return Resume();

  if(c_play)
	return FALSE;

  // previous playing thread must be terminated
  EnterCriticalSection(&c_wcsThreadDone);
  LeaveCriticalSection(&c_wcsThreadDone);

  if(!SeekM(start_ms))
  {
	error("WMp3::PlayLoopM->Can't seek to start of loop!");
	return FALSE;
  }

  c_bLoop = TRUE; // play loop

  c_pause = FALSE; // reset pause indicator

  // initialize VU meter
  c_vudata_ready = FALSE;
  c_dwPos		 = 0;
  c_dwIndex		 = 0;

  // main decoding thread switch
  c_play = TRUE; // enable decoding thread

  // calculate number of mp3 frames to fill one loop
  c_nLoopFrameNum = MulDiv(length_ms, c_sampling_rate, c_sample_per_frame * 1000); // number of mp3 frames needed for one loop
																				   // initialize to 0
  c_nLoopFramePlayed = 0;														   // number of played mp3 frames in one loop
																				   // enable loop processing
  c_bLoop = TRUE;
  // loop repeating
  c_nLoopCount = n_times;
  // loop repeated
  c_nLoop = 0;

  // correct position when repeating loop
  if(length_ms > c_song_length_ms - start_ms)
	c_dLoopPositionCorrector = (unsigned int)((double)(c_song_length_ms - start_ms) / 1000.0 * (double)c_sampling_rate);
  else
	c_dLoopPositionCorrector = (unsigned int)((double)c_nLoopFrameNum * (double)c_sample_per_frame);

  // create playing thread
  if(!w_hThread)
	w_hThread = (HANDLE)CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)_ThreadFunc, (void*)this, 0, &w_hThreadID);

  if(w_hThread == NULL)
  {
	error("WMp3::PlayLoopM->Can't create decoding thread!");
	return FALSE;
  }

  return TRUE;
}

#define XING_MAGIC (('X' << 24) | ('i' << 16) | ('n' << 8) | 'g')
#define INFO_MAGIC (('I' << 24) | ('n' << 16) | ('f' << 8) | 'o')
#define LAME_MAGIC (('L' << 24) | ('A' << 16) | ('M' << 8) | 'E')
#define VBRI_MAGIC (('V' << 24) | ('B' << 16) | ('R' << 8) | 'I')

static unsigned short const crc16_table[256] = {
	0x0000, 0xc0c1, 0xc181, 0x0140, 0xc301, 0x03c0, 0x0280, 0xc241,
	0xc601, 0x06c0, 0x0780, 0xc741, 0x0500, 0xc5c1, 0xc481, 0x0440,
	0xcc01, 0x0cc0, 0x0d80, 0xcd41, 0x0f00, 0xcfc1, 0xce81, 0x0e40,
	0x0a00, 0xcac1, 0xcb81, 0x0b40, 0xc901, 0x09c0, 0x0880, 0xc841,
	0xd801, 0x18c0, 0x1980, 0xd941, 0x1b00, 0xdbc1, 0xda81, 0x1a40,
	0x1e00, 0xdec1, 0xdf81, 0x1f40, 0xdd01, 0x1dc0, 0x1c80, 0xdc41,
	0x1400, 0xd4c1, 0xd581, 0x1540, 0xd701, 0x17c0, 0x1680, 0xd641,
	0xd201, 0x12c0, 0x1380, 0xd341, 0x1100, 0xd1c1, 0xd081, 0x1040,

	0xf001, 0x30c0, 0x3180, 0xf141, 0x3300, 0xf3c1, 0xf281, 0x3240,
	0x3600, 0xf6c1, 0xf781, 0x3740, 0xf501, 0x35c0, 0x3480, 0xf441,
	0x3c00, 0xfcc1, 0xfd81, 0x3d40, 0xff01, 0x3fc0, 0x3e80, 0xfe41,
	0xfa01, 0x3ac0, 0x3b80, 0xfb41, 0x3900, 0xf9c1, 0xf881, 0x3840,
	0x2800, 0xe8c1, 0xe981, 0x2940, 0xeb01, 0x2bc0, 0x2a80, 0xea41,
	0xee01, 0x2ec0, 0x2f80, 0xef41, 0x2d00, 0xedc1, 0xec81, 0x2c40,
	0xe401, 0x24c0, 0x2580, 0xe541, 0x2700, 0xe7c1, 0xe681, 0x2640,
	0x2200, 0xe2c1, 0xe381, 0x2340, 0xe101, 0x21c0, 0x2080, 0xe041,

	0xa001, 0x60c0, 0x6180, 0xa141, 0x6300, 0xa3c1, 0xa281, 0x6240,
	0x6600, 0xa6c1, 0xa781, 0x6740, 0xa501, 0x65c0, 0x6480, 0xa441,
	0x6c00, 0xacc1, 0xad81, 0x6d40, 0xaf01, 0x6fc0, 0x6e80, 0xae41,
	0xaa01, 0x6ac0, 0x6b80, 0xab41, 0x6900, 0xa9c1, 0xa881, 0x6840,
	0x7800, 0xb8c1, 0xb981, 0x7940, 0xbb01, 0x7bc0, 0x7a80, 0xba41,
	0xbe01, 0x7ec0, 0x7f80, 0xbf41, 0x7d00, 0xbdc1, 0xbc81, 0x7c40,
	0xb401, 0x74c0, 0x7580, 0xb541, 0x7700, 0xb7c1, 0xb681, 0x7640,
	0x7200, 0xb2c1, 0xb381, 0x7340, 0xb101, 0x71c0, 0x7080, 0xb041,

	0x5000, 0x90c1, 0x9181, 0x5140, 0x9301, 0x53c0, 0x5280, 0x9241,
	0x9601, 0x56c0, 0x5780, 0x9741, 0x5500, 0x95c1, 0x9481, 0x5440,
	0x9c01, 0x5cc0, 0x5d80, 0x9d41, 0x5f00, 0x9fc1, 0x9e81, 0x5e40,
	0x5a00, 0x9ac1, 0x9b81, 0x5b40, 0x9901, 0x59c0, 0x5880, 0x9841,
	0x8801, 0x48c0, 0x4980, 0x8941, 0x4b00, 0x8bc1, 0x8a81, 0x4a40,
	0x4e00, 0x8ec1, 0x8f81, 0x4f40, 0x8d01, 0x4dc0, 0x4c80, 0x8c41,
	0x4400, 0x84c1, 0x8581, 0x4540, 0x8701, 0x47c0, 0x4680, 0x8641,
	0x8201, 0x42c0, 0x4380, 0x8341, 0x4100, 0x81c1, 0x8081, 0x4040};

unsigned short crc_compute(char const* data, unsigned int length,
						   unsigned short init)
{
  register unsigned int crc;

  for(crc = init; length >= 8; length -= 8)
  {
	crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
	crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
	crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
	crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
	crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
	crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
	crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
	crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
  }

  switch(length)
  {
  case 7: crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
  case 6: crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
  case 5: crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
  case 4: crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
  case 3: crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
  case 2: crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
  case 1: crc = crc16_table[(crc ^ *data++) & 0xff] ^ (crc >> 8);
  case 0: break;
  }

  return (unsigned short)crc;
}

/*
* NAME:	tag->init()
* DESCRIPTION:	initialize tag structure
*/
void tag_init(struct tag_xl* tag)
{
  tag->flags	  = 0;
  tag->encoder[0] = 0;
  memset(&tag->xing, 0, sizeof(struct tag_xing));
  memset(&tag->lame, 0, sizeof(struct tag_lame));
}

/*
* NAME:	parse_xing()
* DESCRIPTION:	parse a Xing VBR tag
*/
static int parse_xing(struct tag_xing*	 xing,
					  struct mad_bitptr* ptr, unsigned int* bitlen)
{
  if(*bitlen < 32)
	goto fail;

  xing->flags = mad_bit_read(ptr, 32);
  *bitlen -= 32;

  if(xing->flags & TAG_XING_FRAMES)
  {
	if(*bitlen < 32)
	  goto fail;

	xing->frames = mad_bit_read(ptr, 32);
	*bitlen -= 32;
  }

  if(xing->flags & TAG_XING_BYTES)
  {
	if(*bitlen < 32)
	  goto fail;

	xing->bytes = mad_bit_read(ptr, 32);
	*bitlen -= 32;
  }

  if(xing->flags & TAG_XING_TOC)
  {
	int i;

	if(*bitlen < 800)
	  goto fail;

	for(i = 0; i < 100; ++i)
	  xing->toc[i] = (unsigned char)mad_bit_read(ptr, 8);

	*bitlen -= 800;
  }

  if(xing->flags & TAG_XING_SCALE)
  {
	if(*bitlen < 32)
	  goto fail;

	xing->scale = mad_bit_read(ptr, 32);
	*bitlen -= 32;
  }

  return 0;

fail:
  xing->flags = 0;
  return -1;
}

/*
* NAME:	parse_lame()
* DESCRIPTION:	parse a LAME tag
*/
static int parse_lame(struct tag_lame*	 lame,
					  struct mad_bitptr* ptr, unsigned int* bitlen,
					  unsigned short crc)
{
  struct mad_bitptr save = *ptr;
  unsigned long		magic;
  char const*		version;

  if(*bitlen < 36 * 8)
	goto fail;

  /* bytes $9A-$A4: Encoder short VersionString */

  magic	  = mad_bit_read(ptr, 4 * 8);
  version = (const char*)mad_bit_nextbyte(ptr);

  mad_bit_skip(ptr, 5 * 8);

  /* byte $A5: Info Tag revision + VBR method */

  lame->revision = (unsigned char)mad_bit_read(ptr, 4);
  if(lame->revision == 15)
	goto fail;

  lame->vbr_method = (enum tag_lame_vbr)mad_bit_read(ptr, 4);

  /* byte $A6: Lowpass filter value (Hz) */

  lame->lowpass_filter = (unsigned short)(mad_bit_read(ptr, 8) * 100);

  /* bytes $A7-$AA: 32 bit "Peak signal amplitude" */

  lame->peak = mad_bit_read(ptr, 32) << 5;

  /* bytes $AB-$AC: 16 bit "Radio Replay Gain" */

  rgain_parse(&lame->replay_gain[0], ptr);

  /* bytes $AD-$AE: 16 bit "Audiophile Replay Gain" */

  rgain_parse(&lame->replay_gain[1], ptr);

  //LAME 3.95.1 reference level changed from 83dB to 89dB and foobar seems to use 89dB
  if(magic == LAME_MAGIC)
  {
	char	 str[6];
	unsigned major = 0, minor = 0, patch = 0;
	int		 i;

	memcpy(str, version, 5);
	str[5] = 0;

	sscanf_s(str, "%u.%u.%u", &major, &minor, &patch);

	if(major == 3 && minor < 95)
	{
	  for(i = 0; i < 2; ++i)
	  {
		if(RGAIN_SET(&lame->replay_gain[i]))
		  lame->replay_gain[i].adjustment += 6; // 6.0 dB
	  }
	}
  }

  /* byte $AF: Encoding flags + ATH Type */

  lame->flags	 = (unsigned char)mad_bit_read(ptr, 4);
  lame->ath_type = (unsigned char)mad_bit_read(ptr, 4);

  /* byte $B0: if ABR {specified bitrate} else {minimal bitrate} */

  lame->bitrate = (unsigned char)mad_bit_read(ptr, 8);

  /* bytes $B1-$B3: Encoder delays */

  lame->start_delay = mad_bit_read(ptr, 12);
  lame->end_padding = mad_bit_read(ptr, 12);

  /* byte $B4: Misc */

  lame->source_samplerate = (enum tag_lame_source)mad_bit_read(ptr, 2);

  if(mad_bit_read(ptr, 1))
	lame->flags |= TAG_LAME_UNWISE;

  lame->stereo_mode	  = (enum tag_lame_mode)mad_bit_read(ptr, 3);
  lame->noise_shaping = (unsigned char)mad_bit_read(ptr, 2);

  /* byte $B5: MP3 Gain */

  lame->gain = (signed char)mad_bit_read(ptr, 8);

  /* bytes $B6-B7: Preset and surround info */

  mad_bit_skip(ptr, 2);

  lame->surround = (enum tag_lame_surround)mad_bit_read(ptr, 3);
  lame->preset	 = (enum tag_lame_preset)mad_bit_read(ptr, 11);

  /* bytes $B8-$BB: MusicLength */

  lame->music_length = mad_bit_read(ptr, 32);

  /* bytes $BC-$BD: MusicCRC */

  lame->music_crc = (unsigned short)mad_bit_read(ptr, 16);

  /* bytes $BE-$BF: CRC-16 of Info Tag */

  if(mad_bit_read(ptr, 16) != crc)
	goto fail;

  *bitlen -= 36 * 8;

  return 0;

fail:
  *ptr = save;
  return -1;
}

/*
* NAME:	tag->parse()
* DESCRIPTION:	parse Xing/LAME tag(s)
*/
int tag_parse(struct tag_xl* tag, struct mad_stream const* stream, struct mad_frame const* frame)
{
  struct mad_bitptr ptr	   = stream->anc_ptr;
  struct mad_bitptr start  = ptr;
  unsigned int		bitlen = stream->anc_bitlen;
  unsigned long		magic;
  unsigned long		magic2;
  int				i;

  tag_init(tag); //tag->flags = 0;

  if(bitlen < 32)
	return -1;

  magic = mad_bit_read(&ptr, 32);

  bitlen -= 32;

  if(magic != XING_MAGIC &&
	 magic != INFO_MAGIC &&
	 magic != LAME_MAGIC)
  {
	/*
			* Due to an unfortunate historical accident, a Xing VBR tag may be
			* misplaced in a stream with CRC protection. We check for this by
			* assuming the tag began two octets prior and the high bits of the
			* following flags field are always zero.
			*/

	if(magic != ((XING_MAGIC << 16) & 0xffffffffL) &&
	   magic != ((INFO_MAGIC << 16) & 0xffffffffL))
	{
	  //check for VBRI tag
	  if(bitlen >= 400)
	  {
		mad_bit_skip(&ptr, 256);
		magic2 = mad_bit_read(&ptr, 32);
		if(magic2 == VBRI_MAGIC)
		{
		  mad_bit_skip(&ptr, 16);							  //16 bits - version
		  tag->lame.start_delay = mad_bit_read(&ptr, 16);	  //16 bits - delay
		  mad_bit_skip(&ptr, 16);							  //16 bits - quality
		  tag->xing.bytes			= mad_bit_read(&ptr, 32); //32 bits - bytes
		  tag->xing.frames			= mad_bit_read(&ptr, 32); //32 bits - frames
		  unsigned int table_size	= mad_bit_read(&ptr, 16);
		  unsigned int table_scale	= mad_bit_read(&ptr, 16);
		  unsigned int entry_bytes	= mad_bit_read(&ptr, 16);
		  unsigned int entry_frames = mad_bit_read(&ptr, 16);
		  {
			unsigned int Entry = 0, PrevEntry = 0, Percent, SeekPoint = 0, i = 0;
			float		 AccumulatedTime	   = 0;
			float		 TotalDuration		   = (float)(1000.0 * tag->xing.frames * ((frame->header.flags & MAD_FLAG_LSF_EXT) ? 576 : 1152) / frame->header.samplerate);
			float		 DurationPerVbriFrames = TotalDuration / ((float)table_size + 1);
			for(Percent = 0; Percent < 100; Percent++)
			{
			  float EntryTimeInMilliSeconds = ((float)Percent / 100) * TotalDuration;
			  while(AccumulatedTime <= EntryTimeInMilliSeconds)
			  {
				PrevEntry = Entry;
				Entry	  = mad_bit_read(&ptr, entry_bytes * 8) * table_scale;
				i++;
				SeekPoint += Entry;
				AccumulatedTime += DurationPerVbriFrames;
				if(i >= table_size) break;
			  }
			  unsigned int fraction	  = ((int)((((AccumulatedTime - EntryTimeInMilliSeconds) / DurationPerVbriFrames) + (1.0f / (2.0f * (float)entry_frames))) * (float)entry_frames));
			  unsigned int SeekPoint2 = SeekPoint - (int)((float)PrevEntry * (float)(fraction) / (float)entry_frames);
			  unsigned int XingPoint  = (256 * SeekPoint2) / tag->xing.bytes;

			  if(XingPoint > 255) XingPoint = 255;
			  tag->xing.toc[Percent] = (unsigned char)(XingPoint & 0xFF);
			}
		  }
		  tag->flags |= (TAG_XING | TAG_VBRI);
		  tag->xing.flags = (TAG_XING_FRAMES | TAG_XING_BYTES | TAG_XING_TOC);

		  return 0;
		}
	  }
	  return -1;
	}

	magic >>= 16;

	/* backtrack the bit pointer */

	ptr = start;
	mad_bit_skip(&ptr, 16);
	bitlen += 16;
  }

  if((magic & 0x0000ffffL) == (XING_MAGIC & 0x0000ffffL))
	tag->flags |= TAG_VBR;

  /* Xing tag */

  if(magic == LAME_MAGIC)
  {
	ptr = start;
	bitlen += 32;
  } else if(parse_xing(&tag->xing, &ptr, &bitlen) == 0)
	tag->flags |= TAG_XING;

  /* encoder string */

  if(bitlen >= 20 * 8)
  {
	start = ptr;

	for(i = 0; i < 20; ++i)
	{
	  tag->encoder[i] = (char)mad_bit_read(&ptr, 8);

	  if(tag->encoder[i] == 0)
		break;

	  /* keep only printable ASCII chars */

	  if(tag->encoder[i] < 0x20 || tag->encoder[i] >= 0x7f)
	  {
		tag->encoder[i] = 0;
		break;
	  }
	}

	tag->encoder[20] = 0;
	ptr				 = start;
  }

  /* LAME tag */

  if(memcmp(tag->encoder, "LAME", 4) == 0 && stream->next_frame - stream->this_frame >= 192)
  {
	unsigned short crc = crc_compute((const char*)stream->this_frame, (frame->header.flags & MAD_FLAG_LSF_EXT) ? 175 : 190, 0x0000);
	if(parse_lame(&tag->lame, &ptr, &bitlen, crc) == 0)
	{
	  tag->flags |= TAG_LAME;
	  tag->encoder[9] = 0;
	}
  } else
  {
	for(i = 0; i < 20; ++i)
	{
	  if(tag->encoder[i] == 0)
		break;

	  /* stop at padding chars */

	  if(tag->encoder[i] == 0x55)
	  {
		tag->encoder[i] = 0;
		break;
	  }
	}
  }

  return 0;
}

/*
 * NAME:	rgain->parse()
 * DESCRIPTION:	parse a 16-bit Replay Gain field
 */
void rgain_parse(struct rgain* rgain, struct mad_bitptr* ptr)
{
  int negative;

  rgain->name		= (enum rgain_name)mad_bit_read(ptr, 3);
  rgain->originator = (enum rgain_originator)mad_bit_read(ptr, 3);

  negative			= mad_bit_read(ptr, 1);
  rgain->adjustment = (short)mad_bit_read(ptr, 9);

  if(negative)
	rgain->adjustment = (short)-rgain->adjustment;
}

void WMp3::init(WMp3* mp3)
{
  mp3->c_stream_start = 0; // first byte of input stream ( including ID3 tag )
  mp3->c_stream_size  = 0; // size of input mp3 stream ( whole stream with ID3 tags )
  mp3->c_stream_end	  = 0; // last byte of input stream ( including ID3 tag )

  mp3->c_start	  = 0; // first valid frame
  mp3->c_end	  = 0; // last byte of stream without ID3 tag
  mp3->c_position = 0; // current position in stream
  mp3->c_size	  = 0; // size of stream (without ID3 tags )

  mp3->c_ID3v1 = 0; // ID3v1 tag present
  mp3->c_ID3v2 = 0; // ID3v2 tag present

  mp3->c_sampling_rate	= 0; // sampling rate frequency  ( Hz )
  mp3->c_layer			= 0; // layer  1, 2, 3
  mp3->c_mode			= 0; // MAD_MODE_SINGLE_CHANNEL,MAD_MODE_DUAL_CHANNEL,MAD_MODE_JOINT_STEREO,MAD_MODE_STEREO
  mp3->c_channel		= 0; // number of channels
  mp3->c_emphasis		= 0;
  mp3->c_mode_extension = 0;
  mp3->c_bitrate		= 0; // bitrate of first frame
  mp3->c_avg_bitrate	= 0; // average bitrate

  mp3->c_avg_frame_size = 0; // average frame size

  mp3->c_duration		  = mad_timer_zero; // audio playing time of frame
  mp3->c_sample_per_frame = 0;				// number of wave samples in one frame
  mp3->c_flags			  = 0;
  mp3->c_mpeg_version	  = 0;	 // MPEG1, MPEG2, MPEG25
  mp3->c_mpeg_version_str = " "; //
  mp3->c_channel_str	  = " ";
  mp3->c_emphasis_str	  = " ";
  mp3->c_layer_str		  = " ";

  memset(&mp3->xing, 0, sizeof(mp3->xing));
  mp3->c_valid_xing		 = 0;
  mp3->c_xing_frame_size = 0;

  mp3->c_song_length_samples = 0; // length of song in samples
  mp3->c_song_length_ms		 = 0; // length of song in milliseconds
  mp3->c_song_length_bytes	 = 0; // length of song in bytes
  mp3->c_song_length_frames	 = 0; // length of song in mp3 frames

  mp3->c_input_buffer_size = 0; // size of input buffer ( frame number )

  mp3->c_tmp   = 0;
  mp3->c_play  = 0;
  mp3->c_vbr   = 0;
  mp3->c_pause = 0; // pause flag, control Pause() and Reset()

  // VU meter
  mp3->c_dwPos		  = 0; // position in current playing wave buffer, need to get corect VU data
  mp3->c_dwIndex	  = 0; // index of current playing wave buffer
  mp3->c_vudata_ready = 0; // get VU data only when playing

  mp3->c_frame_counter = 0; // number of decoded frames
  mp3->c_bitrate_sum   = 0; // sum of all decoded bitrates

  mp3->c_bLoop		= 0; // indicate loop playing
  mp3->c_nLoopCount = 0; // repeat loop n times
  mp3->c_nLoop		= 0;
  ; // number of played loops

  mp3->c_nPosition = 0;

  mp3->c_bFadeOut		  = FALSE;
  mp3->c_nFadeOutFrameNum = 0;

  mp3->c_bFadeIn = FALSE;

  if(mp3->c_gapless_buffer)
	_FREE(mp3->c_gapless_buffer);

  mp3->c_gapless_buffer = 0;

  memset(&mp3->left_dither, 0, sizeof(mp3->left_dither));
  memset(&mp3->right_dither, 0, sizeof(mp3->right_dither));
  memset(&mp3->c_hms_pos, 0, sizeof(MP3_TIME));
}

void mono_filter(struct mad_frame* frame)
{
  // equalize left and right channel
  // we can change this filter at playing time
  if(frame->header.mode != MAD_MODE_SINGLE_CHANNEL)
  {
	unsigned int ns, s, sb;
	mad_fixed_t	 left, right, mono;

	ns = MAD_NSBSAMPLES(&frame->header);

	for(s = 0; s < ns; ++s)
	{
	  for(sb = 0; sb < 32; ++sb)
	  {
		left					  = frame->sbsample[0][s][sb];
		right					  = frame->sbsample[1][s][sb];
		mono					  = (left + right) / 2;
		frame->sbsample[0][s][sb] = mono;
		frame->sbsample[1][s][sb] = mono;
	  }
	}
  }
}

void gain_filter(struct mad_frame* frame, mad_fixed_t gain[2])
{
  unsigned int nch, ch, ns, s, sb;

  nch = MAD_NCHANNELS(&frame->header);
  ns  = MAD_NSBSAMPLES(&frame->header);

  for(ch = 0; ch < nch; ++ch)
  {
	for(s = 0; s < ns; ++s)
	{
	  for(sb = 0; sb < 32; ++sb)
	  {
		frame->sbsample[ch][s][sb] =
			mad_f_mul(frame->sbsample[ch][s][sb], gain[ch]);
	  }
	}
  }
}

void experimental_filter(struct mad_frame* frame)
{
  if(frame->header.mode == MAD_MODE_STEREO ||
	 frame->header.mode == MAD_MODE_JOINT_STEREO)
  {
	unsigned int ns, s, sb;

	ns = MAD_NSBSAMPLES(&frame->header);

	/* enhance stereo separation */

	for(s = 0; s < ns; ++s)
	{
	  for(sb = 0; sb < 32; ++sb)
	  {
		mad_fixed_t left, right;

		left  = frame->sbsample[0][s][sb];
		right = frame->sbsample[1][s][sb];

		frame->sbsample[0][s][sb] -= right / 4;
		frame->sbsample[1][s][sb] -= left / 4;
	  }
	}
  }
}

void WMp3::MixChannels(BOOL fEnable, unsigned int left_percent, unsigned int right_percent)
{
  c_mix_channels = fEnable;

  c_l_mix = mad_f_tofixed((double)left_percent / 100.0);
  c_r_mix = mad_f_tofixed((double)right_percent / 100.0);
}

void vocal_cut_filter(struct mad_frame* frame)
{
  // equalize left and right channel
  // we can change this filter at playing time
  if(frame->header.mode != MAD_MODE_SINGLE_CHANNEL)
  {
	unsigned int ns, s, sb;
	mad_fixed_t	 left, right;

	ns = MAD_NSBSAMPLES(&frame->header);

	for(s = 0; s < ns; ++s)
	{
	  for(sb = 0; sb < 32; ++sb)
	  {
		left  = frame->sbsample[0][s][sb] - frame->sbsample[1][s][sb];
		right = frame->sbsample[1][s][sb] - frame->sbsample[0][s][sb];

		frame->sbsample[0][s][sb] = left;
		frame->sbsample[1][s][sb] = right;
	  }
	}
  }
}

void mix_filter(struct mad_frame* frame, mad_fixed_t left_p, mad_fixed_t right_p)
{
  // equalize left and right channel
  // we can change this filter at playing time
  if(frame->header.mode != MAD_MODE_SINGLE_CHANNEL)
  {
	unsigned int ns, s, sb;
	mad_fixed_t	 left, right, mono;

	ns = MAD_NSBSAMPLES(&frame->header);

	for(s = 0; s < ns; ++s)
	{
	  for(sb = 0; sb < 32; ++sb)
	  {
		left  = frame->sbsample[0][s][sb];
		right = frame->sbsample[1][s][sb];
		mono  = mad_f_mul(left, left_p);
		mono  = mad_f_add(mono, mad_f_mul(right, right_p));

		frame->sbsample[0][s][sb] = mono;
		frame->sbsample[1][s][sb] = mono;
	  }
	}
  }
}

void WMp3::FadeOutM(unsigned int length_ms)
{
  c_bFadeIn	 = FALSE;
  c_bFadeOut = TRUE;

  // calculate number of mp3 frames to fill one loop
  c_nFadeOutFrameNum = MulDiv(length_ms, c_sampling_rate, c_sample_per_frame * 1000);
  c_fadeOutStep		 = 100.0 / (double)c_nFadeOutFrameNum;
  fadeout_gain[0]	 = MAD_F_ONE;
  fadeout_gain[1]	 = MAD_F_ONE;
  c_fade_frame_count = 0;
}

void WMp3::FadeOut(unsigned int length_seconds)
{
  FadeOutM(length_seconds * 1000);
}

void WMp3::FadeIn(unsigned int length_seconds)
{
  FadeInM(length_seconds * 1000);
}

void WMp3::FadeInM(unsigned int length_ms)
{
  c_bFadeOut = FALSE;
  c_bFadeIn	 = TRUE;

  // calculate number of mp3 frames to fill one loop
  c_nFadeInFrameNum	 = MulDiv(length_ms, c_sampling_rate, c_sample_per_frame * 1000);
  c_fadeInStep		 = 100.0 / (double)c_nFadeInFrameNum;
  fadeout_gain[0]	 = 0;
  fadeout_gain[1]	 = 0;
  c_fade_frame_count = 0;
}

int WMp3::reallocate_sfx_buffers(WMp3* mp3)
{
  int i;
  // if buffer size changed allocate new buffer
  if(mp3->c_old_echo_buffer_size != mp3->c_echo_alloc_buffer_size)
  {
	// _FREE old buffers
	for(i = 0; i < ECHO_BUFFER_NUMBER; i++)
	{
	  if(mp3->sfx_buffer[i])
	  {
		_FREE(mp3->sfx_buffer[i]);
		mp3->sfx_buffer[i] = 0;
	  }
	}

	// all buffers _FREE

	// allocate new buffers
	for(i = 0; i < ECHO_BUFFER_NUMBER; i++)
	{
	  mp3->sfx_buffer[i]  = (short*)_ALLOC(mp3->c_echo_alloc_buffer_size);
	  mp3->sfx_buffer1[i] = mp3->sfx_buffer[i];
	  // check allocation
	  if(mp3->sfx_buffer[i] == NULL)
	  {
		// allocation error, _FREE allocated buffers
		for(int j = 0; j <= i; j++)
		{
		  _FREE(mp3->sfx_buffer[j]);
		  mp3->sfx_buffer[j]  = 0;
		  mp3->sfx_buffer1[j] = 0;
		}
		mp3->sfx_buffer1[0] = 0;
		mp3->error("Can't allocate buffers for SFX processor!");

		return 0;
	  }
	}

	mp3->c_old_echo_buffer_size = mp3->c_echo_alloc_buffer_size;

	// all buffers allocated
  } // no need for new buffers, old buffers are OK

  return 1;
}

MP3_TIME* WMp3::GetPositionHMS()
{
  unsigned int pos = GetPositionM();

  c_hms_pos.h  = pos / 3600000;
  pos		   = pos % 3600000;
  c_hms_pos.m  = pos / 60000;
  pos		   = pos % 60000;
  c_hms_pos.s  = pos / 1000;
  c_hms_pos.ms = pos % 1000;

  return &c_hms_pos;
}

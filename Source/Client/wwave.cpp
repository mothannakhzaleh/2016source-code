/*
 * WWave C++ class - free C++ class for playing wave files
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

#include "stdafx.h"
#include <windows.h>


#ifdef _MSC_VER
#pragma comment( lib, "winmm")
#endif


#include "wwave.h"




WWaveOut::WWaveOut()
{
 	_whandle = 0;
    _woc = 0;
	_alloc_buffer_size = 0;


    _waveHdr = 0;
}

WWaveOut::~WWaveOut()
{
 	if( _woc) delete [] _woc;

}


BOOL WWaveOut::GetInfo()
{
// get info about all output devices
	 _num_devs = waveOutGetNumDevs();
     if(_num_devs == 0) {
     	Error("WWaveOut::GetInfo->No wave out devices are presen");
     	return FALSE;
     }

     _woc = new WAVEOUTCAPS[_num_devs];

     for (UINT i = 0; i < _num_devs; i++ ) {
    	waveOutGetDevCaps(i, &_woc[i], sizeof(WAVEOUTCAPS));

    }

    return TRUE;
}


BOOL WWaveOut::OpenAudioOutput(UINT uDeviceID, DWORD dwCallback, DWORD dwCallbackInstance,
				 DWORD fdwOpen)
{
// open wave out device
// INPUT:	UINT uDeviceID			- Identifier of the waveform-audio output device to open
//									- WAVE_MAPPER  The function selects a waveform-audio output device capable of playing the given format.
//          DWORD dwCallback		- Address of a fixed callback function, an event handle,
//									or a handle of a window or thread called during waveform-audio playback
//									to process messages related to the progress of the playback
//          DWORD dwCallbackInstance	- User-instance data passed to the callback mechanism
//          DWORD fdwOpen			- Flags for opening the device.
// RETURN:	TRUE	- all OK
//			FALSE	- error



    DWORD OutProc;
    if(dwCallback == 0)
    	OutProc = (DWORD)waveOutProc;
    else
    	OutProc = dwCallback;

    MMRESULT result;
    result = waveOutOpen(&_whandle,uDeviceID,&_wfx, OutProc, dwCallbackInstance, fdwOpen);

    switch (result) {
    	case MMSYSERR_NOERROR:
        	return TRUE;

        case MMSYSERR_ALLOCATED:
        	Error("WWaveOut::OpenAudioOutput->Specified resource is already allocated");

        case MMSYSERR_BADDEVICEID:
        	Error("WWaveOut::OpenAudioOutput->Specified device identifier is out of range");

        case MMSYSERR_NODRIVER:
        	Error("WWaveOut::OpenAudioOutput->No device driver is present");

        case MMSYSERR_NOMEM:
        	Error("WWaveOut::OpenAudioOutput->Unable to allocate or lock memory");

        case WAVERR_BADFORMAT:
        	Error("WWaveOut::OpenAudioOutput->Attempted to open with an unsupported waveform-audio format");
        case WAVERR_SYNC:
        	Error("WWaveOut::OpenAudioOutput->The device is synchronous but waveOutOpen was called without using the WAVE_ALLOWSYNC flag");

        default:
        	Error("WWaveOut::OpenAudioOutput->Unknown error");
    }

    return FALSE;
}




BOOL WWaveOut::PlayStream(char *stream, int size, int buffer)
{
// play stream of data
// INPUT:	char *stream		- pointer to stream
//          int size			- size of stream
//          int buffer			- buffer index

    _waveHdr[buffer].lpData = stream;
    _waveHdr[buffer].dwBufferLength = size;
    _waveHdr[buffer].dwFlags = 0L;
    _waveHdr[buffer].dwLoops = 0L;

    if(waveOutPrepareHeader(_whandle, &_waveHdr[buffer], sizeof(WAVEHDR)) != MMSYSERR_NOERROR) {
    	Error("WWaveOut::PlayBuffer->Can't prepare data");
        return FALSE;
    }

    if(waveOutWrite(_whandle, &_waveHdr[buffer], sizeof(WAVEHDR)) != MMSYSERR_NOERROR) {
    	Error("WWaveOut::PlayBuffer->Can't write data");
        return FALSE;

    }
    
	return TRUE;

}


BOOL WWaveOut::PlayBuffer(int buffer)
{
// play buffer
// INPUT:	int buffer		- buffer index
// RETURN:	TRUE	- all OK
//			FALSE	- error

// sfx




	

    _waveHdr[buffer].dwFlags = 0L;
    _waveHdr[buffer].dwLoops = 0L;


    if(waveOutPrepareHeader(_whandle, &_waveHdr[buffer], sizeof(WAVEHDR)) != MMSYSERR_NOERROR) {
    	Error("WWaveOut::PlayBuffer->Can't prepare data");
        return FALSE;
    }

    if(waveOutWrite(_whandle, &_waveHdr[buffer], sizeof(WAVEHDR)) != MMSYSERR_NOERROR) {
    	Error("WWaveOut::PlayBuffer->Can't write data");
        return FALSE;

    }

	return TRUE;

}




void CALLBACK WWaveOut::waveOutProc(HWAVEOUT hwo, UINT uMsg, DWORD dwInstance,
    				DWORD dwParam1, DWORD dwParam2)
{
 	switch(uMsg) {
    	case WOM_DONE:
        {
         
         	


        }
        break;
    }
}




BOOL WWaveOut::UnprepareHeader(int buffer)
{
// Cleans up the preparation performed by the waveOutPrepareHeader function
// INPUT:	int buffer		- buffer index
	if( waveOutUnprepareHeader(_whandle, &_waveHdr[buffer],sizeof(WAVEHDR)) == MMSYSERR_NOERROR)
    	return TRUE;

    return FALSE;
}

BOOL WWaveOut::Stop()
{
	waveOutReset(_whandle);
    return TRUE;
}

BOOL WWaveOut::Resume()
{
	waveOutRestart(_whandle);
    return TRUE;
}

DWORD WWaveOut::GetPosition(UINT wType)
{
// get position
// INPUT: 	UINT wType		- position format ( MILLISECONDS, SECONDS, BYTES ) 
// RETURN DWORD				- position
    if(!_whandle)
    	return 0;
    MMTIME mmt;
    switch (wType) {
    	case BYTES:
        	mmt.wType = TIME_BYTES;
        	waveOutGetPosition(_whandle, &mmt, sizeof(MMTIME));
        return mmt.u.cb;

        case SAMPLES:
        	mmt.wType = TIME_SAMPLES;
        	waveOutGetPosition(_whandle, &mmt, sizeof(MMTIME));
        return mmt.u.sample;

        case MILLISECONDS:
        	mmt.wType = TIME_SAMPLES;
        	waveOutGetPosition(_whandle, &mmt, sizeof(MMTIME));
        return ( unsigned int) ((double) mmt.u.sample * 1000.0 / (double) _samples_per_sec );

        case SECONDS:
        	mmt.wType = TIME_SAMPLES;
        	waveOutGetPosition(_whandle, &mmt, sizeof(MMTIME));
        return ( mmt.u.sample / _samples_per_sec);


    }
    return 0;
}

BOOL WWaveOut::Pause()
{
	::waveOutPause(_whandle);
    return TRUE;
}

BOOL WWaveOut::Close()
{
// close wave out device
	MMRESULT result;

    result = ::waveOutClose(_whandle);


    switch(result) {
    	case MMSYSERR_NOERROR:
        	_whandle = 0;
        	return TRUE;

        case MMSYSERR_NODRIVER:
        	Error("WWaveOut::Close->No device driver is present");
        case MMSYSERR_INVALHANDLE:
        	Error("WWaveOut::Close->Specified device handle is invalid");
        case MMSYSERR_NOMEM:
        	Error("WWaveOut::Close->Unable to allocate or lock memory");
        case WAVERR_STILLPLAYING:
        	Error("WWaveOut::Close->There are still buffers in the queue");
        default:
        	Error("WWaveOut::Close->Unknown error");

    }

    return FALSE;
}

BOOL WWaveOut::Initialize(WORD FormatTag, WORD Channels, DWORD SamplesPerSec,
    					WORD BitsPerSample, UINT NumOfBuffers, UINT BufferSize)
{
// initialize WAVEFORMATEX structure and alocate buffers
// INPUT:	WORD FormatTag				- Waveform-audio format type
//          WORD Channels				- Number of channels in the waveform-audio data
//          DWORD SamplesPerSec			- Sample rate, in samples per second (hertz), that each channel should be played or recorded
//          WORD BitsPerSample			- Bits per sample for the FormatTag format type
//          UINT NumOfBuffers			- number of output buffers
//          UINT BufferSize				- size of single output buffer ( milliseconds )
//
// RETURE:	TRUE - all OK
//			FALSE	- error  

    if(_waveHdr) {
        Error("WWaveOut::Initialize->Already initializet. Uninitialize first.");
    	return FALSE;
    }

    _wfx.wFormatTag = FormatTag;
    _wfx.nChannels = Channels;
    _wfx.nSamplesPerSec = SamplesPerSec;
    _wfx.nAvgBytesPerSec = ( Channels * SamplesPerSec * BitsPerSample ) / 8 ;
    _wfx.nBlockAlign = (unsigned short)( ( Channels * BitsPerSample ) / 8);
    _wfx.wBitsPerSample = (unsigned short) BitsPerSample;
    _wfx.cbSize = 0;


	 // allocate array of pointers to buffer
    _waveHdr = ( WAVEHDR * ) _ALLOC(sizeof(WAVEHDR) * NumOfBuffers);
    if(_waveHdr == NULL ) {
    	Error ( "WWave::Initialize->Can't allocate memory for WAVEHDR structure");
    	return FALSE;
    }

    ZeroMemory(_waveHdr, sizeof(WAVEHDR) * NumOfBuffers);


	_alloc_buffer_size = (unsigned int) ( (double) _wfx.nAvgBytesPerSec * (double) BufferSize / 1000.0 );

	
    // allocate memory for buffers
    for (UINT i = 0; i < NumOfBuffers; i++ ) {
   
       	_waveHdr[i].lpData = (char* ) _ALLOC(_alloc_buffer_size);
	    _waveHdr[i].dwUser = i;
		if(_waveHdr[i].lpData == NULL ) {
        	for(UINT j = 0; j < i; j++)
            	_FREE(_waveHdr[j].lpData);
            _FREE(_waveHdr);
            _waveHdr = 0;
            Error ( "WWave::Initialize->Can't allocate memory for output data buffer");
    		return FALSE;

        }
    }

    _number_of_buffers = NumOfBuffers;
    _buffer_size = BufferSize;
    _samples_per_sec = SamplesPerSec;

    return TRUE;

}

BOOL WWaveOut::Uninitialize()
{
// deallocate buffer memory
    if(_waveHdr == 0)
    	return TRUE;
    for (UINT i = 0; i < _number_of_buffers; i++ ) {
    	_FREE(_waveHdr[i].lpData);

    }
	 // deallocate array of pointers to buffer
    _FREE(_waveHdr);
    _waveHdr = 0;

	

    return TRUE;
}

 LPSTR WWaveOut::GetBufferData(DWORD index) { return _waveHdr[index].lpData; };
 void WWaveOut::SetBufferSize(DWORD index, DWORD size) { _waveHdr[index].dwBufferLength = size;};
 BOOL WWaveOut::IsBufferDone(DWORD index) {  return ((_waveHdr[index].dwFlags & WHDR_DONE) ==WHDR_DONE )  ? 1 : 0;};
 DWORD WWaveOut::GetNumOfBuffers() { return _number_of_buffers; };
 void WWaveOut::SetBufferDone(DWORD index) { _waveHdr[index].dwFlags |= WHDR_DONE; };
 void WWaveOut::SetBufferData(char* data,DWORD index) { _waveHdr[index].lpData = data; };



void WWaveOut::Error(char* errormessage)
{
	if(errormessage)
	//	strcpy(error_str,errormessage);
	lstrcpy(error_str,errormessage);
}

DWORD WWaveOut::SetVolume(WORD lvolume, WORD rvolume)
{
	return ::waveOutSetVolume(_whandle, MAKELONG(lvolume, rvolume));
}


DWORD WWaveOut::GetVolume(WORD* lvolume, WORD* rvolume)
{
	MMRESULT ret;
	DWORD vol;
	ret =  ::waveOutGetVolume(_whandle, &vol);
	*lvolume = LOWORD(vol);
	*rvolume = HIWORD(vol);
	return ret;
}



DWORD WWaveOut::GetBufferSize(DWORD index)
{ 
	return _waveHdr[index].dwBufferLength;
}





/*

Shibatch Super Equalizer ver 0.03 for winamp ( modified version )
written by Naoki Shibata  shibatch@users.sourceforge.net

This is modified version of Shibatch Super Equalizer
Some parts are excluded from original version and code is modified
to compile on free Borland commandline compiler 5.5

Date of modification: 03.08.2008.
 

Shibatch Super Equalizer is a graphic and parametric equalizer plugin
for winamp. This plugin uses 16383th order FIR filter with FFT algorithm.
It's equalization is very precise. Equalization setting can be done
for each channel separately.

Processes of internal equalizer in winamp are actually done by each
input plugin, so the results may differ for each input plugin.
With this plugin, this problem can be avoided.

This plugin is optimized for processors which have cache equal to or
greater than 128k bytes(16383*2*sizeof(float) = 128k). This plugin
won't work efficiently with K6 series processors(buy Athlon!!!).

Do not forget pressing "preview" button after changing setting.

http://shibatch.sourceforge.net/

***

  This program(except FFT part) is distributed under LGPL. See LGPL.txt for
details.

  FFT part is a routine made by Mr.Ooura. This routine is a freeware. Contact
Mr.Ooura for details of distributing licenses.

http://momonga.t.u-tokyo.ac.jp/~ooura/fft.html

*/

#ifndef _WEQU_Z_
#define _WEQU_Z_

class paramlistelm
{
  public:
  class paramlistelm* next;

  char	left, right;
  float lower, upper, gain, gain2;
  int	sortindex;

  paramlistelm(void);

  ~paramlistelm();
};

class paramlist
{
  public:
  class paramlistelm* elm;

  paramlist(void);

  ~paramlist();
};

typedef float REAL;

extern int weq_enable;

void		 equ_init(int wb);
void		 equ_makeTable(REAL* lbc, REAL* rbc, paramlist* param, REAL fs);
void		 equ_quit(void);
void		 equ_clearbuf(int srate);
int			 equ_modifySamples(char* buf, int nsamples, int nch);
unsigned int equ_latency();

#endif

/*
 * libmad - MPEG audio decoder library ( modified version )
 * Copyright (C) 2000-2004 Underbit Technologies, Inc.
 *
 * This is modified version of original libmad.
 * Some parts are excluded from original version, and code is modified
 * to compile on free Borland commandline compiler 5.5
 *
 * Date of modification: 03.07.2008.
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
 * If you would like to negotiate alternate licensing terms, you may do
 * so by contacting: Underbit Technologies, Inc. <info@underbit.com>
 */

#ifndef _W_MP3DECODER_
#define _W_MP3DECODER_

#define MAD_BUFFER_GUARD 8
#define MAD_BUFFER_MDLEN (511 + 2048 + MAD_BUFFER_GUARD)

#define MAD_F(x)  ((mad_fixed_t)(x##L))
#define MAD_F_ONE MAD_F(0x10000000)

#define MAD_RECOVERABLE(error) ((error)&0xff00)

#define mad_f_add(x, y) ((x) + (y))
#define mad_f_sub(x, y) ((x) - (y))

enum mad_decoder_mode
{
  MAD_DECODER_MODE_SYNC = 0,
  MAD_DECODER_MODE_ASYNC
};

enum mad_flow
{
  MAD_FLOW_CONTINUE = 0x0000, /* continue normally */
  MAD_FLOW_STOP		= 0x0010, /* stop decoding normally */
  MAD_FLOW_BREAK	= 0x0011, /* stop decoding and signal an error */
  MAD_FLOW_IGNORE	= 0x0020  /* ignore the current frame */
};

struct mad_bitptr
{
  unsigned char const* byte;
  unsigned short	   cache;
  unsigned short	   left;
};

enum mad_error
{
  MAD_ERROR_NONE = 0x0000, /* no error */

  MAD_ERROR_BUFLEN = 0x0001, /* input buffer too small (or EOF) */
  MAD_ERROR_BUFPTR = 0x0002, /* invalid (null) buffer pointer */

  MAD_ERROR_NOMEM = 0x0031, /* not enough memory */

  MAD_ERROR_LOSTSYNC	  = 0x0101, /* lost synchronization */
  MAD_ERROR_BADLAYER	  = 0x0102, /* reserved header layer value */
  MAD_ERROR_BADBITRATE	  = 0x0103, /* forbidden bitrate value */
  MAD_ERROR_BADSAMPLERATE = 0x0104, /* reserved sample frequency value */
  MAD_ERROR_BADEMPHASIS	  = 0x0105, /* reserved emphasis value */

  MAD_ERROR_BADCRC		   = 0x0201, /* CRC check failed */
  MAD_ERROR_BADBITALLOC	   = 0x0211, /* forbidden bit allocation value */
  MAD_ERROR_BADSCALEFACTOR = 0x0221, /* bad scalefactor index */
  MAD_ERROR_BADMODE		   = 0x0222, /* bad bitrate/mode combination */
  MAD_ERROR_BADFRAMELEN	   = 0x0231, /* bad frame length */
  MAD_ERROR_BADBIGVALUES   = 0x0232, /* bad big_values count */
  MAD_ERROR_BADBLOCKTYPE   = 0x0233, /* reserved block_type */
  MAD_ERROR_BADSCFSI	   = 0x0234, /* bad scalefactor selection info */
  MAD_ERROR_BADDATAPTR	   = 0x0235, /* bad main_data_begin pointer */
  MAD_ERROR_BADPART3LEN	   = 0x0236, /* bad audio data length */
  MAD_ERROR_BADHUFFTABLE   = 0x0237, /* bad Huffman table select */
  MAD_ERROR_BADHUFFDATA	   = 0x0238, /* Huffman data overrun */
  MAD_ERROR_BADSTEREO	   = 0x0239	 /* incompatible block_type for JS */
};

enum
{
  MAD_FLAG_NPRIVATE_III = 0x0007, /* number of Layer III private bits */
  MAD_FLAG_INCOMPLETE	= 0x0008, /* header but not data is decoded */

  MAD_FLAG_PROTECTION = 0x0010, /* frame has CRC protection */
  MAD_FLAG_COPYRIGHT  = 0x0020, /* frame is copyright */
  MAD_FLAG_ORIGINAL	  = 0x0040, /* frame is original (else copy) */
  MAD_FLAG_PADDING	  = 0x0080, /* frame has additional slot */

  MAD_FLAG_I_STEREO	  = 0x0100, /* uses intensity joint stereo */
  MAD_FLAG_MS_STEREO  = 0x0200, /* uses middle/side joint stereo */
  MAD_FLAG_FREEFORMAT = 0x0400, /* uses free format bitrate */

  MAD_FLAG_LSF_EXT		= 0x1000, /* lower sampling freq. extension */
  MAD_FLAG_MC_EXT		= 0x2000, /* multichannel audio extension */
  MAD_FLAG_MPEG_2_5_EXT = 0x4000  /* MPEG 2.5 (unofficial) extension */
};

enum mad_mode
{
  MAD_MODE_SINGLE_CHANNEL = 0, /* single channel */
  MAD_MODE_DUAL_CHANNEL	  = 1, /* dual channel */
  MAD_MODE_JOINT_STEREO	  = 2, /* joint (MS/intensity) stereo */
  MAD_MODE_STEREO		  = 3  /* normal LR stereo */
};

// mad decoder options
enum
{
  MAD_OPTION_IGNORECRC		= 0x0001, /* ignore CRC errors */
  MAD_OPTION_HALFSAMPLERATE = 0x0002  /* generate PCM at 1/2 sample rate */
#if 0								  /* not yet implemented */
  MAD_OPTION_LEFTCHANNEL    = 0x0010,	/* decode left channel only */
  MAD_OPTION_RIGHTCHANNEL   = 0x0020,	/* decode right channel only */
  MAD_OPTION_SINGLECHANNEL  = 0x0030	/* combine channels */
#endif
};

enum mad_layer
{
  MAD_LAYER_I	= 1, /* Layer I */
  MAD_LAYER_II	= 2, /* Layer II */
  MAD_LAYER_III = 3	 /* Layer III */
};

enum mad_emphasis
{
  MAD_EMPHASIS_NONE		  = 0, /* no emphasis */
  MAD_EMPHASIS_50_15_US	  = 1, /* 50/15 microseconds emphasis */
  MAD_EMPHASIS_CCITT_J_17 = 3, /* CCITT J.17 emphasis */
  MAD_EMPHASIS_RESERVED	  = 2  /* unknown emphasis */
};

//mad_timer_t const mad_timer_zero;

#define MAD_TIMER_RESOLUTION 352800000UL

enum mad_units
{
  MAD_UNITS_HOURS	= -2,
  MAD_UNITS_MINUTES = -1,
  MAD_UNITS_SECONDS = 0,

  /* metric units */

  MAD_UNITS_DECISECONDS	 = 10,
  MAD_UNITS_CENTISECONDS = 100,
  MAD_UNITS_MILLISECONDS = 1000,

  /* audio sample units */

  MAD_UNITS_8000_HZ	 = 8000,
  MAD_UNITS_11025_HZ = 11025,
  MAD_UNITS_12000_HZ = 12000,

  MAD_UNITS_16000_HZ = 16000,
  MAD_UNITS_22050_HZ = 22050,
  MAD_UNITS_24000_HZ = 24000,

  MAD_UNITS_32000_HZ = 32000,
  MAD_UNITS_44100_HZ = 44100,
  MAD_UNITS_48000_HZ = 48000,

  /* video frame/field units */

  MAD_UNITS_24_FPS = 24,
  MAD_UNITS_25_FPS = 25,
  MAD_UNITS_30_FPS = 30,
  MAD_UNITS_48_FPS = 48,
  MAD_UNITS_50_FPS = 50,
  MAD_UNITS_60_FPS = 60,

  /* CD audio frames */

  MAD_UNITS_75_FPS = 75,

  /* video drop-frame units */

  MAD_UNITS_23_976_FPS = -24,
  MAD_UNITS_24_975_FPS = -25,
  MAD_UNITS_29_97_FPS  = -30,
  MAD_UNITS_47_952_FPS = -48,
  MAD_UNITS_49_95_FPS  = -50,
  MAD_UNITS_59_94_FPS  = -60
};

#define MAD_F_FRACBITS 28

#define MAD_F_MIN ((mad_fixed_t)-0x80000000L)
#define MAD_F_MAX ((mad_fixed_t) + 0x7fffffffL)

#define mad_f_todouble(x) ((double)((x) / (double)(1L << MAD_F_FRACBITS)))

#define mad_f_tofixed(x) ((mad_fixed_t)((x) * (double)(1L << MAD_F_FRACBITS) + 0.5))

struct mad_stream
{
  unsigned char const* buffer;	/* input bitstream buffer */
  unsigned char const* bufend;	/* end of buffer */
  unsigned long		   skiplen; /* bytes to skip before next frame */

  int			sync;	  /* stream sync found */
  unsigned long freerate; /* free bitrate (fixed) */

  unsigned char const* this_frame; /* start of current frame */
  unsigned char const* next_frame; /* start of next frame */
  struct mad_bitptr	   ptr;		   /* current processing bit pointer */

  struct mad_bitptr anc_ptr;	/* ancillary bits pointer */
  unsigned int		anc_bitlen; /* number of ancillary bits */

  unsigned char (*main_data)[MAD_BUFFER_MDLEN];
  /* Layer III main_data() */
  unsigned int md_len; /* bytes in main_data */

  int			 options; /* decoding options (see below) */
  enum mad_error error;	  /* error code (see above) */
};

typedef struct
{
  signed long	seconds;  /* whole seconds */
  unsigned long fraction; /* 1/MAD_TIMER_RESOLUTION seconds */
} mad_timer_t;

struct mad_header
{
  int layer;		  /* audio layer (1, 2, or 3) */
  int mode;			  /* channel mode (see above) */
  int mode_extension; /* additional mode info */
  int emphasis;		  /* de-emphasis to use (see above) */

  unsigned long bitrate;	/* stream bitrate (bps) */
  unsigned int	samplerate; /* sampling frequency (Hz) */

  unsigned short crc_check;	 /* frame CRC accumulator */
  unsigned short crc_target; /* final target CRC checksum */

  int flags;		/* flags (see below) */
  int private_bits; /* private bits (see below) */

  mad_timer_t  duration; /* audio playing time of frame */
  unsigned int size;	 /* frame size */
};

typedef signed int mad_fixed_t;

struct mad_frame
{
  struct mad_header header; /* MPEG audio header */

  int options; /* decoding options (from stream) */

  mad_fixed_t sbsample[2][36][32];	 /* synthesis subband filter samples */
  mad_fixed_t (*overlap)[2][32][18]; /* Layer III block overlap data */
};

struct mad_pcm
{
  unsigned int	 samplerate;	   /* sampling frequency (Hz) */
  unsigned short channels;		   /* number of channels */
  unsigned short length;		   /* number of samples per channel */
  mad_fixed_t	 samples[2][1152]; /* PCM output samples [ch][sample] */
};

struct mad_synth
{
  mad_fixed_t filter[2][2][2][16][8]; /* polyphase filterbank outputs */
									  /* [ch][eo][peo][s][v] */

  unsigned int phase; /* current processing phase */

  struct mad_pcm pcm; /* PCM output */
};

typedef struct
{
  struct mad_stream stream;
  struct mad_frame	frame;
  struct mad_synth	synth;
} SYNC;

struct mad_decoder
{
  int mode;

  int options;

  struct
  {
	long pid;
	int	 in;
	int	 out;
  } async;

  SYNC* sync;
  void* cb_data;

  enum mad_flow (*input_func)(void*, struct mad_stream*);
  enum mad_flow (*header_func)(void*, struct mad_header const*);
  enum mad_flow (*filter_func)(void*,
							   struct mad_stream const*, struct mad_frame*);
  enum mad_flow (*output_func)(void*,
							   struct mad_header const*, struct mad_pcm*);
  enum mad_flow (*error_func)(void*, struct mad_stream*, struct mad_frame*);
  enum mad_flow (*message_func)(void*, void*, unsigned int*);
};

// mad_header functions
void mad_header_init(struct mad_header*);
#define mad_header_finish(header) /* nothing */

// read the next frame header from the stream
//
// RETURN:   0 : all OK
//			-1 : error
int mad_header_decode(struct mad_header* header, struct mad_stream* stream);

// mad stream functions
void mad_stream_init(struct mad_stream* stream);
void mad_stream_finish(struct mad_stream* stream);
void mad_stream_skip(struct mad_stream*, unsigned long length);
int	 mad_stream_sync(struct mad_stream* stream);
void mad_stream_buffer(struct mad_stream*	stream,
					   unsigned char const* buffer, unsigned long length);

char const* mad_stream_errorstr(struct mad_stream const*);
#define mad_stream_options(stream, opts) ((void)((stream)->options = (opts)))

// mad frame functions

void mad_frame_init(struct mad_frame*);

// decode a single frame from a bitstream
//
// RETURN:   0 : all OK
//			-1 : error
int mad_frame_decode(struct mad_frame* frame, struct mad_stream* stream);

void mad_frame_finish(struct mad_frame*);
void mad_frame_mute(struct mad_frame*);

#define MAD_NCHANNELS(header) ((header)->mode ? 2 : 1)
#define MAD_NSBSAMPLES(header) \
  ((header)->layer == MAD_LAYER_I ? 12 : (((header)->layer == MAD_LAYER_III && ((header)->flags & MAD_FLAG_LSF_EXT)) ? 18 : 36))

// mad synth functions
void mad_synth_init(struct mad_synth* synth);
#define mad_synth_finish(synth) /* nothing */
void mad_synth_mute(struct mad_synth* synth);
void mad_synth_frame(struct mad_synth* synth, struct mad_frame const* frame);

// mad timer functions
extern mad_timer_t const mad_timer_zero;
#define mad_timer_reset(timer) ((void)(*(timer) = mad_timer_zero))
int mad_timer_compare(mad_timer_t, mad_timer_t);
#define mad_timer_sign(timer) mad_timer_compare((timer), mad_timer_zero)
void		  mad_timer_negate(mad_timer_t*);
mad_timer_t	  mad_timer_abs(mad_timer_t);
void		  mad_timer_set(mad_timer_t*, unsigned long, unsigned long, unsigned long);
void		  mad_timer_add(mad_timer_t*, mad_timer_t);
void		  mad_timer_multiply(mad_timer_t*, signed long);
signed long	  mad_timer_count(mad_timer_t, enum mad_units);
unsigned long mad_timer_fraction(mad_timer_t, unsigned long);
void		  mad_timer_string(mad_timer_t, char*, int, char const*,
							   enum mad_units, enum mad_units, unsigned long);

void mad_bit_init(struct mad_bitptr*, unsigned char const*);
#define mad_bit_finish(bitptr) /* nothing */
unsigned int mad_bit_length(struct mad_bitptr const*,
							struct mad_bitptr const*);

#define mad_bit_bitsleft(bitptr) ((bitptr)->left)
unsigned char const* mad_bit_nextbyte(struct mad_bitptr const*);
void				 mad_bit_skip(struct mad_bitptr*, unsigned int);
unsigned long		 mad_bit_read(struct mad_bitptr*, unsigned int);
void				 mad_bit_write(struct mad_bitptr*, unsigned int, unsigned long);
unsigned short		 mad_bit_crc(struct mad_bitptr, unsigned int, unsigned short);

void mad_decoder_init(struct mad_decoder*, void*,
					  enum mad_flow (*)(void*, struct mad_stream*),
					  enum mad_flow (*)(void*, struct mad_header const*),
					  enum mad_flow (*)(void*,
										struct mad_stream const*,
										struct mad_frame*),
					  enum mad_flow (*)(void*,
										struct mad_header const*,
										struct mad_pcm*),
					  enum mad_flow (*)(void*,
										struct mad_stream*,
										struct mad_frame*),
					  enum mad_flow (*)(void*, void*, unsigned int*));

int mad_decoder_run(struct mad_decoder*, enum mad_decoder_mode);

int mad_decoder_finish(struct mad_decoder* decoder);

char const* mad_stream_errorstr(struct mad_stream const*);

#endif

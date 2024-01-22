/*************************  StringPoolL.cpp   *********************************
* Author:        Agner Fog
* Date created:  2008-06-12
* Last modified: 2008-06-12
* Description:
* Defines memory pool for storing ASCII strings or UTF-8 encoded strings of 
* arbitrary length. The length of each string is remembered.
*
* The latest version of this file is available at:
* www.agner.org/optimize/cppexamples.zip
* (c) 2008 GNU General Public License www.gnu.org/copyleft/gpl.html
*******************************************************************************
*
* This string pool is a useful replacement for string classes such as 'string' 
* or 'CString'. It stores all strings in the same allocated memory block
* rather than allocating a new memory block for each string. This is 
* faster and causes less fragmentation of memory.
*
* StringPoolL allows strings of any length to be stored and manipulated
* without the risk of writing outside the bounds of a buffer, that the old
* C-style strings have.
*
* StringPoolL remembers the length of each string. This requires two bytes
* of extra storage for each non-zero string, but makes manipulation faster
* because it is not necessary to measure the length of a string every time
* it is manipulated. The maximum length of each string is 64 kbytes. Change
* the definition of StringPoolL::LengthType if strings longer than 64 kbytes
* can occur.
*
* StringPoolL is not thread safe if shared between threads. If your program 
* handles strings in multiple threads then each thread must have its own 
* private StringPoolL.
*
* Each string is identified by an integer index. For example:
* StringPoolL strings;
* strings[20] = "Hello world";
* strings[20].Write(stdout);
*
* This example will store the text "Hello world" as string number 20, and 
* print it to the standard output. All unused string numbers below the 
* highest used number are set to empty strings. In the above example, 
* strings[3] contains an empty string, while an attempt to read strings[21]
* would generate an error message. It is OK to have unused strings as long
* as the number is not excessive. An unused string uses 4 bytes of memory,
* while a used string uses 7 bytes plus its length. For example, a program
* that uses string numbers starting at 100 in one part of the program and
* string numbers starting at 200 in another part of the program would not
* be overly wasteful, but a program with a million unused strings would 
* waste four megabytes of memory.
*
* StringPoolL allocates a memory block of at least size AllocateSpace1  
* = 4 kilobytes when the first string is stored. You may change this value.
* If the memory block is filled up, it will allocate a new memory block of
* more than the double size and move all strings to the new block. Garbage
* collection takes place only when a new memory block is allocated.
*
* Note that you should never store a pointer to a string in the string pool
* because the pointer will become invalid in case the assignment or
* modification of another string causes the memory to be re-allocated.
* All strings should be identified by their index, not by pointers. 
*
* Attempts to read a non-existing string or read beyond the end of a string
* will cause an error message to the standard error output. You may change
* the StringPoolL::Error function to produce a message box if the program has
* a graphical user interface.
*
* At the end of this file you will find a working example of how to use 
* StringPoolL and how to manipulate strings.
*
* The first part of this file containing declarations may be placed in a 
* header file. The second part containing function definitions should be in
* a .cpp file. The third part containing examples should be removed from your
* final application.
*
******************************************************************************/

/******************************************************************************
Header part. Put this in a .h file:
******************************************************************************/
#ifndef STRINGPOOLL_H
#define STRINGPOOLL_H

#define _CRT_SECURE_NO_WARNINGS // Avoid warning for vsnprintf function in MS compiler
#define _CRT_SECURE_NO_DEPRECATE
#pragma warning(disable : 4996)
#include <memory.h> // For memcpy and memset
#include <string.h> // For strlen, strcmp, strchr
#include <stdlib.h> // For exit in Error function
#include <stdarg.h> // For va_list, va_start
#include <stdio.h>	// Needed for example only
//#include <varargs.h>            // Include varargs.h for va_list, va_start only if required by your system

// Define pointer to zero-terminated string
typedef char const* PChar;

// Class definition for StringPoolL
class StringPoolL
{
  public:
  // Length stored as 16-bit integer.
  // Change this to unsigned int if strings can be longer than 64 kilobytes:
  typedef unsigned short int LengthType; // Type for string length
  // Helper class StringElement. This class defines all the operators and
  // functions we can apply to StringPoolLObject[i]:
  class StringElement
  {
public:
	// Constructor:
	StringElement(StringPoolL& a, int i) :
		arr(a) { index = i; };
	// Get string length:
	LengthType Len() const { return arr.Len(index); };
	// Format string using printf style formating:
	StringElement const& Printf(const char* format, ...);
	// Write string to file or stdout:
	int Write(FILE* f);
	// Search in string:
	int SearchForSubstring(PChar s);
	// Assign substring:
	StringElement const& SetToSubstring(PChar s, size_t start, size_t len);
	// Operator '=' assigns string:
	StringElement const& operator=(PChar s)
	{
	  arr.Set(index, s);
	  return *this;
	};
	// Same, the length of the string is known:
	StringElement const& operator=(StringElement const& s)
	{
	  arr.Set(index, s, (unsigned int)s.Len());
	  return *this;
	};
	// Operator '+=' concatenates strings:
	void operator+=(const char* s) { arr.Concatenate(index, s); };
	// Automatic conversion to const char *
	operator PChar() const { return arr.Get(index); };
	// Operator '[]' gives access to a single character in a string:
	char& operator[](int i);

protected:
	StringPoolL& arr;	// Reference to the StringPoolL that created this object
	int			 index; // Index to string in StringPoolL
  };
  friend class StringElement; // Friend class defining all operations we can do on StringPoolObject[i]

  // Members of class StringPoolL
  StringPoolL();							   // Constructor
  ~StringPoolL();							   // Destructor
  void			Clear();					   // Erase all strings
  int			GetNum() const { return Num; } // Get number of strings
  StringElement operator[](int i)
  { // Operator '[]' gives access to a string in StringPoolL
	return StringElement(*this, i);
  }
  void		 Set(int i, PChar s);					// Insert zero-terminated string. Used by StringElement
  void		 Set(int i, PChar s, unsigned int len); // Insert non zero-terminated string. Used by StringElement
  void		 Concatenate(int i, PChar s);			// Concatenate strings. Used by StringElement
  void		 ReserveBuf(unsigned int newsize);		// Allocate memory for string space
  void		 ReserveNum(unsigned int newsize);		// Allocate memory for string indices
  LengthType Len(int i) const;						// Get length of string

  // Define desired allocation sizes. You may change these values:
  enum DefineSizes
  {
	AllocateSpace1 = 4096,	  // Minimum number of characters to allocate in string buffer
	AllocateSpace2 = 1024,	  // Minimum number of indices to allocate in offsets buffer
	FormatLength   = 2048 - 1 // Maximum length of strings written with Printf
  };

  protected:
  char* Get(int i) const;				 // Read string. Used only from StringElement
  void	Error(int message, int i) const; // Produce fatal error message.
  private:
  char*			Buffer;							   // Memory block containing strings
  char*			OldBuffer;						   // Save old Buffer during copying of string
  unsigned int* Offsets;						   // Memory block containing offsets to strings
  unsigned int	BufferSize;						   // Size of buffer block
  unsigned int	OffsetsSize;					   // Size of Offsets block
  unsigned int	DataSize;						   // Used part of Buffer, including garbage
  unsigned int	GarbageSize;					   // Total size of garbage in Buffer
  unsigned int	Top;							   // Highest used Offset
  int			Num;							   // Number of strings = highest used index in Offsets + 1
  char*			Allocate(int i, unsigned int len); // Make space for a new string
  StringPoolL(StringPoolL&){};					   // Private copy constructor to prevent copying
  void operator=(StringPoolL&){};				   // Private operator = to prevent copying
};

/******************************************************************************
Operators for comparing strings. You may include these if needed.
Replace strcmp by stricmp (Windows) or strcasecmp (Linux) if you want 
case-insensitive compares.
******************************************************************************/

inline bool operator==(StringPoolL::StringElement const& a, StringPoolL::StringElement const& b)
{
  return strcmp(a, b) == 0;
}
inline bool operator!=(StringPoolL::StringElement const& a, StringPoolL::StringElement const& b)
{
  return strcmp(a, b) != 0;
}
inline bool operator<(StringPoolL::StringElement const& a, StringPoolL::StringElement const& b)
{
  return strcmp(a, b) < 0;
}
inline bool operator>(StringPoolL::StringElement const& a, StringPoolL::StringElement const& b)
{
  return strcmp(a, b) > 0;
}

#endif STRINGPOOLL_H
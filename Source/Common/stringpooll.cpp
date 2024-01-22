#include "StringPoolL.h"
#include "MyMemory.h"

// Default constructor
StringPoolL::StringPoolL()
{
  // Set everything to zero
  memset(this, 0, sizeof(*this));
}

// Destructor
StringPoolL::~StringPoolL()
{
  // Free allocated memory
  if(Buffer) delete[] Buffer;
  if(OldBuffer) delete[] OldBuffer;
  if(Offsets) delete[] Offsets;
  // Set everything to zero
  memset(this, 0, sizeof(*this));
}

// Erase all strings
void StringPoolL::Clear()
{
  // Set all offsets to zero
  if(Offsets) memset(Offsets, 0, Num * sizeof(*Offsets));
  // Indicate that Buffer is empty, but do not deallocate
  DataSize = GarbageSize = 0;
}

// Insert string. Used by StringElement
void StringPoolL::Set(int i, PChar s)
{
  if(i >= Num)
  {
	// i is higher than any previous index
	Num = i + 1;
	if((unsigned int)i >= OffsetsSize)
	{
	  // Make Offsets buffer bigger
	  ReserveNum(i + 1);
	}
  }
  // Length of new string
  size_t len = 0;
  if(s) len = strlen(s);
  if(len == 0)
  {
	// Erase string
	if(Offsets[i])
	{
	  GarbageSize += Len(i) + 1 + sizeof(LengthType);
	  Offsets[i] = 0;
	}
	return;
  }
  // Check if too long
  if(len > (size_t)(LengthType)(-1))
  {
	Error(5, (int)len); // Longer than max LengthType
  }
  // Make space for string
  char* p = Allocate(i, (unsigned int)len);
  // Insert length
  *(LengthType*)p = (LengthType)len;
  // Insert string
  memcpy(p + sizeof(LengthType), s, len + 1);
  // Release OldBuffer if any
  if(OldBuffer)
  {
	delete[] OldBuffer;
	OldBuffer = 0;
  }
}

// Insert non zero-terminated string. Used by StringElement
void StringPoolL::Set(int i, PChar s, unsigned int len)
{
  if(i >= Num)
  {
	// i is higher than any previous index
	Num = i + 1;
	if((unsigned int)i >= OffsetsSize)
	{
	  // Make Offsets buffer bigger
	  ReserveNum(i + 1);
	}
  }
  // Length of new string
  if(len == 0)
  {
	// Erase string
	if(Offsets[i])
	{
	  GarbageSize += Len(i) + 1 + sizeof(LengthType);
	  Offsets[i] = 0;
	}
	return;
  }
  // Make space for string
  char* p = Allocate(i, len);
  // Insert length
  *(LengthType*)p = (LengthType)len;
  // Insert string
  memcpy(p + sizeof(LengthType), s, len);
  // Zero-terminate
  p[len + sizeof(LengthType)] = 0;
  // Release OldBuffer if any
  if(OldBuffer)
  {
	delete[] OldBuffer;
	OldBuffer = 0;
  }
}

// Concatenate strings. Used by StringElement
void StringPoolL::Concatenate(int i, PChar s)
{
  unsigned int len1 = Len(i); // Length of first string
  size_t	   len2 = 0;	  // Length of second string
  if(s) len2 = strlen(s);
  if(len2 == 0)
  {
	// Second string is empty. Do nothing
	return;
  }
  // Check if too long
  if(len2 > (size_t)(LengthType)(-1))
  {
	Error(5, (int)len2); // Longer than max LengthType
  }
  // Check i
  if(i >= Num) Error(1, i); // Out of range
  if(len1 == 0)
  {
	// First string is empty. Just insert new string
	Set(i, s);
	return;
  }
  // Remember position of string1
  PChar string1 = Get(i);
  // Make space for combined string
  char* p = Allocate(i, len1 + (unsigned int)len2);
  // Insert length
  *(LengthType*)p = LengthType(len1 + (unsigned int)len2);
  // Copy strings
  memcpy(p + sizeof(LengthType), string1, len1);
  memcpy(p + sizeof(LengthType) + len1, s, (unsigned int)len2 + 1);
  // Release OldBuffer if any
  if(OldBuffer)
  {
	delete[] OldBuffer;
	OldBuffer = 0;
  }
}

// Allocate new memory for string space and do garbage collection
void StringPoolL::ReserveBuf(unsigned int newsize)
{
  int		   i;			  // Loop counter
  unsigned int DataSize2 = 0; // Used part of buffer after garbage collection
  unsigned int Strlen;		  // Length of current string

  // Decide new size
  if(newsize < (DataSize - GarbageSize) * 2 + AllocateSpace1)
  {
	newsize = (DataSize - GarbageSize) * 2 + AllocateSpace1;
  }
  // Allocate new larger block
  char* Buffer2 = new char[newsize + 1 + sizeof(LengthType)];
  if(Buffer2 == 0) Error(3, newsize); // Allocation failed

  // Make empty string at offset 0. This will be used for all empty strings
  *(LengthType*)Buffer2		  = 0;
  Buffer2[sizeof(LengthType)] = 0;
  DataSize2 = Top = sizeof(LengthType) + 1;

  // Copy strings from old to new buffer
  if(Buffer)
  {
	// Loop through old indices
	for(i = 0; i < Num; i++)
	{
	  if(Offsets[i])
	  {
		// Length of string
		Strlen = Len(i);
		if(Strlen)
		{
		  // String is not empty, copy it
		  memcpy(Buffer2 + DataSize2, Buffer + Offsets[i], Strlen + sizeof(LengthType) + 1);
		  // Store new offset
		  Offsets[i] = Top = DataSize2;
		  // Offset to next
		  DataSize2 += Strlen + sizeof(LengthType) + 1;
		} else
		{
		  // Empty string found
		  Offsets[i] = 0;
		  GarbageSize += sizeof(LengthType) + 1;
		}
	  }
	}
	// OldBuffer should be empty here.
	// This check should not be necessary in single-thread applications:
	if(OldBuffer)
	{
	  delete[] OldBuffer;
	  OldBuffer = 0;
	}

	// Save old buffer, but don't delete it yet, because it might
	// contain a string being copied. Remember to delete Oldbuffer
	// after new string has been stored
	OldBuffer = Buffer;
  }

  // Save new buffer
  Buffer	 = Buffer2;
  BufferSize = newsize + sizeof(LengthType) + 1;

  // Save new DataSize
  DataSize	  = DataSize2;
  GarbageSize = 0;
}

// Allocate memory for string indices
void StringPoolL::ReserveNum(unsigned int newsize)
{
  // Only grow, not shrink:
  if(newsize <= OffsetsSize) return;

  // Decide new size
  if(newsize < OffsetsSize * 2 + AllocateSpace2)
  {
	newsize = OffsetsSize * 2 + AllocateSpace2;
  }

  // Allocate new larger block
  unsigned int* Offsets2 = new unsigned int[newsize];
  if(Offsets2 == 0) Error(3, newsize); // Allocation failed

  // Copy indices to new block unless empty
  if(Offsets) memcpy(Offsets2, Offsets, OffsetsSize * sizeof(*Offsets));

  // Set rest of new block to zero
  if(newsize > OffsetsSize)
  {
	memset(Offsets2 + OffsetsSize, 0, (newsize - OffsetsSize) * sizeof(*Offsets2));
  }

  // Deallocate old block
  if(Offsets) delete[] Offsets;

  // Save pointer to new block
  Offsets	  = Offsets2;
  OffsetsSize = newsize;
}

// Get length of string
StringPoolL::LengthType StringPoolL::Len(int i) const
{
  // Check that i is within range
  if((unsigned int)i >= (unsigned int)Num)
  {
	// Out of range
	Error(1, i);
  }
  // Return pointer
  return *(LengthType*)(Buffer + Offsets[i]);
}

// Read string. Used only by StringElement
char* StringPoolL::Get(int i) const
{
  // Check that i is within range
  if((unsigned int)i >= (unsigned int)Num)
  {
	// Out of range
	Error(1, i);
  }
  // Return pointer
  return Buffer + sizeof(LengthType) + Offsets[i];
}

// Produce fatal error message. Used internally and by StringElement.
// Note: If your program has a graphical user interface (GUI) then you
// must rewrite this function to produce a message box with the error message.
void StringPoolL::Error(int message, int i) const
{
  // Define error texts
  static const char* ErrorTexts[] = {
	  "Unknown error",				// 0
	  "Index out of range",			// 1
	  "Going beyond end of string", // 2
	  "Memory allocation failed",	// 3
	  "Formatted string too long",	// 4
	  "String too long"				// 5
  };
  // Number of texts in ErrorTexts
  const unsigned int NumErrorTexts = sizeof(ErrorTexts) / sizeof(*ErrorTexts);

  // check that index is within range
  if((unsigned int)message >= NumErrorTexts) message = 0;

  // Replace this with your own error routine, possibly with a message box:
  fprintf(stderr, "\nStringPool error: %s (%i)\n", ErrorTexts[message], i);

  // Terminate execution
  exit(1);
}

// Make space for a new string. Used only internally
// Allocate reserves space for a string of length 'len' plus the length
// word plus the terminating zero. The return value is not a pointer to
// the string but a pointer to the length word preceding the string.
char* StringPoolL::Allocate(int i, unsigned int len)
{
  // This is allready done by Set or Concatenate before calling Allocate:
  // if (i >= OffsetsSize) ReserveNum(i+1);

  if(Offsets[i])
  {
	// Index i allready has a string
	if(Offsets[i] == Top)
	{
	  // This is last in Buffer. Can grow without overwriting other strings
	  if(Top + sizeof(LengthType) + 1 + len > BufferSize)
	  {
		// Buffer not big enough
		ReserveBuf(Top + sizeof(LengthType) + 1 + len);
	  }
	  // Reserve size
	  DataSize = Top + sizeof(LengthType) + 1 + len;
	  // Return pointer. Offsets[i] unchanged
	  return Buffer + Top;
	}
	// Length of old string
	unsigned int OldLen = Len(i);
	if(OldLen >= len)
	{
	  // New string fits into same space
	  GarbageSize += OldLen - len;
	  // Return pointer. Offsets[i] unchanged
	  return Buffer + Offsets[i];
	}
	// New string doesn't fit into existing space. Old string becomes garbage
	GarbageSize += OldLen + sizeof(LengthType) + 1;
  }
  // Put new string at end of Buffer
  if(DataSize + sizeof(LengthType) + 1 + len > BufferSize)
  {
	// Make Buffer bigger
	ReserveBuf(DataSize + sizeof(LengthType) + 1 + len);
  }
  // New offset
  Offsets[i] = Top = DataSize;
  DataSize += sizeof(LengthType) + 1 + len;
  // Return pointer
  return Buffer + Top;
}

// Format string using printf style formatting
StringPoolL::StringElement const& StringPoolL::StringElement::Printf(const char* format, ...)
{
  // Temporary buffer for new string.
  // You may change the maximum length StringPoolL::FormatLength defined above
  const int FormatLength = StringPoolL::FormatLength;
  char		strbuf[FormatLength + 1];
  // Variable argument list
  va_list args;
  va_start(args, format);
  // Write formatted string to strbuf
  int len = vsnprintf(strbuf, FormatLength, format, args);
  // Check for errors
  if(len < 0)
  {
	// len < 0 indicates an error in vsnprintf. Activate Error
	len = FormatLength + 1;
  }
  if(len > FormatLength)
  {
	// Error message if string too long
	arr.Error(4, len);
  }
  // Terminate string
  strbuf[FormatLength] = 0;
  // Put into string pool
  arr.Set(index, strbuf);
  return *this;
};

// Write string to file or standard output
int StringPoolL::StringElement::Write(FILE* f)
{
  return fprintf(f, "%s", (PChar)arr.Get(index));
}

// Search in string for any substring.
// The return value is the position of the substring if found,
// or -1 if not found.
int StringPoolL::StringElement::SearchForSubstring(PChar s)
{
  PChar h = arr.Get(index);
  PChar n = strstr(h, s);
  if(n)
  {
	// Substring found. Return offset
	return int(n - h);
  }
  // Not found
  return -1;
}

// Set string to a part of another string
StringPoolL::StringElement const& StringPoolL::StringElement::SetToSubstring(PChar s, size_t start, size_t len)
{
  // Get length of full string s
  size_t len1 = 0;
  if(s) len1 = strlen(s);
  if(start + len > len1)
  {
	// Outside bounds of string s
	arr.Error(2, start + len);
  }
  // Save substring
  arr.Set(index, s + start, len);
  return *this;
}

// Operator '[]' lets you read or write a single character in the string.
char& StringPoolL::StringElement::operator[](int i)
{
  if((unsigned int)i >= (unsigned int)Len())
  {
	// Index out of range
	arr.Error(2, i);
  }
  return arr.Get(index)[i];
}

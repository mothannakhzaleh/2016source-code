#ifndef __MYALLOC_H
#define __MYALLOC_H
#ifdef __MEM_DEBUG__
extern void AddTrack(void* addr, size_t asize, const char *fname, unsigned long lnum);
extern void RemoveTrack(void* addr);
extern size_t GetCurUseMemory();
extern size_t GetMaxUseMemory();
extern DWORD  GetCurObject();
extern DWORD  GetMaxObject();

#ifdef __cplusplus
inline 
#endif
void* MyAlloc(size_t size, const char* file, int line)
{
	void* p = malloc(size);
	AddTrack(p, size, file, line);
	return p;
}

#define _ALLOC(size) MyAlloc(size, __FILE__, __LINE__)
#define _FREE(p)	 if(p) { RemoveTrack(p); free(p); p = NULL; }
#else
#define _ALLOC(size) malloc(size)
#define _FREE(p)	 if(p){ free(p); p = NULL; }
#endif
#endif//__MYALLOC_H
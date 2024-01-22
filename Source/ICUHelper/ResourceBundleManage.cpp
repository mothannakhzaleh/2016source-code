#include "resourcebundlemanage.h"

#include "windows.h"
#include <string>

using namespace std;

#define BUFFER_SIZE 255

class CLogLock
{
public:
	CLogLock() { InitializeCriticalSection(&_cs); }
	~CLogLock() { DeleteCriticalSection(&_cs); }

	void Lock() { EnterCriticalSection(&_cs); }
	void Unlock() { LeaveCriticalSection(&_cs); }

private:
    CRITICAL_SECTION _cs;
};

CFormatParameter::CFormatParameter(int paraNum)
{
	UErrorCode status = U_ZERO_ERROR;
	m_MsgArgs = new icu::Formattable[paraNum];
	this->paraNum = paraNum;
}

CFormatParameter::~CFormatParameter()
{
	if(m_MsgArgs)
	{
		delete[] m_MsgArgs;
		m_MsgArgs = NULL;
	}
}

void CFormatParameter::setDouble(int index, double d)
{
	m_MsgArgs[index].setDouble(d);
}

void CFormatParameter::setLong(int index, int32_t l)
{
	m_MsgArgs[index].setLong(l);
}

void CFormatParameter::setInt64(int index, int64_t ll) 
{
	m_MsgArgs[index].setInt64(ll);
}

void CFormatParameter::setDate(int index, UDate d) 
{
	m_MsgArgs[index].setDate(d);
}

void CFormatParameter::setString(int index, const icu::UnicodeString &stringToCopy)
{
	m_MsgArgs[index].setString(stringToCopy);
}

CResourceBundleManage* CResourceBundleManage::_instance = NULL;

CResourceBundleManage* CResourceBundleManage::Instance(const char* configFileName)
{
    if(_instance == NULL && configFileName == NULL)
    {
        throw "Resource is not instance!";
    }

    if(_instance != NULL && configFileName != NULL)
    {
        throw "Resource is already instance!";
        //_instance = new CResourceBundleManage();
    }

    if(_instance == NULL)
    {
        _instance = new CResourceBundleManage(configFileName);
    }

    return _instance;
}

CResourceBundleManage::CResourceBundleManage(const char* configFileName)
: m_ResDir(NULL), m_ResLocale(NULL), m_pResourceBundle(NULL), m_pConverter(NULL), m_MaxSize(0)/*, m_LogFile(NULL), m_LogFlag(0)*/
{
    char szPath[MAX_PATH]; 
    
    if( !GetModuleFileName( NULL, szPath, MAX_PATH ) )
    {
        throw "GetModuleFileName failed \n"; 
    }
	// 取得入口程序的路径
	const char* ret = strrchr(szPath, '\\');
	long dirLength = (long)(ret - szPath);

	size_t length = strlen(configFileName);
	char* fileName = new char[dirLength + length + 2 ];
	//char* fileName = cnew char[dirLength + length + 2 ];
	memcpy(fileName, szPath, dirLength);
	fileName[dirLength] = '\\';
	memcpy(fileName + dirLength + 1, configFileName, length);
	fileName[dirLength + length + 1] = 0;

	UErrorCode status;
	icu::Locale::setDefault(icu::Locale::getEnglish(),status);

	const char* lpAppName = "locale";
	const char* lpLocaleKeyName = "locale";
	const char* lpPathKeyName = "path";
	const char* lpDefaultLocale = "en_US";
	char* lpDefaultPath = new char[dirLength + 1];
	//char* lpDefaultPath = cnew char[dirLength + 1];
	memcpy(lpDefaultPath, szPath, dirLength);
	lpDefaultPath[dirLength] = 0;

	char lpReturnedLocaleString[BUFFER_SIZE];
	char lpReturnedPathString[BUFFER_SIZE];

	length = GetPrivateProfileStringA(lpAppName,lpLocaleKeyName,lpDefaultLocale,lpReturnedLocaleString,sizeof(lpReturnedLocaleString),fileName);

	m_ResLocale = new char[length+1];
	//m_ResLocale = cnew char[length+1];
	memcpy(m_ResLocale, lpReturnedLocaleString, length);
	m_ResLocale[length] = 0;

	length = GetPrivateProfileStringA(lpAppName,lpPathKeyName,lpDefaultPath,lpReturnedPathString,sizeof(lpReturnedPathString),fileName);

	m_ResDir = new char[length + 1];
	//m_ResDir = cnew char[length + 1];
	memcpy(m_ResDir, lpReturnedPathString, length);
	m_ResDir[length] = 0;

	//m_LogFlag = GetPrivateProfileInt(lpAppName, "log", 0 ,fileName);

	delete[] fileName;
	//cdelete(fileName);
	delete[] lpDefaultPath;
	//cdelete(lpDefaultPath);

	//if(m_LogFlag)
	//{
	//	string logFileName = string(m_ResDir) + "\\res.log";
	//	
	//	errno_t err;

	//	if( (err  = fopen_s( &m_LogFile,logFileName.c_str(), "w+" )) !=0 )
	//	{
	//		::MessageBox(NULL, "Open resource log ", NULL, 0);

	//		m_LogFile = NULL;
	//	}
	//}

	status = U_ZERO_ERROR;
	m_pConverter = ucnv_open(NULL, &status); //ucnv_open("cp936", &status); // windows-936-2000
	
	if(status == U_ZERO_ERROR)
	{

	}
	else if(status == U_MEMORY_ALLOCATION_ERROR)
		::MessageBox(NULL,"Memory allocation error",NULL,0);
	else if(status == U_FILE_ACCESS_ERROR)
		::MessageBox(NULL,"The requested file cannot be found",NULL,0);
	else
		::MessageBox(NULL,"Other error!",NULL,0);

	m_MaxSize = ucnv_getMaxCharSize(m_pConverter);

	m_pLocale = new icu::Locale(m_ResLocale);
	m_pResourceBundle = new icu::ResourceBundle(m_ResDir,m_ResLocale, status);

	Init();
}

CResourceBundleManage::~CResourceBundleManage(void)
{
	Release();
}

// 取得资源个数
int CResourceBundleManage::GetSize(void)
{
	return (int)mapRes.size();
}

// 把Unicode字符串转换为多字节本机编码
UErrorCode CResourceBundleManage::ToCodePageString(UConverter *conv, UChar* source, char* target, int destCapacity, int& len)
{
  UErrorCode status = U_ZERO_ERROR;

  len = ucnv_fromUChars(conv, target, destCapacity, source, -1, &status);

  if(U_SUCCESS(status) == FALSE)
	  return status;

  return status;
}

// 初始化资源管理器
bool CResourceBundleManage::Init()
{
	int len = 0;
	int maxSize = 0;

	UErrorCode status = U_ZERO_ERROR;

#if _DEBUG

	const char* name = ucnv_getName(m_pConverter, &status);
	//printf("Current CodePage is %s\n",name);

#endif

	status = U_ZERO_ERROR;

	if(U_SUCCESS(status) == TRUE)
	{
		m_pResourceBundle->resetIterator();
		
        while(m_pResourceBundle->hasNext()) {
            icu::ResourceBundle bundle = m_pResourceBundle->getNext(status);

			if(status == U_ZERO_ERROR)
			{
				const char * key = bundle.getKey();

				icu::UnicodeString value = bundle.getString(status);

				len = 0;
				maxSize = m_MaxSize * ( 1 + value.length());

				char* buffer = new char[maxSize];
				//char* buffer = cnew char[maxSize];
				memset(buffer, 0, maxSize);

				ToCodePageString(m_pConverter, const_cast<UChar*>(value.getTerminatedBuffer()), buffer, maxSize, len);

				mapRes[key] = buffer;
			}
			else
			{
				printf("Error!\r\n");
			}
		}
	
		return true;
	}

	return false;
}

// 释放资源
void CResourceBundleManage::Release(void)
{
	const char* pBuffer = NULL;
	for(StringMap::iterator i = mapRes.begin(); i != mapRes.end(); i++)
	{
		pBuffer = i->second.c_str();
		delete pBuffer;
		//cdelete(pBuffer);
	}

	delete[] m_ResDir;
	//cdelete(m_ResDir);
	delete[] m_ResLocale;
	//cdelete(m_ResLocale);

	m_ResDir = NULL;
	m_ResLocale = NULL;

	mapRes.clear();

	delete m_pLocale;
	delete m_pResourceBundle;

	if (m_pConverter != NULL)
		ucnv_close(m_pConverter);

	//if(m_LogFlag)
	//{
	//	if(m_LogFile)
	//	{
	//		fclose(m_LogFile);
	//		m_LogFile = NULL;
	//	}
	//}
}

// 根据ID取得字符串
const char* CResourceBundleManage::LoadResString(const char* key)
{
	const char* ret ="";
	StringMap::iterator in = mapRes.find(key);

	if(in != mapRes.end())
	{
		ret = in->second.c_str();
	}
#if _DEBUG
	//printf("key = %s value = %s\n",key, ret);
#endif

	//static CLogLock lock;
	//lock.Lock();
	//if(m_LogFlag)
	//{
	//	if(m_LogFile)
	//	{
	//		fprintf_s(m_LogFile, "Key = [%s] Value = %s\r\n", key, ret);
	//	}
	//}
	//lock.Unlock();

	return ret;
}
 
icu::UnicodeString CResourceBundleManage::LoadUResString(const char* key)
{
	UErrorCode status = U_ZERO_ERROR;
	return m_pResourceBundle->getStringEx(key, status);
}

// 格式根据参数化一个字符串
int CResourceBundleManage::Format(const char* key, CFormatParameter& parameter, char buffer[])
{
    UErrorCode status = U_ZERO_ERROR;
    icu::UnicodeString str;
    icu::FieldPosition pos;

	icu::UnicodeString format = LoadUResString(key);

	// Create a message format
    icu::MessageFormat msg(format, status);
    msg.format(parameter.GetMsgArgs(), parameter.GetParaNum(), str, pos, status);

	int len = 0;
	int maxSize = m_MaxSize * ( 1 + str.length());

	ToCodePageString(m_pConverter, const_cast<UChar*>(str.getTerminatedBuffer()), buffer, maxSize, len);

	return len;
}

// 格式根据参数化一个字符串
int CResourceBundleManage::FormatString(const char* formatStr, CFormatParameter& parameter, char buffer[])
{
    UErrorCode status = U_ZERO_ERROR;
    icu::UnicodeString str;
    icu::FieldPosition pos;

	icu::UnicodeString format = formatStr;

	// Create a message format
    icu::MessageFormat msg(format, status);
    msg.format(parameter.GetMsgArgs(), parameter.GetParaNum(), str, pos, status);

	int len = 0;
	int maxSize = m_MaxSize * ( 1 + str.length());

	ToCodePageString(m_pConverter, const_cast<UChar*>(str.getTerminatedBuffer()), buffer, maxSize, len);

	return len;
}

int32_t CBreakLine::WrapParagraph(const icu::UnicodeString& s, const icu::Locale& locale, int32_t maxCharsPreLine, int32_t lineStarts[], int32_t lineEnds[], int32_t maxLines)
{
    int32_t        numLines = 0;
    int32_t        p, q, t;

	UChar          c;

	UErrorCode status = U_ZERO_ERROR;

    icu::BreakIterator *bi = icu::BreakIterator::createLineInstance(locale, status);
    
	if (U_FAILURE(status)) {
        delete bi;
        return 0;
    }
    bi->setText(s);


    p = 0;

	int32_t len = s.length();

    while (p < s.length()) {
        // jump ahead in the paragraph by the maximum number of
        // characters that will fit
        q = p + maxCharsPreLine;

        // if this puts us on a white space character, a control character
        // (which includes newlines), or a non-spacing mark, seek forward
        // and stop on the next character that is not any of these things
        // since none of these characters will be visible at the end of a
        // line, we can ignore them for the purposes of figuring out how
        // many characters will fit on the line)
        if (q < s.length()) {
            c = s[q];
            while (q < s.length()
                   && (u_isspace(c)
                       || u_charType(c) == U_CONTROL_CHAR 
                       || u_charType(c) == U_NON_SPACING_MARK
            )) {
                ++q;
                c = s[q];
            }
        }

        // then locate the last legal line-break decision at or before
        // the current position ("at or before" is what causes the "+ 1")
        t = bi->preceding(q + 1);

		if(q - t >= maxCharsPreLine)
		{
			q = t;

			lineStarts[numLines] = p;

			p += maxCharsPreLine;
			++numLines;
		}
		else
		{
			q = t;

			// if this causes us to wind back to where we started, then the
			// line has no legal line-break positions. Break the line at
			// the maximum number of characters
			if (q == p) {
				p += maxCharsPreLine;
				lineStarts[numLines] = p;
				++numLines;
			}
			// otherwise, we got a good line-break position. Record the start of this
			// line (p) and then seek back from the end of this line (q) until you find
			// a non-white space character (same criteria as above) and
			// record the number of white space characters at the end of the
			// line in the other results array
			else {
				lineStarts[numLines] = p;
				int32_t nextLineStart = q;
				for (q--; q > p; q--) {
					c = s[q];
					if (!(u_isspace(c)
						   || u_charType(c) == U_CONTROL_CHAR 
						   || u_charType(c) == U_NON_SPACING_MARK)) {
						break;
					}
				} 

				p = nextLineStart;
			    ++numLines;
			}
		}
        if (numLines >= maxLines) {
            break;
        }
    }
    delete bi;

	for(int i=0;i<numLines-1;i++)
	{
		lineEnds[i] = lineStarts[i+1];
	}

	if(numLines > 0)
		lineEnds[numLines - 1] = s.length();

    return numLines;
}
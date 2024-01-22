#pragma once

#include <exception>
#include <stdexcept>
#include <string>

class excpSync : public std::runtime_error
{
  public:
  excpSync(const char* message) :
	  std::runtime_error(message){};
};

class excpMem : public std::runtime_error
{
  public:
  excpMem(const char* message) :
	  std::runtime_error(message){};
};

class excpThrd : public std::runtime_error
{
  public:
  excpThrd(const char* message) :
	  std::runtime_error(message){};
};

class excpIniF : public std::runtime_error
{
  public:
  excpIniF(const char* message) :
	  std::runtime_error(message){};

  excpIniF(std::string const& message) :
	  std::runtime_error(message){};
};

class excpFile : public std::runtime_error
{
  public:
  excpFile(const char* message) :
	  std::runtime_error(message){};

  excpFile(std::string const& message) :
	  std::runtime_error(message){};
};






//------------------------------------------------------------------------------------------------------------------
//common exception define
//class excp:public std::exception			//基异常类
//{
//public:
//	excp(cChar * desc):std::exception((_mPtr=new char[strlen(desc)+1])?strcpy(_mPtr,desc):""){}
//	excp(excp &e):std::exception(_mPtr=e._mPtr){e.setZero();}
//	virtual ~excp(){delete[]_mPtr;}
//	virtual cChar *what() const{return _mPtr;}
//private:
//	excp &operator=(excp &e){
//		delete[]_mPtr;
//		exception::operator =(e);
//		_mPtr=e._mPtr;
//		e.setZero();
//		return *this;
//	};
//	void setZero(){exception::operator=(exception());_mPtr =0;}
//
//	char *_mPtr;
//};
//------------------------------------------------------------------------------------------------------------------
//class excpMem:public excp				//内存分配或释放异常
//{
//public:
//	excpMem(cChar * desc):excp(desc){};
//};
//------------------------------------------------------------------------------------------------------------------
//class excpArr:public excp				//数组越界或其他数组相关错误异常
//{
//public:
//	excpArr(cChar * desc):excp(desc){};
//};
//------------------------------------------------------------------------------------------------------------------
//class excpSync:public excp				//操作系统同步对象操作异常
//{
//public:
//	excpSync(cChar * desc):excp(desc){};
//};
//------------------------------------------------------------------------------------------------------------------
//class excpThrd:public excp				//操作系统线程操作异常
//{
//public:
//	excpThrd(cChar * desc):excp(desc){};
//};
//class excpSock:public excp				//操作系统线程操作异常
//{
//public:
//	excpSock(cChar * desc):excp(desc){};
//};
////------------------------------------------------------------------------------------------------------------------
//class excpCOM:public excp				//COM操作异常
//{
//public:
//	excpCOM(cChar * desc):excp(desc){};
//};
////------------------------------------------------------------------------------------------------------------------
//class excpDB:public excp				//数据库操作异常
//{
//public:
//	excpDB(cChar * desc):excp(desc){};
//};
////------------------------------------------------------------------------------------------------------------------
//class excpIniF:public excp				//文件操作异常
//{
//public:
//	excpIniF(cChar * desc):excp(desc){};
//};
////------------------------------------------------------------------------------------------------------------------
//class excpFile:public excp				//文件操作异常
//{
//public:
//	excpFile(cChar * desc):excp(desc){};
//};
////------------------------------------------------------------------------------------------------------------------
//class excpXML:public excp				//文件操作异常
//{
//public:
//	excpXML(cChar * desc):excp(desc){};
//};




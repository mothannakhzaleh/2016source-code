#ifndef LESingleton_H
#define LESingleton_H

/** 模板类用于创建单例实体
*/
template <typename T> class LESingleton
{
protected:

	static T* m_sSingleton;

public:
	LESingleton(void)
	{
		assert( !m_sSingleton );
#if defined( _MSC_VER ) && _MSC_VER < 1200	 
		int offset = (int)(T*)1 - (int)(LESingleton <T>*)(T*)1;
		m_sSingleton = (T*)((int)this + offset);
#else
		m_sSingleton = static_cast< T* >( this );
#endif
	}

	~LESingleton(void)
	{  assert( ms_Singleton );  m_sSingleton = 0;  }

	static T& getSingleton(void)
	{	assert( ms_Singleton );  return ( *m_sSingleton ); }

	static T* getSingletonPtr(void)
	{ return m_sSingleton; }
};


#endif
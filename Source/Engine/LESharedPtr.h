#ifndef LESharedPtr_H
#define LESharedPtr_H

#include "LEEffPrerequisites.h"

template <class T> class LESharedPtr
{
protected:
	T* m_pRep;
	unsigned int* m_pUseCount;

public:
	LE_AUTO_SHARED_MUTEX; // 公有访问权限允许外部锁定

	/** 默认构造函数，并没有初始化SharedPtr
	@remarks
	<b>危险!</b> 在你使用SharedPtr之前必须调用bind() .
	*/
	LESharedPtr() : m_pRep(0), m_pUseCount(0) {}

	explicit LESharedPtr(T* rep) : m_pRep(rep), m_pUseCount(new unsigned int(1)) 
	{
		LE_NEW_AUTO_SHARED_MUTEX
	}

	LESharedPtr(const LESharedPtr& r) 
	{
		// 锁定并拷贝其他mutex的指针
		LE_LOCK_MUTEX(*(r.LE_AUTO_MUTEX_NAME));
		LE_COPY_AUTO_SHARED_MUTEX(r.LE_AUTO_MUTEX_NAME);

		m_pRep = r.m_pRep;
		m_pUseCount = r.m_pUseCount; 

		if(m_pUseCount)
		{
			++(*m_pUseCount); 
		}
	}

	LESharedPtr& operator=(const LESharedPtr& r) {
		if (m_pRep == r.m_pRep)
			return *this;
		release();

		// 锁定并拷贝其他mutex的指针
		LE_LOCK_MUTEX(*(r.LE_AUTO_MUTEX_NAME));
		LE_COPY_AUTO_SHARED_MUTEX(r.LE_AUTO_MUTEX_NAME);

		m_pRep = r.m_pRep;
		m_pUseCount = r.m_pUseCount;
		if (m_pUseCount)
		{
			++(*m_pUseCount);
		}
		return *this;
	}

	virtual ~LESharedPtr() {
		release();
	}

	inline T& operator*() const { assert(m_pRep); return *m_pRep; }
	inline T* operator->() const { assert(m_pRep); return m_pRep; }
	inline T* get() const { return m_pRep; }

	/** 将指针绑定到SharedPtr上.
	@remarks
		这里假设SharedPtr并没有初始化!
	*/
	void bind(T* rep) {
		assert(!pRep && !pUseCount);
		LE_NEW_AUTO_SHARED_MUTEX;
		LE_LOCK_AUTO_SHARED_MUTEX;

		m_pUseCount = new unsigned int(1);
		m_pRep = rep;
	}

	inline bool unique() const { assert(m_pUseCount); LE_LOCK_AUTO_SHARED_MUTEX; return (*m_pUseCount) == 1; }
	inline unsigned int useCount() const { assert(m_pUseCount); LE_LOCK_AUTO_SHARED_MUTEX return *m_pUseCount; }
	inline unsigned int* useCountPointer() const { return m_pUseCount; }

	inline T* getPointer() const { return m_pRep; }

	inline bool isNull(void) const { return m_pRep == 0; }

	inline void setNull(void) { 
		if (m_pRep)
		{
			// 在内部析构，这里不锁定（双判断）
			release();
			m_pRep = 0;
			m_pUseCount = 0;
			LE_COPY_AUTO_SHARED_MUTEX(0)
		}
	}

protected:

	inline void release(void) 
	{
		bool destroyThis = false;
		{
			// 仅在有限的范围内锁定自己的mutex(在析构之前必须解锁)
			LE_LOCK_AUTO_SHARED_MUTEX;

			if (m_pUseCount)
			{
				if (--(*m_pUseCount) == 0) 
				{
					destroyThis = true;
				}
			}
			// 到这里自动解锁（查看boost帮助）
		}
		if (destroyThis)
			destroy();
	}

	virtual void destroy(void)
	{
		// 如果你在这遇到崩溃，你肯定在结束程序之前没有释放指针
		// 在结束程序之前使用setNull(),或确保你的指针在程序结束前超出它的范围（自动析构）
		delete m_pRep;
		delete m_pUseCount;
		LE_DELETE_AUTO_SHARED_MUTEX;
	}

};

template<class T, class U> inline bool operator==(LESharedPtr<T> const& a, LESharedPtr<U> const& b)
{
	return a.get() == b.get();
}

template<class T, class U> inline bool operator!=(LESharedPtr<T> const& a, LESharedPtr<U> const& b)
{
	return a.get() != b.get();
}

#endif
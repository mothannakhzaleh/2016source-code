#ifndef LEParticleAffectorFactory_H
#define LEParticleAffectorFactory_H

#include "LEEffPrerequisites.h"

class LIGHTENGINE_API LEParticleAffectorFactory
{
protected:
	std::vector<LEParticleAffector*> m_Affectors;
public:
	LEParticleAffectorFactory() {};
	virtual ~LEParticleAffectorFactory();
	/** 返回工厂的名字, 这个名字标识了这个工厂创建的粒子影响因子的类型 */
	virtual string getName() const = 0;

	/** 创建一个新的影响因子对象.*/
	virtual LEParticleAffector* createAffector(LEParticleSystem* psys) = 0;

	/** 析构影响因子对象. */
	virtual void destroyAffector(LEParticleAffector* e);
};
#endif
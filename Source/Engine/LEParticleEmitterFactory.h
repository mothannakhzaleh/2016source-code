#ifndef LEParticleEmitterFactory_H
#define LEParticleEmitterFactory_H

#include "LEEffPrerequisites.h"

class LIGHTENGINE_API LEParticleEmitterFactory
{
protected:
	std::vector<LEParticleEmitter*> m_Emitters;
public:
	LEParticleEmitterFactory() {};
	virtual ~LEParticleEmitterFactory();

	virtual string getName() const = 0;

	virtual LEParticleEmitter* createEmitter(LEParticleSystem* psys) = 0;

	virtual void destroyEmitter(LEParticleEmitter* e);
};
#endif
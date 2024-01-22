#ifndef LEScriptLoader_h
#define LEScriptLoader_h

#include "LEEffPrerequisites.h"

class LIGHTENGINE_API LEScriptLoader
{
public:
	virtual ~ScriptLoader();

	virtual const LEStringVector& getScriptPatterns(void) const = 0;

	virtual void parseScript(LEDataStreamPtr& stream, const string& groupName) = 0;

	virtual float getLoadingOrder(void) const  = 0;
};

#endif
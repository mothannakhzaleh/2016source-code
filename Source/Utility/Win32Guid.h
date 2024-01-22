#pragma once

#include <Rpc.h>
#include <string>

using namespace std;

class Win32Guid
{
public:
	Win32Guid(void);
	~Win32Guid(void);

	void Generate();

	string AsString() const;
private:
	UUID uuid;
};

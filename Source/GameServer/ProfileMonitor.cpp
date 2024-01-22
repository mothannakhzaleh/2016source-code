#include "ProfileMonitor.h"

namespace ProfileMonitor
{
	MonitorManager* MonitorManager::_instance = NULL;

	void MonitorManager::Init()
	{
		TotalTick_ = 0;

		char c = 'a';

		FunNumMap_.clear();
		FunSpanList_.clear();

		for(int i = 0; i < 100; i++)
		{
			std::ostrstream buf;
			buf << (char)(c + i);
			buf << std::ends;

			FunSpanList_.push_back(FunSpanListT::value_type(buf.str(), 0));
		}

		LARGE_INTEGER lv;
		QueryPerformanceFrequency(&lv);
		TicksPerSecond_ = lv.QuadPart;
	}

	void MonitorManager::Dump()
	{
		if(!GetEnable())
		{
			std::cout << "性能测试未开启" << std::endl;
			return;
		}

		Lock_.Lock();

		try
		{
			FILE* file;
			char fileName[256];

			SYSTEMTIME systime;
			GetLocalTime(&systime);
			_snprintf_s(fileName, sizeof(fileName), _TRUNCATE, "log\\PM_%u%02u%02u%02u%02u%02u.csv", systime.wYear,systime.wMonth, systime.wDay, systime.wHour, systime.wMinute, systime.wSecond);

			errno_t err = fopen_s(&file, fileName, "w+");

			if(err == 0)
			{
				fprintf_s(file, "本身耗时,%I64i,每秒时钟数,%I64i\n\n序号,位置,调用次数,总消耗(时钟)\n", TotalTick_, TicksPerSecond_);

				// 请按照花费时间 次数 调用 层次
				int i = 0;
				for(FunNumMapIt it = FunNumMap_.begin(); it != FunNumMap_.end(); it++, i++)
				{
					fprintf_s(file, "%d,\"%s\",%d,%I64i\n", (i + 1), it->first.c_str(), it->second.first, it->second.second);
				}

				fprintf_s(file, "\n\n序号,位置,最大消耗(时钟)\n");

				i = 0;
				for(FunSpanIt it = FunSpanList_.begin(); it != FunSpanList_.end(); it++)
				{
					if( it->second > 0.0)
					{
						fprintf_s(file, "%d,\"%s\",%I64i\n", (i + 1), it->first.c_str(), it->second);
						i ++;
					}
				}

				fclose(file);

				std::cout << "性能测试存盘结束" << std::endl;
			}
			else
			{
				std::cout << "性能测试失败" << std::endl;
			}
		}
		catch(...)
		{

		}

		Lock_.Unlock();
	}

}

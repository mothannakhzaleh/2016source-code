#pragma once
#include <windows.h>

// Standard library C-style
#include <wchar.h>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
#include <io.h>
#include <fcntl.h>

#ifndef CONSOLEUTILS_H
#define CONSOLEUTILS_H

#define ESC "\x1b["
#define PBSTR	"||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
#define PBWIDTH 60
#define DEFAULT_FONT_COLOR "36"


//https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
class ConsoleUtils
{
public:
  
  static DWORD StartupVirtualTerminal() {
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
	if(hOut == INVALID_HANDLE_VALUE)
	{
	  return GetLastError();
	}

	DWORD dwMode = 0;
	if(!GetConsoleMode(hOut, &dwMode))
	{
	  return GetLastError();
	}

	dwMode |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
	if(!SetConsoleMode(hOut, dwMode))
	{
	  return GetLastError();
	}
	return true;
  }


  inline static void SetFontColorOnce(int param, const char* str) {
	printf(ESC "%dm%s" ESC "m", param, str);
  }
  inline static void SetFontColor(int param)
  {
	printf(ESC "%dm", param);
  }
  inline static void ResetFontColor() {
	printf(ESC DEFAULT_FONT_COLOR"m");
  }

  static void printProgressBar(double percentage, const char* str = nullptr) {
	int val	 = (int)(percentage * 100);
	int lpad = (int)(percentage * PBWIDTH);
	int rpad = PBWIDTH - lpad;
	printf("\r%3d%% [%.*s%*s]", val, lpad, PBSTR, rpad, "");
	fflush(stdout);
  }
  
  static void printASCIIArt()
  {
	_setmode(_fileno(stdout), _O_U16TEXT);
	std::wcout << L"\
██╗░░░██╗░█████╗░████████╗░█████╗░██████╗░░██████╗    ██████╗░██████╗░░█████╗░░░░░░██╗███████╗░█████╗░████████╗\n\
╚██╗░██╔╝██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔════╝    ██╔══██╗██╔══██╗██╔══██╗░░░░░██║██╔════╝██╔══██╗╚══██╔══╝\n\
░╚████╔╝░███████║░░░██║░░░██║░░██║██████╔╝╚█████╗░    ██████╔╝██████╔╝██║░░██║░░░░░██║█████╗░░██║░░╚═╝░░░██║░░░\n\
░░╚██╔╝░░██╔══██║░░░██║░░░██║░░██║██╔═══╝░░╚═══██╗    ██╔═══╝░██╔══██╗██║░░██║██╗░░██║██╔══╝░░██║░░██╗░░░██║░░░\n\
░░░██║░░░██║░░██║░░░██║░░░╚█████╔╝██║░░░░░██████╔╝    ██║░░░░░██║░░██║╚█████╔╝╚█████╔╝███████╗╚█████╔╝░░░██║░░░\n\
░░░╚═╝░░░╚═╝░░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═════╝░    ╚═╝░░░░░╚═╝░░╚═╝░╚════╝░░╚════╝░╚══════╝░╚════╝░░░░╚═╝░░░\n";
	_setmode(_fileno(stdout), _O_U16TEXT);

	//Try with different font
	CONSOLE_FONT_INFOEX font  = {sizeof(font)};
	HANDLE				hcout = GetStdHandle(STD_OUTPUT_HANDLE);
	GetCurrentConsoleFontEx(hcout, FALSE, &font);
	wcscpy_s(font.FaceName, L"MS Gothic");
	SetCurrentConsoleFontEx(hcout, FALSE, &font);
	wcout << L"\
⠀⠀Mdr⠀⠀⠀⠀⠀⠀⠀⣀⠀⠤⠴⠶⡇⠀⠀⠀Snre3n⠀⠀⠀⠀\n\
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n\
⠀⠀⠀⠀⠀⠀⠀⠂⠉⡇⠀⠀⠀⢰⣿⣿⣿⣿⣧⠀⠀⢀⣄⣀⠀⠀⠀⠀⠀⠀\n\
⠀⠀⠀⠀⠀⠀⢠⣶⣶⣷⠀⠀⠀⠸⠟⠁⠀⡇⠀⠀⠀⠀⠀⢹⠀⠀⠀⠀⠀⠀\n\
⠀⠀⠀⠀⠀⠀⠘⠟⢹⣋⣀⡀⢀⣤⣶⣿⣿⣿⣿⣿⡿⠛⣠⣼⣿⡟⠀⠀⠀⠀\n\
⠀⠀⠀⠀⠀⣴⣾⣿⣿⣿⣿⢁⣾⣿⣿⣿⣿⣿⣿⡿⢁⣾⣿⣿⣿⠁⠀⠀⠀⠀\n\
⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⡇⢸⣿⣿⣿⠿⠇⠀⠀⠀⠀\n\
⠀⠀⠀⠳⣤⣙⠟⠛⢻⠿⣿⠸⣿⣿⣿⣿⣿⣿⣿⣇⠘⠉⠀⢸⠀⢀⣠⠀⠀⠀\n\
⠀⠀⠀⠀⠈⠻⣷⣦⣼⠀⠀⠀⢻⣿⣿⠿⢿⡿⠿⣿⡄⠀⠀⣼⣷⣿⣿⠀⠀⠀\n\
⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣶⣄⡈⠉⠀⠀⢸⡇⠀⠀⠉⠂⠀⣿⣿⣿⣧⠀⠀⠀\n\
⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣷⣤⣀⣸⣧⣠⣤⣴⣶⣾⣿⣿⣿⡿⠀⠀⠀\n\
⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀\n\
⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠉⠀⠀⠀⠀\n\
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n\
							  \n";

	_setmode(_fileno(stdout), _O_TEXT);
	cout << "\"Not all treasure's silver and gold, mate.\" \n\t\t-Captain Jack Sparrow" << endl;
	cout << endl;
  }
  
  static COORD GetConsoleCursorPosition()
  {
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);

	CONSOLE_SCREEN_BUFFER_INFO cbsi;
	if(GetConsoleScreenBufferInfo(hOut, &cbsi))
	{
	  return cbsi.dwCursorPosition;
	} else
	{
	  // The function failed. Call GetLastError() for details.
	  COORD invalid = {0, 0};
	  return invalid;
	}
  }

  static void UpdatePreviousLine(const char* str, int n = 1) {
	HANDLE hOut = GetStdHandle(STD_OUTPUT_HANDLE);
	COORD old_pos = GetConsoleCursorPosition();
	COORD  new_pos;
	new_pos.Y = old_pos.Y - n;
	new_pos.X = 0;
	SetConsoleCursorPosition(hOut, new_pos);
	printf(ESC "2K");
	printf(str);
	SetConsoleCursorPosition(hOut, old_pos);
  }
};

#endif
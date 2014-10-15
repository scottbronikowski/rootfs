// NMEAParser.h: interface for the NMEAParser class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_NMEAPARSER_H__26C0F55B_19A8_4E71_A1BA_A2EBA169FCEB__INCLUDED_)
#define AFX_NMEAPARSER_H__26C0F55B_19A8_4E71_A1BA_A2EBA169FCEB__INCLUDED_

#include "mGPSInfo.h"	// Added by ClassView
#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>

class NMEAParser
{
public:
	NMEAParser();
	//NMEAParser(LPCTSTR outputFileName);
	virtual ~NMEAParser();
	void Parse(const char *buf, const unsigned int bufSize);
	GPSInfo& GetActualGPSInfo();

private:
	//CFile m_outputFile;

	void ParseRecursive(const char ch);
	void ParseNMEASentence(const char *addressField,
		                   const char *buf, const unsigned int bufSize);
	void ProcessGPGGA(const char *buf, const unsigned int bufSize);
	void ProcessGPGSA(const char *buf, const unsigned int bufSize);
	void ProcessGPGSV(const char *buf, const unsigned int bufSize);
	void ProcessGPRMB(const char *buf, const unsigned int bufSize);
	void ProcessGPRMC(const char *buf, const unsigned int bufSize);
	void ProcessGPZDA(const char *buf, const unsigned int bufSize);

	bool m_logging;
	GPSInfo m_GPSInfo;
};

#endif // !defined(AFX_NMEAPARSER_H__26C0F55B_19A8_4E71_A1BA_A2EBA169FCEB__INCLUDED_)

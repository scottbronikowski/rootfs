// GPSInfo.cpp: implementation of the GPSInfo class.
//
//////////////////////////////////////////////////////////////////////

//#include "stdafx.h"
#include "mGPSInfo.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

GPSInfo::GPSInfo():
m_latitude(0),
m_longitude(0),
m_altitude(0),
m_nSentences(0),
m_signalQuality(0),
m_satelitesInUse(0),
m_fixQuality(0),
m_HDOP(0),
m_hour(0),
m_minute(0),
m_second(0),
m_trackValid(true),
m_courseOverGround(0),
m_day(0),
m_month(0),
m_year(0),
m_magneticVariation(0),
m_groundSpeed(0)

{
}

GPSInfo::~GPSInfo()
{}

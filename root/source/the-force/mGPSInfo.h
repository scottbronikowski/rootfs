// GPSInfo.h: interface for the GPSInfo class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_GPSINFO_H__2040A232_786E_4C7B_8EA5_0A9438ED6C1F__INCLUDED_)
#define AFX_GPSINFO_H__2040A232_786E_4C7B_8EA5_0A9438ED6C1F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef FALSE
#define FALSE 0
#define TRUE 1
#endif

struct GPSInfo
{
public:
  double m_latitude;
  double m_longitude;
  double m_altitude;
  unsigned long m_nSentences;
  unsigned int m_signalQuality;
  unsigned int m_satelitesInUse;
  unsigned int m_fixQuality;
  double m_HDOP;
  unsigned int m_hour;
  unsigned int m_minute;
  unsigned int m_second;
  bool m_trackValid;
  double m_courseOverGround;
  unsigned int m_day;
  unsigned int m_month;
  unsigned int m_year;
  double m_magneticVariation;
  double m_groundSpeed;

	GPSInfo();
	virtual ~GPSInfo();
};

#endif // !defined(AFX_GPSINFO_H__2040A232_786E_4C7B_8EA5_0A9438ED6C1F__INCLUDED_)

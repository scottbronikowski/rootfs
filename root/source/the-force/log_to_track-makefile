code: control_system.c Dstar.cpp kalmaninit.c simple.cpp mGPSInfo.cpp mNMEAParser.cpp
	g++ `pkg-config --cflags --libs opencv` `pkg-config --cflags opencv` control_system.c Dstar.cpp simple.cpp mGPSInfo.cpp mNMEAParser.cpp -o ATV.out


log-to-track: log_to_track.cpp 
	g++ `pkg-config --cflags --libs opencv` `pkg-config --cflags opencv`log_to_track.cpp -o log-to-track.out
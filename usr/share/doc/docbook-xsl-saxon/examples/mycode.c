#ifndef _My_Parser_h_
#define _My_Parser_h_
#include "MyFetch.h"
class My_Parser
{
public:
        //
        // Construction/Destruction
        //
        My_Parser();
        virtual      ~My_Parser() = 0;
        virtual int  parse(MyFetch &amp;fetcher) = 0;
};
#endif

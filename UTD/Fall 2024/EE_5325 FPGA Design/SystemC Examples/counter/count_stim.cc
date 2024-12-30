//Example: Stimulus Generator(.cc)

//count_stim.cc
#include "count_stim.h"

//use the scoping operator to tie the stimgen to count_stim  modules
void count_stim::stimgen()	{
	while ( true )	{
		load = true;	//load 0
		din  = 0; 
		wait();			// count up, value = 1
		load = false;
		wait();			//count up, value = 2
		if ( dout != 2 )	{
			printf( "counter failed at value 2" );
		}
		wait();			//count up, value = 3
		if ( dout != 3 )	{
			printf( "counter failed at value 2" );
		}
		wait();			//count up, value = 4
		if ( dout != 4 )	{
			printf( "counter failed at value 2" );
		}
		wait();			//count up, value = 5
		if ( dout != 5 )	{
			printf( "counter failed at value 2" );
		}
		wait();			//count up, value = 6
		if ( dout != 6 )	{
			printf( "counter failed at value 2" );
		}
		wait();			//count up, value = 7
		if ( dout != 7 )	{
			printf( "counter failed at value 2" );
		}
	}
};
//count_up.cc

#include "count.h"			//include the main or top module for the design

//using scoping operator :: to tie the current module to the main module
void count::count_up()	{
	if ( load )	{
		count_val = din;
	}	else{
			count_val = count_val + 1;		//could also write count_val++
	}
	dout = count_val;
}
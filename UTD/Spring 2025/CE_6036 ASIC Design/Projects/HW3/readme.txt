
this prrogram consist of 3 vector arrays. data_in, MSDAP_Coeff, Rj
the Rj file determines the number of terms at filter stage
there are 16 Rj stages 0<j<15

MSDAP_Coeff consist of 9 bits with the MSB used as the sign bit and the rest of the 8 bits will be in part of n to determine the memory location of the x(n) to be filtered
the HEX value on the Rj will determine the how many coeff will used at that stage. eg R0(0B) will used the first 11 MSDAP_Coeff samples for the u0.

Computation:
First resutl is initialize to 0
after the Data_in sample is determined by using the y(n) needed the follwing is determined
the x(n) is padding to 24bits
the 2s complement is determined by using taking negative of x(n)

the MSB of the MSDAP_Coeff is either 0 or 1
if 1 then the 2s complement of data_in is used to result and then new result is shift to the right by 1 bit 
else data_in is added to results and then new result is shift to the right by 1 bit 

Result is accomulated across each MSDAP_Coeff until the last MSDAP_Coeff of R15 where j=15.
the final result the is store in HEX and compared to a know result to ensure the logic used in the code is right.
 
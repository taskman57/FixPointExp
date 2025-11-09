#ifndef ALTITUDE_H_INCLUDED
#define ALTITUDE_H_INCLUDED
#include "ap_int.h"
#include "ap_fixed.h"

typedef ap_uint<7>			uint_7;
typedef ap_uint<10>			uint_10;

typedef ap_fixed<17,9>		const_c;
typedef ap_fixed<17,2>		const_b;
typedef ap_fixed<17,1>		const_a;

typedef ap_fixed<17,5>		var_inp;
typedef ap_fixed<34,10>		inp_sqr;
typedef ap_fixed<17,9>		var_res1;
typedef ap_fixed<30,17>		big_mul;

//	types used to store intermediate results!
typedef	ap_fixed<51,11>		var_poly2;
typedef	ap_fixed<34,7>		var_poly1;

const const_a coeff_a = -0.0088043212890625;
const const_b coeff_b = 1.76727294921875;
const const_c coeff_c = 131.2890625;

void to_fix(float x_inp, var_inp *fix_result);
void altitude(var_inp x_inp, var_res *altitude);

#endif // ALTITUDE_H_INCLUDED

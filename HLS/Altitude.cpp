#include <string>
#include <iostream>
#include <iomanip>
#include "Altitude.h"
using namespace std;

void altitude(var_inp x_inp, var_res *alt_out){
	inp_sqr squre;
	var_poly2 cx2;
	var_poly1 bx;
	squre = x_inp * x_inp;
	cx2 = (var_poly2)coeff_a * (var_poly2)squre;
	bx = ((var_poly1)coeff_b * (var_poly1)x_inp);
	*alt_out = (var_res)cx2 + (var_res)bx + coeff_c;
}

#ifndef __SYNTHESIS__
void to_fix(float x_inp, var_inp *fix_result){
	big_mul div;
	float temp = floor(x_inp*4096);
	var_inp conv_type;
	div = ((big_mul)temp/((big_mul)4096));
	conv_type = (var_inp)div;
	*fix_result = conv_type;
}
#endif
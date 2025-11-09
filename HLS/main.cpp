#include <fstream>
#include <string>
#include <iostream>
using namespace std;
#include "Altitude.h"

int main(){
	int i;
	float sing = 0.0f;
	var_inp inp_x;
	var_res alt;
	cout.precision(23);
	for(i=0;i<=100;i++){
		to_fix(sing, &inp_x);
		altitude(inp_x, &alt);
		cout << " Altitude is: " << alt << endl;
		sing +=0.1f;
	}
}

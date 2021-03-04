

#include "Lung.h"
#include "Roi.h"
#include <fstream>
#include <iostream>
#include <string>
using namespace std;

int main() {
	
	CLung test;
	int outf = test.treshold(80);
	test.tracertLess(1,75);
	test.getNodesSimple();
	return 0;
}

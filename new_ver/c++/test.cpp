#include "mex.h" 
#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <cstdint>
#include "Matrix.h"
#include "Lung.h"




void mexFunction(int nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[]) 
{
    const mwSize *b;
    double *num,*xout,*yout,*zout,*nout;
    double *tres,*G;
    
    mwSize a = mxGetNumberOfDimensions(prhs[0]);
    b = mxGetDimensions(prhs[0]);
    num = mxGetPr(prhs[0]);
    tres = mxGetPr(prhs[1]);
    G = mxGetPr(prhs[2]);
    
    
    
    
    if ((nrhs != 3)|| (a != 3) || nlhs !=4)
    {
        mexPrintf("Nothing to do :(!%d,%d\n",nlhs,nrhs); 
        return;
        
    }
    mexPrintf("Treshold =  %f, Gred = %f\n",tres[0],G[0]); 
    
    CLung test(num,b[0],b[1],b[2]);
    test.treshold(int(tres[0]));
    test.tracertLess(1,int(G[0]));
    test.getNodesSimple();
    
    mexPrintf("Size %d\n",test.xout.size());
    plhs[0] =   mxCreateDoubleMatrix(test.xout.size(), 1, mxREAL);
    plhs[1] =   mxCreateDoubleMatrix(test.yout.size(), 1, mxREAL);
    plhs[2] =   mxCreateDoubleMatrix(test.zout.size(), 1, mxREAL);
    plhs[3] =   mxCreateDoubleMatrix(test.nout.size(), 1, mxREAL);
    
    
    
    
    xout = mxGetPr(plhs[0]);
    yout = mxGetPr(plhs[1]);
    zout = mxGetPr(plhs[2]);
    nout = mxGetPr(plhs[3]);
    
    
    
    for( int  i = 0; i<test.xout.size(); i++)
    {
        
        xout[i] = double(test.xout[i]);
        yout[i] = double(test.yout[i]);
        zout[i] = double(test.zout[i]);
        nout[i] = double(test.nout[i]);
        
    } 
    
 mexPrintf("Done\n");   
return;
}
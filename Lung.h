#include "Matrix.h"
#include <vector>
#pragma once
using namespace std;
class CLung
{
public:
	CLung(double *tes,int xs,int ys,int zs);
	~CLung(void);
	int tracertLess(int kl,int Gis);
	int treshold(int tres);
	int number;
	int getNodesSimple();
	CMatrix <unsigned short int> * mat;
	CMatrix <int >* tur;
	CMatrix <unsigned short int> * settur;
    vector <int> xout;
	vector <int> yout;
	vector <int> zout;
    vector <int> nout;
	
private:
	vector <int> numv;
	
	vector <int> xmaxv;
	vector <int> xminv;
	vector <int> ymaxv;
	vector <int> yminv;
	vector <int> zmaxv;
	vector <int> zminv;
	vector <int> nkv;
    


};
CLung::CLung(double *num,int xs,int ys,int zs)
{
	
	number =0;
	
    mat =  new CMatrix<unsigned short int> (xs,ys,zs);
    tur =  new CMatrix<int> (mat->xsize,mat->ysize,mat->zsize);
	settur = new  CMatrix <unsigned short int> (mat->xsize,mat->ysize,mat->zsize);
    
	 for(int x = 0;x<mat->xsize;x++)
    {
        for(int y = 0;y<mat->ysize;y++)
        {
            for(int z = 0;z<mat->zsize;z++)
            {
                // mexPrintf("%d \n",int(num[z*mat->xsize*mat->ysize+y*mat->xsize+x]));
                mat->set(x,y,z,int(num[z*mat->xsize*mat->ysize+y*mat->xsize+x]));
                
            }
        }
       
    }
	
	
}


CLung::~CLung(void)
{
	delete mat;
	delete tur;
	delete settur;
	
}

int CLung::getNodesSimple()
{
	int numb = 1;
	
	for (int i=0;i<nkv.size();i++)
	{
		
		if((numv[i]>200)&&((zmaxv[i] -zminv[i])>=3))
		{
			
			for(int x = xminv[i]; x<=xmaxv[i]; x++)
			{
				for(int  y = yminv[i]; y<=ymaxv[i]; y++)
				{
					for(int z = zminv[i]; z<=zmaxv[i]; z++)
					{
						if(tur->get(x,y,z) == nkv[i]) 
						{
							xout.push_back(x);
                            yout.push_back(y);
                            zout.push_back(z);
                            nout.push_back(numb);
                            
							
						}
					
					
					}
				}
			}
			
			numb++;
            xout.push_back(-1);
            yout.push_back(-1);
            zout.push_back(-1);
            nout.push_back(-1);
            mexPrintf("I current = %d \n",i);

		}
		
	}

	

return 1;
}


int CLung::tracertLess(int kl,int Gis)
{
	
	int nk = 0;int number =0;
	int fear;
	int xk,yk,zk;
	for(int x = 1; x<mat->xsize-1; x++)
	{
		for(int  y = 1; y<mat->ysize-1; y++)
		{
			for(int z = 0; z<mat->zsize-1; z++)
			{
				if((mat->get(x,y,z)>0)&&(tur->get(x,y,z)==0))
				{
					
					nk++;
					vector <int> stx;
					vector <int> sty;
					vector <int> stz;
					
					stx.push_back(x);
					sty.push_back(y);
					stz.push_back(z);
					int xmax = x,xmin = x;
					int ymax = y,ymin = y;
					int zmax = z,zmin = z;
					double G ;//<---


					while((stz.size()!=0))
					{
						tur->set(stx[0],sty[0],stz[0],nk);
						int curx=stx[0],cury=sty[0],curz=stz[0];

						number++;
						stx.erase(stx.begin());
						sty.erase(sty.begin());
						stz.erase(stz.begin());


						if((curx>1)&&(cury>1)&&(curz>0)&&(curx<mat->xsize-1)&&(cury<mat->ysize-1)&&(curz<mat->zsize-1))
						{
							

							for( zk = curz;zk<=curz+1;zk++)
							{
								for( yk = cury-1; yk<=cury+1; yk++)
								{
									for( xk = curx-1; xk<=curx+1; xk++)
									{
										
										fear = abs(mat->get(curx,cury,curz) - mat->get(xk,yk,zk));
										G = Gis;//<-
										if(zk!=curz) G=G*1.4;
										if((xk!=curx)&&(yk!=cury)) G=G*1.4;
										int ksp = int (zk!=curz) + int (xk!=curx) + int (yk!=cury);
										
										
										
										//if((mat->get(xk,yk,zk)>0)&&(tur->get(xk,yk,zk)==0)&&settur->get(xk,yk,zk)==0)
										
										if((fear<G)&&(tur->get(xk,yk,zk)==0)&&(settur->get(xk,yk,zk)==0)&&(mat->get(xk,yk,zk)>0)&&(ksp<=1))
										{
											
											stx.push_back(xk);
											sty.push_back(yk);
											stz.push_back(zk);
											settur->set(xk,yk,zk,1);
											if( xmax<xk) xmax = xk;
											if( xmin>xk) xmin = xk;
											if( ymax<yk) ymax = yk;
											if( ymin>yk) ymin = yk;
											if( zmax<zk) zmax = zk;
											if( zmin>zk) zmin = zk;





										}
									}
								}
							}


						}		
					}
					xmaxv.push_back(xmax);
					xminv.push_back(xmin);
					ymaxv.push_back(ymax);
					yminv.push_back(ymin);
					zmaxv.push_back(zmax);
					zminv.push_back(zmin);
					nkv.push_back(nk);
					numv.push_back(number);
					if (number>20) mexPrintf("Length = %d, x = %d, number = %d \n",nk,x,number);
                    number = 0;
				}
				
				
				
				
			}
		}
	}
	return 0;

}
int CLung::treshold(int tresh)
{
	return mat->tres(tresh);

}



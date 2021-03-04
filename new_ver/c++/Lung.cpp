#include "Lung.h"
#include "Roi.h"
#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <cstdint>
#include "Matrix.h"



CLung::CLung( CMatrix<int> *tet)
{
	
	number =0;

	mat = tet;
	tur =  new CMatrix<int> (mat->xsize,mat->ysize,mat->zsize);
	settur = new  CMatrix <unsigned short int> (mat->xsize,mat->ysize,mat->zsize);


	

	for(int x = 0;x<mat->xsize;x++)
	{
		for(int  y = 0; y<mat->ysize; y++)
		{
			for(int z = 0; z<mat->zsize; z++)
			{
				int16_t buf;
				fread( &buf, sizeof(int16_t), 1, fil1);
				mat->set(x,y,z,int(buf));
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
	ofstream myfile ("param.csv");
	for (int i=0;i<nkv.size();i++)
	{
		
		if((numv[i]>200)&&((zmaxv[i] -zminv[i])>=3))
		{
			string pi = "commet" + std::to_string(numb);
			ofstream nodfile (pi.c_str());
			for(int x = xminv[i]; x<=xmaxv[i]; x++)
			{
				for(int  y = yminv[i]; y<=ymaxv[i]; y++)
				{
					for(int z = zminv[i]; z<=zmaxv[i]; z++)
					{
						if(tur->get(x,y,z) == nkv[i]) 
						{
						//	out->set(x,y,z,numb);
							nodfile<<x<<","<<y<<","<<z<<endl;
							
						}
					
					
					}
				}
			}
			nodfile.close();
			myfile<<numb<<","<<xminv[i]<<","<<xmaxv[i]<<","<<yminv[i]<<","<<ymaxv[i]<<","<<zminv[i]<<","<<zmaxv[i]<<","<<numv[i]<<','<<0<<endl;
			numb++;

		}
		std::cout<<"set "<<i<<"day at"<<endl;
	}

	 myfile.close();

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
										
										if((fear<G)&&(tur->get(xk,yk,zk)==0)&&(settur->get(xk,yk,zk)==0)&&(mat->get(xk,yk,zk)>0)&&(ksp<=kl))
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
					std::cout<<"set "<<nk<<"day at"<<x<<" number  = "<<number<<endl;
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



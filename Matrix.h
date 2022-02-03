#pragma once

template <class T>
class CMatrix
{
public:
	CMatrix(int xsize,int ysize, int zsize);
	~CMatrix(void);
	int xsize;
	int ysize; 
	int zsize;
	int max;
	int set(int x,int y,int z,int dat);
	int get(int x,int y,int z);
	int setmax();
	int getvol(int k);
	int tres(int k);

	

private:
	T *mat;

};
template <class T>
CMatrix<T>::CMatrix(int xsize,int ysize, int zsize):xsize(xsize),ysize(ysize),zsize(zsize)
{
	mat = new T[xsize*ysize*zsize];
	for(int x=0;x<xsize;x++)
	{
		for(int y = 0;y < ysize; y++)
		{
			for(int z = 0;z < zsize; z++)
			{
				mat[z*xsize*ysize+y*xsize+x] = 0;		
			}
		}
	}
	max = 0;
}

template <class T>
CMatrix<T>::~CMatrix(void)
{
	delete mat;
}
template <class T>
int CMatrix<T>::set(int x,int y,int z,int dat)
{
	if((x<xsize)&&(y<ysize)&&(z<zsize)) 
	{
		mat[z*xsize*ysize+y*xsize+x] = T(dat);
		return 1;
	}
	else return 0;
}template <class T>
int CMatrix<T>::get(int x,int y,int z)
{
	if((x<xsize)&&(y<ysize)&&(z<zsize)) 
	{
		return int(mat[z*xsize*ysize+y*xsize+x]);
	}
	else return 0;
}
template <class T>
int CMatrix<T>::setmax()
{
	max = 0;
	for(int x=0;x<xsize;x++)
	{
		for(int y = 0;y < ysize; y++)
		{
			for(int z = 0;z < zsize; z++)
			{
				if (mat[z*xsize*ysize+y*xsize+x]>max)	
				{
					max = int(mat[z*xsize*ysize+y*xsize+x]);
				}	
			}
		}
	}
	return max;

}
template <class T>
int CMatrix<T>::getvol(int k)
{
	int num = 0;
	for(int x=0;x<xsize;x++)
	{
		for(int y = 0;y < ysize; y++)
		{
			for(int z = 0;z < zsize; z++)
			{
				if (int(mat[z*xsize*ysize+y*xsize+x])==k)	
				{
					num++;
				}	
			}
		}
	}
	return num;

}
template <class T>
int CMatrix<T>::tres(int k)
{
	int num=0;
	for(int x=0;x<xsize;x++)
	{
		for(int y = 0;y < ysize; y++)
		{
			for(int z = 0;z < zsize; z++)
			{
				if (int(mat[z*xsize*ysize+y*xsize+x])<k)
				{
					mat[z*xsize*ysize+y*xsize+x]=0;
					num++;
				}
			}
		}
	}
	return num;

}

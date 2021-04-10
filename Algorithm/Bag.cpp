// Bag.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include <iostream>
using namespace std;

void print(int **maxValue, int n, int c)
{
	for (int k = 1; k <= n; k++)
	{
		for (int l = 1; l <= c; l++)
		{
			printf("%3d", maxValue[k][l]);
		}
		cout << endl;
	}
	cout << endl;
}

int DPBag(int weight[],int value[],int c,int n)
{

	// 利用二重指针构造动态网格:n行c列, 方便后续操作额外构造一格
	int **maxValue = new int*[n + 1];
	for (int i = 0; i <= n; i++)
	{
		maxValue[i] = new int[c + 1];
	}
	// 初始化网格值为0
	for (int i = 0; i <= n; i++)
	{
		for (int j = 0; j <= c; j++)
		{
			maxValue[i][j] = 0;
		}
	}
	// 填充网格
	for (int i = 1; i <= n; i++) {
		for (int j = 1; j <= c; j++) {

			int topValue = maxValue[i - 1][j];  // 上一个网格的值
			int thisValue = (weight[i] <= j ?       // 当前商品的价值 + 剩余空间的价值
				(j - weight[i] > 0 ? value[i] + maxValue[i - 1][j - weight[i]] : value[i])
				: topValue);
			// 返回 topValue和thisValue中较大的一个
			maxValue[i][j] = (topValue > thisValue ? topValue : thisValue);

			// 打印矩阵
			print(maxValue, n, c);

		}   // end inner for
	}   // end outer for

	int max = maxValue[n][c];
	
	// 释放内存
	for (int i = 0; i <= n; i++)
	{
		delete[]maxValue[i];
	}
	delete[]maxValue;

	return max;
}


int main()
{
	int value[] = { 0, 6, 3, 5, 4, 6 };
	int weight[] = { 0, 2, 2, 6, 5, 4 };
	int c = 10;
	int n = 5;
	int temp = DPBag(weight, value, c, n);
	cout << "最大价值为：" << temp;

}

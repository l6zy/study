// IPValidity.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include <iostream>
#define MAX 12
using namespace std;

int str2int(char ip[], int start, int end)
{
	int digit, sum = 0;
	for (int i = start; i <= end; i++)
	{
		digit = ip[i] - '0';
		sum = sum * 10 + digit;
	}
	return sum;
}

int IsIP(char ip[], int start, int end)
{
	int temp = str2int(ip, start, end);
	if (temp > 255 || (start != end && ip[start] == '0'))
	{
		return 0;
	}
	else {
		return 1;
	}
}

//穷举
int QJIP(char ip[],int n)
{
	int count = 0;
	for (int i = 1; i <= 3; i++)
	{
		if (i > n || !IsIP(ip, 0, i - 1))
			break;
		for (int j = 1; j <= 3; j++)
		{
			if (i + j > n || !IsIP(ip, i, i + j - 1))
				break;
			for (int k = 1; k <= 3; k++)
			{
				if (i + j + k > n || !IsIP(ip, i + j, i + j + k - 1))
					break;
				for (int l = 1; l <= 3; l++)
				{
					if (i + j + k + l == n && IsIP(ip,i + j + k,i + j + k + l - 1))
					{
						count++;
						cout <<str2int(ip, 0, i - 1) << "." << str2int(ip, i, i + j - 1) << "." << str2int(ip, i + j, i + j + k - 1) << "." << str2int(ip, i + j + k, n - 1) << endl;
					}
				}
			}
		}
	}
	return count;
}

//动态规划
int DPIP(char ip[], int n)
{
	int sum[12][4] = {};
	for (int i = 0; i < 4; i++)
	{
		sum[i][i] = 1;
	}
	if (ip[0] != '0')
	{
		sum[1][0] = 1;
		if (IsIP(ip, 0, 2))
			sum[2][0] = 1;
	}
	for (int i = 2; i < n; i++)
	{
		for (int j = 1; j < 4; j++)
		{
			if (i > j)
			{
				if (i - 1 >= 0)
				{
					sum[i][j] += sum[i - 1][j - 1];
					if (i - 2 >= 0 && IsIP(ip,i - 1,i))
					{
						sum[i][j] += sum[i - 2][j - 1];
						if (i - 3 >= 0 && IsIP(ip,i - 2,i))
						{
							sum[i][j] += sum[i - 3][j - 1];
						}
					}
				}
			}
		}
	}
	return sum[n - 1][3];
}

int main()
{
	char ip[MAX];
	cout << "请输入字符串：";
	cin >> ip;
	int n = strlen(ip);
	cout << "----------------------" << endl;
	int all = QJIP(ip, n);
	cout << "----------------------" << endl;
	cout << "穷  举  法：" << all << " 种情况" << endl;
	cout << "动态规划法：" << DPIP(ip,n) << " 种情况";
}

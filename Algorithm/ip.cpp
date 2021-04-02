#include <iostream>
#include <string>
#include <sstream>
using namespace std;

//存放字符串中的数字
int number[12];
//存放合法IP个数
int sum[12][4] = {};

int IP(int n)
{
	if (n < 4 || n > 12)
		return 0;

	//初始化
	sum[0][0] = 1;
	sum[1][1] = 1;
	sum[2][2] = 1;
	sum[3][3] = 1;
	if (number[0] != 0)
	{
		sum[1][0] = 1;
		if (number[0] * 100 + number[1] * 10 + number[2] <= 255)
			sum[2][0] = 1;
	}

	//sum[i][j] = sum[i-1][j-1] + sum[i-2][j-1] + sum[i-3][j-1]
	for (int i = 0; i < n; i++)
	{
		for (int j = 1; j < 4; j++)
		{
			if (i > j)
				if (i - 1 >= 0)
				{
					sum[i][j] += sum[i - 1][j - 1];

					if (i - 2 >= 0)
					{
						if (number[i - 1] != 0)
							sum[i][j] += sum[i - 2][j - 1];

						if (i - 3 >= 0)
						{
							int count = 0;
							for (int z = i - 2; z <= i; z++)
								count = count * 10 + number[z];

							if (number[i - 2] != 0 && count <= 255)
								sum[i][j] += sum[i - 3][j - 1];
						}
					}
				}

		}
	}
	return sum[n - 1][3];
}

int main()
{
	string str;
	cout << "请输入字符串:";
	cin >> str;

	int temp = 0;
	for (int j = 0; j < str.length(); j++)
	{
		stringstream is;
		is << str[j];
		is >> number[j];
		temp++;
	}

	cout << "合法IP地址总数:" << IP(temp) << endl;
	return 0;
}
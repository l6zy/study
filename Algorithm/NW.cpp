// NW.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include <iostream>
using namespace std;

int n;  // 记录字符串长度
int* a; // 记录字符串对应的数字数组
char w[] = "abcdefghijklmnopqrstuvwxyz";
char b[10];
int sum = 0;// 可能的结果数

int *str2int(char c[])
{
    int n = strlen(c);
    int* a = new int[n];
    for (int i = 0; i < n; i++)
    {
        a[i] = c[i] - '0';
    }
    return a;
}

void Backtrack(int p)
{
    if (p != n && a[p] < 2)
    {
        cout << "不能出现 1 或 0";
        return;
    }
    int index = (a[p] != 9 && a[p] != 7) ? 3 : 4;   // 如果数字是 7 或 9, 则在T9输入法会有四个字母, 需要判断一下
    if (p == n)
    {
        sum++;
        cout << b <<"\n";
    }else 
        for (int i = 0; i < index; i++)
        {
            int t = a[p] <= 7 ? t = 3 * (a[p] - 2) : t = 3 * (a[p] - 3) + 4;
            b[p] = w[t + i];
            Backtrack(p + 1);
        }
}

int main()
{
    char c[] = "29768";
    n = strlen(c);
    a = str2int(c);
    Backtrack(0);
    cout << "------------------\n";
    cout << "共有 " << sum << " 种结果";
}

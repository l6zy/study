#include <iostream>
using namespace std;

int GetPossibleIp(int a[], int total)
{
    //记录每一段位数
    int n[4] = {1, 1, 1, 1};
    int count = 0;
    for (int i = 1; i < 4; i++)
    {
        n[0] = i;
        for (int j = 1; j < 4; j++)
        {
            n[1] = j;
            for (int k = 1; k < 4; k++)
            {
                n[2] = k;
                for (int l = 1; l < 4; l++)
                {
                    n[3] = l;
                    if (i + j + k + l == total)
                    {
                        //判断是否首位数字为0
                        if ((a[0] == 0 && i > 1) || (a[i] == 0 && j > 1) || (a[i + j] == 0 && k > 1) || (a[i + j + k] == 0 && l > 1))
                        {
                            continue;
                        }

                        //判断每一段是否超过255
                        if (n[0] == 3)
                        {
                            if (a[0] * 100 + a[1] * 10 + a[2] > 255)
                            {
                                continue;
                            }
                        }

                        if (n[1] == 3)
                        {
                            if (a[0 + i] * 100 + a[1 + i] * 10 + a[2 + i] > 255)
                            {
                                continue;
                            }
                        }

                        if (n[2] == 3)
                        {
                            if (a[0 + i + j] * 100 + a[1 + i + j] * 10 + a[2 + i + j] > 255)
                            {
                                continue;
                            }
                        }

                        if (n[3] == 3)
                        {
                            if (a[0 + i + j + k] * 100 + a[1 + i + j + k] * 10 + a[2 + i + j + k] > 255)
                            {
                                continue;
                            }
                        }

                        //输出合法IP
                        int b = 0;
                        while (b != total)
                        {
                            cout << a[b];
                            b++;
                            if (b == n[0] || b == n[0] + n[1] || b == n[0] + n[1] + n[2])
                            {
                                cout << ".";
                            }
                        }
                        cout << "\n";

                        count++;
                    }
                    else
                    {
                        continue;
                    }
                }
            }
        }
    }
    return count;
}

int main()
{
    int a[12];
    int i = 0;
    cin >> a[i];
    i++;
    do
    {
        cin >> a[i];
        i++;
    } while (getchar() != '\n');
    cout << "---------------------------" << endl;
    cout << GetPossibleIp(a, i) << " 种可能";
}
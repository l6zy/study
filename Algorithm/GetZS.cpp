#include <iostream>
#include <fstream>
using namespace std;

int count, midNum = 0, N;

void getIndex(int a[], int i, int j)
{
    if (i == j)
    {
        return;
    }

    int m, n, mid, mNum;
    mid = (i + j) / 2;
    m = mid, n = mid;

    while (a[n + 1] == a[n])
    {
        n = n + 1;
    }
    while (a[m - 1] == a[m])
    {
        m = m - 1;
    }

    mNum = n - m + 1;
    // cout << mNum;
    if (mNum > count)
    {
        count = mNum;
        midNum = a[mid];
    }

    if (j + 1 - (m + mNum) > count)
    {
        getIndex(a, n, j);
    }

    if (m > count)
    {
        getIndex(a, i, m);
    }
}

void quickSort(int a[], int left, int right)
{
    if (left >= right)
    {
        return;
    }
    int base = a[left];

    int i = left;
    int j = right;
    int temp;

    while (i != j)
    {

        while (a[j] >= base && i < j)
        {
            j--;
        }
        while (a[i] <= base && i < j)
        {
            i++;
        }

        temp = a[i];
        a[i] = a[j];
        a[j] = temp;
    }

    a[left] = a[i];
    a[i] = base;

    quickSort(a, left, i - 1);

    quickSort(a, j + 1, right);
}

int main()
{
    ifstream ifile("input.txt");
    ofstream ofile("output.txt");

    int n = 0;
    int a[10000], index;

    ifile >> n;
    N = n;

    for (int i = 0; i < n; i++)
    {
        ifile >> a[i];
    }

    quickSort(a, 0, n - 1);

    //Display a[N]
    for (int i = 0; i < n; i++)
    {
        cout << a[i] << " ";
    }
    cout << endl;

    getIndex(a, 0, n - 1);

    cout << "众数：" << midNum << "  重数：" << count;
    ofile << midNum << "\n"
          << count;

    ifile.close();
    ofile.close();
}

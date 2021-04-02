// test.cpp : Defines the entry point for the console application.
//

#include <time.h>
#include <iostream>
using namespace std;
void BubbleSort(int a[], int n);
void QuickSort(int *arr, int begin, int end);
void sort(int arr[], int left, int right, int temp[]);
void merge(int arr[], int left, int mid, int right, int temp[]);

int main()
{
	int a[50000];
	int n = 50000;
	int b[50000];
	for (int i = 0; i < n; i++)
		a[i] = rand();
	clock_t start = clock();

	//BubbleSort(a,n);
	//QuickSort(a, 0, n - 1);
	sort(a,0,n-1,b);

	clock_t end = clock();

	auto gap = (double)(end - start) / CLOCKS_PER_SEC;
	cout << "归并算法所需时间："<<gap << endl;
	getchar();

	return 0;
}

void BubbleSort(int a[], int n)
{
	int temp;
	for (int i = 0; i < n - 1; i++)
		for (int j = i + 1; j < n; j++)
			if (a[j] < a[i])
			{
				temp = a[i];
				a[i] = a[j];
				a[j] = temp;
			}
}

void QuickSort(int *arr, int begin, int end)
{
	if (begin < end)
	{
		int temp = arr[begin];
		int i = begin;
		int j = end;
		while (i < j)
		{
			while (i < j && arr[j] > temp)
				j--;
			arr[i] = arr[j];
			while (i < j && arr[i] <= temp)
				i++;
			arr[j] = arr[i];
		}
		arr[i] = temp;
		QuickSort(arr, begin, i - 1);
		QuickSort(arr, i + 1, end);
	}
	else
		return;
}

void sort(int arr[], int left, int right, int temp[])
{
	if (left < right)
	{
		int mid = (left + right) / 2;
		sort(arr, left, mid, temp);
		sort(arr, mid + 1, right, temp);
		merge(arr, left, mid, right, temp);
	}
}
void merge(int arr[], int left, int mid, int right, int temp[])
{
	int i = left;
	int j = mid + 1;
	int t = 0;
	while (i <= mid && j <= right)
	{
		if (arr[i] <= arr[j])
		{
			temp[t++] = arr[i++];
		}
		else
		{
			temp[t++] = arr[j++];
		}
	}
	while (i <= mid)
	{
		temp[t++] = arr[i++];
	}
	while (j <= right)
	{
		temp[t++] = arr[j++];
	}
	t = 0;

	while (left <= right)
	{
		arr[left++] = temp[t++];
	}
}
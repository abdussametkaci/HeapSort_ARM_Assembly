# HeapSort_ARM_Assembly
## About Project
In this project, min heap was implemented by using ARM assembly. By using min heap data
structure, an array was sorted. For simulation, Keil uVision5 IDE was used.
## Min Heap
Min heap is a data structure. All root nodes are smaller than their children nodes. We can
sort an array by using this data structure. Firstly, we must build an min heap structure before
sorting. I will give an example when I used array in my project.
![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/array.PNG)
This algorithm check that whether root nodes are smaller than left child and right child. If a
child is smaller than parent node, nodes are swapped and then keep going to check all
parent nodes.
I used this formulas:
Parent = i
Left child = 2i + 1
Right Child = 2i + 2
I accept that the first element is zero index
## Sorting By Using Min Heap
In min heap structure, the first element is the smallest element. So, after creating a min
heap, if we create a min heap for the rest of the elements except the first element of the
array and do this continuously, we will sort the array.
So, to given an example
---------------
These arrows show that building min heap in how much size.

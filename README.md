# HeapSort_ARM_Assembly
## About Project
In this project, min heap was implemented by using ARM assembly. By using min heap data
structure, an array was sorted. For simulation, Keil uVision5 IDE was used.

## Min Heap
Min heap is a data structure. All root nodes are smaller than their children nodes. We can
sort an array by using this data structure. Firstly, we must build an min heap structure before
sorting. I will give an example when I used array in my project.

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/array.PNG)

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/heap.PNG)

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/min_heap_arr.PNG)

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

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/min_heap_sort_arr.PNG)

These arrows show that building min heap in how much size.

## Project Details
Firstly, I defined an array. The first elemnent of the array is size of array. The rest of the array
has elements.

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/code1.PNG)

After that I assigned the address of array to R0 register, size of array to R1 register and index
of node (i) to R2 register. Then, I called the sort procedure.

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/code2.PNG)

Sort procedure sorts the given array. I defined an index (R9 = sort_for_i) for a for loop. And
then, I pushed link register for begining next instruction returning from the other
procedures. This for loop repeats for the size of the array and it calls build procedure in
every step. In every step, address of the array is increases and size of array decreases. In this
way, the array is sorted.

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/code3.PNG)

Build procedure builds a min heap structure. This procedure calls heapify procedure for all
parent nodes. In this way, min heap tree are builded by using heapify. 

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/code4.PNG)

Heapify procedure actually builds a min heap locally. So this procedure heapify a subtree
rooted with node i is an index in the array. In the first part, we find left child and right child.
Then we check whether the left and right index exceed the size of array. Later, we compare
children and parent node. The smaller one replaces the own parent.

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/code5.PNG)

At the end of this controls, we check that whether the smallest one is root. If smallest one is
not root, these values are swpped and then heapify procedure continues to work. And we
set i as smallest.

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/code6.PNG)

Find procedure check that whether min heap has given element (R4). If it finds the element
return 1 (R3 = 1), otherwise return 0.

![](https://abdussametkaci.github.io/HeapSort_ARM_Assembly/img/code7.PNG)

Furthermore, I create a map file for debugging. In this way, there is no need to manually
adjust every time when we debug.

File name --> Map.ini
MAP 0xf0000000, 0xf0ffffff exec read write
MAP 0x00000000, 0x0000ffff exec read write
MAP 0xfffff000, 0xffffffff exec read write

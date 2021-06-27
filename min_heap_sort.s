	AREA min_heap_sort, CODE, READWRITE
	ENTRY
	
	LDR R0, =arr			; address of array
	LDR R1, [R0], #4 		; array size arr[0], r0 + 4 => arr[1] -> it is actual array address
	MOV R2, #0				; i -> index of node
	
	MOV R10, R0				; store array address, because sort procedure change the address and size
	MOV R11, R1				; store array size, because sort procedure change the address and size
	BL sort					; call sort procedure
	
	; restore to the original registers
	MOV R0, R10
	MOV R1, R11
	
	MOV R4, #3
	BL find					; check whether 3 in min heap
	
	MOV R4, #12
	BL find					; check whether 12 in min heap

dead						; then go to the dead loop and finish
	B dead

; the procedure sort the array by using min heap algorithm
sort PROC
	PUSH {LR}			; push LR
	MOV R9, #0			; sort_for_i = 0
	MOV R12, R1			; sort_for_n = size (sort_for_n is local parameter)
sort_for				; begin for loop
	CMP R9, R12			; compare sort_for_i and size of array
	BGE sort_end_for	; if (sort_for_i >= size of array) end sort for loop
	BL build			; else call build procedure
	ADD R0, R0, #4		; arr + 1 -> change the address of array (int = 4 byte)
	SUB R1, R1, #1		; size - 1 -> decerease the size of array
	ADD R9, R9, #1		; sort_for_i++
	B sort_for			; keep going sort for loop
sort_end_for
	POP {PC}			; pop PC
	ENDP

; the procedure build min heap
build PROC
	PUSH {LR}
	MOV R8, R1, LSR #1		; n / 2 (n is size of array)
	SUB R8, R8, #1			; index = n / 2 - 1 -> index of root
	
for							; begin for loop
	CMP R8, #0				; compare index and zero
	BLT end_for				; if (index < zero) end for loop
	MOV R2, R8				; else i = index
	BL heapify				; call heapify procedure
	SUB R8, R8, #1			; index--
	B for					; keep going for loop
end_for
	POP {PC}
	ENDP

; the procedure heapify a subtree rooted with node i is an index in array
heapify PROC
	PUSH {LR}
								; R3 is smallest
recursive 
	MOV R3, R2					; initialize smallest = i
	MOV R4, R2, LSL #1			; left = 2 * i
	ADD R4, R4, #1				; left = 2 * i + 1
	MOV R5, R2, LSL #1			; right = 2 * i
	ADD R5, R5, #2				; right = 2 * i + 2
	
	CMP R4, R1					; compare left and size
	BGE end_left_control		; if (left >= size) end left control
	LDR R6, [R0, R4, LSL #2]	; else R6 = arr[left]
	LDR R7, [R0, R3, LSL #2]	; R7 = arr[smallest]
	CMP R6, R7					; compare arr[left] and arr[smallest]
	BGE end_left_control		; if (arr[left] >= arr[smallest]) end left control
	MOV R3, R4					; else smallest = left
end_left_control

	
	CMP R5, R1					; compare right and size
	BGE end_right_control		; if (right >= size) end right control
	LDR R6, [R0, R5, LSL #2]	; else R6 = arr[right]
	LDR R7, [R0, R3, LSL #2]	; R7 = arr[smallest]
	CMP R6, R7					; compare arr[right] and arr[smallest]
	BGE end_right_control		; if(arr[right] >= arr[smallest]) end right control
	MOV R3, R5					; else smallest = right
end_right_control

	CMP R3, R2					; compare smallest and i
	BEQ end_if					; if (smallest == i) end if, else swap
	LDR R6, [R0, R2, LSL #2]	; temp = arr[i]
	LDR R7, [R0, R3, LSL #2]	; arr[smallest]
	STR R7, [R0, R2, LSL #2]	; arr[i] = arr[smallest]
	STR R6, [R0, R3, LSL #2]	; arr[smallest] = temp
	MOV R2, R3					; i = smallest
	B recursive
end_if
	POP {PC}
	ENDP

; find element (R4) in the min heap
; if find the element return 1 (R3 = 1), else return 0 (R3 = 0)
find PROC
	PUSH {LR}
	MOV R2, #0	; i = 0 -> index for find_loop
	MOV R3, #0	; false
find_loop
	CMP R2, R1					; compare index and array size
	BGE find_end_loop			; if(index >= size) finish the loop
	LDR R5, [R0, R2, LSL #2]	; R5 = arr [i]
	CMP R4, R5
	BEQ founded					; if(R4 == R5)
	ADD R2, R2, #1				; i++
	B find_loop					; else keeop going the loop
founded
	MOV R3, #1	; true
find_end_loop
	POP {PC}
	ENDP
		
; define an array
arr
	DCD 5, 4, 6, 3, 2, 9; arr[0] -> size, arr = [1...size]
	END
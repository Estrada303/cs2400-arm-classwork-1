memstore	fill		4
storeptr	fill		4
heap		fill		1000
		adr		r1, memstore
		adr		r2, storeptr
		adr		r3, heap
		str		r3, [r1]
		str		r3, [r2]
		
		
		
main		;str		lr, [sp, #-4]
		sub		sp, sp, #12
		mov		r0, #400
		bl		malloc
		mov		r3, r0
		str		r3, [sp, #4]
		ldr		r0, [sp, #4]
		bl		free
		movs		r3, #0
		str		r3, [sp, #4]
		movs		r3, #0
		mov		r0, r3
		add		sp, sp, #12
		;ldr		pc, [sp], #4
		end
		
malloc
		add		r0, r0, #4		;total space needed array size plus one word for array size
		adr		r3, storeptr
		ldr		r3, [r3]
		mov		r4, #250
		lsl		r4, r4, #2
		adr		r5, heap
		add		r5, r4, r5
		sub		r5, r5, r3
		cmp		r5, r0
		movlt	r0, #0
		movlt	pc, lr
		sub		r0, r0, #4		;get back to array size
		adr		r3, memstore		;load address for memstore ptr
		ldr		r4, [r3]			;get ptr from memstore loaded to r4
		add		r4, r4, #4		;increase memstore to next address
		str		r4, [r3]			;store back to memstore
		mov		r5, r4
		add		r4, r0, r4
		adr		r3, storeptr
		add		r3, r3, #4
		str		r0, [r3]
		str		r4, [r3, #-4]
		mov		r0, r5			;pass back the ptr for the array
		mov		pc, lr
free
		adr		r1, storeptr
		ldr		r2, [r1]
		ldr		r3, [r0, #-4]
		add		r3, r3, #4
		sub		r2, r2, r3
		str		r2, [r1]
		adr		r4, memstore
		ldr		r5, [r4]
		cmp		r2, r5
		sublt	r5, r5, #4
		strlt	r5, [r4]
		mov		pc, lr
		
		
		
		
		
		

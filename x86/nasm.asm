; rax is the return register which will return
; values from function.
section .text
global SomeFunctionNasm
global CpuID

SomeFunctionNasm:
	mov rax, 111	; Load decimal value 111 to rax
	ret

CpuID:
	mov rax, 1h
	cpuid	
	ret


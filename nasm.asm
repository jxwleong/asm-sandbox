; rax is the return register which will return
; values from function.
section .text
global SomeFunctionNasm

SomeFunctionNasm:
	mov rax, 111	; Load decimal value 123 to rax
	ret


end
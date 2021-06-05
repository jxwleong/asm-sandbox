; Main reference: https://www.youtube.com/watch?v=p5X1Sf5ejCc
.data
vendorString db 12 dup(0), 0	; 13 chars array, 0 in the end
								; so will stop printing at 0
processorBrandString db 49 dup(0), 0	; 49 char array
; rax is the return register which will return
; values from function.
.code
SomeFunction proc
	mov rax, 123	; Load decimal value 123 to rax
	ret
SomeFunction endp

; bool GetCPUIDSupport()
; This function tests if the CPU can call the CPUID instruction
; by setting the ID flag (bit 21) in the flags register to 1
; and checking if the change stuck. If this flag cannot be set
; which means that the CPU automatically reset it to 0, then the
; CPU doesn't not understand the CPUID instruction whcih is unlikely.
GetCPUIDSupport proc
	push rbx	; Save caller's RBX as RBX is preserved register
	pushfq		; Push the flags register
	pop rax		; Pop the flag register value into EAX
	mov rbx, rax	; Save the value into EBX
	xor rax, 200000h; set bit 21, the ID flag, to 1
	push rax	; Push this toggled flags register
	popfq		; Pop the toggled flags back to the flag register.
				;	At this point, CPU will either automatically reset
				;	21st bit to 0 or leave it as 1 depend on whether
				;	it understand/know about the CPUID instruction.
	pushfq		; Push the flags again (has the bits changed?)
	pop rax		; Pop the flags to EAX again.
	cmp  rax, rbx	; Compare whether the flags is same as the value
					; of EAX we saved on EBX earlier.
					; "cmp" just subract both operands.
	jz No_CPUID	; If the value is 0 (same), this mean that the 
				; CPU set back the bit 21 to 0.., and it will
				; jump to label NO_CPUID
	;Come here if cmp rax, rbx not equal 0	
	pop  rbx	; Restore the caller RBX
	mov  rax, 1	; return (1) which indicate true
	ret

;Come here if cmp rax, rbx equal to 0	
No_CPUID:
	pop rbx		; Restore the caller RBX
	mov rax, 0	; return (1) which indicate true
	ret
GetCPUIDSupport endp

; char* GetVendorString()
; CPUID_0000_0000_EBX:EDX:ECX
; CPUID__function_number__register_for_output
; This means that laod 0000_0000 to EAX, and the
; output we're looking is at EBX:EDX:ECX
GetVendorString proc
	push rbx	; Save RBX
	mov eax, 0	; Move function number 0 into EAX
	cpuid	; Call CPUID
	lea rax, vendorString	; Load address of *vendorString into rax

	; Move the value in registers into *vendorString in the specific order:
	; (Must in this order, else the chars *vendorString will be positioned properly)
	mov dword ptr [rax], ebx	; 1st 4 bytes of vendor string in ebx
	mov  dword ptr [rax+4], edx ; 2nd 4 bytes of vendor string in edx
	mov dword ptr[rax+8], ecx	; 3rd 4 bytes of vendor string in ecx

	pop rbx		; Restore caller's RBX
	ret		; Return with RAX pointing to the answer in *vendorString
GetVendorString endp

; Obselete, still looking for correct way of doing it...
; https://stackoverflow.com/questions/2901694/how-to-detect-the-number-of-physical-processors-cores-on-windows-mac-and-linu
; https://stackoverflow.com/questions/1647190/cpuid-on-intel-i7-processors
; int GetLogicalProcessorCount()
; CPUID_0000_1011_EBX
GetLogicalProcessorCount proc
	push rbx	; Save caller RBX
	;mov eax, 1011b	; Move 0xb to eax
	mov eax, 1;
	cpuid	; Call CPUID
	;and ebx, 0000ffffh
	mov eax, edx
	pop rbx		; Restore caller's RBX
	ret
GetLogicalProcessorCount endp

; unsigned int GetHighestExtendedFunction
; Highest value/function number implemented to be loaded into eax
GetHighestExtendedFunction proc
	mov eax, 80000000h
	cpuid
	ret
GetHighestExtendedFunction endp

end
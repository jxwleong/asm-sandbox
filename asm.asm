.data
vendorString db 12 dup(0), 0


; rax is the return register which will return
; values from function.
.code
SomeFunction proc
	mov rax, 123	; Load decimal value 123 to rax
	ret
SomeFunction endp

GetCPUIDSupport proc
	push rbx
	pushfq
	pop rax
	mov rbx, rax
	xor rax, 200000h
	push rax
	popfq
	pushfq
	pop rax
	cmp  rax, rbx

	jz No_CPUID
	pop  rbx
	mov  rax, 1
	ret

No_CPUID:
	pop rbx
	mov rax, 0
	ret
GetCPUIDSupport endp

GetVendorString proc
	push rbx
	mov eax, 0
	cpuid
	lea rax, vendorString

	mov dword ptr [rax], ebx
	mov  dword ptr [rax+4], edx
	mov dword ptr[rax+8], ecx

	pop rbx
	ret
	ret
GetVendorString endp

GetLogicalProcessorCount proc
	push rbx
	mov eax, 1
	cpuid
	and ebx, 00ff0000h
	mov eax, ebx
	pop rbx
	shr eax, 16
	ret
GetLogicalProcessorCount endp
end
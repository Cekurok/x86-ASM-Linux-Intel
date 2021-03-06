; Filename: Procedure-Function-Saves.asm
; Author: Brandon Dennis

global _start

section .txt

; notice that this is not inside of the _start section since _start is where the entry point is, this will not get executed
; upon the application starting
ProcHelloWorld:
  
  ;This is called the epilog
  push ebp ; this pushes the fram pointer onto the stack
  mov ebp, esp ; this moves the current stakc pointer into ebp
  
  ; Prints Hello World using the write syscall # 4
  
  mov eax, 0x4 ; moves syscall write #4 to eax
  mov ebx, 0x1 ; moves the fiel descriptor sysout to ebx
  mov ecx, message ; moves the string hello world into ecx
  mov edx, mlen ; moves the length of the string hello world to edx
  int 0x80 ; executes the syscall in eax
  
  leave ; this performs the instructions below in a shorter to write way
  ; mov esp, ebp
  ; pop ebp
  
  ret ; this returns to the place that used the call ProcHelloWorld instruction
  
  
_start:
  
  mov ecx, 0x10 ; moving 10 into ecx as a counter
  
PrintHelloWorld:
  
  pushad ; this pushes all registers contents onto the stack
  pushfd ; this pushes all the flags onto the stack
  
  call ProcHelloWorld ; this call the procedure ProcHElloWorld to be ran
  ; when call is execture it takes the memory addr of the next instruction (pop ecx) and pushes it onto the stack
  ; once the ret instruction is called it will pop that value off the stack and into EIP and continue from where EIP is(pop ecx)
  
  
  popfd ; this restores all of the flags from the stack
  popad ; this restores all registers content from the stack
  
  loop PrintHelloWorld ; this will dec 1 from ecx then issue a call PrintHelloWorld instruction
  ; once ecx is set to 0 the ZF flag will be set and if that flag is set it will skip the loop instruction
  
  
  ; exit the application
  mov eax, 0x1 ; moves the syscall for exit #1 into eax
  mov ebx, 0x1 ; moves the exit code into ebx
  int 0x80 ; executes the syscall in eax
  
section .data

	message: db "Hello World!"
	mlen	equ  $-message ; short way to get length of a string




  

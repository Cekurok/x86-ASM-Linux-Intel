; Filename: Control.asm
; Author: Brandon Dennis

global _start

section .txt
_start:

  jmp Begin ; This jumps to theBegin label skipping the SkipSection label
  
SkipSection: ; This never gets executed because of the jump
  mov eax, 0x10 ; movs 10 into eax
  xor ebx, ebx ; 0's out ebx
  
Begin:
  mov eax, 0x5 ; movs 5 into eax
  
PrintHW:
  
  push eax ; this pushes eax(5) onto the stack to be saved for later
  
  ; below prints hello world using the write syscall
  mov eax, 0x4 ; this moves the syscall # for write(4) into eax
  mov ebx, 0x1 ; this moves 1(the sysout file descripter) into ebx as param #2
  mov ecx, message ; this moves the memory addr of hello world into ecx as param #3
  mov edx, mlen ; this moves the length of the string hello world into edx as param #4
  int 0x80 ; this init's the syscall of write to print on the screen hello world
  
  pop eax ; This moves 0x5 back into eax from the stack
  dec eax ; this takes eax and - 1 from it, so eax is now 4
  jnz PrintHW


  ; Exits the application
  mov eax, 0x1 ; sets the syscall # for exit to eax
  mov ebx, 0x1 ; sets the exit code to the 2nd arg in ebx
  int 0x80 ; runs the syscall command in eax with ebx as arg 1


section .data

  message: db "Hello World! "
  mlen equ $-message




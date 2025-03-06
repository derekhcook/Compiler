; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no141

_start:                                 
        call    ReadInt                 ; read int; value placed in eax
        mov     [I0],eax                ; store eax at aaaaaaaaaaaaaaa
        call    ReadInt                 ; read int; value placed in eax
        mov     [I0],eax                ; store eax at aaaaaaaaaaaaaaa
        call    ReadInt                 ; read int; value placed in eax
        mov     [I0],eax                ; store eax at aaaaaaaaaaaaaaa
        add     eax,[I0]                ; AReg = aaaaaaaaaaaaaaa + aaaaaaaaaaaaaaa
        mov     [I0],eax                ; aaaaaaaaaaaaaaa = AReg
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        Exit    {0}                     

SECTION .data                           

SECTION .bss                            
I0      resd    1                       ; aaaaaaaaaaaaaaa

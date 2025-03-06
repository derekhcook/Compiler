; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no159

_start:                                 
        call    ReadInt                 ; read int; value placed in eax
        mov     [I4],eax                ; store eax at i
        call    ReadInt                 ; read int; value placed in eax
        mov     [I5],eax                ; store eax at j
        mov     eax,[I4]                ; load i in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I5]                ; load j in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out

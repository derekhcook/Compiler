; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no137

_start:                                 
        call    ReadInt                 ; read int; value placed in eax
        mov     [I0],eax                ; store eax at a
        call    ReadInt                 ; read int; value placed in eax
        mov     [I1],eax                ; store eax at b
        call    ReadInt                 ; read int; value placed in eax
        mov     [I2],eax                ; store eax at c
        mov     eax,[I0]                ; load a in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I1]                ; load b in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I2]                ; load c in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I1]                ; AReg = b
        sub     eax,[I2]                ; AReg = b - c
        add     eax,[I0]                ; AReg = T0 + a
        mov     [I3],eax                ; d = AReg
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I1]                ; AReg = b
        imul    dword [I1]              ; AReg = b * b
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I4]                ; AReg = 4
        imul    dword [I0]              ; AReg = 4 * a
        imul    dword [I2]              ; AReg = T1 * c
        mov     [T1],eax                ; deassign AReg
        mov     eax,[T0]                ; AReg = T0
        sub     eax,[T1]                ; AReg = T0 - T1
        mov     [I3],eax                ; d = AReg
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        Exit    {0}                     

SECTION .data                           
I4      dd      4                       ; 4

SECTION .bss                            
T0      resd    1                       ; T0
T1      resd    1                       ; T1
I0      resd    1                       ; a
I1      resd    1                       ; b
I2      resd    1                       ; c
I3      resd    1                       ; d

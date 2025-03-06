; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no140

_start:                                 
        call    ReadInt                 ; read int; value placed in eax
        mov     [I0],eax                ; store eax at a
        call    ReadInt                 ; read int; value placed in eax
        mov     [I1],eax                ; store eax at b
        call    ReadInt                 ; read int; value placed in eax
        mov     [I2],eax                ; store eax at c
        call    ReadInt                 ; read int; value placed in eax
        mov     [I3],eax                ; store eax at d
        call    ReadInt                 ; read int; value placed in eax
        mov     [I4],eax                ; store eax at e
        call    ReadInt                 ; read int; value placed in eax
        mov     [I5],eax                ; store eax at f
        add     eax,[I4]                ; AReg = f + e
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I3]                ; AReg = d
        sub     eax,[T0]                ; AReg = d - T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I2]                ; AReg = c
        cdq                             ; sign extend dividend from eax to edx:eax
        idiv    dword [T0]              ; AReg = c div T0
        imul    dword [I1]              ; AReg = T0 * b
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I0]                ; AReg = a
        cdq                             ; sign extend dividend from eax to edx:eax
        idiv    dword [T0]              ; AReg = a div T0
        xchg    eax,edx                 ; exchange quotient and remainder
        mov     [I6],eax                ; g = AReg
        mov     eax,[I0]                ; load a in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I1]                ; load b in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I2]                ; load c in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I3]                ; load d in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I4]                ; load e in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I5]                ; load f in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I6]                ; load g in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        Exit    {0}                     

SECTION .data                           

SECTION .bss                            
T0      resd    1                       ; T0
I0      resd    1                       ; a
I1      resd    1                       ; b
I2      resd    1                       ; c
I3      resd    1                       ; d
I4      resd    1                       ; e
I5      resd    1                       ; f
I6      resd    1                       ; g

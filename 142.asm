; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no142

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

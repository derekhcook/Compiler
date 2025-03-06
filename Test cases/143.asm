; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no143

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

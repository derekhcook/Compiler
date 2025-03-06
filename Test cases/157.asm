; Trey Fleming, Derek Cook       Fri Dec  6 00:10:01 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no157

_start:                                 
        call    ReadInt                 ; read int; value placed in eax
        mov     [I4],eax                ; store eax at i

; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no112

_start:                                 
        mov     eax,[I1]                ; AReg = five
        imul    dword [I2]              ; AReg = five * a

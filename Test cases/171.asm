; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no171

_start:                                 
        mov     eax,[FALSE]             ; AReg = false
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        mov     [B1],eax                ; d = AReg
        mov     eax,[TRUE]              ; AReg = true
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        not     eax                     ; AReg = !AReg
        not     eax                     ; AReg = !AReg
        mov     [B1],eax                ; d = AReg

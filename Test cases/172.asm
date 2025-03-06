; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no172

_start:                                 
        mov     eax,[B0]                ; AReg = x
        or      eax,[B0]                ; AReg = x or x
        mov     [B1],eax                ; d = AReg
        mov     eax,[B0]                ; AReg = x
        or      eax,[TRUE]              ; AReg = x or true
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        or      eax,[B0]                ; AReg = false or x
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        or      eax,[FALSE]             ; AReg = false or false
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        or      eax,[TRUE]              ; AReg = false or true
        mov     [B1],eax                ; d = AReg
        mov     eax,[TRUE]              ; AReg = true
        or      eax,[FALSE]             ; AReg = true or false
        mov     [B1],eax                ; d = AReg
        mov     eax,[TRUE]              ; AReg = true
        or      eax,[TRUE]              ; AReg = true or true
        mov     [B1],eax                ; d = AReg
        mov     eax,[TRUE]              ; AReg = true
        or      eax,[TRUE]              ; AReg = true or true
        mov     [B1],eax                ; d = AReg
        mov     eax,[TRUE]              ; AReg = true
        or      eax,[FALSE]             ; AReg = true or false
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        or      eax,[TRUE]              ; AReg = false or true
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        or      eax,[FALSE]             ; AReg = false or false
        mov     [B1],eax                ; d = AReg

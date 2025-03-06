; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no165

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
        mov     eax,[B0]                ; AReg = a
        cmp     eax,[B2]                ; compare a and c
        je      .L0                     ; if a = c then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L1                     ; unconditionally jump
.L0:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L1:                                    
        not     eax                     ; AReg = !AReg
        mov     [B4],eax                ; k = AReg
        mov     eax,[FALSE]             ; AReg = false
        mov     [B4],eax                ; k = AReg
        mov     eax,[FALSE]             ; AReg = false
        mov     [B4],eax                ; k = AReg
        mov     eax,[I0]                ; AReg = e
        add     eax,[I1]                ; AReg = e + f
        mov     [I4],eax                ; i = AReg
        mov     eax,[I6]                ; AReg = 4301
        mov     [I4],eax                ; i = AReg
        mov     eax,[I2]                ; AReg = g
        mov     [I4],eax                ; i = AReg
        mov     eax,[I1]                ; AReg = f
        sub     eax,[I2]                ; AReg = f - g
        neg     eax                     ; AReg = -AReg
        mov     [I4],eax                ; i = AReg
        mov     eax,[I7]                ; AReg = -4301
        mov     [I4],eax                ; i = AReg
        mov     eax,[I2]                ; AReg = g
        neg     eax                     ; AReg = -AReg
        mov     [I4],eax                ; i = AReg

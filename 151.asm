; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no151

_start:                                 
        mov     eax,[TRUE]              ; AReg = true
        mov     [B1],eax                ; b = AReg
        mov     eax,[FALSE]             ; AReg = false
        mov     [B2],eax                ; c = AReg
        mov     eax,[TRUE]              ; AReg = true
        mov     [B0],eax                ; a = AReg
        mov     eax,[B1]                ; AReg = b
        cmp     eax,[B2]                ; compare b and c
        je      .L0                     ; if b = c then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L1                     ; unconditionally jump
.L0:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L1:                                    
        cmp     eax,[B0]                ; compare T0 and a
        je      .L2                     ; if T0 = a then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L3                     ; unconditionally jump
.L2:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L3:                                    
        mov     [B3],eax                ; d = AReg
        mov     eax,[I1]                ; AReg = 5
        neg     eax                     ; AReg = -AReg
        mov     [I0],eax                ; e = AReg
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        Exit    {0}                     

SECTION .data                           
I1      dd      5                       ; 5
FALSE   dd      0                       ; false
TRUE    dd      -1                      ; true

SECTION .bss                            
B0      resd    1                       ; a
B1      resd    1                       ; b
B2      resd    1                       ; c
B3      resd    1                       ; d
I0      resd    1                       ; e

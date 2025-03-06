; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no138

_start:                                 
        call    ReadInt                 ; read int; value placed in eax
        mov     [I0],eax                ; store eax at a
        call    ReadInt                 ; read int; value placed in eax
        mov     [I1],eax                ; store eax at b
        mov     eax,[I0]                ; AReg = a
        cdq                             ; sign extend dividend from eax to edx:eax
        idiv    dword [I1]              ; AReg = a div b
        imul    dword [I1]              ; AReg = T0 * b
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I0]                ; AReg = a
        sub     eax,[T0]                ; AReg = a - T0
        mov     [I2],eax                ; c = AReg
        mov     eax,[I0]                ; AReg = a
        cdq                             ; sign extend dividend from eax to edx:eax
        idiv    dword [I1]              ; AReg = a div b
        xchg    eax,edx                 ; exchange quotient and remainder
        mov     [I3],eax                ; d = AReg
        cmp     eax,[I2]                ; compare d and c
        je      .L0                     ; if c = d then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L1                     ; unconditionally jump
.L0:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L1:                                    
        mov     [B0],eax                ; e = AReg
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
        mov     eax,[B0]                ; load e in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        Exit    {0}                     

SECTION .data                           
FALSE   dd      0                       ; false
TRUE    dd      -1                      ; true

SECTION .bss                            
T0      resd    1                       ; T0
I0      resd    1                       ; a
I1      resd    1                       ; b
I2      resd    1                       ; c
I3      resd    1                       ; d
B0      resd    1                       ; e

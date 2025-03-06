; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program dwwtest1

_start:                                 
        mov     eax,[I0]                ; AReg = a
        add     eax,[I1]                ; AReg = a + b
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I2]                ; AReg = c
        add     eax,[I3]                ; AReg = c + d
        mov     [T1],eax                ; deassign AReg
        mov     eax,[I4]                ; AReg = e
        add     eax,[I5]                ; AReg = e + f
        mov     [T2],eax                ; deassign AReg
        mov     eax,[I6]                ; AReg = g
        add     eax,[I7]                ; AReg = g + h
        mov     [T3],eax                ; deassign AReg
        mov     eax,[I8]                ; AReg = i
        add     eax,[I9]                ; AReg = i + j
        mov     [T4],eax                ; deassign AReg
        mov     eax,[I10]               ; AReg = k
        add     eax,[I11]               ; AReg = k + l
        mov     [T5],eax                ; deassign AReg
        mov     eax,[I12]               ; AReg = m
        add     eax,[I13]               ; AReg = m + n
        mov     [T6],eax                ; deassign AReg
        mov     eax,[I14]               ; AReg = o
        add     eax,[I15]               ; AReg = o + p
        mov     [T7],eax                ; deassign AReg
        mov     eax,[I16]               ; AReg = q
        add     eax,[I17]               ; AReg = q + r
        mov     [T8],eax                ; deassign AReg
        mov     eax,[I18]               ; AReg = s
        add     eax,[I19]               ; AReg = s + t
        mov     [T9],eax                ; deassign AReg
        mov     eax,[I20]               ; AReg = u
        add     eax,[I21]               ; AReg = u + v
        mov     [T10],eax               ; deassign AReg
        mov     eax,[I22]               ; AReg = w
        add     eax,[I23]               ; AReg = w + x
        mov     [T11],eax               ; deassign AReg
        mov     eax,[I24]               ; AReg = y
        add     eax,[I25]               ; AReg = y + z
        add     eax,[T11]               ; AReg = T12 + T11
        add     eax,[T10]               ; AReg = T11 + T10
        add     eax,[T9]                ; AReg = T10 + T9
        add     eax,[T8]                ; AReg = T9 + T8
        add     eax,[T7]                ; AReg = T8 + T7
        add     eax,[T6]                ; AReg = T7 + T6
        add     eax,[T5]                ; AReg = T6 + T5
        add     eax,[T4]                ; AReg = T5 + T4
        add     eax,[T3]                ; AReg = T4 + T3
        add     eax,[T2]                ; AReg = T3 + T2
        add     eax,[T1]                ; AReg = T2 + T1
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [I26],eax               ; sum1 = AReg
        mov     eax,[I1]                ; AReg = b
        imul    dword [I2]              ; AReg = b * c
        add     eax,[I0]                ; AReg = T0 + a
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I3]                ; AReg = d
        imul    dword [I4]              ; AReg = d * e
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I5]                ; AReg = f
        imul    dword [I6]              ; AReg = f * g
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I7]                ; AReg = h
        imul    dword [I8]              ; AReg = h * i
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I9]                ; AReg = j
        imul    dword [I10]             ; AReg = j * k
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I11]               ; AReg = l
        imul    dword [I12]             ; AReg = l * m
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I13]               ; AReg = n
        imul    dword [I14]             ; AReg = n * o
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I15]               ; AReg = p
        imul    dword [I16]             ; AReg = p * q
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I17]               ; AReg = r
        imul    dword [I18]             ; AReg = r * s
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I19]               ; AReg = t
        imul    dword [I20]             ; AReg = t * u
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I21]               ; AReg = v
        imul    dword [I22]             ; AReg = v * w
        add     eax,[T0]                ; AReg = T1 + T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I23]               ; AReg = x
        imul    dword [I24]             ; AReg = x * y
        add     eax,[T0]                ; AReg = T1 + T0
        add     eax,[I25]               ; AReg = T0 + z
        mov     [I27],eax               ; sum2 = AReg
        mov     eax,[I0]                ; AReg = a
        add     eax,[I1]                ; AReg = a + b
        add     eax,[I2]                ; AReg = T0 + c
        add     eax,[I3]                ; AReg = T0 + d
        add     eax,[I4]                ; AReg = T0 + e
        add     eax,[I5]                ; AReg = T0 + f
        add     eax,[I6]                ; AReg = T0 + g
        add     eax,[I7]                ; AReg = T0 + h
        add     eax,[I8]                ; AReg = T0 + i
        add     eax,[I9]                ; AReg = T0 + j
        add     eax,[I10]               ; AReg = T0 + k
        add     eax,[I11]               ; AReg = T0 + l
        add     eax,[I12]               ; AReg = T0 + m
        add     eax,[I13]               ; AReg = T0 + n
        add     eax,[I14]               ; AReg = T0 + o
        add     eax,[I15]               ; AReg = T0 + p
        add     eax,[I16]               ; AReg = T0 + q
        add     eax,[I17]               ; AReg = T0 + r
        add     eax,[I18]               ; AReg = T0 + s
        add     eax,[I19]               ; AReg = T0 + t
        add     eax,[I20]               ; AReg = T0 + u
        add     eax,[I21]               ; AReg = T0 + v
        add     eax,[I22]               ; AReg = T0 + w
        add     eax,[I23]               ; AReg = T0 + x
        add     eax,[I24]               ; AReg = T0 + y
        add     eax,[I25]               ; AReg = T0 + z
        mov     [I28],eax               ; sum3 = AReg
        mov     eax,[I0]                ; AReg = a
        neg     eax                     ; AReg = -AReg
        add     eax,[I1]                ; AReg = T0 + b
        neg     eax                     ; AReg = -AReg
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I3]                ; AReg = d
        neg     eax                     ; AReg = -AReg
        add     eax,[I2]                ; AReg = T1 + c
        imul    dword [T0]              ; AReg = T1 * T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I4]                ; AReg = e
        sub     eax,[I5]                ; AReg = e - f
        neg     eax                     ; AReg = -AReg
        imul    dword [T0]              ; AReg = T1 * T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I6]                ; AReg = g
        neg     eax                     ; AReg = -AReg
        mov     [T1],eax                ; deassign AReg
        mov     eax,[I7]                ; AReg = h
        neg     eax                     ; AReg = -AReg
        mov     [T2],eax                ; deassign AReg
        mov     eax,[T1]                ; AReg = T1
        sub     eax,[T2]                ; AReg = T1 - T2
        imul    dword [T0]              ; AReg = T1 * T0
        mov     [I29],eax               ; sum4 = AReg
        mov     eax,[I0]                ; AReg = a
        neg     eax                     ; AReg = -AReg
        neg     eax                     ; AReg = -AReg
        neg     eax                     ; AReg = -AReg
        neg     eax                     ; AReg = -AReg
        neg     eax                     ; AReg = -AReg
        neg     eax                     ; AReg = -AReg
        mov     [I30],eax               ; sum5 = AReg
        mov     eax,[I0]                ; AReg = a
        cmp     eax,[I1]                ; compare a and b
        je      .L0                     ; if a = b then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L1                     ; unconditionally jump
.L0:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L1:                                    
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I2]                ; AReg = c
        cmp     eax,[I3]                ; compare c and d
        jl      .L2                     ; if c < d then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L3                     ; unconditionally jump
.L2:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L3:                                    
        or      eax,[T0]                ; AReg = T1 or T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I4]                ; AReg = e
        cmp     eax,[I5]                ; compare e and f
        jle     .L4                     ; if e <= f then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L5                     ; unconditionally jump
.L4:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L5:                                    
        or      eax,[T0]                ; AReg = T1 or T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I6]                ; AReg = g
        cmp     eax,[I7]                ; compare g and h
        jg      .L6                     ; if g > h then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L7                     ; unconditionally jump
.L6:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L7:                                    
        or      eax,[T0]                ; AReg = T1 or T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I8]                ; AReg = i
        cmp     eax,[I9]                ; compare i and j
        jge     .L8                     ; if i >= j then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L9                     ; unconditionally jump
.L8:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L9:                                    
        or      eax,[T0]                ; AReg = T1 or T0
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I10]               ; AReg = k
        cmp     eax,[I11]               ; compare k and l
        jne     .L10                    ; if k <> l then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L11                    ; unconditionally jump
.L10:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L11:                                   
        or      eax,[T0]                ; AReg = T1 or T0
        mov     [B0],eax                ; aa = AReg
        cmp     eax,[B1]                ; compare aa and bb
        je      .L12                    ; if aa = bb then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L13                    ; unconditionally jump
.L12:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L13:                                   
        mov     [T0],eax                ; deassign AReg
        mov     eax,[B2]                ; AReg = cc
        cmp     eax,[B3]                ; compare cc and dd
        jne     .L14                    ; if cc <> dd then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L15                    ; unconditionally jump
.L14:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L15:                                   
        and     eax,[T0]                ; AReg = T1 and T0
        mov     [B1],eax                ; bb = AReg
        mov     eax,[B0]                ; AReg = aa
        not     eax                     ; AReg = !AReg
        mov     [T0],eax                ; deassign AReg
        mov     eax,[B1]                ; AReg = bb
        not     eax                     ; AReg = !AReg
        cmp     eax,[T0]                ; compare T1 and T0
        je      .L16                    ; if T0 = T1 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L17                    ; unconditionally jump
.L16:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L17:                                   
        not     eax                     ; AReg = !AReg
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I2]                ; AReg = c
        cmp     eax,[I3]                ; compare c and d
        jl      .L18                    ; if c < d then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L19                    ; unconditionally jump
.L18:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L19:                                   
        not     eax                     ; AReg = !AReg
        and     eax,[T0]                ; AReg = T1 and T0
        mov     [B2],eax                ; cc = AReg
        mov     eax,[B0]                ; AReg = aa
        not     eax                     ; AReg = !AReg
        not     eax                     ; AReg = !AReg
        not     eax                     ; AReg = !AReg
        not     eax                     ; AReg = !AReg
        mov     [B3],eax                ; dd = AReg
        Exit    {0}                     

SECTION .data                           
FALSE   dd      0                       ; false
TRUE    dd      -1                      ; true

SECTION .bss                            
T0      resd    1                       ; T0
T1      resd    1                       ; T1
T10     resd    1                       ; T10
T11     resd    1                       ; T11
T2      resd    1                       ; T2
T3      resd    1                       ; T3
T4      resd    1                       ; T4
T5      resd    1                       ; T5
T6      resd    1                       ; T6
T7      resd    1                       ; T7
T8      resd    1                       ; T8
T9      resd    1                       ; T9
I0      resd    1                       ; a
B0      resd    1                       ; aa
I1      resd    1                       ; b
B1      resd    1                       ; bb
I2      resd    1                       ; c
B2      resd    1                       ; cc
I3      resd    1                       ; d
B3      resd    1                       ; dd
I4      resd    1                       ; e
I5      resd    1                       ; f
I6      resd    1                       ; g
I7      resd    1                       ; h
I8      resd    1                       ; i
I9      resd    1                       ; j
I10     resd    1                       ; k
I11     resd    1                       ; l
I12     resd    1                       ; m
I13     resd    1                       ; n
I14     resd    1                       ; o
I15     resd    1                       ; p
I16     resd    1                       ; q
I17     resd    1                       ; r
I18     resd    1                       ; s
I26     resd    1                       ; sum1
I27     resd    1                       ; sum2
I28     resd    1                       ; sum3
I29     resd    1                       ; sum4
I30     resd    1                       ; sum5
I19     resd    1                       ; t
I20     resd    1                       ; u
I21     resd    1                       ; v
I22     resd    1                       ; w
I23     resd    1                       ; x
I24     resd    1                       ; y
I25     resd    1                       ; z

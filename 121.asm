; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no121

_start:                                 
        call    ReadInt                 ; read int; value placed in eax
        mov     [I1],eax                ; store eax at a
        call    ReadInt                 ; read int; value placed in eax
        mov     [I2],eax                ; store eax at b
        call    ReadInt                 ; read int; value placed in eax
        mov     [I3],eax                ; store eax at c
        call    ReadInt                 ; read int; value placed in eax
        mov     [I4],eax                ; store eax at d
        call    ReadInt                 ; read int; value placed in eax
        mov     [I5],eax                ; store eax at e
        call    ReadInt                 ; read int; value placed in eax
        mov     [I6],eax                ; store eax at f
        call    ReadInt                 ; read int; value placed in eax
        mov     [I7],eax                ; store eax at g
        call    ReadInt                 ; read int; value placed in eax
        mov     [I8],eax                ; store eax at h
        call    ReadInt                 ; read int; value placed in eax
        mov     [I9],eax                ; store eax at i
        call    ReadInt                 ; read int; value placed in eax
        mov     [I10],eax               ; store eax at j
        call    ReadInt                 ; read int; value placed in eax
        mov     [I11],eax               ; store eax at k
        call    ReadInt                 ; read int; value placed in eax
        mov     [I12],eax               ; store eax at l
        call    ReadInt                 ; read int; value placed in eax
        mov     [I13],eax               ; store eax at m
        call    ReadInt                 ; read int; value placed in eax
        mov     [I14],eax               ; store eax at n
        call    ReadInt                 ; read int; value placed in eax
        mov     [I15],eax               ; store eax at o
        call    ReadInt                 ; read int; value placed in eax
        mov     [I16],eax               ; store eax at p
        call    ReadInt                 ; read int; value placed in eax
        mov     [I17],eax               ; store eax at q
        call    ReadInt                 ; read int; value placed in eax
        mov     [I18],eax               ; store eax at r
        call    ReadInt                 ; read int; value placed in eax
        mov     [I19],eax               ; store eax at s
        call    ReadInt                 ; read int; value placed in eax
        mov     [I20],eax               ; store eax at t
        call    ReadInt                 ; read int; value placed in eax
        mov     [I21],eax               ; store eax at u
        call    ReadInt                 ; read int; value placed in eax
        mov     [I22],eax               ; store eax at v
        call    ReadInt                 ; read int; value placed in eax
        mov     [I23],eax               ; store eax at w
        call    ReadInt                 ; read int; value placed in eax
        mov     [I24],eax               ; store eax at x
        call    ReadInt                 ; read int; value placed in eax
        mov     [I25],eax               ; store eax at y
        call    ReadInt                 ; read int; value placed in eax
        mov     [I26],eax               ; store eax at z
        mov     eax,[I1]                ; AReg = a
        add     eax,[I2]                ; AReg = a + b
        add     eax,[I3]                ; AReg = T0 + c
        add     eax,[I4]                ; AReg = T0 + d
        add     eax,[I5]                ; AReg = T0 + e
        add     eax,[I6]                ; AReg = T0 + f
        add     eax,[I7]                ; AReg = T0 + g
        add     eax,[I8]                ; AReg = T0 + h
        add     eax,[I9]                ; AReg = T0 + i
        add     eax,[I10]               ; AReg = T0 + j
        add     eax,[I11]               ; AReg = T0 + k
        add     eax,[I12]               ; AReg = T0 + l
        add     eax,[I13]               ; AReg = T0 + m
        add     eax,[I14]               ; AReg = T0 + n
        add     eax,[I15]               ; AReg = T0 + o
        add     eax,[I16]               ; AReg = T0 + p
        add     eax,[I17]               ; AReg = T0 + q
        add     eax,[I18]               ; AReg = T0 + r
        add     eax,[I19]               ; AReg = T0 + s
        add     eax,[I20]               ; AReg = T0 + t
        add     eax,[I21]               ; AReg = T0 + u
        add     eax,[I22]               ; AReg = T0 + v
        add     eax,[I23]               ; AReg = T0 + w
        add     eax,[I24]               ; AReg = T0 + x
        add     eax,[I25]               ; AReg = T0 + y
        add     eax,[I26]               ; AReg = T0 + z
        mov     [I0],eax                ; sum = AReg
        mov     eax,[I1]                ; load a in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I2]                ; load b in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I3]                ; load c in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I4]                ; load d in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I5]                ; load e in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I6]                ; load f in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I7]                ; load g in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I8]                ; load h in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I9]                ; load i in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I10]               ; load j in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I11]               ; load k in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I12]               ; load l in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I13]               ; load m in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I14]               ; load n in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I15]               ; load o in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I16]               ; load p in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I17]               ; load q in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I18]               ; load r in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I19]               ; load s in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I20]               ; load t in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I21]               ; load u in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I22]               ; load v in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I23]               ; load w in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I24]               ; load x in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I25]               ; load y in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I26]               ; load z in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        mov     eax,[I0]                ; load sum in eax
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        Exit    {0}                     

SECTION .data                           

SECTION .bss                            
I1      resd    1                       ; a
I2      resd    1                       ; b
I3      resd    1                       ; c
I4      resd    1                       ; d
I5      resd    1                       ; e
I6      resd    1                       ; f
I7      resd    1                       ; g
I8      resd    1                       ; h
I9      resd    1                       ; i
I10     resd    1                       ; j
I11     resd    1                       ; k
I12     resd    1                       ; l
I13     resd    1                       ; m
I14     resd    1                       ; n
I15     resd    1                       ; o
I16     resd    1                       ; p
I17     resd    1                       ; q
I18     resd    1                       ; r
I19     resd    1                       ; s
I0      resd    1                       ; sum
I20     resd    1                       ; t
I21     resd    1                       ; u
I22     resd    1                       ; v
I23     resd    1                       ; w
I24     resd    1                       ; x
I25     resd    1                       ; y
I26     resd    1                       ; z

; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no174

_start:                                 
        mov     eax,[B0]                ; AReg = x
        cmp     eax,[B0]                ; compare x and x
        jne     .L0                     ; if x <> x then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L1                     ; unconditionally jump
.L0:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L1:                                    
        mov     [B1],eax                ; d = AReg
        mov     eax,[B0]                ; AReg = x
        cmp     eax,[FALSE]             ; compare x and false
        jne     .L2                     ; if x <> false then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L3                     ; unconditionally jump
.L2:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L3:                                    
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        cmp     eax,[B0]                ; compare false and x
        jne     .L4                     ; if false <> x then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L5                     ; unconditionally jump
.L4:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L5:                                    
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        cmp     eax,[FALSE]             ; compare false and false
        jne     .L6                     ; if false <> false then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L7                     ; unconditionally jump
.L6:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L7:                                    
        mov     [B1],eax                ; d = AReg
        mov     eax,[B0]                ; AReg = x
        cmp     eax,[TRUE]              ; compare x and true
        jne     .L8                     ; if x <> true then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L9                     ; unconditionally jump
.L8:                                    
        mov     eax,[TRUE]              ; set eax to TRUE
.L9:                                    
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        cmp     eax,[B0]                ; compare false and x
        jne     .L10                    ; if false <> x then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L11                    ; unconditionally jump
.L10:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L11:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        cmp     eax,[FALSE]             ; compare false and false
        jne     .L12                    ; if false <> false then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L13                    ; unconditionally jump
.L12:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L13:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        cmp     eax,[TRUE]              ; compare false and true
        jne     .L14                    ; if false <> true then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L15                    ; unconditionally jump
.L14:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L15:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[TRUE]              ; AReg = true
        cmp     eax,[FALSE]             ; compare true and false
        jne     .L16                    ; if true <> false then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L17                    ; unconditionally jump
.L16:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L17:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[TRUE]              ; AReg = true
        cmp     eax,[TRUE]              ; compare true and true
        jne     .L18                    ; if true <> true then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L19                    ; unconditionally jump
.L18:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L19:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[TRUE]              ; AReg = true
        cmp     eax,[TRUE]              ; compare true and true
        jne     .L20                    ; if true <> true then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L21                    ; unconditionally jump
.L20:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L21:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[TRUE]              ; AReg = true
        cmp     eax,[FALSE]             ; compare true and false
        jne     .L22                    ; if true <> false then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L23                    ; unconditionally jump
.L22:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L23:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        cmp     eax,[TRUE]              ; compare false and true
        jne     .L24                    ; if false <> true then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L25                    ; unconditionally jump
.L24:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L25:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[FALSE]             ; AReg = false
        cmp     eax,[FALSE]             ; compare false and false
        jne     .L26                    ; if false <> false then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L27                    ; unconditionally jump
.L26:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L27:                                   
        mov     [B1],eax                ; d = AReg
        call    ReadInt                 ; read int; value placed in eax
        mov     [I1],eax                ; store eax at a
        call    ReadInt                 ; read int; value placed in eax
        mov     [I2],eax                ; store eax at b
        mov     eax,[I1]                ; AReg = a
        neg     eax                     ; AReg = -AReg
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I2]                ; AReg = b
        neg     eax                     ; AReg = -AReg
        cmp     eax,[T0]                ; compare T1 and T0
        jne     .L28                    ; if T0 <> T1 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L29                    ; unconditionally jump
.L28:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L29:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I1]                ; AReg = a
        neg     eax                     ; AReg = -AReg
        cmp     eax,[I2]                ; compare T0 and b
        jne     .L30                    ; if T0 <> b then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L31                    ; unconditionally jump
.L30:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L31:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I1]                ; AReg = a
        neg     eax                     ; AReg = -AReg
        cmp     eax,[I2]                ; compare T0 and b
        jne     .L32                    ; if T0 <> b then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L33                    ; unconditionally jump
.L32:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L33:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I2]                ; AReg = b
        neg     eax                     ; AReg = -AReg
        cmp     eax,[I1]                ; compare T0 and a
        jne     .L34                    ; if a <> T0 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L35                    ; unconditionally jump
.L34:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L35:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I1]                ; AReg = a
        cmp     eax,[I2]                ; compare a and b
        jne     .L36                    ; if a <> b then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L37                    ; unconditionally jump
.L36:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L37:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I1]                ; AReg = a
        cmp     eax,[I2]                ; compare a and b
        jne     .L38                    ; if a <> b then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L39                    ; unconditionally jump
.L38:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L39:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I2]                ; AReg = b
        neg     eax                     ; AReg = -AReg
        cmp     eax,[I1]                ; compare T0 and a
        jne     .L40                    ; if a <> T0 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L41                    ; unconditionally jump
.L40:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L41:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I1]                ; AReg = a
        cmp     eax,[I2]                ; compare a and b
        jne     .L42                    ; if a <> b then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L43                    ; unconditionally jump
.L42:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L43:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I1]                ; AReg = a
        cmp     eax,[I2]                ; compare a and b
        jne     .L44                    ; if a <> b then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L45                    ; unconditionally jump
.L44:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L45:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I3]                ; AReg = -4301
        cmp     eax,[I3]                ; compare -4301 and -4301
        jne     .L46                    ; if -4301 <> -4301 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L47                    ; unconditionally jump
.L46:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L47:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I3]                ; AReg = -4301
        cmp     eax,[I4]                ; compare -4301 and 4301
        jne     .L48                    ; if -4301 <> 4301 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L49                    ; unconditionally jump
.L48:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L49:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I3]                ; AReg = -4301
        cmp     eax,[I4]                ; compare -4301 and 4301
        jne     .L50                    ; if -4301 <> 4301 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L51                    ; unconditionally jump
.L50:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L51:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I4]                ; AReg = 4301
        cmp     eax,[I3]                ; compare 4301 and -4301
        jne     .L52                    ; if 4301 <> -4301 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L53                    ; unconditionally jump
.L52:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L53:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I4]                ; AReg = 4301
        cmp     eax,[I4]                ; compare 4301 and 4301
        jne     .L54                    ; if 4301 <> 4301 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L55                    ; unconditionally jump
.L54:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L55:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I4]                ; AReg = 4301
        cmp     eax,[I4]                ; compare 4301 and 4301
        jne     .L56                    ; if 4301 <> 4301 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L57                    ; unconditionally jump
.L56:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L57:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I4]                ; AReg = 4301
        cmp     eax,[I3]                ; compare 4301 and -4301
        jne     .L58                    ; if 4301 <> -4301 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L59                    ; unconditionally jump
.L58:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L59:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I4]                ; AReg = 4301
        cmp     eax,[I4]                ; compare 4301 and 4301
        jne     .L60                    ; if 4301 <> 4301 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L61                    ; unconditionally jump
.L60:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L61:                                   
        mov     [B1],eax                ; d = AReg
        mov     eax,[I4]                ; AReg = 4301
        cmp     eax,[I4]                ; compare 4301 and 4301
        jne     .L62                    ; if 4301 <> 4301 then jump to set eax to TRUE
        mov     eax,[FALSE]             ; else set eax to FALSE
        jmp     .L63                    ; unconditionally jump
.L62:                                   
        mov     eax,[TRUE]              ; set eax to TRUE
.L63:                                   
        mov     [B1],eax                ; d = AReg

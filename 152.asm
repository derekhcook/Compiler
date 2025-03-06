; Trey Fleming, Derek Cook       Fri Dec  6 00:01:57 2024
%INCLUDE "Along32.inc"
%INCLUDE "Macros_Along.inc"

SECTION .text                           
global  _start                          ; program stage1no152

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
        mov     eax,[I1]                ; AReg = a
        add     eax,[I2]                ; AReg = a + b
        mov     [T0],eax                ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T1],eax                ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T2],eax                ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T3],eax                ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T4],eax                ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T5],eax                ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T6],eax                ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T7],eax                ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T8],eax                ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T9],eax                ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T10],eax               ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T11],eax               ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T12],eax               ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T13],eax               ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T14],eax               ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T15],eax               ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T16],eax               ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T17],eax               ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T18],eax               ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T19],eax               ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T20],eax               ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T21],eax               ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T22],eax               ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T23],eax               ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T24],eax               ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T25],eax               ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T26],eax               ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T27],eax               ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T28],eax               ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T29],eax               ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T30],eax               ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T31],eax               ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T32],eax               ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T33],eax               ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T34],eax               ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T35],eax               ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T36],eax               ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T37],eax               ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T38],eax               ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T39],eax               ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T40],eax               ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T41],eax               ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T42],eax               ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T43],eax               ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T44],eax               ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T45],eax               ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T46],eax               ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T47],eax               ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T48],eax               ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T49],eax               ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T50],eax               ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T51],eax               ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T52],eax               ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T53],eax               ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T54],eax               ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T55],eax               ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T56],eax               ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T57],eax               ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T58],eax               ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T59],eax               ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T60],eax               ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T61],eax               ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T62],eax               ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T63],eax               ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T64],eax               ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T65],eax               ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T66],eax               ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T67],eax               ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T68],eax               ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T69],eax               ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T70],eax               ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T71],eax               ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T72],eax               ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T73],eax               ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T74],eax               ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T75],eax               ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T76],eax               ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T77],eax               ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T78],eax               ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T79],eax               ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T80],eax               ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T81],eax               ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T82],eax               ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T83],eax               ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T84],eax               ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T85],eax               ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T86],eax               ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T87],eax               ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T88],eax               ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T89],eax               ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T90],eax               ; deassign AReg
        mov     eax,[I3]                ; AReg = c
        add     eax,[I4]                ; AReg = c + d
        mov     [T91],eax               ; deassign AReg
        mov     eax,[I5]                ; AReg = e
        add     eax,[I6]                ; AReg = e + f
        mov     [T92],eax               ; deassign AReg
        mov     eax,[I7]                ; AReg = g
        add     eax,[I8]                ; AReg = g + h
        mov     [T93],eax               ; deassign AReg
        mov     eax,[I9]                ; AReg = i
        add     eax,[I10]               ; AReg = i + j
        mov     [T94],eax               ; deassign AReg
        mov     eax,[I11]               ; AReg = k
        add     eax,[I12]               ; AReg = k + l
        mov     [T95],eax               ; deassign AReg
        mov     eax,[I13]               ; AReg = m
        add     eax,[I14]               ; AReg = m + n
        mov     [T96],eax               ; deassign AReg
        mov     eax,[I15]               ; AReg = o
        add     eax,[I16]               ; AReg = o + p
        mov     [T97],eax               ; deassign AReg
        mov     eax,[I17]               ; AReg = q
        add     eax,[I18]               ; AReg = q + r
        mov     [T98],eax               ; deassign AReg
        mov     eax,[I19]               ; AReg = s
        add     eax,[I20]               ; AReg = s + t
        mov     [T99],eax               ; deassign AReg
        mov     eax,[I21]               ; AReg = u
        add     eax,[I22]               ; AReg = u + v
        mov     [T100],eax              ; deassign AReg
        mov     eax,[I1]                ; AReg = a
        add     eax,[I2]                ; AReg = a + b
        add     eax,[T100]              ; AReg = T101 + T100
        add     eax,[T99]               ; AReg = T100 + T99
        add     eax,[T98]               ; AReg = T99 + T98
        add     eax,[T97]               ; AReg = T98 + T97
        add     eax,[T96]               ; AReg = T97 + T96
        add     eax,[T95]               ; AReg = T96 + T95
        add     eax,[T94]               ; AReg = T95 + T94
        add     eax,[T93]               ; AReg = T94 + T93
        add     eax,[T92]               ; AReg = T93 + T92
        add     eax,[T91]               ; AReg = T92 + T91
        add     eax,[T90]               ; AReg = T91 + T90
        add     eax,[T89]               ; AReg = T90 + T89
        add     eax,[T88]               ; AReg = T89 + T88
        add     eax,[T87]               ; AReg = T88 + T87
        add     eax,[T86]               ; AReg = T87 + T86
        add     eax,[T85]               ; AReg = T86 + T85
        add     eax,[T84]               ; AReg = T85 + T84
        add     eax,[T83]               ; AReg = T84 + T83
        add     eax,[T82]               ; AReg = T83 + T82
        add     eax,[T81]               ; AReg = T82 + T81
        add     eax,[T80]               ; AReg = T81 + T80
        add     eax,[T79]               ; AReg = T80 + T79
        add     eax,[T78]               ; AReg = T79 + T78
        add     eax,[T77]               ; AReg = T78 + T77
        add     eax,[T76]               ; AReg = T77 + T76
        add     eax,[T75]               ; AReg = T76 + T75
        add     eax,[T74]               ; AReg = T75 + T74
        add     eax,[T73]               ; AReg = T74 + T73
        add     eax,[T72]               ; AReg = T73 + T72
        add     eax,[T71]               ; AReg = T72 + T71
        add     eax,[T70]               ; AReg = T71 + T70
        add     eax,[T69]               ; AReg = T70 + T69
        add     eax,[T68]               ; AReg = T69 + T68
        add     eax,[T67]               ; AReg = T68 + T67
        add     eax,[T66]               ; AReg = T67 + T66
        add     eax,[T65]               ; AReg = T66 + T65
        add     eax,[T64]               ; AReg = T65 + T64
        add     eax,[T63]               ; AReg = T64 + T63
        add     eax,[T62]               ; AReg = T63 + T62
        add     eax,[T61]               ; AReg = T62 + T61
        add     eax,[T60]               ; AReg = T61 + T60
        add     eax,[T59]               ; AReg = T60 + T59
        add     eax,[T58]               ; AReg = T59 + T58
        add     eax,[T57]               ; AReg = T58 + T57
        add     eax,[T56]               ; AReg = T57 + T56
        add     eax,[T55]               ; AReg = T56 + T55
        add     eax,[T54]               ; AReg = T55 + T54
        add     eax,[T53]               ; AReg = T54 + T53
        add     eax,[T52]               ; AReg = T53 + T52
        add     eax,[T51]               ; AReg = T52 + T51
        add     eax,[T50]               ; AReg = T51 + T50
        add     eax,[T49]               ; AReg = T50 + T49
        add     eax,[T48]               ; AReg = T49 + T48
        add     eax,[T47]               ; AReg = T48 + T47
        add     eax,[T46]               ; AReg = T47 + T46
        add     eax,[T45]               ; AReg = T46 + T45
        add     eax,[T44]               ; AReg = T45 + T44
        add     eax,[T43]               ; AReg = T44 + T43
        add     eax,[T42]               ; AReg = T43 + T42
        add     eax,[T41]               ; AReg = T42 + T41
        add     eax,[T40]               ; AReg = T41 + T40
        add     eax,[T39]               ; AReg = T40 + T39
        add     eax,[T38]               ; AReg = T39 + T38
        add     eax,[T37]               ; AReg = T38 + T37
        add     eax,[T36]               ; AReg = T37 + T36
        add     eax,[T35]               ; AReg = T36 + T35
        add     eax,[T34]               ; AReg = T35 + T34
        add     eax,[T33]               ; AReg = T34 + T33
        add     eax,[T32]               ; AReg = T33 + T32
        add     eax,[T31]               ; AReg = T32 + T31
        add     eax,[T30]               ; AReg = T31 + T30
        add     eax,[T29]               ; AReg = T30 + T29
        add     eax,[T28]               ; AReg = T29 + T28
        add     eax,[T27]               ; AReg = T28 + T27
        add     eax,[T26]               ; AReg = T27 + T26
        add     eax,[T25]               ; AReg = T26 + T25
        add     eax,[T24]               ; AReg = T25 + T24
        add     eax,[T23]               ; AReg = T24 + T23
        add     eax,[T22]               ; AReg = T23 + T22
        add     eax,[T21]               ; AReg = T22 + T21
        add     eax,[T20]               ; AReg = T21 + T20
        add     eax,[T19]               ; AReg = T20 + T19
        add     eax,[T18]               ; AReg = T19 + T18
        add     eax,[T17]               ; AReg = T18 + T17
        add     eax,[T16]               ; AReg = T17 + T16
        add     eax,[T15]               ; AReg = T16 + T15
        add     eax,[T14]               ; AReg = T15 + T14
        add     eax,[T13]               ; AReg = T14 + T13
        add     eax,[T12]               ; AReg = T13 + T12
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
        mov     [I0],eax                ; sum = AReg
        call    WriteInt                ; write int in eax to standard out
        call    Crlf                    ; write \r\n to standard out
        Exit    {0}                     

SECTION .data                           

SECTION .bss                            
T0      resd    1                       ; T0
T1      resd    1                       ; T1
T10     resd    1                       ; T10
T100    resd    1                       ; T100
T11     resd    1                       ; T11
T12     resd    1                       ; T12
T13     resd    1                       ; T13
T14     resd    1                       ; T14
T15     resd    1                       ; T15
T16     resd    1                       ; T16
T17     resd    1                       ; T17
T18     resd    1                       ; T18
T19     resd    1                       ; T19
T2      resd    1                       ; T2
T20     resd    1                       ; T20
T21     resd    1                       ; T21
T22     resd    1                       ; T22
T23     resd    1                       ; T23
T24     resd    1                       ; T24
T25     resd    1                       ; T25
T26     resd    1                       ; T26
T27     resd    1                       ; T27
T28     resd    1                       ; T28
T29     resd    1                       ; T29
T3      resd    1                       ; T3
T30     resd    1                       ; T30
T31     resd    1                       ; T31
T32     resd    1                       ; T32
T33     resd    1                       ; T33
T34     resd    1                       ; T34
T35     resd    1                       ; T35
T36     resd    1                       ; T36
T37     resd    1                       ; T37
T38     resd    1                       ; T38
T39     resd    1                       ; T39
T4      resd    1                       ; T4
T40     resd    1                       ; T40
T41     resd    1                       ; T41
T42     resd    1                       ; T42
T43     resd    1                       ; T43
T44     resd    1                       ; T44
T45     resd    1                       ; T45
T46     resd    1                       ; T46
T47     resd    1                       ; T47
T48     resd    1                       ; T48
T49     resd    1                       ; T49
T5      resd    1                       ; T5
T50     resd    1                       ; T50
T51     resd    1                       ; T51
T52     resd    1                       ; T52
T53     resd    1                       ; T53
T54     resd    1                       ; T54
T55     resd    1                       ; T55
T56     resd    1                       ; T56
T57     resd    1                       ; T57
T58     resd    1                       ; T58
T59     resd    1                       ; T59
T6      resd    1                       ; T6
T60     resd    1                       ; T60
T61     resd    1                       ; T61
T62     resd    1                       ; T62
T63     resd    1                       ; T63
T64     resd    1                       ; T64
T65     resd    1                       ; T65
T66     resd    1                       ; T66
T67     resd    1                       ; T67
T68     resd    1                       ; T68
T69     resd    1                       ; T69
T7      resd    1                       ; T7
T70     resd    1                       ; T70
T71     resd    1                       ; T71
T72     resd    1                       ; T72
T73     resd    1                       ; T73
T74     resd    1                       ; T74
T75     resd    1                       ; T75
T76     resd    1                       ; T76
T77     resd    1                       ; T77
T78     resd    1                       ; T78
T79     resd    1                       ; T79
T8      resd    1                       ; T8
T80     resd    1                       ; T80
T81     resd    1                       ; T81
T82     resd    1                       ; T82
T83     resd    1                       ; T83
T84     resd    1                       ; T84
T85     resd    1                       ; T85
T86     resd    1                       ; T86
T87     resd    1                       ; T87
T88     resd    1                       ; T88
T89     resd    1                       ; T89
T9      resd    1                       ; T9
T90     resd    1                       ; T90
T91     resd    1                       ; T91
T92     resd    1                       ; T92
T93     resd    1                       ; T93
T94     resd    1                       ; T94
T95     resd    1                       ; T95
T96     resd    1                       ; T96
T97     resd    1                       ; T97
T98     resd    1                       ; T98
T99     resd    1                       ; T99
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

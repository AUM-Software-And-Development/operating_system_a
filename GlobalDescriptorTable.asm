GDTStart:

.nullDescriptor:

dd 0x0
dd 0x0

.codeSegmentBlock:

dw 0xffff
dw 0x0
db 0x0
db 10011010b
db 11001111b
db 0x0

.dataSegmentBlock:

dw 0xffff
dw 0x0
db 0x0
db 10010010b
db 11001111b
db 0x0

GDTEnd:

GDTPointer:
dw GDTEnd - GDTStart - 1
dd GDTStart

CodeSegmentGDT: equ GDTStart.codeSegmentBlock - GDTStart
DataSegmentGDT: equ GDTStart.dataSegmentBlock - GDTStart
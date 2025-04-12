.segment "CHARROM"
	
	.byte $00, $00, $00, $00, $00		; $00	
	.byte $01, $00, $00, $00, $00		; $01	
	.byte $02, $00, $00, $00, $00		; $02	
	.byte $03, $00, $00, $00, $00		; $03	
	.byte $04, $00, $00, $00, $00		; $04	
	.byte $05, $00, $00, $00, $00		; $05	
	.byte $06, $00, $00, $00, $00		; $06	
	.byte $07, $00, $00, $00, $00		; $07	
	.byte $08, $00, $00, $00, $00		; $08	
	.byte $09, $00, $00, $00, $00		; $09	
	.byte $0a, $00, $00, $00, $00		; $0a	
	.byte $0b, $00, $00, $00, $00		; $0b	
	.byte $0c, $00, $00, $00, $00		; $0c	
	.byte $0d, $00, $00, $00, $00		; $0d	
	.byte $0e, $00, $00, $00, $00		; $0e	
	.byte $0f, $00, $00, $00, $00		; $0f	
	.byte $00, $00, $00, $00, $00		; $10	
	.byte $11, $00, $00, $00, $00		; $11	
	.byte $12, $00, $00, $00, $00		; $12	
	.byte $13, $00, $00, $00, $00		; $13	
	.byte $14, $00, $00, $00, $00		; $14	
	.byte $15, $00, $00, $00, $00		; $15	
	.byte $16, $00, $00, $00, $00		; $16	
	.byte $17, $00, $00, $00, $00		; $17	
	.byte $18, $00, $00, $00, $00		; $18	
	.byte $19, $00, $00, $00, $00		; $19	
	.byte $1a, $00, $00, $00, $00		; $1a	
	.byte $1b, $00, $00, $00, $00		; $1b	
	.byte $1c, $00, $00, $00, $00		; $1c	
	.byte $1d, $00, $00, $00, $00		; $1d	
	.byte $1e, $00, $00, $00, $00		; $1e	
	.byte $1f, $00, $00, $00, $00		; $1f	

	.byte $00, $00, $00, $00, $00		; $20	space
	.byte $00, $00, $5F, $00, $00		; $21	!
	.byte $00, $07, $00, $07, $00		; $22	"
	.byte $14, $7F, $14, $7F, $14		; $23	#
	.byte $24, $2A, $7F, $2A, $12		; $24	$
	.byte $63, $13, $08, $64, $63		; $25	%
	.byte $36, $49, $55, $22, $50		; $26	&
	.byte $00, $00, $07, $00, $00		; $27	'
	.byte $00, $00, $3E, $41, $00		; $28	(
	.byte $00, $41, $3E, $00, $00		; $29	)
	.byte $14, $08, $3E, $08, $14		; $2a	*
	.byte $08, $08, $3E, $08, $08		; $2b	+
	.byte $00, $50, $30, $00, $00		; $2c	,
	.byte $08, $08, $08, $08, $08		; $2d	-
	.byte $00, $60, $60, $00, $00		; $2e	.
	.byte $60, $10, $08, $04, $03		; $2f	/
	.byte $3E, $51, $49, $45, $3E		; $30	0
	.byte $00, $42, $7F, $40, $00		; $31	1
	.byte $42, $61, $51, $49, $46		; $32	2
	.byte $21, $41, $45, $4B, $31		; $33	3
	.byte $18, $14, $12, $11, $7f		; $34	4
	.byte $27, $45, $45, $45, $39		; $35	5
	.byte $3C, $4A, $49, $49, $30		; $36	6
	.byte $01, $01, $79, $05, $03		; $37	7
	.byte $36, $49, $49, $49, $36		; $38	8
	.byte $06, $49, $49, $29, $1E		; $39	9
	.byte $00, $36, $36, $00, $00		; $3a	:
	.byte $00, $56, $36, $00, $00		; $3b	;
	.byte $00, $08, $14, $22, $41		; $3c	<
	.byte $14, $14, $14, $14, $14		; $3d	=
	.byte $41, $22, $14, $08, $00		; $3e	>
	.byte $02, $01, $51, $09, $06		; $3f	?

	.byte $3E, $41, $4D, $53, $5E		; $40	@
	.byte $7E, $09, $09, $09, $7E		; $41	A
	.byte $7F, $49, $49, $49, $36		; $42	B
	.byte $3E, $41, $41, $41, $22		; $43	C
	.byte $7F, $41, $41, $41, $3E		; $44	D
	.byte $7F, $49, $49, $49, $41		; $45	E
	.byte $7F, $09, $09, $09, $01		; $46	F
	.byte $3E, $41, $41, $49, $7A		; $47	G
	.byte $7F, $08, $08, $08, $7F		; $48	H
	.byte $00, $41, $7F, $41, $00		; $49	I
	.byte $20, $40, $41, $3F, $01		; $4a	J
	.byte $7F, $08, $14, $22, $41		; $4b	K
	.byte $7F, $40, $40, $40, $40		; $4c	L
	.byte $7F, $04, $08, $04, $7F		; $4d	M
	.byte $7F, $04, $08, $10, $7F		; $4e	N
	.byte $3E, $41, $41, $41, $3E		; $4f	O
	.byte $7F, $09, $09, $09, $06		; $50	P
	.byte $3E, $41, $51, $21, $5E		; $51	Q
	.byte $7F, $09, $19, $29, $46		; $52	R
	.byte $46, $49, $49, $49, $31		; $53	S
	.byte $01, $01, $7F, $01, $01		; $54	T
	.byte $3F, $40, $40, $40, $3F		; $55	U
	.byte $1F, $20, $40, $20, $1F		; $56	V
	.byte $3F, $40, $20, $40, $3F		; $57	W
	.byte $63, $14, $08, $14, $63		; $58	X
	.byte $03, $04, $78, $04, $03		; $59	Y
	.byte $61, $51, $49, $45, $43		; $5a	Z
	.byte $00, $7F, $41, $41, $00		; $5b	[
	.byte $03, $04, $08, $10, $60		; $5c	\
	.byte $00, $41, $41, $7F, $00		; $5d	]
	.byte $00, $02, $01, $02, $00		; $5e	^
	.byte $40, $40, $40, $40, $40		; $5f	_

	.byte $00, $00, $07, $00, $00		; $60	'
	.byte $20, $54, $54, $54, $78		; $61	a
	.byte $7F, $48, $44, $44, $78		; $62	b
	.byte $38, $44, $44, $44, $20		; $63	c
	.byte $38, $44, $44, $44, $7F		; $64	d
	.byte $38, $54, $54, $54, $18		; $65	e
	.byte $08, $7E, $09, $01, $02		; $66	f
	.byte $08, $54, $54, $54, $3C		; $67	g
	.byte $7F, $08, $04, $04, $78		; $68	h
	.byte $00, $48, $7D, $40, $00		; $69	i
	.byte $40, $40, $40, $3D, $00		; $6a	j
	.byte $7F, $10, $28, $44, $00		; $6b	k
	.byte $00, $01, $3F, $40, $00		; $6c	l
	.byte $7C, $04, $78, $04, $78		; $6d	m
	.byte $7C, $08, $04, $04, $78		; $6e	n
	.byte $38, $44, $44, $44, $38		; $6f	o
	.byte $7C, $14, $14, $14, $08		; $70	p
	.byte $08, $14, $14, $14, $7C		; $71	q
	.byte $7C, $04, $04, $04, $08		; $72	r
	.byte $48, $54, $54, $54, $20		; $73	s
	.byte $04, $3F, $44, $40, $20		; $74	t
	.byte $3C, $40, $40, $20, $7C		; $75	u
	.byte $1C, $20, $40, $20, $1C		; $76	v
	.byte $3C, $40, $30, $40, $3C		; $77	w
	.byte $44, $28, $10, $28, $44		; $78	x
	.byte $0C, $50, $50, $50, $3C		; $79	y
	.byte $44, $64, $54, $4C, $44		; $7a	z
	.byte $00, $08, $36, $41, $00		; $7b	{	
	.byte $00, $00, $7F, $00, $00		; $7c	|
	.byte $00, $41, $36, $08, $00		; $7d	}
	.byte $10, $08, $08, $10, $08		; $7e	~
	.byte $78, $44, $42, $44, $78		; $7f	DEL
	
	.byte $80, $00, $00, $00, $00		; $80	
	.byte $81, $00, $00, $00, $00		; $81	
	.byte $82, $00, $00, $00, $00		; $82	
	.byte $83, $00, $00, $00, $00		; $83	
	.byte $84, $00, $00, $00, $00		; $84	
	.byte $85, $00, $00, $00, $00		; $85	
	.byte $86, $00, $00, $00, $00		; $86	
	.byte $87, $00, $00, $00, $00		; $87	
	.byte $88, $00, $00, $00, $00		; $88	
	.byte $89, $00, $00, $00, $00		; $89	
	.byte $8a, $00, $00, $00, $00		; $8a	
	.byte $8b, $00, $00, $00, $00		; $8b	
	.byte $8c, $00, $00, $00, $00		; $8c	
	.byte $8d, $00, $00, $00, $00		; $8d	
	.byte $8e, $00, $00, $00, $00		; $8e	
	.byte $8f, $00, $00, $00, $00		; $8f	
	.byte $90, $00, $00, $00, $00		; $90	
	.byte $91, $00, $00, $00, $00		; $91	
	.byte $92, $00, $00, $00, $00		; $92	
	.byte $93, $00, $00, $00, $00		; $93	
	.byte $94, $00, $00, $00, $00		; $94	
	.byte $95, $00, $00, $00, $00		; $95	
	.byte $96, $00, $00, $00, $00		; $96	
	.byte $97, $00, $00, $00, $00		; $97	
	.byte $98, $00, $00, $00, $00		; $98	
	.byte $99, $00, $00, $00, $00		; $99	
	.byte $9a, $00, $00, $00, $00		; $9a	
	.byte $9b, $00, $00, $00, $00		; $9b	
	.byte $9c, $00, $00, $00, $00		; $9c	
	.byte $9d, $00, $00, $00, $00		; $9d	
	.byte $9e, $00, $00, $00, $00		; $9e	
	.byte $9f, $00, $00, $00, $00		; $9f	
	
	.byte $a0, $00, $00, $00, $00		; $a0	
	.byte $a1, $00, $00, $00, $00		; $a1	
	.byte $a2, $00, $00, $00, $00		; $a2	
	.byte $a3, $00, $00, $00, $00		; $a3	
	.byte $a4, $00, $00, $00, $00		; $a4	
	.byte $a5, $00, $00, $00, $00		; $a5	
	.byte $a6, $00, $00, $00, $00		; $a6	
	.byte $a7, $00, $00, $00, $00		; $a7	
	.byte $a8, $00, $00, $00, $00		; $a8	
	.byte $a9, $00, $00, $00, $00		; $a9	
	.byte $aa, $00, $00, $00, $00		; $aa	
	.byte $ab, $00, $00, $00, $00		; $ab	
	.byte $ac, $00, $00, $00, $00		; $ac	
	.byte $ad, $00, $00, $00, $00		; $ad	
	.byte $ae, $00, $00, $00, $00		; $ae	
	.byte $af, $00, $00, $00, $00		; $af	
	.byte $b0, $00, $00, $00, $00		; $b0	
	.byte $b1, $00, $00, $00, $00		; $b1	
	.byte $b2, $00, $00, $00, $00		; $b2	
	.byte $b3, $00, $00, $00, $00		; $b3	
	.byte $b4, $00, $00, $00, $00		; $b4	
	.byte $b5, $00, $00, $00, $00		; $b5	
	.byte $b6, $00, $00, $00, $00		; $b6	
	.byte $b7, $00, $00, $00, $00		; $b7	
	.byte $b8, $00, $00, $00, $00		; $b8	
	.byte $b9, $00, $00, $00, $00		; $b9	
	.byte $ba, $00, $00, $00, $00		; $ba	
	.byte $bb, $00, $00, $00, $00		; $bb	
	.byte $bc, $00, $00, $00, $00		; $bc	
	.byte $bd, $00, $00, $00, $00		; $bd	
	.byte $be, $00, $00, $00, $00		; $be	
	.byte $bf, $00, $00, $00, $00		; $bf	
	
	.byte $c0, $00, $00, $00, $00		; $c0	
	.byte $c1, $00, $00, $00, $00		; $c1	
	.byte $c2, $00, $00, $00, $00		; $c2	
	.byte $c3, $00, $00, $00, $00		; $c3	
	.byte $c4, $00, $00, $00, $00		; $c4	
	.byte $c5, $00, $00, $00, $00		; $c5	
	.byte $c6, $00, $00, $00, $00		; $c6	
	.byte $c7, $00, $00, $00, $00		; $c7	
	.byte $c8, $00, $00, $00, $00		; $c8	
	.byte $c9, $00, $00, $00, $00		; $c9	
	.byte $ca, $00, $00, $00, $00		; $ca	
	.byte $cb, $00, $00, $00, $00		; $cb	
	.byte $cc, $00, $00, $00, $00		; $cc	
	.byte $cd, $00, $00, $00, $00		; $cd	
	.byte $ce, $00, $00, $00, $00		; $ce	
	.byte $cf, $00, $00, $00, $00		; $cf	
	.byte $d0, $00, $00, $00, $00		; $d0	
	.byte $d1, $00, $00, $00, $00		; $d1	
	.byte $d2, $00, $00, $00, $00		; $d2	
	.byte $d3, $00, $00, $00, $00		; $d3	
	.byte $d4, $00, $00, $00, $00		; $d4	
	.byte $d5, $00, $00, $00, $00		; $d5	
	.byte $d6, $00, $00, $00, $00		; $d6	
	.byte $d7, $00, $00, $00, $00		; $d7	
	.byte $d8, $00, $00, $00, $00		; $d8	
	.byte $d9, $00, $00, $00, $00		; $d9	
	.byte $da, $00, $00, $00, $00		; $da	
	.byte $db, $00, $00, $00, $00		; $db	
	.byte $dc, $00, $00, $00, $00		; $dc	
	.byte $dd, $00, $00, $00, $00		; $dd	
	.byte $de, $00, $00, $00, $00		; $de	
	.byte $df, $00, $00, $00, $00		; $df	
	
	.byte $e0, $00, $00, $00, $00		; $e0	
	.byte $e1, $00, $00, $00, $00		; $e1	
	.byte $e2, $00, $00, $00, $00		; $e2	
	.byte $e3, $00, $00, $00, $00		; $e3	
	.byte $e4, $00, $00, $00, $00		; $e4	
	.byte $e5, $00, $00, $00, $00		; $e5	
	.byte $e6, $00, $00, $00, $00		; $e6	
	.byte $e7, $00, $00, $00, $00		; $e7	
	.byte $e8, $00, $00, $00, $00		; $e8	
	.byte $e9, $00, $00, $00, $00		; $e9	
	.byte $ea, $00, $00, $00, $00		; $ea	
	.byte $eb, $00, $00, $00, $00		; $eb	
	.byte $ec, $00, $00, $00, $00		; $ec	
	.byte $ed, $00, $00, $00, $00		; $ed	
	.byte $ee, $00, $00, $00, $00		; $ee	
	.byte $ef, $00, $00, $00, $00		; $ef	
	.byte $f0, $00, $00, $00, $00		; $f0	
	.byte $f1, $00, $00, $00, $00		; $f1	
	.byte $f2, $00, $00, $00, $00		; $f2	
	.byte $f3, $00, $00, $00, $00		; $f3	
	.byte $f4, $00, $00, $00, $00		; $f4	
	.byte $f5, $00, $00, $00, $00		; $f5	
	.byte $f6, $00, $00, $00, $00		; $f6	
	.byte $f7, $00, $00, $00, $00		; $f7	
	.byte $f8, $00, $00, $00, $00		; $f8	
	.byte $f9, $00, $00, $00, $00		; $f9	
	.byte $fa, $00, $00, $00, $00		; $fa	
	.byte $fb, $00, $00, $00, $00		; $fb	
	.byte $fc, $00, $00, $00, $00		; $fc	
	.byte $fd, $00, $00, $00, $00		; $fd	
	.byte $fe, $00, $00, $00, $00		; $fe	
	.byte $ff, $00, $00, $00, $FF		; $ff	
	
; $D500 decoding scan codes to ascii values for normal keys
; For unknown characters ? is sent back
	
	.byte $3F ; $00
	.byte $3F ; $01 F9
	.byte $3F ; $02
	.byte $03 ; $03 F5
	.byte $3F ; $04 F3
	.byte $3F ; $05 F1
	.byte $3F ; $06 F2
	.byte $3F ; $07 F12
	.byte $3F ; $08
	.byte $3F ; $09 F10
	.byte $3F ; $0a F8
	.byte $3F ; $0b F6
	.byte $3F ; $0c F4
	.byte $09 ; $0d	tab
	.byte $30 ; $0e HU: 0
	.byte $3F ; $0f
	.byte $3F ; $10
	.byte $3F ; $11			left alt + right alt E0
	.byte $3F ; $12			left shift
	.byte $3F ; $13
	.byte $3F ; $14			left ctrl + right ctrl E0
	.byte $51 ; $15 q
	.byte $31 ; $16 1
	.byte $3F ; $17
	.byte $3F ; $18
	.byte $3F ; $19
	.byte $59 ; $1a HU: y
	.byte $53 ; $1b s
	.byte $41 ; $1c	a
	.byte $57 ; $1d w
	.byte $32 ; $1e 2
	.byte $3F ; $1f
	
	.byte $3F ; $20
	.byte $43 ; $21 c
	.byte $58 ; $22 x
	.byte $44 ; $23 d
	.byte $45 ; $24 e
	.byte $34 ; $25 4
	.byte $33 ; $26 3
	.byte $3F ; $27
	.byte $3F ; $28
	.byte $20 ; $29 space
	.byte $56 ; $2a v
	.byte $46 ; $2b f
	.byte $54 ; $2c t
	.byte $52 ; $2d r
	.byte $35 ; $2e 5
	.byte $3F ; $2f
	.byte $3F ; $30
	.byte $4E ; $31 n
	.byte $42 ; $32 b
	.byte $48 ; $33 h
	.byte $47 ; $34 g
	.byte $5A ; $35 HU: z
	.byte $36 ; $36 6
	.byte $3F ; $37
	.byte $3F ; $38
	.byte $3F ; $39
	.byte $4D ; $3a m
	.byte $4A ; $3b j
	.byte $55 ; $3c u
	.byte $37 ; $3d 7
	.byte $38 ; $3e 8
	.byte $3F ; $3f
	
	.byte $3F ; $40
	.byte $2C ; $41 ,
	.byte $4B ; $42 k
	.byte $49 ; $43 i
	.byte $4F ; $44 o
	.byte $30 ; $45 0
	.byte $39 ; $46 9
	.byte $3F ; $47
	.byte $3F ; $48
	.byte $2E ; $49 .
	.byte $2F ; $4a /
	.byte $4C ; $4b l
	.byte $3B ; $4c ;
	.byte $50 ; $4d p
	.byte $2D ; $4e -
	.byte $3F ; $4f
	.byte $3F ; $50
	.byte $3F ; $51
	.byte $27 ; $52 '
	.byte $3F ; $53 
	.byte $5B ; $54 [
	.byte $3D ; $55 =
	.byte $3F ; $56
	.byte $3F ; $57
	.byte $3F ; $58			caps lock
	.byte $3F ; $59			right shift
	.byte $0D ; $5a	enter
	.byte $5D ; $5b ]
	.byte $3F ; $5c
	.byte $5C ; $5d \
	.byte $3F ; $5e
	.byte $3F ; $5f
	
	.byte $3F ; $60
	.byte $3F ; $61
	.byte $3F ; $62
	.byte $3F ; $63
	.byte $3F ; $64
	.byte $3F ; $65
	.byte $5F ; $66 backspace ($08 ascii, $5F for wozmon)
	.byte $3F ; $67
	.byte $3F ; $68
	.byte $31 ; $69 1
	.byte $3F ; $6a 
	.byte $34 ; $6b 4		left arrow E0
	.byte $37 ; $6c 7
	.byte $3F ; $6d 
	.byte $3F ; $6e
	.byte $3F ; $6f
	.byte $30 ; $70 0		ins E0
	.byte $2E ; $71 .		del E0
	.byte $32 ; $72 2		down arrow E0
	.byte $35 ; $73 5
	.byte $36 ; $74 6		right arrow E0
	.byte $38 ; $75 8		up arrow E0
	.byte $1B ; $76	esc
	.byte $3F ; $77
	.byte $3F ; $78 F11
	.byte $2B ; $79 +
	.byte $33 ; $7a 3
	.byte $2D ; $7b -
	.byte $2A ; $7c *
	.byte $39 ; $7d 9
	.byte $3F ; $7e
	.byte $3F ; $7f
	
	.byte $3F ; $80
	.byte $3F ; $81
	.byte $3F ; $82
	.byte $3F ; $83 F7
	.byte $3F ; $84
	.byte $3F ; $85
	.byte $3F ; $86
	.byte $3F ; $87
	.byte $3F ; $88
	.byte $3F ; $89
	.byte $3F ; $8a
	.byte $3F ; $8b
	.byte $3F ; $8c
	.byte $3F ; $8d
	.byte $3F ; $8e
	.byte $3F ; $8f
	.byte $3F ; $90
	.byte $3F ; $91
	.byte $3F ; $92
	.byte $3F ; $93
	.byte $3F ; $94
	.byte $3F ; $95
	.byte $3F ; $96
	.byte $3F ; $97
	.byte $3F ; $98
	.byte $3F ; $99
	.byte $3F ; $9a
	.byte $3F ; $9b
	.byte $3F ; $9c
	.byte $3F ; $9d
	.byte $3F ; $9e
	.byte $3F ; $9f
	
	.byte $3F ; $a0
	.byte $3F ; $a1
	.byte $3F ; $a2
	.byte $3F ; $a3
	.byte $3F ; $a4
	.byte $3F ; $a5
	.byte $3F ; $a6
	.byte $3F ; $a7
	.byte $3F ; $a8
	.byte $3F ; $a9
	.byte $3F ; $aa
	.byte $3F ; $ab
	.byte $3F ; $ac
	.byte $3F ; $ad
	.byte $3F ; $ae
	.byte $3F ; $af
	.byte $3F ; $b0
	.byte $3F ; $b1
	.byte $3F ; $b2
	.byte $3F ; $b3
	.byte $3F ; $b4
	.byte $3F ; $b5
	.byte $3F ; $b6
	.byte $3F ; $b7
	.byte $3F ; $b8
	.byte $3F ; $b9
	.byte $3F ; $ba
	.byte $3F ; $bb
	.byte $3F ; $bc
	.byte $3F ; $bd
	.byte $3F ; $be
	.byte $3F ; $bf
	
	.byte $3F ; $c0
	.byte $3F ; $c1
	.byte $3F ; $c2
	.byte $3F ; $c3
	.byte $3F ; $c4
	.byte $3F ; $c5
	.byte $3F ; $c6
	.byte $3F ; $c7
	.byte $3F ; $c8
	.byte $3F ; $c9
	.byte $3F ; $ca
	.byte $3F ; $cb
	.byte $3F ; $cc
	.byte $3F ; $cd
	.byte $3F ; $ce
	.byte $3F ; $cf
	.byte $3F ; $d0
	.byte $3F ; $d1
	.byte $3F ; $d2
	.byte $3F ; $d3
	.byte $3F ; $d4
	.byte $3F ; $d5
	.byte $3F ; $d6
	.byte $3F ; $d7
	.byte $3F ; $d8
	.byte $3F ; $d9
	.byte $3F ; $da
	.byte $3F ; $db
	.byte $3F ; $dc
	.byte $3F ; $dd
	.byte $3F ; $de
	.byte $3F ; $df
	
	.byte $3F ; $e0
	.byte $3F ; $e1
	.byte $3F ; $e2
	.byte $3F ; $e3
	.byte $3F ; $e4
	.byte $3F ; $e5
	.byte $3F ; $e6
	.byte $3F ; $e7
	.byte $3F ; $e8
	.byte $3F ; $e9
	.byte $3F ; $ea
	.byte $3F ; $eb
	.byte $3F ; $ec
	.byte $3F ; $ed
	.byte $3F ; $ee
	.byte $3F ; $ef
	.byte $3F ; $f0
	.byte $3F ; $f1
	.byte $3F ; $f2
	.byte $3F ; $f3
	.byte $3F ; $f4
	.byte $3F ; $f5
	.byte $3F ; $f6
	.byte $3F ; $f7
	.byte $3F ; $f8
	.byte $3F ; $f9
	.byte $3F ; $fa
	.byte $3F ; $fb
	.byte $3F ; $fc
	.byte $3F ; $fd
	.byte $3F ; $fe
	.byte $3F ; $ff

; $D600 decoding scan codes to ascii values for shifted keys
; For unknown characters ? is sent back
	
	.byte $3F ; $00
	.byte $3F ; $01 F9
	.byte $3F ; $02
	.byte $03 ; $03 F5
	.byte $3F ; $04 F3
	.byte $3F ; $05 F1
	.byte $3F ; $06 F2
	.byte $3F ; $07 F12
	.byte $3F ; $08
	.byte $3F ; $09 F10
	.byte $3F ; $0a F8
	.byte $3F ; $0b F6
	.byte $3F ; $0c F4
	.byte $09 ; $0d	tab
	.byte $60 ; $0e '
	.byte $3F ; $0f
	.byte $3F ; $10
	.byte $3F ; $11			left alt + right alt E0
	.byte $3F ; $12			left shift
	.byte $3F ; $13
	.byte $3F ; $14			left ctrl + right ctrl E0
	.byte $51 ; $15 Q
	.byte $27 ; $16 HU: '
	.byte $3F ; $17
	.byte $3F ; $18
	.byte $3F ; $19
	.byte $59 ; $1a HU: Y
	.byte $53 ; $1b S
	.byte $41 ; $1c	A
	.byte $57 ; $1d W
	.byte $22 ; $1e HU: "
	.byte $3F ; $1f
	
	.byte $3F ; $20
	.byte $43 ; $21 C
	.byte $58 ; $22 X
	.byte $44 ; $23 D
	.byte $45 ; $24 E
	.byte $21 ; $25 HU: !
	.byte $2B ; $26 HU: +
	.byte $3F ; $27
	.byte $3F ; $28
	.byte $20 ; $29 space
	.byte $56 ; $2a V
	.byte $46 ; $2b F
	.byte $54 ; $2c T
	.byte $52 ; $2d R
	.byte $25 ; $2e HU: %
	.byte $3F ; $2f
	.byte $3F ; $30
	.byte $4E ; $31 N
	.byte $42 ; $32 B
	.byte $48 ; $33 H
	.byte $47 ; $34 G
	.byte $5A ; $35 HU: Z
	.byte $2F ; $36 HU: /
	.byte $3F ; $37
	.byte $3F ; $38
	.byte $3F ; $39
	.byte $4D ; $3a M
	.byte $4A ; $3b J
	.byte $55 ; $3c U
	.byte $3D ; $3d HU: =
	.byte $28 ; $3e HU: (
	.byte $3F ; $3f
	
	.byte $3F ; $40
	.byte $3F ; $41 HU: ?
	.byte $4B ; $42 K
	.byte $49 ; $43 I
	.byte $4F ; $44 O
	.byte $30 ; $45 0
	.byte $29 ; $46 HU: )
	.byte $3F ; $47
	.byte $3F ; $48
	.byte $3A ; $49 HU: :
	.byte $5F ; $4a HU: _
	.byte $4C ; $4b L
	.byte $3B ; $4c ;
	.byte $50 ; $4d P
	.byte $5F ; $4e HU: _
	.byte $3F ; $4f
	.byte $3F ; $50
	.byte $3F ; $51
	.byte $27 ; $52 '
	.byte $3F ; $53 
	.byte $5B ; $54 [
	.byte $3D ; $55 =
	.byte $3F ; $56
	.byte $3F ; $57
	.byte $3F ; $58			caps lock
	.byte $3F ; $59			right shift
	.byte $0D ; $5a	enter
	.byte $5D ; $5b ]
	.byte $3F ; $5c
	.byte $5C ; $5d \
	.byte $3F ; $5e
	.byte $3F ; $5f
	
	.byte $3F ; $60
	.byte $3F ; $61
	.byte $3F ; $62
	.byte $3F ; $63
	.byte $3F ; $64
	.byte $3F ; $65
	.byte $5F ; $66 backspace ($08 ascii, $5F for wozmon)
	.byte $3F ; $67
	.byte $3F ; $68
	.byte $31 ; $69 1
	.byte $3F ; $6a 
	.byte $34 ; $6b 4		left arrow E0
	.byte $37 ; $6c 7
	.byte $3F ; $6d 
	.byte $3F ; $6e
	.byte $3F ; $6f
	.byte $30 ; $70 0		ins E0
	.byte $2E ; $71 .		del E0
	.byte $32 ; $72 2		down arrow E0
	.byte $35 ; $73 5
	.byte $36 ; $74 6		right arrow E0
	.byte $38 ; $75 8		up arrow E0
	.byte $1B ; $76	esc
	.byte $3F ; $77
	.byte $3F ; $78 F11
	.byte $2B ; $79 +
	.byte $33 ; $7a 3
	.byte $2D ; $7b -
	.byte $2A ; $7c *
	.byte $39 ; $7d 9
	.byte $3F ; $7e
	.byte $3F ; $7f
	
	.byte $3F ; $80
	.byte $3F ; $81
	.byte $3F ; $82
	.byte $3F ; $83 F7
	.byte $3F ; $84
	.byte $3F ; $85
	.byte $3F ; $86
	.byte $3F ; $87
	.byte $3F ; $88
	.byte $3F ; $89
	.byte $3F ; $8a
	.byte $3F ; $8b
	.byte $3F ; $8c
	.byte $3F ; $8d
	.byte $3F ; $8e
	.byte $3F ; $8f
	.byte $3F ; $90
	.byte $3F ; $91
	.byte $3F ; $92
	.byte $3F ; $93
	.byte $3F ; $94
	.byte $3F ; $95
	.byte $3F ; $96
	.byte $3F ; $97
	.byte $3F ; $98
	.byte $3F ; $99
	.byte $3F ; $9a
	.byte $3F ; $9b
	.byte $3F ; $9c
	.byte $3F ; $9d
	.byte $3F ; $9e
	.byte $3F ; $9f
	
	.byte $3F ; $a0
	.byte $3F ; $a1
	.byte $3F ; $a2
	.byte $3F ; $a3
	.byte $3F ; $a4
	.byte $3F ; $a5
	.byte $3F ; $a6
	.byte $3F ; $a7
	.byte $3F ; $a8
	.byte $3F ; $a9
	.byte $3F ; $aa
	.byte $3F ; $ab
	.byte $3F ; $ac
	.byte $3F ; $ad
	.byte $3F ; $ae
	.byte $3F ; $af
	.byte $3F ; $b0
	.byte $3F ; $b1
	.byte $3F ; $b2
	.byte $3F ; $b3
	.byte $3F ; $b4
	.byte $3F ; $b5
	.byte $3F ; $b6
	.byte $3F ; $b7
	.byte $3F ; $b8
	.byte $3F ; $b9
	.byte $3F ; $ba
	.byte $3F ; $bb
	.byte $3F ; $bc
	.byte $3F ; $bd
	.byte $3F ; $be
	.byte $3F ; $bf
	
	.byte $3F ; $c0
	.byte $3F ; $c1
	.byte $3F ; $c2
	.byte $3F ; $c3
	.byte $3F ; $c4
	.byte $3F ; $c5
	.byte $3F ; $c6
	.byte $3F ; $c7
	.byte $3F ; $c8
	.byte $3F ; $c9
	.byte $3F ; $ca
	.byte $3F ; $cb
	.byte $3F ; $cc
	.byte $3F ; $cd
	.byte $3F ; $ce
	.byte $3F ; $cf
	.byte $3F ; $d0
	.byte $3F ; $d1
	.byte $3F ; $d2
	.byte $3F ; $d3
	.byte $3F ; $d4
	.byte $3F ; $d5
	.byte $3F ; $d6
	.byte $3F ; $d7
	.byte $3F ; $d8
	.byte $3F ; $d9
	.byte $3F ; $da
	.byte $3F ; $db
	.byte $3F ; $dc
	.byte $3F ; $dd
	.byte $3F ; $de
	.byte $3F ; $df
	
	.byte $3F ; $e0
	.byte $3F ; $e1
	.byte $3F ; $e2
	.byte $3F ; $e3
	.byte $3F ; $e4
	.byte $3F ; $e5
	.byte $3F ; $e6
	.byte $3F ; $e7
	.byte $3F ; $e8
	.byte $3F ; $e9
	.byte $3F ; $ea
	.byte $3F ; $eb
	.byte $3F ; $ec
	.byte $3F ; $ed
	.byte $3F ; $ee
	.byte $3F ; $ef
	.byte $3F ; $f0
	.byte $3F ; $f1
	.byte $3F ; $f2
	.byte $3F ; $f3
	.byte $3F ; $f4
	.byte $3F ; $f5
	.byte $3F ; $f6
	.byte $3F ; $f7
	.byte $3F ; $f8
	.byte $3F ; $f9
	.byte $3F ; $fa
	.byte $3F ; $fb
	.byte $3F ; $fc
	.byte $3F ; $fd
	.byte $3F ; $fe
	.byte $3F ; $ff

; $D700 decoding scan codes to ascii values for right alted keys
; For unknown characters ? is sent back
	
	.byte $3F ; $00
	.byte $3F ; $01 F9
	.byte $3F ; $02
	.byte $03 ; $03 F5
	.byte $3F ; $04 F3
	.byte $3F ; $05 F1
	.byte $3F ; $06 F2
	.byte $3F ; $07 F12
	.byte $3F ; $08
	.byte $3F ; $09 F10
	.byte $3F ; $0a F8
	.byte $3F ; $0b F6
	.byte $3F ; $0c F4
	.byte $09 ; $0d	tab
	.byte $60 ; $0e '
	.byte $3F ; $0f
	.byte $3F ; $10
	.byte $3F ; $11			left alt + right alt E0
	.byte $3F ; $12			left shift
	.byte $3F ; $13
	.byte $3F ; $14			left ctrl + right ctrl E0
	.byte $51 ; $15 Q
	.byte $27 ; $16 HU: '
	.byte $3F ; $17
	.byte $3F ; $18
	.byte $3F ; $19
	.byte $59 ; $1a HU: Y
	.byte $53 ; $1b S
	.byte $41 ; $1c	A
	.byte $57 ; $1d W
	.byte $22 ; $1e HU: "
	.byte $3F ; $1f
	
	.byte $3F ; $20
	.byte $43 ; $21 C
	.byte $58 ; $22 X
	.byte $44 ; $23 D
	.byte $45 ; $24 E
	.byte $21 ; $25 HU: !
	.byte $2B ; $26 HU: +
	.byte $3F ; $27
	.byte $3F ; $28
	.byte $20 ; $29 space
	.byte $56 ; $2a V
	.byte $46 ; $2b F
	.byte $54 ; $2c T
	.byte $52 ; $2d R
	.byte $25 ; $2e HU: %
	.byte $3F ; $2f
	.byte $3F ; $30
	.byte $4E ; $31 N
	.byte $42 ; $32 B
	.byte $48 ; $33 H
	.byte $47 ; $34 G
	.byte $5A ; $35 HU: Z
	.byte $2F ; $36 HU: /
	.byte $3F ; $37
	.byte $3F ; $38
	.byte $3F ; $39
	.byte $4D ; $3a M
	.byte $4A ; $3b J
	.byte $55 ; $3c U
	.byte $3D ; $3d HU: =
	.byte $28 ; $3e HU: (
	.byte $3F ; $3f
	
	.byte $3F ; $40
	.byte $3F ; $41 HU: ?
	.byte $4B ; $42 K
	.byte $49 ; $43 I
	.byte $4F ; $44 O
	.byte $30 ; $45 0
	.byte $29 ; $46 HU: )
	.byte $3F ; $47
	.byte $3F ; $48
	.byte $3A ; $49 HU: :
	.byte $5F ; $4a HU: _
	.byte $4C ; $4b L
	.byte $24 ; $4c HU: $
	.byte $50 ; $4d P
	.byte $5F ; $4e HU: _
	.byte $3F ; $4f
	.byte $3F ; $50
	.byte $3F ; $51
	.byte $27 ; $52 '
	.byte $3F ; $53 
	.byte $5B ; $54 [
	.byte $3D ; $55 =
	.byte $3F ; $56
	.byte $3F ; $57
	.byte $3F ; $58			caps lock
	.byte $3F ; $59			right shift
	.byte $0D ; $5a	enter
	.byte $5D ; $5b ]
	.byte $3F ; $5c
	.byte $5C ; $5d \
	.byte $3F ; $5e
	.byte $3F ; $5f
	
	.byte $3F ; $60
	.byte $3F ; $61
	.byte $3F ; $62
	.byte $3F ; $63
	.byte $3F ; $64
	.byte $3F ; $65
	.byte $5F ; $66 backspace ($08 ascii, $5F for wozmon)
	.byte $3F ; $67
	.byte $3F ; $68
	.byte $31 ; $69 1
	.byte $3F ; $6a 
	.byte $34 ; $6b 4		left arrow E0
	.byte $37 ; $6c 7
	.byte $3F ; $6d 
	.byte $3F ; $6e
	.byte $3F ; $6f
	.byte $30 ; $70 0		ins E0
	.byte $2E ; $71 .		del E0
	.byte $32 ; $72 2		down arrow E0
	.byte $35 ; $73 5
	.byte $36 ; $74 6		right arrow E0
	.byte $38 ; $75 8		up arrow E0
	.byte $1B ; $76	esc
	.byte $3F ; $77
	.byte $3F ; $78 F11
	.byte $2B ; $79 +
	.byte $33 ; $7a 3
	.byte $2D ; $7b -
	.byte $2A ; $7c *
	.byte $39 ; $7d 9
	.byte $3F ; $7e
	.byte $3F ; $7f
	
	.byte $3F ; $80
	.byte $3F ; $81
	.byte $3F ; $82
	.byte $3F ; $83 F7
	.byte $3F ; $84
	.byte $3F ; $85
	.byte $3F ; $86
	.byte $3F ; $87
	.byte $3F ; $88
	.byte $3F ; $89
	.byte $3F ; $8a
	.byte $3F ; $8b
	.byte $3F ; $8c
	.byte $3F ; $8d
	.byte $3F ; $8e
	.byte $3F ; $8f
	.byte $3F ; $90
	.byte $3F ; $91
	.byte $3F ; $92
	.byte $3F ; $93
	.byte $3F ; $94
	.byte $3F ; $95
	.byte $3F ; $96
	.byte $3F ; $97
	.byte $3F ; $98
	.byte $3F ; $99
	.byte $3F ; $9a
	.byte $3F ; $9b
	.byte $3F ; $9c
	.byte $3F ; $9d
	.byte $3F ; $9e
	.byte $3F ; $9f
	
	.byte $3F ; $a0
	.byte $3F ; $a1
	.byte $3F ; $a2
	.byte $3F ; $a3
	.byte $3F ; $a4
	.byte $3F ; $a5
	.byte $3F ; $a6
	.byte $3F ; $a7
	.byte $3F ; $a8
	.byte $3F ; $a9
	.byte $3F ; $aa
	.byte $3F ; $ab
	.byte $3F ; $ac
	.byte $3F ; $ad
	.byte $3F ; $ae
	.byte $3F ; $af
	.byte $3F ; $b0
	.byte $3F ; $b1
	.byte $3F ; $b2
	.byte $3F ; $b3
	.byte $3F ; $b4
	.byte $3F ; $b5
	.byte $3F ; $b6
	.byte $3F ; $b7
	.byte $3F ; $b8
	.byte $3F ; $b9
	.byte $3F ; $ba
	.byte $3F ; $bb
	.byte $3F ; $bc
	.byte $3F ; $bd
	.byte $3F ; $be
	.byte $3F ; $bf
	
	.byte $3F ; $c0
	.byte $3F ; $c1
	.byte $3F ; $c2
	.byte $3F ; $c3
	.byte $3F ; $c4
	.byte $3F ; $c5
	.byte $3F ; $c6
	.byte $3F ; $c7
	.byte $3F ; $c8
	.byte $3F ; $c9
	.byte $3F ; $ca
	.byte $3F ; $cb
	.byte $3F ; $cc
	.byte $3F ; $cd
	.byte $3F ; $ce
	.byte $3F ; $cf
	.byte $3F ; $d0
	.byte $3F ; $d1
	.byte $3F ; $d2
	.byte $3F ; $d3
	.byte $3F ; $d4
	.byte $3F ; $d5
	.byte $3F ; $d6
	.byte $3F ; $d7
	.byte $3F ; $d8
	.byte $3F ; $d9
	.byte $3F ; $da
	.byte $3F ; $db
	.byte $3F ; $dc
	.byte $3F ; $dd
	.byte $3F ; $de
	.byte $3F ; $df
	
	.byte $3F ; $e0
	.byte $3F ; $e1
	.byte $3F ; $e2
	.byte $3F ; $e3
	.byte $3F ; $e4
	.byte $3F ; $e5
	.byte $3F ; $e6
	.byte $3F ; $e7
	.byte $3F ; $e8
	.byte $3F ; $e9
	.byte $3F ; $ea
	.byte $3F ; $eb
	.byte $3F ; $ec
	.byte $3F ; $ed
	.byte $3F ; $ee
	.byte $3F ; $ef
	.byte $3F ; $f0
	.byte $3F ; $f1
	.byte $3F ; $f2
	.byte $3F ; $f3
	.byte $3F ; $f4
	.byte $3F ; $f5
	.byte $3F ; $f6
	.byte $3F ; $f7
	.byte $3F ; $f8
	.byte $3F ; $f9
	.byte $3F ; $fa
	.byte $3F ; $fb
	.byte $3F ; $fc
	.byte $3F ; $fd
	.byte $3F ; $fe
	.byte $3F ; $ff

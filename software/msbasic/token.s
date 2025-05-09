		init_token_tables

		keyword_rts "END", END
		keyword_rts "FOR", FOR
		keyword_rts "NEXT", NEXT
		keyword_rts "DATA", DATA
		keyword_rts "INPUT", INPUT
		keyword_rts "DIM", DIM
		keyword_rts "READ", READ
		keyword_rts "LET", LET
		keyword_rts "GOTO", GOTO, TOKEN_GOTO
		keyword_rts "RUN", RUN
		keyword_rts "IF", IF
		keyword_rts "RESTORE", RESTORE
		keyword_rts "GOSUB", GOSUB, TOKEN_GOSUB
		keyword_rts "RETURN", POP
		keyword_rts "REM", REM, TOKEN_REM
		keyword_rts "STOP", STOP
		keyword_rts "ON", ON
		keyword_rts "WAIT", WAIT
		keyword_rts "LOAD", LOAD
		keyword_rts "SAVE", SAVE
		keyword_rts "DEF", DEF
		keyword_rts "POKE", POKE
		keyword_rts "PRINT", PRINT, TOKEN_PRINT
		keyword_rts "CONT", CONT
		keyword_rts "LIST", LIST
		keyword_rts "CLEAR", CLEAR
		keyword_rts "GET", GET
		keyword_rts "NEW", NEW

		count_tokens

		keyword	"TAB(", TOKEN_TAB
		keyword	"TO", TOKEN_TO
		keyword	"FN", TOKEN_FN
		keyword	"SPC(", TOKEN_SPC
		keyword	"THEN", TOKEN_THEN
		keyword	"NOT", TOKEN_NOT
		keyword	"STEP", TOKEN_STEP
		keyword	"+", TOKEN_PLUS
		keyword	"-", TOKEN_MINUS
		keyword	"*"
		keyword	"/"
		keyword	"^"
		keyword	"AND"
		keyword	"OR"
		keyword	">", TOKEN_GREATER
		keyword	"=", TOKEN_EQUAL
		keyword	"<"

        .segment "VECTORS"
UNFNC:

		keyword_addr "SGN", SGN, TOKEN_SGN
		keyword_addr "INT", INT
		keyword_addr "ABS", ABS
		keyword_addr "USR", USR, TOKEN_USR
		keyword_addr "FRE", FRE
		keyword_addr "POS", POS
		keyword_addr "SQR", SQR
		keyword_addr "RND", RND
		keyword_addr "LOG", LOG
		keyword_addr "EXP", EXP
.segment "VECTORS"
UNFNC_COS:
		keyword_addr "COS", COS
.segment "VECTORS"
UNFNC_SIN:
		keyword_addr "SIN", SIN
.segment "VECTORS"
UNFNC_TAN:
		keyword_addr "TAN", TAN
.segment "VECTORS"
UNFNC_ATN:
		keyword_addr "ATN", ATN
		keyword_addr "PEEK", PEEK
		keyword_addr "LEN", LEN
		keyword_addr "STR$", STR
		keyword_addr "VAL", VAL
		keyword_addr "ASC", ASC
		keyword_addr "CHR$", CHRSTR
		keyword_addr "LEFT$", LEFTSTR, TOKEN_LEFTSTR
		keyword_addr "RIGHT$", RIGHTSTR
		keyword_addr "MID$", MIDSTR
		keyword	"GO", TOKEN_GO

        .segment "KEYWORDS"
		.byte   0

        .segment "VECTORS"
MATHTBL:
        .byte   $79
        .word   FADDT-1
        .byte   $79
        .word   FSUBT-1
        .byte   $7B
        .word   FMULTT-1
        .byte   $7B
        .word   FDIVT-1
        .byte   $7F
        .word   FPWRT-1
        .byte   $50
        .word   TAND-1
        .byte   $46
        .word   OR-1
        .byte   $7D
        .word   NEGOP-1
        .byte   $5A
        .word   EQUOP-1
        .byte   $64
        .word   RELOPS-1

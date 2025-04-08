.segment "INIT"

; ----------------------------------------------------------------------------
PR_WRITTEN_BY:
        lda     #<QT_WRITTEN_BY
        ldy     #>QT_WRITTEN_BY
        jsr     STROUT

COLD_START:

        jsr		LCD_CLS

        ldx     #$FF
        stx     CURLIN+1
        ldx     #$FB

        txs

        lda     #<COLD_START
        ldy     #>COLD_START
        sta     GORESTART+1
        sty     GORESTART+2

        sta     GOSTROUT+1
        sty     GOSTROUT+2
        lda     #<AYINT
        ldy     #>AYINT
        sta     GOAYINT
        sty     GOAYINT+1
        lda     #<GIVAYF
        ldy     #>GIVAYF
        sta     GOGIVEAYF
        sty     GOGIVEAYF+1

        lda     #$4C
        sta     GORESTART

        sta     GOSTROUT
        sta     JMPADRS

        sta     USR

        lda     #<IQERR
        ldy     #>IQERR
        
        sta     USR+1
        sty     USR+2
		
        lda     #WIDTH
        sta     Z17
        lda     #WIDTH2
        sta     Z18


        ldx     #GENERIC_CHRGET_END-GENERIC_CHRGET-1 ; XXX

L4098:
        lda     GENERIC_CHRGET-1,x
        sta     CHRGET-1,x
        dex
        bne     L4098

        lda     #$03
        sta     DSCLEN

        txa
        sta     SHIFTSIGNEXT
  
        sta     LASTPT+1
  
        pha
        sta     Z14

        lda     #$03
        sta     DSCLEN
        jsr     CRDO

        inx
        stx     INPUTBUFFER-3
        stx     INPUTBUFFER-4

        ldx     #TEMPST
        stx     TEMPPT

        lda     #<QT_MEMORY_SIZE
        ldy     #>QT_MEMORY_SIZE
        jsr     STROUT

        jsr     NXIN

        stx     TXTPTR
        sty     TXTPTR+1
        jsr     CHRGET

        tay
        bne     L40EE

.ifndef CBM2
  .ifndef BARNA
        lda     #<RAMSTART2
  .endif
.endif

        ldy     #>RAMSTART2

        sta     TXTTAB
        sty     TXTTAB+1

        sta     LINNUM
        sty     LINNUM+1

  		tay

L40D7:
        inc     LINNUM
        bne     L40DD
        inc     LINNUM+1

		bmi     L40FA

L40DD:
        lda     #$55 ; 01010101 / 10101010

        sta     (LINNUM),y
        cmp     (LINNUM),y
        bne     L40FA
        asl     a
        sta     (LINNUM),y
        cmp     (LINNUM),y 

        bne     L40FA; new: slower
        beq     L40D7

L40EE:
        jsr     CHRGOT
        jsr     LINGET
        tay
        beq     L40FA
        jmp     SYNERR

L40FA:
        lda     LINNUM
        ldy     LINNUM+1
        sta     MEMSIZ
        sty     MEMSIZ+1
        
        sta     FRETOP
        sty     FRETOP+1

L4106:

        lda     #<QT_TERMINAL_WIDTH
        ldy     #>QT_TERMINAL_WIDTH
        jsr     STROUT
        jsr     NXIN

        stx     TXTPTR
        sty     TXTPTR+1
        jsr     CHRGET
        tay
        beq     L4136
        jsr     LINGET
        lda     LINNUM+1
        bne     L4106
        lda     LINNUM
        cmp     #$10
        bcc     L4106
L2829:
        sta     Z17
L4129:
        sbc     #$0E

        bcs     L4129
        eor     #$FF

        sbc     #$0C

        clc
        adc     Z17
        sta     Z18

L4136:
        ldx     #<RAMSTART2
        ldy     #>RAMSTART2

        stx     TXTTAB
        sty     TXTTAB+1
        ldy     #$00
        tya
        sta     (TXTTAB),y
        inc     TXTTAB

        bne     L4192
        inc     TXTTAB+1
L4192:

        lda     TXTTAB
        ldy     TXTTAB+1
        jsr     REASON

        jsr     LCD_CLS
        lda     #<QT_BASIC
        ldy     #>QT_BASIC
        jsr     STROUT

        lda     MEMSIZ
        sec
        sbc     TXTTAB
        tax
        lda     MEMSIZ+1
        sbc     TXTTAB+1
        jsr     LINPRT
        lda     #<QT_BYTES_FREE
        ldy     #>QT_BYTES_FREE
        jsr     STROUT

        jsr     SCRTCH

        jmp     RESTART

QT_WRITTEN_BY:
        .byte   CR
        .byte   "WRITTEN BY WEILAND & GATES"
        .byte   CR,0

QT_MEMORY_SIZE:
        .byte   "MEMORY SIZE"
        .byte   0
        
QT_TERMINAL_WIDTH:
        .byte   "TERMINAL WIDTH"
        .byte   0
        
QT_BYTES_FREE:
        .byte   " BYTES FREE"
        .byte   CR,0

QT_BASIC:
        .byte   "### MSBASIC ###"
        .byte   CR,CR,0

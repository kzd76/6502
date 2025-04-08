.segment "CODE"

PRSTRING:
        jsr     STRPRT
L297E:
        jsr     CHRGOT

; ----------------------------------------------------------------------------
; "PRINT" STATEMENT
; ----------------------------------------------------------------------------

PRINT:
        beq     CRDO
PRINT2:
        beq     L29DD
        cmp     #TOKEN_TAB
        beq     L29F5
        cmp     #TOKEN_SPC

        clc	; also AppleSoft II

        beq     L29F5
        cmp     #','

        beq     L29DE
        cmp     #$3B
        beq     L2A0D
        jsr     FRMEVL
        bit     VALTYP
        bmi     PRSTRING
        jsr     FOUT
        jsr     STRLIT

        ldy     #$00
        lda     (FAC_LAST-1),y
        clc
        adc     POSX

        cmp     Z17

        bcc     L29B1
        jsr     CRDO
L29B1:

        jsr     STRPRT

        jsr     OUTSP
        bne     L297E ; branch always

L29B9:
        lda     #$00                            ; terminate line with $00
        sta     INPUTBUFFER,x
        ldx     #<(INPUTBUFFER-1)               ; set pointer to the beginning of the input buffer
        ldy     #>(INPUTBUFFER-1)

CRDO:
        lda     #CRLF_1                         ; echo a CR
        sta     POSX
        jsr     OUTDO

CRDO2:
        lda     #CRLF_2                         ; echo a LF, do we need this?
        jsr     OUTDO

PRINTNULLS:
        eor     #$FF                            ; invert A

L29DD:
        rts                                     ; go back

L29DE:
        lda     POSX
        cmp     Z18                             ; check pos with line width
        bcc     L29EA
        jsr     CRDO                            ; do we need this CR?
        jmp     L2A0D
L29EA:
        sec
L29EB:
        sbc     #$0E                            ; sustract $0F from A
        bcs     L29EB
        eor     #$FF                            ; invert A
        adc     #$01
        bne     L2A08
L29F5:
        php
        jsr     GTBYTC
        cmp     #')'
        bne     SYNERR4
        plp
        bcc     L2A09

        txa
        sbc     POSX
        bcc     L2A0D

L2A08:
        tax

L2A09:
        inx

L2A0A:
        dex
        bne     L2A13

L2A0D:
        jsr     CHRGET
        jmp     PRINT2

L2A13:
        jsr     OUTSP
        bne     L2A0A

; ----------------------------------------------------------------------------
; PRINT STRING AT (Y,A)
; ----------------------------------------------------------------------------
STROUT:
        jsr     STRLIT

; ----------------------------------------------------------------------------
; PRINT STRING AT (FACMO,FACLO)
; ----------------------------------------------------------------------------
STRPRT:
        jsr     FREFAC
        tax
        ldy     #$00
        inx
L2A22:
        dex
        beq     L29DD
        lda     (INDEX),y
        jsr     OUTDO
        iny
        cmp     #$0D
        bne     L2A22
        jsr     PRINTNULLS
        jmp     L2A22
; ----------------------------------------------------------------------------
OUTSP:
        lda     #$20
        .byte   $2C

OUTQUES:
        lda     #$3F

; ----------------------------------------------------------------------------
; PRINT CHAR FROM (A)
; ----------------------------------------------------------------------------
OUTDO:
        bit     Z14                             ; if Z14 B7 is set, don't do anything
        bmi     L2A56

        cmp     #$20			        ; if it is a space, go print it
        bcc     L2A4E
        
LCA6A:
        inc     POSX			        ; otherwise increment POSX

L2A4E:
        jsr     MONCOUT                         ; and print anything from A

L2A56:
        and     #$FF
        
LE8F2:
        rts

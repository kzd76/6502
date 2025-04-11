.segment "CODE"

; ----------------------------------------------------------------------------
; SEE IF CONTROL-C TYPED
; ----------------------------------------------------------------------------

ISCNTC:
        jsr CHRIN
        bcc not_cntc                        ; C is set by CHRIN if any key is pressed
        cmp #3
        bne not_cntc
        jmp is_cntc

not_cntc:
        rts

is_cntc:
        ; Fall through
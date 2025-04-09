; configuration
CONFIG_2A := 1

;CONFIG_NO_LINE_EDITING := 1; support for "@", "_", BEL etc.
;CONFIG_NO_CR := 1; terminal doesn't need explicit CRs on line ends
CONFIG_SCRTCH_ORDER := 2

; zero page
ZP_START1 = $30
ZP_START2 = $3A
ZP_START3 = $40
ZP_START4 = $4C

; extra/override ZP variables
USR				:= GORESTART ; XXX

; inputbuffer
INPUTBUFFER     := $0200

; constants
SPACE_FOR_GOSUB := $3E
STACK_TOP		:= $FA
WIDTH			:= 32
WIDTH2			:= 20

RAMSTART2		:= $0400

; monitor functions
CHROUT			:= ECHO
;GETIN			:= CHRIN
MONCOUT			:= ECHO
;MONRDKEY		:= CHRIN

;OPEN	:= $FFC0
;CLOSE	:= $FFC3
;CHKIN	:= $FFC6
;CHKOUT	:= $FFC9
;CLRCH	:= $FFCC
;VERIFY	:= $FFDB
;SYS		:= $FFDE
;CLALL	:= $FFE7
;LE7F3	:= $E7F3; for CBM1


;CONFIG_CBM_ALL := 1
;
;CONFIG_DATAFLG := 1
;CONFIG_EASTER_EGG := 1
;CONFIG_FILE := 1; support PRINT#, INPUT#, GET#, CMD
;
;
;CONFIG_NO_READ_Y_IS_ZERO_HACK := 1
;CONFIG_PEEK_SAVE_LINNUM := 1
;
;
;; extra/override ZP variables
;CURDVC			:= $000E
;TISTR			:= $008D
;Z96				:= $0096
;POSX			:= $00C6
;TXPSV			:= LASTOP
;
;
;; magic memory locations
;ENTROPY = $E844
;
.setcpu "65C02"
.segment "BIOS"

;-------------------------------------------------------------------------
;  Memory declaration
;-------------------------------------------------------------------------

XAML		= $24			; Last "opened" location Low
XAMH		= $25			; Last "opened" location High
STL			= $26			; Store address Low
STH			= $27			; Store address High
L			= $28			; Hex value parsing Low
H			= $29			; Hex value parsing High
YSAV		= $2A			; Used to see if hex value is given
MODE		= $2B			; $00=XAM, $7F=STOR, $AE=BLOCK XAM

CHADDRL		= $04			; 1 byte
CHADDRH		= $05			; 1 byte

PATTERN		= $06			; 1 byte
SEG			= $07			; 1 byte
CHR			= $08			; 5 byte
CHVAL		= $09			; 1 byte
CCHAR		= $0A			; 1 byte
YPOS		= $0B			; 1 byte
XPOS		= $0C			; 1 byte
ZPOS		= $0D			; 1 byte
OFFSET		= $0E			; 1 byte
LASTROW		= $0F			; 1 byte
KBDWPTR		= $10 			; 1 byte
KBDRPTR		= $11 			; 1 byte
KBDFLAG		= $12			; 1 byte


KBDBUFF 	= $0300			; Keyboard input buffer
IN			= $0400         ; Input buffer for WozMon


CHROM		= $D000			; First address of the LCD character ROM
SCROM		= $D500			; First address of the scancode to ascii ROM
SSCROM		= $D600			; First address of the shifted scancode to ascii ROM
RALTROM		= $D700			; First address of the right alted scancode to ascii ROM

KBDPB 		= $9010
KBDPBDDR 	= $9012
KBDPBCTR 	= $901C
KBDPBIFR 	= $901D
KBDPBIER 	= $901E

DBGPA 		= $9011
DBGPADDR 	= $9013

LCDPB 		= $9020
LCDPA 		= $9021
LCDPBDDR 	= $9022
LCDPADDR 	= $9023

ACIADATA	= $A000
ACIASTAT	= $A001
ACIACMD		= $A002
ACIACTRL	= $A003 

; Keyboard flags

RELEASE		= %00000001
SHIFT		= %00000010
EXTENDED	= %00000100
R_ALT		= %00001000
L_ALT		= %00010000

; LCD flags

LCDBUSY		= %10000000
LCDRESET	= %00010000
LCDOFF		= %00000010

;-------------------------------------------------------------------------
;  Constants
;-------------------------------------------------------------------------

BSCHR		= $5F			; Backspace key, arrow left key
CRCHR		= $0D			; Linebreak
ESCCHR		= $1B			; ESC key
PROMPTCHR	= $5C			; Prompt character
DOTCHR		= $2E			; Dot character
COLONCHR	= $3A			; Colon character
RUNCHR		= $52			; R character
SPACECHR	= $20			; Space character
ZEROCHR		= $30			; 0 character
NINECHR		= $39			; 9 character

;-------------------------------------------------------------------------
;  Let's get started
;
;  Remark the RESET routine is only to be entered by asserting the RESET
;  line of the system. This ensures that the data direction registers
;  are selected.
;-------------------------------------------------------------------------

RESET:
				SEI								; Disable interrupts during reset
				CLD								; Clear decimal arithmetic mode
				
				LDA		#%11111111 				; Set all pins on LCD port B to output
				STA		LCDPBDDR
				LDA		#%11111111				; Set all pins on LCD port A to output
				STA		LCDPADDR
				
				LDA		#%00000000				; Set all pins on KBD port B to input
				STA		KBDPBDDR
				
				LDA		#%11111111				; Set all pins on DBG port A to output
				STA		DBGPADDR
				
				LDA		#00
				STA		DBGPA					; Set all pins to 0 on 	 port
				STA		LCDPB					; Set all pins to 0 on LCD data port
				
				LDA		#$00
				STA		LCDPA					; Keep LCD reset low till init
				
				LDA		#$90					; Set KBDCB1 pin interrupt enabled
				STA		KBDPBIER
				
				LDA		#$10					; Set KBDCB1 interrupt on the rising edge
				STA		KBDPBCTR
				
				JSR		LCD_INIT				; Call LCD init subrutine
	
				LDA		#$55
				STA		PATTERN					; Set empty bytes as pattern
				JSR		LCD_FILL_SCREEN			; Fill screen with pattern
				LDA		#$AA
				STA		PATTERN					; Set empty bytes as pattern
				JSR		LCD_FILL_SCREEN			; Fill screen with pattern
				LDA		#$00
				STA		PATTERN					; Set empty bytes as pattern
				JSR		LCD_FILL_SCREEN			; Fill screen with pattern
				
				JSR		LCD_HOME
				
				LDA		#$00					; Set both keybuffer pointer to zero 
				STA		KBDRPTR
				STA		KBDWPTR
				STA		KBDFLAG
				
				STA		ACIASTAT				; Soft reset of ACIA
				
				LDA		#$1F					; N-8-1, 19200 baud
				STA		ACIACTRL
				
				LDA		#$0B					; No parity, no echo, no interrupts
				STA		ACIACMD
				
				CLI								; Enable interrupts after reset completed
				
				JMP		WOZMON					; Jump to WozMon

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
DEBUG:
				STA		DBGPA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_DELAY:
				PHA
				PHX
				LDX		#$2
DLOOP:
				DEX
				BNE		DLOOP
				
				PLX
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_HOME:
				PHA
				LDA		#$00
				STA		XPOS
				JSR		LCD_X_POS_ALL
				STA		YPOS
				JSR		LCD_Y_POS_ALL
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_CLS:
				PHA
				PHX
				PHY
				LDA		#$00
				STA		PATTERN					; Set empty bytes as pattern
				JSR		LCD_FILL_SCREEN			; Fill screen with pattern
				JSR		LCD_HOME
				PLY
				PLX
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_INIT:
				PHA
				LDA		#%00010000				; Enable LCD, setting the reset pin high
				STA		LCDPA
				JSR		LCD_DELAY
				LDA		#$00
				STA		XPOS
				STA		YPOS
				STA		ZPOS
				STA		OFFSET
				LDA		#$08
				STA		LASTROW
				LDA		#%00111111				; turn on display on all segments
				JSR		LCD_INSTRUCTION_ALL
				LDA		#%01000000				; set y to 0 on all segment
				JSR		LCD_INSTRUCTION_ALL
				LDA		#%10111000				; set x to 0 on all segment
				JSR		LCD_INSTRUCTION_ALL
				LDA		#%11000000				; set z to 0 on all segment
				JSR		LCD_INSTRUCTION_ALL
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_FILL_SCREEN:
				PHA
				PHX
				PHY
				LDA		#%11000000				; set z address to 0
				JSR		LCD_INSTRUCTION_ALL
				LDX		#0
LOOPX:
				STX		XPOS
				JSR		LCD_X_POS_ALL
				LDY		#0
				STY		YPOS
				JSR		LCD_Y_POS_ALL
LOOPY:
				LDA		PATTERN
				JSR		LCD_DATA_ALL
				INY
				STY		YPOS
				CPY		#64
				BNE		LOOPY
				INX
				CPX		#8
				BNE		LOOPX
				PLY
				PLX
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_WAIT:
				PHA
				LDA		#%00000000				; Port B is input
				STA		LCDPBDDR
				
				LDA		#%00010110				; Set E pin to high and read status
				STA		LCDPA
				JSR		LCD_DELAY
				
LCD_BUSY:
				LDA		#%00010010				; Set E pin to low
				STA		LCDPA
				JSR		LCD_DELAY
				LDA		#%00010110				; Set E pin to high
				STA		LCDPA
				JSR		LCD_DELAY
				LDA		LCDPB					; Read from LCD data port
				CMP		#LCDBUSY				; Check B7
				BEQ		LCD_BUSY				; If B7 set, LCD is still busy
				
				CMP		#LCDRESET				; Check B5
				BEQ		LCD_RESET				; If B5 set, LCD is in reset mode
				
				JMP		LCD_OK
				
LCD_RESET:
				LDA		#%00010000
				STA		LCDPA
				JMP 	LCD_BUSY

LCD_OK:
				LDA		#%00010010
				STA		LCDPA
				JSR		LCD_DELAY
				LDA		#%11111111				; Port B is output
				STA		LCDPBDDR
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_INSTRUCTION_ALL:
				JSR		LCD_WAIT
				STA		LCDPB
				LDA		#%00010000
				STA		LCDPA
				JSR		LCD_DELAY
				LDA		#%00010100
				STA		LCDPA
				JSR		LCD_DELAY
				LDA		#%00010000
				STA		LCDPA
				JSR		LCD_DELAY
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_DATA_ALL:
				JSR		LCD_WAIT
				STA		LCDPB
				LDA		#%00010001
				STA		LCDPA
				JSR		LCD_DELAY
				LDA		#%00010101
				STA		LCDPA
				JSR		LCD_DELAY
				LDA		#%00010001
				STA		LCDPA
				JSR		LCD_DELAY
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_SELECT_SEGMENT:
				PHA
				LDA		YPOS
				CMP		#%01000000
				BCC		S0
				CMP		#%10000000
				BCC		S1
				CMP		#%11000000
				BCS		S2
				LDA		#%00111000
				JMP		LCD_SEG_OK
S2:
				LDA		#$00
				STA		YPOS
				JSR		LCD_Y_POS_ALL
				LDA		XPOS
				INC		A
				CMP		#$08
				BNE		S3
				JSR		LCD_SCROLL
				LDA		OFFSET
				STA		LASTROW
				CMP		#$00
				BNE		S4
				LDA		#$08
				STA		LASTROW
S4:
				DEC		A
S3:
				STA		XPOS
				JSR		LCD_X_POS_ALL
				JMP		S0
S1:
				LDA		#%01011000
				JMP		LCD_SEG_OK
S0:
				LDA		#%01110000
LCD_SEG_OK:
				STA		SEG
				PLA
				RTS

; ----------------------------------------------------------------------------
; Reading back from LCD
; Value is returned in A
; ----------------------------------------------------------------------------
LCD_READMEM:
				JSR		LCD_WAIT
				LDA		#$00
				STA		LCDPBDDR
				JSR		LCD_SELECT_SEGMENT
				LDA		SEG
				ORA		#%00000011
				STA		LCDPA
				JSR		LCD_DELAY
				ORA		#%00000100
				STA		LCDPA
				PHA
				JSR		LCD_DELAY
				LDA		LCDPB
				STA		CHR
				PLA
				AND		#%11111011
				STA		LCDPA
				JSR		LCD_DELAY
				LDA		#$FF
				STA		LCDPBDDR
				INC		YPOS
				LDA		CHR
				RTS

; ----------------------------------------------------------------------------
; Scrolling up the LCD with 8 pixels
; A, X, Y is used so all is reserved in the stack
; YPOS reset to 0
; XPOS returns with previous OFFSET value
; OFFSET returns with the next top row value
; ----------------------------------------------------------------------------
LCD_SCROLL:
				PHA
				PHX
				PHY

				LDX		OFFSET
				STX		XPOS
				JSR		LCD_X_POS_ALL
; top row must be cleared first
				LDA		#$00
				STA		YPOS
				JSR		LCD_Y_POS_ALL
				LDY		#$00
E_SCROLL_Y:
				LDA		#$00
				JSR		LCD_DATA_ALL
				INY
				CPY		#64
				BNE		E_SCROLL_Y
; return back to leftmost
				LDA		#$00
				STA		YPOS
				JSR		LCD_Y_POS_ALL
; scroll up
				LDX		#$00
SCRLOOP:
				INX
				CPX		#$09
				BEQ		SCRDONE
				INC		ZPOS
				LDA		ZPOS
				AND		#%00111111				; Z max is 63
				ORA		#%11000000
				JSR		LCD_INSTRUCTION_ALL		; Set the same Z on all segments
				JMP		SCRLOOP
SCRDONE:
				LDA		ZPOS					; This might be skipped, as the lower 6 bits are used only
				CMP		#64
				BNE		SCRNOLOOP
				LDA		#$00
				STA		ZPOS
SCRNOLOOP:
				INC		OFFSET
				LDA		OFFSET
				CMP		#$08
				BNE		SCRFINISH
				LDA		#$00
				STA		OFFSET
SCRFINISH:
				PLY
				PLX
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_INSTRUCTION:
	JSR LCD_WAIT
	STA LCDPB
	JSR LCD_SELECT_SEGMENT
	LDA SEG
	STA LCDPA
	JSR LCD_DELAY
	ORA #%00000100
	STA LCDPA
	JSR LCD_DELAY
	AND #%11111011
	STA LCDPA
	JSR LCD_DELAY
	RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_DATA:
	JSR LCD_WAIT
	STA LCDPB
	JSR LCD_SELECT_SEGMENT
	LDA SEG
	ORA #%00000001
	STA LCDPA
	JSR LCD_DELAY
	ORA #%00000100
	STA LCDPA
	JSR LCD_DELAY
	AND #%11111011
	STA LCDPA
	JSR LCD_DELAY
	INC YPOS
	RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_X_POS:
				PHA
				LDA		XPOS
				AND		#%00000111				; X max is 7
				ORA		#%10111000				; set x address to 0 + x
				JSR		LCD_INSTRUCTION
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_X_POS_ALL:
				PHA
				LDA		XPOS
				AND		#%00000111				; X max is 7
				ORA		#%10111000				; set x address to 0 + x
				JSR		LCD_INSTRUCTION_ALL
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_Y_POS:
				PHA
				LDA		YPOS
				AND		#%00111111				; Y max is 63
				ORA		#%01000000
				JSR		LCD_INSTRUCTION
				PLA
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_Y_POS_ALL:
				PHA
				LDA		YPOS
				AND		#%00111111				; Y max is 63
				ORA		#%01000000
				JSR		LCD_INSTRUCTION_ALL
				PLA
				RTS

; ----------------------------------------------------------------------------
; Set or clear a pixel on the LCD
; If A contains $00 the pixel is cleared, otherwise it is set
; Y and X contains the coordinates of the pixel to be set
; ----------------------------------------------------------------------------
LCD_PLOT:
				PHA
				STY		YPOS
				TXA
				LDX		#$00
PLOTXLOOP:
				CMP		#$08
				BCC		NOMOREXLOOP
				CLC
				INX
				SBC		#$08
				JMP		PLOTXLOOP

NOMOREXLOOP:
				STX		XPOS
				TAX		
				CLC
				LDA		#$01
PLOTLOOP:
				CPX		#$00
				BEQ		PLOTREADY
				ROL		A
				DEX
				JMP		PLOTLOOP

PLOTREADY:
				STA		CHR
				JSR		LCD_Y_POS
				JSR		LCD_X_POS
				JSR		LCD_READMEM
				JSR		LCD_Y_POS
				TAY
				PLA
				BEQ		PLOTCLEAR
				TYA
				ORA		CHR
				JSR		LCD_DATA
				JMP		PLOTDONE

PLOTCLEAR:
				TYA
				EOR		CHR
				JSR		LCD_DATA

PLOTDONE:
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LCD_PRINT_CHAR:
				PHA
				PHY
				LDY		#$0
CHR_LOOP:
				LDA		CHR, Y
				JSR		LCD_DATA
				INY
				CPY		#$5
				BCC		CHR_LOOP
				LDA		#$0
				JSR		LCD_DATA
				PLY
				PLA
				RTS

; ----------------------------------------------------------------------------
; Printing an ASCII character to the screen
; CCHAR variable stores the character to be printed
; Function using A, Y, no value returned
; ----------------------------------------------------------------------------
LCD_PRINT_ASCII:
				PHY
				PHA
				LDA		CCHAR
				CMP		#CRCHR					; if it is CR, just print it
				BEQ		PRINTCR
				CMP		#$20					; if anything goes in below space
				BCC		FINISHPRINT
				CMP		#$7F					; or above del, do nothing
				BCS		FINISHPRINT
				STA		CHVAL
				LDA		#<CHROM					; low byte of the character rom address
				STA		CHADDRL
				LDY		#>CHROM					; high byte of the character rom address
				STY		CHADDRH
; ----------------------------------------------------------------------------
				LDY		#$00
CALCLOOP:										; calculating the start address of the ROM
				CLC
				LDA		CHADDRL
				ADC		CHVAL
				BCC		CARRYNO
				STA		CHADDRL
				INC		CHADDRH					; increase high address byte if carry was set
				JMP		CARRYYES
CARRYNO:
				STA		CHADDRL
CARRYYES:
				INY
				CPY		#$05
				BNE		CALCLOOP
				LDY		#$00
; ----------------------------------------------------------------------------
CHR_LOOP_2:										; printing 5x8 bits to display
				LDA		(CHADDRL),Y
				JSR 	LCD_DATA
				INY
				CPY		#$05
				BCC		CHR_LOOP_2
				LDA		#$00					; and 1x8 separator
				JSR		LCD_DATA
				JMP		FINISHPRINT
; ----------------------------------------------------------------------------
PRINTCR:										; printing CR
				LDA		#$00
				STA		YPOS
				JSR		LCD_Y_POS_ALL
				LDA		XPOS
				INC		A
				CMP		LASTROW
				BNE		NOSCROLL
				JSR		LCD_SCROLL
				LDA		OFFSET
				STA		LASTROW
				CMP		#$00
				BNE		NOTLOOPED
				LDA		#$08
				STA		LASTROW
NOTLOOPED:
				DEC		A
NOSCROLL:
				STA		XPOS
				JSR		LCD_X_POS_ALL
				LDA		#%01110000
				STA		SEG
FINISHPRINT:
				PLA
				PLY
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
CHRIN:
				PHX
				SEI
				LDA		KBDRPTR
				CMP		KBDWPTR
				CLI
				BEQ		NO_KEY_PRESSED
				LDX		KBDRPTR
				LDA		KBDBUFF, X
				JSR		ECHO
				INC		KBDRPTR
				SEC
				PLX
				RTS
				
NO_KEY_PRESSED:
				CLC
				PLX
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
LOAD:
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
SAVE:
				RTS

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
RX_WAIT:
				LDA		ACIASTAT
				AND		#$08					; Check RX buffer
				BEQ		RX_WAIT
				
				LDA		ACIADATA
				JSR		LCD_PRINT_ASCII
				JSR		TX_DATA					; echo the received character back
				JMP		RX_WAIT

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
TX_DATA:
				STA		ACIADATA
				PHA

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
TX_WAIT:
				LDA		ACIASTAT
				AND		#$10					; Check TX buffer
				BEQ		TX_WAIT
				PLA
				RTS
				

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
NMI:
				RTI

; ----------------------------------------------------------------------------
; ----------------------------------------------------------------------------
IRQ:
				PHA								; Store A and X
				TXA
				PHA
				
				LDA		KBDFLAG					; Check keyboard flag for release flag
				AND		#RELEASE
				BNE		RELEASE_MODE			; Jump out if we are in release mode
				LDA		KBDFLAG
				AND		#EXTENDED
				BNE		IRQ_READ_EXTKEY			; Jump out to extended key read
				JMP		IRQ_READ_KEY			; Otherwise jump to process the key

RELEASE_MODE:
				LDA		KBDFLAG					; Load keyboard flags
				EOR		#RELEASE				; Flip the release flag
				STA		KBDFLAG					; Store the flags back
				LDA		KBDPB					; Load the scan code to cancel the interrupt
				
				CMP		#$11
				BEQ		L_ALT_UP
				CMP		#$12					; If it is a left shift key, 
				BEQ		SHIFT_UP				; 	it is released
				CMP		#$59					; If it is a right shift key, 
				BEQ		SHIFT_UP				; 	it is released
				JMP		IRQ_EXIT

RELEASE_EXTENDED:
				LDA		KBDFLAG
				EOR		#EXTENDED
				EOR		#RELEASE
				STA		KBDFLAG
				LDA		KBDPB					; Load the scan code to cancel the interrupt

				CMP		#$11
				BEQ		R_ALT_UP
				JMP		IRQ_EXIT

R_ALT_UP:
				LDA		KBDFLAG
				EOR		#R_ALT
				STA		KBDFLAG
				JMP		IRQ_EXIT

L_ALT_UP:
				LDA		KBDFLAG
				EOR		#L_ALT
				STA		KBDFLAG
				JMP		IRQ_EXIT

SHIFT_UP:
				LDA		KBDFLAG					; Removing shift key from 
				EOR		#SHIFT					; keyboard flags as it was released
				STA		KBDFLAG
				JMP		IRQ_EXIT

IRQ_READ_EXTKEY:
				LDA		KBDPB
				CMP		#$F0
				BEQ		RELEASE_MODE
				CMP		#$E0
				BEQ		RELEASE_EXTENDED
				CMP		#$11
				BEQ		R_ALT_DOWN

				TAX

				LDA		KBDFLAG
				AND		#R_ALT
				BNE		R_ALTED_KEY				; Go to right alted keys if right alt flag active

				JMP		IRQ_EXIT

R_ALT_DOWN:
				LDA		KBDFLAG
				ORA		#R_ALT
				STA		KBDFLAG
				JMP		IRQ_EXIT

IRQ_READ_KEY:
				LDA		KBDPB					; Reading the pressed key
				CMP		#$F0
				BEQ		KEY_RELEASE				; It is a release key event
				CMP		#$E0
				BEQ		KEY_EXTENDED			; It is an extended key
				CMP		#$11
				BEQ		L_ALT_DOWN
				CMP		#$12
				BEQ		SHIFT_DOWN				; Left shift was pressed
				CMP		#$59
				BEQ		SHIFT_DOWN				; Right shift was pressed
				
				TAX								; Put the scancode to X
				LDA		KBDFLAG					; Check the flags
				AND		#SHIFT
				BNE		SHIFTED_KEY				; Go to shifted keys if shift flag active

				LDA		KBDFLAG
				AND		#L_ALT
				BNE		L_ALTED_KEY				; Go to right alted keys if right alt flag active

				LDA		SCROM, X				; Otherwise look up for a normal key
				JMP		PUSH_KEY

L_ALTED_KEY:
				LDA		RALTROM, X
				JMP		PUSH_KEY

R_ALTED_KEY:
				LDA		RALTROM, X
				JMP		PUSH_KEY

SHIFTED_KEY:
				LDA		SSCROM, X				; Look up for the shifted key

PUSH_KEY:
				LDX		KBDWPTR					; Get the write head to X
				STA		KBDBUFF, X				; and store the ascii value there
				INC		KBDWPTR					; Move write head to the next slot
				JMP		IRQ_EXIT

L_ALT_DOWN:
				LDA		KBDFLAG					; Load the keyboard flags
				ORA		#L_ALT					; Set shifted mode
				STA		KBDFLAG
				JMP		IRQ_EXIT

SHIFT_DOWN:
				LDA		KBDFLAG					; Load the keyboard flags
				ORA		#SHIFT					; Set shifted mode
				STA		KBDFLAG
				JMP		IRQ_EXIT

KEY_EXTENDED:
				LDA		KBDFLAG
				ORA		#EXTENDED				; Set the next key is an extended key
				STA		KBDFLAG
				JMP		IRQ_EXIT

KEY_RELEASE:				
				LDA		KBDFLAG					; Load the keyboard flags
				ORA		#RELEASE				; Set release mode
				STA		KBDFLAG

IRQ_EXIT:
				PLA								; Restore X and A
				TAX
				PLA
				RTI


.segment "WOZMON"

; ----------------------------------------------------------------------------
; The original WozMon is cleared the interrupt flag
; Because of space limitations this is removed, so before wozmon is called
; interrupts must be enabled.
; ----------------------------------------------------------------------------
WOZMON:
										
				CLD								;Clear decimal arithmetic mode
				LDY		#%01111111				; Setting the original WozMon 
				LDA		#%10100111				; input conditions

; Program falls through to the GETLINE routine to save some program bytes
; Please note that Y still holds $7F, which will cause an automatic Escape

;-------------------------------------------------------------------------
; The GETLINE process
;-------------------------------------------------------------------------

notcr:
                CMP     #BSCHR          ;Backspace key?
                BEQ     backspace       ;Yes
                CMP     #ESCCHR         ;ESC?
                BEQ     escape          ;Yes
                INY                     ;Advance text index
                BPL     wait_for_key    ;Auto ESC if line longer than 127

escape:
                LDA     #PROMPTCHR      ;Print prompt character
                JSR     ECHO            ;Output it.

getline:
                LDA     #CRCHR          ;Send CR
                JSR     ECHO

                LDY     #0+1            ;Start a new input line
backspace:
                DEY                     ;Backup text index
                BMI     getline         ;Oops, line's empty, reinitialize

wait_for_key:
                SEI
				LDA		KBDRPTR
				CMP		KBDWPTR
				CLI
				BNE		key_pressed
				JMP		wait_for_key
				
key_pressed:
				LDX		KBDRPTR
				LDA		KBDBUFF, x
                
                STA     IN,Y            ;Add to text buffer
    			INC		KBDRPTR
				
                JSR     ECHO            ;Display character
                CMP     #CRCHR
                BNE     notcr           ;It's not CR!

; Line received, now let's parse it

                LDY     #$FF            ;Reset text index
                LDA     #0              ;Default mode is XAM
                TAX                     ;X=0

setstor:
                ASL                     ;Leaves $7B if setting STOR mode

setmode:
                STA     MODE            ;Set mode flags (0 if falling through)

blkskip:
                INY                     ;Advance text index

nextitem:
                LDA     IN,Y            ; Get character
                CMP     #CRCHR
                BEQ     getline         ; We're done if it's CR!
                CMP     #DOTCHR
                BCC     blkskip         ; Ignore everything below "."!
                BNE     notblockxam		; Skip if not "."
                ORA		#%10000000		; Correcting "." to the original B7 value
                JMP		setmode         ; Set BLOCK XAM mode ("." = $AE)
notblockxam:
                CMP     #COLONCHR
                BEQ     setstor         ;Set STOR mode! $3A will become $7B
                CMP     #RUNCHR
                BEQ     run             ;Run the program! Forget the rest
                STX     L               ;Clear input value (X=0)
                STX     H
                STY     YSAV            ;Save Y for comparison

; Here we're trying to parse a new hex value

nexthex:
                LDA     IN,Y            ;Get character for hex test
                EOR     #$30            ;Map digits to 0-9
                CMP     #9+1            ;Is it a decimal digit?
                BCC     dig             ;Yes!
                ADC     #$08            ;Map letter "A"-"F" to $FA-FF
                CMP     #$7A            ;Hex letter?
                BCC     nothex          ;No! Character not hex

dig:
                ASL
                ASL                     ;Hex digit to MSD of A
                ASL
                ASL

                LDX     #4              ;Shift count
hexshift:
                ASL                     ;Hex digit left, MSB to carry
                ROL     L               ;Rotate into LSD
                ROL     H               ;Rotate into MSD's
                DEX                     ;Done 4 shifts?
                BNE     hexshift        ;No, loop
                INY                     ;Advance text index
                BNE     nexthex         ;Always taken

nothex:
                CPY     YSAV            ;Was at least 1 hex digit given?
                BEQ     escape          ;No! Ignore all, start from scratch

                BIT     MODE            ;Test MODE byte
                BVC     notstor         ;B6=0 is STOR, 1 is XAM or BLOCK XAM

; STOR mode, save LSD of new hex byte

                LDA     L               ;LSD's of hex data
                STA     (STL,X)         ;Store current 'store index'(X=0)
                INC     STL             ;Increment store index.
                BNE     nextitem        ;No carry!
                INC     STH             ;Add carry to 'store index' high
tonextitem:
                JMP     nextitem        ;Get next command item.

;-------------------------------------------------------------------------
;  RUN user's program from last opened location
;-------------------------------------------------------------------------

run:
                JMP     (XAML)          ;Run user's program

;-------------------------------------------------------------------------
;  We're not in Store mode
;-------------------------------------------------------------------------

notstor:
                BMI     xamnext         ;B7 = 0 for XAM, 1 for BLOCK XAM

; We're in XAM mode now

                LDX     #2              ;Copy 2 bytes
setadr:
                LDA     L-1,X           ;Copy hex data to
                STA     STL-1,X         ; 'store index'
                STA     XAML-1,X        ; and to 'XAM index'
                DEX                     ;Next of 2 bytes
                BNE     setadr          ;Loop unless X = 0

; Print address and data from this address, fall through next BNE.

nxtprnt:
                BNE     prdata          ;NE means no address to print
                LDA     #CRCHR          ;Print CR first
                JSR     ECHO
                LDA     XAMH            ;Output high-order byte of address
                JSR     prbyte
                LDA     XAML            ;Output low-order byte of address
                JSR     prbyte
                LDA     #COLONCHR       ;Print colon
                JSR     ECHO

prdata:
                LDA     #SPACECHR       ;Print space
                JSR     ECHO
                LDA     (XAML,X)        ;Get data from address (X=0)
                JSR     prbyte          ;Output it in hex format
xamnext:
                STX     MODE            ;0 -> MODE (XAM mode).
                LDA     XAML            ;See if there's more to print
                CMP     L
                LDA     XAMH
                SBC     H
                BCS     tonextitem      ;Not less! No more data to output

                INC     XAML            ;Increment 'examine index'
                BNE     mod8chk         ;No carry!
                INC     XAMH

mod8chk:
                LDA     XAML            ;If address MOD 8 = 0 start new line
                AND     #%00000111
                BPL     nxtprnt         ;Always taken.

;-------------------------------------------------------------------------
;  Subroutine to print a byte in A in hex form (destructive)
;-------------------------------------------------------------------------

prbyte:
                PHA                     ;Save A for LSD
                LSR
                LSR
                LSR                     ;MSD to LSD position
                LSR
                JSR     prhex           ;Output hex digit
                PLA                     ;Restore A

; Fall through to print hex routine

;-------------------------------------------------------------------------
;  Subroutine to print a hexadecimal digit
;-------------------------------------------------------------------------

prhex:
                AND     #%00001111				;Mask LSD for hex print
                ORA     #ZEROCHR				;Add "0"
                CMP     #NINECHR+1				;Is it a decimal digit?
                BCC     ECHO					;Yes! output it
                ADC     #6						;Add offset for letter A-F

; Fall through to print routine

;-------------------------------------------------------------------------
;  Subroutine to print a character to the terminal
;-------------------------------------------------------------------------

ECHO:
				STA		CCHAR           		;Store char value to CCHAR
				JSR		LCD_PRINT_ASCII
    			RTS
				                
.segment "RESETVECTOR"

				.word	NMI
				.word	RESET
				.word	IRQ

;******************************************************************************************************
list p=16F887
#include"p16f887.inc"
;--------------------------- CONFIGURACION DE PUERTOS  -------------------------
    #include "p16f887.inc"

; CONFIG1
; __config 0xE0F5
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
 
;********************************************************
 CBLOCK 0X20
 REG1
 REG2
 REG3
 ENTRADA
 CUENTA
 UNIDAD
 DECENA
 CENTENA
 REGH1
 REGH
 REG1AUX
 CUENTA1
 K
 M
 N

 ENDC
 
 
 ORG	.0
 
INICIO:
 CALL    OSC_CONF
 CALL    CONFIGURACION
 CLRF	PORTB	    ;CLAREAR PUERTOS A Y B
 CLRF	PORTC	    ;

PRINCIPAL:
	    CLRF    REGH1
	    MOVF    PORTA,w
	    MOVWF   REGH1
	 CONTEO
	    CALL    HEX_BCD
	    MOVF    UNIDAD,w
	    MOVWF   REG1AUX
	    SWAPF   DECENA    ;cambia los 4 bits de la parte H y los coloca en L y viceversa
	    MOVF    DECENA,w
	    IORWF   REG1AUX,1 ;or
	    MOVF    REG1AUX,w
	    MOVWF   PORTB
	    MOVF    CENTENA,w
	    MOVWF   PORTC 
	    CALL    RETARDO_500ms
	    MOVLW   0XFF
            SUBWF   REGH1,w
	    BTFSC   STATUS,Z
	    CALL    RUTINA
	    INCF    REGH1
	    MOVF    REGH1,W
	    BTFSS   PORTD,RD0
	    GOTO    CONTEO
	    CALL    RETARDO_250ms
	    GOTO    PRINCIPAL
	    
	    
;**************RUTINA***********************	    
	RUTINA
	    CLRF    PORTC
	    CLRF    PORTB      
	    MOVLW   .8 
	    MOVWF   CUENTA1 
BUCLE1	    BTFSC   PORTD,RD0
	    GOTO    X
	    BSF	    STATUS,C 
	    RRF	    PORTC,1  ;RRF
	    CALL    RETARDO_500ms   
	    DECFSZ  CUENTA1,1 
	    GOTO    BUCLE1 
	    MOVLW   .8 
	    MOVWF   CUENTA1  
BUCLE2	    BTFSC   PORTD,RD0
	    GOTO    X
	    BSF STATUS,C 
	    RRF PORTB,1  ;RRF
	    CALL    RETARDO_500ms 
	    DECFSZ  CUENTA1,1 
	    GOTO BUCLE2 
	    MOVLW .8 
	    MOVWF   CUENTA1 
BUCLE3	    BTFSC   PORTD,RD0
	    GOTO    X
	    BCF STATUS,C 
	    RLF PORTB,1  ;RLF
	    CALL    RETARDO_500ms 
	    DECFSZ  CUENTA1,1 
	    GOTO BUCLE3
	    MOVLW .4 
	    MOVWF   CUENTA1 
BUCLE4	    BTFSC   PORTD,RD0
	    GOTO    X
	    BCF STATUS,C 
	    RLF PORTC,1  ;RLF
	    CALL    RETARDO_500ms 
	    DECFSZ  CUENTA1,1 
	    GOTO BUCLE4
	    MOVLW   .0
	    MOVWF   REG1
	    RETURN
;****************************************************************
    X       CALL    RETARDO_250ms
	    GOTO    PRINCIPAL
;**********


#include    "config.inc"
#include    "RETARDOS.inc"
END
     
     

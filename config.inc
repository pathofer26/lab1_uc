
 
 configuracion:
    BSF	STATUS,RP0	    ; SE SELECCIONA BANCO 3
    BSF	STATUS,RP1	    ;
    CLRF	ANSEL	    ;SE CONFIGURAN LOS PUERTOS A Y B
    CLRF	ANSELH	    ;COMO DE I/O
    BCF	STATUS,RP1
    CLRF	TRISB	    ;PUERTO B COMO SALIDA
    CLRF	TRISC	    ;PUERTO C COMO SALIDA
    MOVLW	0xFF	    ;MUEVA A W FF
    MOVWF	TRISA	    ;PUERTO A COMO ENTRADA
    MOVLW	0X01	    ;MUEVO A W 1
    MOVWF	TRISD	    ;PIN RD0 COMO ENTRADA
    BCF	STATUS,RP0	    ;
 return
 
 ;********** RUTINA PARA PASAR DE HEXADECIMAL A FORMATO BCD********
HEX_BCD     MOVWF   REGH
            CLRF    UNIDAD
            CLRF    DECENA
            CLRF    CENTENA
            XORLW   0           ; REGH XOR 0
            BTFSC   STATUS,Z    ;SALTE SI REGH ES DIFERENTE DE CERO
            RETURN
            MOVLW   .100
HEX1        INCF    CENTENA,1
            SUBWF   REGH,1      ;REGH-100  C=1 SI REGH>= 100 Y C=0 0 SI <
            BTFSC   STATUS,C
            GOTO    HEX1
            DECF    CENTENA,1
            ADDWF   REGH,1      ;recupra el numero N + 100


            MOVLW   .10
HEX2        INCF    DECENA,1
            SUBWF   REGH,1      ;REGH-100  C=1 SI + O 0; 0 SI -
            BTFSC   STATUS,C
            GOTO    HEX2
            DECF    DECENA,1
            ADDWF   REGH,1

            MOVF    REGH,0
            MOVWF   UNIDAD
            RETURN

;*************************************************************
	  

    



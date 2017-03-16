;----------RUTINA DE RETARDO 500ms---------------
RETARDO_500ms:
    MOVLW   .255
    MOVWF   K
UNO MOVLW   .180
    MOVWF   M
DOS MOVLW   .6
    MOVWF   N
    DECFSZ  N
    GOTO    $-1 
    DECFSZ  M
    GOTO    DOS
    DECFSZ  K
    GOTO    UNO
 RETURN 
;------------------------------------------
;----------RUTINA DE RETARDO 1s---------------
RETARDO_1s:
    MOVLW   .255
    MOVWF   K
CONT
    MOVLW   .255
    MOVWF   M
CONT0
    MOVLW   .9
    MOVWF   N
    DECFSZ  N
    GOTO    $-1 
    DECFSZ  M
    GOTO    CONT0
    DECFSZ  K
    GOTO    CONT
 RETURN 
;------------------------------------------
 ;----------RUTINA DE RETARDO 250ms---------------
RETARDO_250ms:
    MOVLW   .100
    MOVWF   K
CONT1
    MOVLW   .100
    MOVWF   M
CONT2
    MOVLW   .15
    MOVWF   N
    DECFSZ  N
    GOTO    $-1 
    DECFSZ  M
    GOTO    CONT2
    DECFSZ  K
    GOTO    CONT1
 RETURN 
;------------------------------------------



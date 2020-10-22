#include "p16F628a.inc"
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
;Se configura todo apagado

RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program

 
i equ 0x30;Identificadores
j equ 0x31;Identificadores
k equ 0x32;Identificadores
e equ 0x33
 
START
    MOVLW 0x07;Apagar comparadores en este caso es del 0-7
    MOVWF CMCON;Y establecer los pines como entrada y salida
    BCF STATUS, RP1 ;
    BSF STATUS, RP0 ;Encender un bit del registro F
    MOVLW b'00000000'
    MOVWF TRISB ;Registro donde les decimos si es entrada o salida
    BCF STATUS, RP0 ;Apgao y regeso todo a lo normal


inicio:
    BCF PORTB,0
    call tiempo5
    nop
    nop
    BTFSC PORTB,1
    call tiempo1seg
    nop
    nop
    BSF PORTB,0
    call tiempo5
    BTFSC PORTB,1
    call tiempo1seg
    
    GOTO inicio
    
tiempo5:
    MOVLW d'60'
    MOVWF i ;Movemos el 255 a i
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
loopj:    
    MOVLW d'53'
    MOVWF j ;Movemos el 255 a j
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
loopk: 
    MOVLW d'51'
    MOVWF k ;Movemos el 255 a k
    ;Decrementaremos k porque es el mas anidado es decir mas adentro
    DECFSZ k ;Decrementar hasta que de 0 por default 
    ;la primera instruccion es la que hara hasta que llegue a 0 la 2 es lo que hara despues de estar en 0
    GOTO $-1 ;Regresar a la instruccion anterio con $-1
    DECFSZ j;Cuando ya llego 0 entra a aqui
    GOTO loopk
    DECFSZ i
    GOTO loopj
    return
    
    ;Acabamos de guardar 11111111 en binario
    ;PORT se va a ver como voltaje a fuera -->Registro de memoria
    ;Meter o sacar valores de voltaje
    ;Un ejemplo seria para prender el led
    
    ;Es como un for dentro de otro por eso regresamos a los loop para que se reinicien desde su valor y restar al siguiente for
    
tiempo1seg:
    MOVLW d'49'
    MOVWF i
loopj2:    
    MOVLW d'51'
    nop
    nop
    nop
    nop
    MOVWF j
loopk2: 
    MOVLW d'132'
    MOVWF k 
    DECFSZ k
    GOTO $-1 
    DECFSZ j
    GOTO loopk2
    DECFSZ i
    GOTO loopj2
    return
    
    
END
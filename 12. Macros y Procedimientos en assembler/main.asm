include macros.asm
.model small
.stack
.data
    msgWelcome db 'Bienvenido al capitulo 12',13,10,'$'
    msg1 db 'Este es el primer mensaje',13,10,'$'
    msg2 db 'Este es el segundo mensaje',13,10,'$'
    msg3 db 'Este es el tercer mensaje',13,10,'$'
    msg4 db 'Este es el cuarto mensaje',13,10,'$'
    msgFIN db 'Fin del programa',13,10,'$'

.code

main proc
    mov dx,@DATA
    mov ds,dx
    xor dx,dx

    print msgWelcome
    call cambiartodoavideo  
    print msg4

    print msgFIN
    .exit
main endp

cambiartodoavideo proc
    print msg1
    print msg2
    print msg4
    ret
cambiartodoavideo endp

end main
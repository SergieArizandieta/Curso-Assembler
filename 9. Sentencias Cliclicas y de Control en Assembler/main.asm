printChar macro char	
    mov ah,02h
    mov dl, char
    int 21h
endm

printDiferencia macro char	
    printChar 10  
    printChar '~'
    printChar '~'
    printChar '~'
    printChar '~'
    printChar '~'
    printChar '~'
    printChar 10
endm

.model small
.stack
.data
    COND1 db 1b
    COND2 db 1b
    COND3 db 0b
.code

    main PROC  
        ;importo varibles
        mov dx, @DATA   
        mov ds , dx
        xor dx,dx   

        ;-----------IF NORMAL ----------------------
        ; if(COND1){
        ;     print('a')
        ; }else{
        ;     print('b')
        ; }


        ;---ASM--
        printDiferencia
        cmp COND1,1b
        je L1
        jmp L2

        L1:
            printChar 'a'
            jmp L3
        L2:
            printChar 'b'
        L3:

        ;-----------IF  OR ----------------------
        ; if( COND1 OR COND2 ){
        ;     print('a')
        ; }else{
        ;     print('b')
        ; }
        
        ;---ASM--
        printDiferencia
        cmp COND1,1b
        je Z1
        
        cmp COND2,1b
        je Z1
        jmp Z2

        Z1:
            printChar 'a'
            jmp Z3
        Z2:
            printChar 'b'

        Z3:

        ;-----------IF  AND ----------------------
        ;Etiqueta true -> L1
        ;Etiqueta false -> L2

        ; if( COND1 AND COND2 ){
        ;     print('a')
        ; }else{
        ;     print('b')
        ; }
        
        ;---ASM-- Otra forma de hacer el and
        ; printDiferencia
        ; cmp COND1,1b
        ; je P1
        ; jmp P3

        ; P1:
        ;     cmp COND2,1b
        ;     je P2
        ;     jmp P3
        
        ; P2:
        ;     printChar 'a'
        ;     jmp P4
        ; P3:
        ;     printChar 'b'

        ; P4:


        ;---ASM--  Forma mas obtimizada---------
        printDiferencia
        cmp COND1,1b
        jne P1

        cmp COND2,1b
        jne P1

        printChar 'a'
        jmp P2
        
        P1:
            printChar 'b'
        
        P2:

        ;-----------for(0..6) ----------------------
        ; for n in range(0,6){
        ;     print('a')
        ;}
        ;SALIDA ESPERADA: aaaaa
        
        ;---ASM--
        printDiferencia
        xor si,si
        CFOR:
          cmp si,5d
          je SALIRFOR

          printChar 'a'
          inc si
          jmp CFOR

        SALIRFOR:

        ;----------- While(COND1) ------------------
        ; COND1 = true
        ; contador = 0
        ; whiel(COND1){
        ;     print('b')
        ;     if(contador == 5){
        ;         COND1 = false
        ;     }
        ;     contador++
        ; }
        ;SALIDA ESPERADA: bbbbbb

        ;---ASM--  
        printDiferencia
        mov COND1,1b
        xor si,si
        
        CWHILE:  
            cmp COND1,1b
            jne EXITWHILE

            printChar 'b'

            cmp si,5d
            je SIES5
            jmp NOES5

            SIES5:
                mov COND1,0b

            NOES5:
            
            inc si
            jmp CWHILE

        EXITWHILE:

        ;----------- While - break ------------------
        ; contador = 0
        ; whiel(true){
        ;     print('z')
        ;     if(contador == 4){
        ;         braak
        ;     }
        ;     contador++
        ; }
        ;SALIDA ESPERADA: zzzzz
      
        ;---ASM--
        printDiferencia
        xor si,si
        CWHILE2:  
            printChar 'z'

            cmp si,4d
            je SIES4
            jmp NOES4

            SIES4:
                jmp EXITWHILE2

            NOES4:
            
            inc si
            jmp CWHILE2

        EXITWHILE2:

        ;----------- While - continue / break ------------------
        ; contador = 0
        ; whiel(true){
        ;     contador++
        ;
        ;     if(contador == 3){
        ;        print('a')
        ;        continue
        ;     }
        ;       
        ;      print('z')
        ;
        ;     if(contador == 4){
        ;        break
        ;     }
        ; }
        ;SALIDA ESPERADA: zzaz
        
      
        ;---ASM--  
        printDiferencia
        xor si,si
        CWHILE3:  
            inc si

            cmp si,3d
            je SIES3
            jmp NOES3

            SIES3:
                printChar 'a'
                jmp CWHILE3

            NOES3:
            
            printChar 'z'

            cmp si,4d
            je SIESS4
            jmp NOESS4

            SIESS4:
                jmp EXITWHILE4

            NOESS4:

            jmp CWHILE3

        EXITWHILE4:

        .exit
    main ENDP

end main
.model small
.stack
.data
.code

    main PROC 
        ;Operadores aritmeticos
        
        ;Suma(ADD)------------------   
        ;1000 + 999 = 1999
        ;mov ax,1000d   
        ;mov bx,999d
        ;add ax,bx
        ;ax = ax + bx 
     
        
        ;Resta(SUB)------------------ 
        ;300 - 255  = 45
        ;mov bx,300d
        ;mov ax,255d
        ;sub bx,ax
        ;bx = bx - ax


        ;multiplicacion(MUL)------------------  
        ;11 * 255  = 2805  
        ;mov ax,255d
        ;mov bx,11d
        ;mul bx
        ;ax = ax * bx


        ;Division(DIV)------------------        
        ;1000 / 100  = 10 
        ;mov ax,1000d
        ;mov bx,100d
        ;div bx 
        ;ax = ax / bx          
        


        ;Operadores logicos

        ;AND------------------
        ;214 and 91

        ;11010110 
        ;01011011 AND
        ;01010010 = 82

        ;mov ax,11010110b 
        ;mov bx,01011011b
        ;and ax,bx


        ;OR------------------
        ;214 OR 91

        ;11010110 
        ;01011011 OR
        ;11011111 = 223

        ;mov ax,11010110b
        ;or ax,01011011b


        ;NOT------------------
        ;NOT 214 

        ;11010110 
        ;NOT
        ;00101001 = 41
        ;mov ax,11010110b
        ;not al


        ;XOR------------------
        ;214 XOR 91

        ;11010110 
        ;01011011 XOR
        ;10001101 = 141
        
        ;mov ax,11010110b
        ;xor ax,01011011b
        
        ;Xor------------------
        ;xor ax,ax


        .exit
    main ENDP

end 
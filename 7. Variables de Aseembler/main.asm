.model small
.stack
.data
    ;Err1 db 256d
    ;Err2 dw 65536d

    DataByte db 200d 
    DataWord dw 60000d
    DataDouble dd 90000d    
    
    
    ;variables ------ parte 2 
    var1 db "!"
    var2 dw "+!"
    
    
    var3 db "+!"
    var4 dw "+!+"
    
    var5 db "+","!","+"
    var6 dw "+","!","+" 
    
    var7 db 200d,200d,200d,200d,200d,200d
    var8 dw 60000d,60000d,60000d,60000d,60000d
    
.code

    main PROC  
        ;Importacion a segmento
        mov ax,@data  
        mov ds,ax
        xor ax,ax 
        
        ;mov ax,DataByte ;Error
        
        
        ;AL = DB + AL
        ;mov al,55d
        ;add al,DataByte
        
        ;DW = DW - CX
        ;mov cx,50000d
        ;sub DataWord,cx
        
        ;EAX = DD / EBX    <---- Emu 8086 = microsprocesasdor de 16 bits 
        ;mov eax,DataDouble
        ;mov EBX,10000d
        ;div EBX 
        
        
        ;AX =  DW / BX 
        ;mov ax,DataWord
        ;mov bx,2d
        ;div bx
        
        ;AL = DB * BL
        ;mov al,DataByte
        ;mov bl,2d
        ;mul bl 
        
        
        ;--- << 2da parte >> ---
        ;Diferencias entre registros y varibles
        
        ;1 caracter = 8 bits
        ;2 caracteres = 16 bits
        
        ;mov al,"+"
        ;mov al,"+!" ;Error
        
        ;mov ax,"+!"
        ;mov ax,"!+!" ;Error
        
        ;al,ah,bl,bh ... = DB
        ;AX,BX,CX,DX ... = DW 
        
        .exit
    main ENDP

end main
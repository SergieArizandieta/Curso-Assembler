.model small
.stack 

.data 
    msg db 'Hello World $'

; segemento de codigo    
.code

    ; procedimiento principal main
	main PROC

        ; carga en memoria las variables del semento de datos
    	MOV ax, @data
    	MOV ds, ax
		xor ax,ax  

        ; impresion por pantalla
		mov dx, offset msg
		mov ah, 9
    	int 21h   
    	.exit   

	main ENDP   

end main
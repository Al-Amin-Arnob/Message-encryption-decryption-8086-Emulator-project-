.model small
.stack 100h    

print macro p1
    mov ah,9
    lea dx,p1
    int 21h
    
endm 

input macro f1
    xor cx,cx
    mov cl,f1 
    mov si,0
    loop1:
     
    mov ah,1
    int 21h  
    mov array[si],al
    inc si 
    loop loop1
endm

.data  

title1 db 10,13,".-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.$" 
title2 db 10,13,"______Message Encryption and Dcryption__________$"
title3 db 10,13,".-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.$"
array db 100 dup<?>   
msg db 0ah,0dh,"Message length(within 60): $"
msg0 db 0ah,0dh,"Enter message length(within 60): $"  
length db ?  
msgkey db 10,13,"Enter key value(0 to 9): $"
key db ?
msg1 db 10,13,"Enter a message: $"
msg2 db 10,13,"Encrypted message: $"
msg3 db 10,13,"Decrypted message: $" 
msg4 db 10,13,"Do you want to continue?$" 
char_input db ?

main proc
    mov ax,@data
    mov ds,ax
    
    print title1
    print title2
    print title3
    print msg 
    start: 
    xor ax,ax
    xor bx,bx
    xor cx,cx
    
    
    mov ah,1
    int 21h
    sub al,48

    mov cl,10
    mul cl 
    mov bl,al
    
    mov ah,1
    int 21h
    sub al,48
    add bl,al
   
    mov length,bl
    
    print msgkey 
    mov ah,1
    int 21h
    sub al,48
    mov key,al
       
    print msg1
    input bl
    
    print msg2
    mov si,0
    mov cl,bl
    encryption:                 ;encryption start
    xor ax,ax
    mov al,array[si]
    add al,key
    mov array[si],al
    inc si
    loop encryption
    jmp outputE 
    
    outputE:                    ;encryption output
    mov si,0
    mov cl,bl
    output1:
    mov ah,2                   
    mov dl,array[si]
    int 21h
    inc si
    loop output1
       
    print msg3
    mov si,0
    mov cl,bl  
    dencryption:                ;decryption start
    xor ax,ax
    mov al,array[si]
    sub al,key 
    mov array[si],al            
    inc si
    loop dencryption
    jmp outputD
    
    outputD:                    ;decryption output
    mov si,0
    mov cl,bl
    output2:
    mov ah,2 
    mov dl,array[si]
    int 21h
    inc si
    loop output2
    jmp ask
    
    xor dx,dx
    ask:
    ;asking user to choice 
    mov ah,9
    lea dx, msg4
    int 21h

    ;take user input as (y/n)
    mov ah,1
    int 21h
    mov char_input, al

    ;check if the user inputs
    cmp char_input, 'N'
    je  end
    
    cmp char_input, 'n'
    je  end   
    
    cmp char_input, 'y'
    print msg0
    je start
    cmp char_input, 'Y'
    print msg0 
    je start

    
    end:
    mov ah,4ch
    int 21h 
    
    main endp  
      
end main
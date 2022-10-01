org 100h

jmp start       

msg1:    db      "Press 1 for Addition",0dh,0ah,"Press 2 for Subtraction",0dh,0ah, "Press 3 for Multiplication",0dh,0ah,"Press 4 for Division", 0Dh,0Ah, '$'
msg2:    db      0dh,0ah,"Enter First value : $"
msg3:    db      0dh,0ah,"Enter Second value : $"
msg4:    db      0dh,0ah,"^^Wrong Choice^^  Press any key to restart $" 
msg5:    db      0dh,0ah,"Result : $" 
msg6:    db      0dh,0ah ,'thank you ! press any key', 0Dh,0Ah, '$'

start:  mov ah,9
        mov dx, offset msg1
        int 21h
        mov ah,0                       
        int 16h  ;we will use int 16h to read what operation the user wants to perform
        cmp al,31h ; keypress will be stored in al and then compared -- 31h=1 in ascii
        je Addition
        cmp al,32h   ;32h=2 in ascii
        je Subtract
        cmp al,33h   ;33h=3 in ascii
        je Multiply
        cmp al,34h   ;34h=4 in ascii
        je Divide
        mov ah,09h
        mov dx, offset msg4  ;any other input will generate an error
        int 21h
        mov ah,0
        int 16h
        jmp start
        
Addition:   mov ah,09h           ;to display a string character
            mov dx, offset msg2  ;input first value from user
            int 21h
            mov cx,0             ;we will initialize cx=0 as incerement will occur here
            call InputNo         ;we will call input procedure as every input will be taken seperately
            push dx        
            mov ah,9
            mov dx, offset msg3  ;input second value
            int 21h 
            mov cx,0
            call InputNo          
            pop bx
            add dx,bx
            push dx 
            mov ah,9
            mov dx, offset msg5  ;display result
            int 21h
            mov cx,10000         ;range this calculator can calculate 
            pop dx               ;pop the result stored in dx
            call View            ;to view the result
            jmp exit 
            
            
Subtract:   mov ah,09h
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            sub bx,dx            ;bx-dx
            mov dx,bx            ;result is stored back in dx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 
    
                  
       


                       
Multiply:   mov ah,09h
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            mov ax,dx             
            mul bx                ;ax*bx
            mov dx,ax             ;result stored in dx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp exit 
 
    
            
Divide:     mov ah,09h
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            mov ax,bx               ;first vlaue in ax
            mov cx,dx               ;second value in cx
            mov dx,0
            mov bx,0
            div cx                  ;quotient will be viewed
            mov bx,dx
            mov dx,ax
            push bx 
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View
            pop bx
            cmp bx,0
            je exit 
            jmp exit             


InputNo:    mov ah,0    ;to take input from the user
            int 16h     ;then we will use int 16h to read a key press     
            mov dx,0  
            mov bx,1 
            cmp al,0dh ;the keypress will be stored in al so, we will comapre to  0d(enter) to check whether the user entered the complete num or not
            je FormNo ;if it is enter then num will be stored in stack, we will return it back using FormNo
            sub ax,30h ;to convert entered value from ascii to decimal
            call ViewNo ;then call ViewNo to view the key we pressed on the screen
            mov ah,0 ;we will mov 0 to ah before we push ax to the stack bec we only need the value in al
            push ax  ;push the contents of ax to the stack
            inc cx   ;we will add 1 to cx as this represent the counter for the number of digit
            jmp InputNo ;then we will jump back to input number to either take another number or press enter          
   

           
                            
                            
FormNo:     ;to form number eg. 367=7x1 + 6x10 + 3x100
            pop ax  
            push dx      
            mul bx   ;7x1
            pop dx
            add dx,ax
            mov ax,bx       
            mov bx,10   ;6x10
            push dx     
            mul bx      ;10x10 
            pop dx      ;pop the result
            mov bx,ax   ;we assume result is in bx
            dec cx      ;when we finish the first value we will dec cx(counter)
            cmp cx,0    ;if cx=0 we have formed all digits 
            jne FormNo
            ret   
 
 
 View:      ;to view the result
            mov ax,dx   ;result stored in dx will be moved in ax
            mov dx,0   
            div cx      ;div by 1000 to represent each digit separately
            call ViewNo ;will continue to call until cx=0 i.e all digits are viewed
            mov bx,dx   ;stores the remainder after division
            mov dx,0
            mov ax,cx 
            mov cx,10
            div cx      ;divide by 10 to represent the result
            mov dx,bx 
            mov cx,ax
            cmp ax,0
            jne View
            ret

           
           
ViewNo:    ;to view the entered values on screen
           push ax ;we will push ax and dx to the stack because we will change there values while viewing then we will pop them back from
           push dx ;the stack we will do so we don't affect their contents
           mov dx,ax ;we will mov the value to dx as interrupt 21h expect that the output is stored in it
           add dl,30h ;add 30 to its value to convert it back to ascii
           mov ah,2
           int 21h    ;to view the number
           pop dx     ;again pop the numbers after they are viewed on screen
           pop ax
           ret
      
   
exit:   mov dx,offset msg6   ;display thankyou msg
        mov ah, 09h
        int 21h  
        mov ah, 0
        int 16h

        ret
            
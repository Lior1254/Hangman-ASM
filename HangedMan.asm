
MAX_LETTERS equ 26  ;the amount of letters in English
MAX_LETTERS_IN_WORD equ 8;the max amount of letter in word is 8 with $
ROUNDS equ 7 

.model small
.stack 100h
.data
                        
                        
;10,13 Backspace - \n
                 
                 
;----------------------------------------------------------------- 
;The Logo      
Logo: db "  _    _                                         ",10,13 
      db " | |  | |                                        ",10,13
      db " | |__| | __ _ _ __   __ _ _ __ ___   __ _ _ __  ",10,13
      db " |  __  |/ _` | '_ \ / _` | '_ ` _ \ / _` | '_ \ ",10,13
      db " | |  | | (_| | | | | (_| | | | | | | (_| | | | |",10,13
      db " |_|  |_|\__,_|_| |_|\__, |_| |_| |_|\__,_|_| |_|",10,13
      db "                      __/ |                      ",10,13
      db "                     |___/",10,13
      db "$"
;-----------------------------------------------------------------
;info about the game
msg_hangman_info db "Welcome to Hangman!",10,13
                 db "Guess the hidden word by selecting one letter at a time.",10,13
                 db "Each incorrect guess adds a part to the hangman figure.",10,13
                 db "You have a limited number of attempts to guess correctly.",10,13
                 db "Good luck and have fun!",10,13
                 db "",10,13
                 db "The theme is: "
                 db "$"
;-----------------------------------------------------------------
;End mseges
msg_win   db " ____      ____  _____  ____  _____  ____  _____  ________  _______     ",10,13
          db "|_  _|    |_  _||_   _||_   \|_   _||_   \|_   _||_   __  ||_   __ \    ",10,13
          db "  \ \  /\  / /    | |    |   \ | |    |   \ | |    | |_ \_|  | |__) |   ",10,13
          db "   \ \/  \/ /     | |    | |\ \| |    | |\ \| |    |  _| _   |  __ /    ",10,13
          db "    \  /\  /     _| |_  _| |_\   |_  _| |_\   |_  _| |__/ | _| |  \ \_  ",10,13
          db "     \/  \/     |_____||_____|\____||_____|\____||________||____| |___| ",10,13
          db "                                                                       ",10,13
          db "                       Y O U   W I N   :)                              ",10,13
          db "$"




msg_lose  db "  _      ____   _____ ______  _____ ",10,13
          db " | |    / __ \ / ____|  ____||  __ \",10,13
          db " | |   | |  | | (___ | |__  || |__) |",10,13
          db " | |   | |  | |\___ \|  __|  |  _  / ",10,13
          db " | |___| |__| |____) | |____ | | \ \ ",10,13
          db " |______\____/|_____/|______||_|  \_\",10,13
          db "                                     ",10,13
          db "          Y O U   L O S E ):         ",10,13
          db "                                     ",10,13
          db "$"
		  
		  

 
msg_Good_Bye   db "   _____                 _   ____             _ ",10,13
               db "  / ____|               | | |  _ \           | |",10,13
               db " | |  __  ___   ___   __| | | |_) |_   _  ___| |",10,13
               db " | | |_ |/ _ \ / _ \ / _` | |  _ <| | | |/ _ \ |",10,13
               db " | |__| | (_) | (_) | (_| | | |_) | |_| |  __/_|",10,13
               db "  \_____|\___/ \___/ \__,_| |____/ \__, |\___(_)",10,13
               db "                                    __/ |       ",10,13
               db "                                   |___/        ",10,13
               db "                                                ",10,13
               db "          GOOD BYE! SEE YOU NEXT TIME           ",10,13
               db "$"
                                            
;-----------------------------------------------------------------
;All the states of the Hanged man

Hanged_man0:  db "   _______",10,13
              db "  |       |",10,13
              db "  |        ",10,13
              db "  |        ",10,13
              db "  |        ",10,13
              db "  |        ",10,13
              db "__|__     $",10,13 

Hanged_man1:  db "   _______",10,13
              db "  |       |",10,13
              db "  |       O",10,13
              db "  |        ",10,13
              db "  |        ",10,13
              db "  |        ",10,13
              db "__|__     $",10,13 

Hanged_man2:  db "   _______",10,13
              db "  |       |",10,13
              db "  |       O",10,13
              db "  |       |",10,13
              db "  |        ",10,13
              db "  |        ",10,13
              db "__|__     $",10,13 

Hanged_man3:  db "   _______",10,13
              db "  |       |",10,13
              db "  |       O",10,13
              db "  |      /|",10,13
              db "  |        ",10,13
              db "  |        ",10,13
              db "__|__     $",10,13 

Hanged_man4:  db "   _______",10,13
              db "  |       |",10,13
              db "  |       O",10,13
              db "  |      /|\",10,13
              db "  |        ",10,13
              db "  |        ",10,13
              db "__|__     $",10,13 

Hanged_man5:  db "   _______",10,13
              db "  |       |",10,13
              db "  |       O",10,13
              db "  |      /|\",10,13
              db "  |      / ",10,13
              db "  |        ",10,13
              db "__|__     $",10,13 

Hanged_man6:  db "   _______",10,13
              db "  |       |",10,13
              db "  |       O",10,13
              db "  |      /|\",10,13
              db "  |      / \",10,13
              db "  |        ",10,13
              db "__|__     $",10,13 

;arr of pointers with all the Hanged_mans
Hanged_mans dw offset Hanged_man0,offset Hanged_man1,offset Hanged_man2
            dw offset Hanged_man3,offset Hanged_man4,offset Hanged_man5
            dw offset Hanged_man6

Hanged_man_index dw 0
;-----------------------------------------------------------------
;The words in the game 
; Fruits
fruits0   db "apple$"
fruits1   db "banana$"
fruits2   db "grape$"
fruits3   db "orange$"
fruits4   db "melon$"
fruits5   db "cherry$"
fruits6   db "peach$"
fruits7   db "kiwi$"
fruits8   db "plum$"
fruits9   db "pear$"
fruits10  db "lemon$"
fruits11  db "fig$"
fruits12  db "papaya$"
fruits13  db "mango$"
fruits14  db "guava$"
fruits15  db "berry$"
fruits16  db "date$"
fruits17  db "olive$"
fruits18  db "apricot$"
fruits19  db "coconut$"

; Animals
animals0   db "cat$"
animals1   db "dog$"
animals2   db "lion$"
animals3   db "bear$"
animals4   db "wolf$"
animals5   db "fox$"
animals6   db "deer$"
animals7   db "zebra$"
animals8   db "horse$"
animals9   db "sheep$"
animals10  db "goat$"
animals11  db "mouse$"
animals12  db "shark$"
animals13  db "whale$"
animals14  db "snake$"
animals15  db "eagle$"
animals16  db "tiger$"
animals17  db "rabbit$"
animals18  db "camel$"
animals19  db "otter$"

; Cities
cities0   db "paris$"
cities1   db "london$"
cities2   db "tokyo$"
cities3   db "berlin$"
cities4   db "madrid$"
cities5   db "rome$"
cities6   db "sydney$"
cities7   db "delhi$"
cities8   db "moscow$"
cities9   db "dublin$"
cities10  db "vienna$"
cities11  db "cairo$"
cities12  db "oslo$"
cities13  db "lisbon$"
cities14  db "sofia$"
cities15  db "seoul$"
cities16  db "beirut$"
cities17  db "athens$"
cities18  db "baghdad$"
cities19  db "doha$"

;Array of pointers  with all the words
words dw offset fruits0, offset fruits1, offset fruits2, offset fruits3, offset fruits4
      dw offset fruits5, offset fruits6, offset fruits7, offset fruits8, offset fruits9
      dw offset fruits10, offset fruits11, offset fruits12, offset fruits13, offset fruits14
      dw offset fruits15, offset fruits16, offset fruits17, offset fruits18, offset fruits19
      dw offset animals0, offset animals1, offset animals2, offset animals3, offset animals4
      dw offset animals5, offset animals6, offset animals7, offset animals8, offset animals9
      dw offset animals10, offset animals11, offset animals12, offset animals13, offset animals14
      dw offset animals15, offset animals16, offset animals17, offset animals18, offset animals19
      dw offset cities0, offset cities1, offset cities2, offset cities3, offset cities4
      dw offset cities5, offset cities6, offset cities7, offset cities8, offset cities9
      dw offset cities10, offset cities11, offset cities12, offset cities13, offset cities14
      dw offset cities15, offset cities16, offset cities17, offset cities18, offset cities19


;Topics array
topic0 db "Fruits!$",0
topic1 db "Animals!$",0
topic2 db "Cities!$",0

; Array of pointers to the topics
topics dw offset topic0, offset topic1, offset topic2
;-----------------------------------------------------------------  
;msg
msg_get_char_input          db "Enter a letter: $"              
msg_letter_already_selected db "Letter already chosen, $"
msg_not_in_range            db "Letter not in range a-z, $"
msg_hidden_guess            db 'You guessed a correct letter!$'
msg_incorrect_guess         db "Wrong guess! Better luck next time!$"
msg_round db "Round: $"
msg_wrong_guesses db "Wrong Guesses: $"
msg_show_word db "The word is: $"
 
;-----------------------------------------------------------------
;Variables
randomNum dw 0                      ;varibale for random number
old_letters db MAX_LETTERS dup(0)   ;26 cells with valuse of 0
selectedWord dw ?                   ;the random word   
hidden_word db MAX_LETTERS_IN_WORD dup(?);the word with the higher char it strawberry$ with 11
num_hidden_letter db 0 


.code

mov ax,@data
mov ds, ax 
        

        call menu;call menu function
        call updateHiddenWord 
        
        mov cx,ROUNDS
        
        main_game:
              
            mov si,Hanged_man_index
            shl si,1
            
            courrect_letter_loop:
                
                ;check win
                sub sp,2;Saves space in the stack
                push bp;save bp
                call check_win                                       
                mov bp,sp
                mov dx,[bp+2];pull the value
                pop bp;pull bp
                add sp,2;Returns the stack to the source
                cmp dl,1
                je player_win ;check if the player fill all the hidden_word not have _ 
                
                ;print rounds
                call newline 
                call newline
                mov dx,offset msg_round;print roundom msg
                push dx
                call print_string
                mov dl, cl        ; Load the digit into dl
                add dl, '0'       ; Convert the digit to ASCII
                mov ah, 2         ; Select DOS function 2 (print character)
                int 21h           ; Print the character in dl
                call newline

                ;print worng letters
                mov dx,offset msg_wrong_guesses
                push dx
                call print_string
                call print_letter_guses
                call newline
                call newline
                
                ;print hidden_word
                mov dx,offset hidden_word
                push dx
                call print_string
                call newline 
                call newline 
                
                ;get char and check input
                enter_agin:                        
                    sub sp,2;Saves space in the stack
                    push bp;save bp
                    call get_input
                    mov bp,sp
                    mov dx,[bp+2];pull the value
                    pop bp;pull bp
                    add sp,2;Returns the stack to the source
                
                cmp dl,1
                jne enter_agin;if dl = 0 run agine 
                ;fill hidden_word
                call updateHiddenWord
                
                
                ;check if the user put courrect letter
                sub sp,2;Saves space in the stack                                   
                push bp;save bp
                call check_correct_guess
                mov bp,sp
                mov dx,[bp+2];pull the value
                pop bp;pull bp
                add sp,2;Returns the stack to the source  
            
            
            cmp dl,1            
            je courrect_letter_loop;0 worng guse ,
            
            ;print msg_incorrect_guess
            mov dx,offset msg_incorrect_guess
            push dx
            call print_string
            call newline
            
            ;print Hanged_mans
            mov dx,[Hanged_mans + si]
            push dx
            call print_string
            call newline
           
            
            
            inc Hanged_man_index 
        loop main_game
        
        ;if the player come to here he finish the rounds
        jmp player_lose    
        
        player_win:
        call newline
        call newline
        mov dx,offset msg_show_word;print the The word is 
        push dx
        call print_string
        mov dx,selectedWord;print the word
        push dx
        call print_string 
        call newline
        call newline
        
        mov dx,offset msg_win;win msg
        push dx
        call print_string
        call newline 
        jmp skip_lose
        
        player_lose:
        call newline
        call newline
        mov dx,offset msg_show_word;print the The word is 
        push dx
        call print_string
        mov dx,selectedWord;print the word
        push dx
        call print_string 
        call newline
        call newline
        
        call newline
        call newline
        mov dx,offset msg_lose;lose msg
        push dx
        call print_string
        call newline 
        skip_lose:
               
               
        ;good bye msg
        mov dx,offset msg_Good_Bye
        push dx
        call print_string
        
         

mov ah,4ch;end of the main
mov al,0  ;end of the main
int 21h   ;end of the main

;-------------------------------------------------- 
; Function: Run in the beggining of the game and, print logo,choose the random word.
; Input:    None.
; Output:   None.
;--------------------------------------------------  

proc menu;Start of the menu function

   pusha 
   ;print logo 
   mov dx, offset Logo; Get the pointer of Logo  
   push dx;Push to thh stack, for save it   
   call print_string
   call newline 
   ;print info
   mov dx,offset msg_hangman_info;the info about the game
   push dx 
   call print_string  
   
   
   ;generat num 0-19
   sub sp,2;Saves space in the stack
   push bp;save bp 
   push 20
   call generate_random_number
   mov bp,sp
   mov dx,[bp+2];pull the value
   pop bp;pull bp
   add sp,2;Returns the stack to the source     
   mov randomNum,dx
   
   ;generat num 0-2
   sub sp,2;Saves space in the stack
   push bp;save bp 
   push 3
   call generate_random_number
   mov bp,sp
   mov ax,[bp+2];pull the value
   pop bp;pull bp
   add sp,2;Returns the stack to the source
   
   ;print topic
   mov si,ax
   shl si,1;mul in 2
   mov dx,[topics+si]
   push dx
   call print_string
   call newline
   
   ;mack the random number point on the correct topic   
   mov bx,20;mul in 20 ax
   mul bx 

   add randomNum,ax     
   mov si, randomNum;for choose a word in the arr   
   shl si, 1; because words - 2byte,randomNum - 1byte
                        
   mov dx, [words + si];tack the addres and + index 
   mov selectedWord,dx;save to the later
   
   
   popa
   ret
   
endp menu;End of the menu function 
          
;-------------------------------------------------- 
; Function: Prints a string from the stack using DOS interrupt 21h, ah=09h
; Input:    Pointer to string (offset), must be in the end'$'.
; Output:   None.
;--------------------------------------------------

proc print_string
   pusha            ;save all the registers in the stack
   mov bp, sp       ;bp work with like bx data segment
   mov dx, [bp+18]  ;18 - because pusha 16,fun 2
      
   mov     ah, 09h;Interrupt of print,use dx 
   int     21h    ;Interrupt of print,use dx
 
   popa     ;Pull all the registers from the stack and save them in the registers      
   retn 2   ;For clean the stack, I writh 2 beacuse push only one parameter for the function 
endp print_string

;-------------------------------------------------- 
; Function: Fill the hidden_word with '_' or with letters from old_letters 
;           if the letter in selectedWord
; Input:    None.
; Output:   Return full hidden_word with '_' and chars.
;-------------------------------------------------- 

proc updateHiddenWord 
        
    pusha
   
        
        mov si,selectedWord ; the random word
        mov bx,offset hidden_word ; the array of guesses
    
        loop_process_word:
            mov al,[si] ; load the character from selectedWord
            mov di,offset old_letters ; the array of guessed letters
                check_guessed_letters:
                    cmp [di],0; until old letter end
                    je add_underscore ; go to _
                    mov ah,[di]
                    cmp al,ah ; check if letter matches
                    je add_char_letter ; add letter  
                    inc di    
                jmp check_guessed_letters
                add_char_letter:
                
                mov [bx],ah

                jmp continue_processing
                
                add_underscore:
                mov [bx],'_'
                continue_processing: 
            
            inc si 
            inc bx
            cmp [si],'$';stop if the last char is $
        jne loop_process_word 
        mov [bx],'$';add to the str.length + 1 &
          
         
      
    popa
    
    ret  
endp updateHiddenWord

;-------------------------------------------------- 
; Function: Check if hidden_word not have '_' 
;           because, if have the need guess more latter.
; Input:    Space in stack.
; Output:   If the player win  return 1 else 0,save it in the stack.
;-------------------------------------------------- 

proc check_win 
    
        
    push si
    push ax
   
        
        ;mov si,selectedWord ; the random word
        mov si,offset hidden_word ; the array of guesses
        mov dl,1;win 
        
        check_win_loop:
            mov al,[si]
            cmp al,'_'
            jne skip_check_win_loop
                mov dl,0;not win
            skip_check_win_loop: 
            inc si
            cmp al,'$'
        jne check_win_loop
        
        mov bp,sp
        mov [bp+8],dx;save dx in space, 8 because 2 x push - 4 ,fun - 2, parameter - 2
          
                  
    pop ax
    pop si
    ret  
endp check_win

;-------------------------------------------------- 
; Function: Check if some letter add to hidden_word.
; Input:    Space in stack.
; Output:   Return 1 or 0 with the stack, if 1 correct guse, 0 worng guse.
;--------------------------------------------------  
  
proc check_correct_guess 
    
    pusha
    
    mov si,offset hidden_word
    mov cl,-1;because it count with $ 
    mov dx,0;uncorrect letter 
                          
    proces_word:
    mov al,[si]; char char hiding_word 
    
    cmp al,'_'; chech char == '_'
    je add_num_hidden_letter
        inc cl
    add_num_hidden_letter:
    inc si
    cmp al,'$';check end of hidden_word
    jne proces_word 
    
    
    cmp cl,num_hidden_letter;check if correct letter add
    jbe skip_hidden_letter
        mov num_hidden_letter,cl
        mov dl,1;correct letter
         
        ;guess correct letter msg  
        mov cx,offset msg_hidden_guess
        push cx
        call print_string
        call newline
        
    skip_hidden_letter:
    
    mov bp,sp
    mov [bp + 20],dx; save in the space,20 because pusha - 16, fun - 2, parameter - 2  
    
    popa
    ret  
endp check_correct_guess 

;-------------------------------------------------- 
; Function: Do all the input function in the end return in the stack. 
;           1 if courrect else 0. 
; Input:    From the stack.
; Output:   Return to the stack 1 if the legal and courrect, 0 if the illegal.
;--------------------------------------------------      

 proc get_input
    pusha 
    
        mov dx,offset msg_get_char_input
        push dx
        call print_string ;print Enter a Char:
        
        sub sp,2;Saves space in the stack
        push bp;save bp
        call get_char
        mov bp,sp
        mov ax,[bp+2];pull the char input value
        pop bp;pull bp
        add sp,2;Returns the stack to the source 
        
        push ax;char input value
        sub sp,2;Saves space in the stack
        push bp;save bp
        push ax
        call check_illegal_letter
        mov bp,sp
        mov bx,[bp+2];pull the value
        pop bp;pull bp
        add sp,2;Returns the stack to the source 
        pop ax;pull char input value 
        
        cmp bl,1;if 1 letter in range
        jne skip_check_already_selected;if the letter not in the range jmp
                                             
            
            sub sp,2;Saves space in the stack
            push bp;save bp
            push ax;char input value
            call check_letter_exists;need add
            mov bp,sp
            mov bx,[bp+2];pull the boolean value
            pop bp;pull bp
            add sp,2;Returns the stack to the source 
            
            cmp bl,0 ; if the letter in the list 
            jne skip_print;jmp if letter not in the list
            
                mov dx,offset msg_letter_already_selected 
                push dx
                call print_string

                jmp skip_print
                
                 
        skip_check_already_selected:
        mov dx,offset msg_not_in_range; print not_in_range_msg
        push dx
        call print_string
        
        skip_print: 
        
        mov bp,sp
        mov [bp + 20],bl
                              
                              
    popa
    ret
 endp get_input 
 
;-------------------------------------------------- 
; Function: Get char from the user and do in the end\n function.
; Input:    None.
; Output:   Return to the stack the char.
;--------------------------------------------------
  
proc get_char
    push ax
    push bp
    push sp
           
    mov ah, 01h ; Character input with echo
    int 21h ; Character in AL   
    call newline 
    
    mov bp,sp
    mov [bp+10],ax
    
    pop sp
    pop bp
    pop ax  
    ret
endp get_char

;-------------------------------------------------- 
; Function: Check if the letter in range of a-z 
; Input:    Save space in the stack.
; Output:   Return 1 if the letter in the range else retutn 0.
;--------------------------------------------------
            
proc check_illegal_letter
    pusha
        
    mov bp,sp
    mov al,[bp+18]
    mov cx,0
    
    ;a-z
    cmp al,97 ;  al < 97 - a
    jb latter_not_in_range
        cmp al,122; al > 122 - z
        ja latter_not_in_range    
            mov cl,1; letter in range
    latter_not_in_range:
    
    mov [bp+22],cx 
       
    popa
    retn 2  
endp check_illegal_letter 
                
;-------------------------------------------------- 
; Function: Check if the ltter exists in old_letters. 
; Input:    From the stack.
; Output:   Return in stack the 1 - letter not in the arr,0 - letter in the arr.
;--------------------------------------------------
 
proc check_letter_exists 
    pusha  
    mov bp,sp
    mov ax,[bp+18] 
    
    mov si,offset old_letters ;the arr
    
    
    check_loop:
        cmp [si],0 ;check if we dont have more letters to check 
        je letter_not_found 
        
                    ;use si beacuse si creat for work with arr indexs(Continuous memory) 
        cmp al,[si] ;check if the letter is in the arr[si]
        je letter_found
                    
        inc si;go to the next value        
    jmp check_loop
                
        letter_found:
        mov bx,0;letter in the arr(not add letter) - 0
        jmp skip2;if letter found bl = 1 and skip the found
            
        letter_not_found:
        push ax;push to add_letter
        call add_letter  
        mov bx,1;letter not in the arr(add letter) - 1
        skip2:
        
          
    mov [bp+22],bx    
    popa
    retn 2
endp check_letter_exists  

;-------------------------------------------------- 
; Function: Add letter to old letters,if old letters full (26) not add letter from the stack. 
; Input:    Space in stack.
; Output:   None.
;--------------------------------------------------
  
proc add_letter    
    pusha
     
    mov bp,sp
    mov ax,[bp+18]
    mov cx,0;amout of letter in the arr
    
    mov si,offset old_letters
    ;run until the one after the last letter in the arr
    check_add_letter_loop:
        cmp [si],0
        je skip_check_add_letter_loop
        inc si
        inc cx
    jmp check_add_letter_loop
    
    skip_check_add_letter_loop:
    
             
    cmp cx,MAX_LETTERS;letter_index == 26
    je letter_arr_full   ;check if the arr is full (26)   
           
        mov bx, offset old_letters;else,go to the first of the old_letters arr
        add bx,cx; bx point of the index in the
        mov [bx],al
        
    letter_arr_full:
    
    popa
    retn 2
endp add_letter  

;-------------------------------------------------- 
; Function: Printing all the old letters that are not correct guess. 
; Input:    None.
; Output:   None.
;-------------------------------------------------- 
          
proc print_letter_guses 
    pusha
     
     
    mov bx,offset old_letters
    loop_old_letters:
    
    mov ch,[bx]
    mov cl,1
        mov si,selectedWord
        loop_selectedWord:
        
            mov al,[si]; char char from selectedWord
            inc si
            cmp ch,al; not need to print
            jne skip_change_cl
                mov cl,0 ;if cl = 0 - char not in the word
            skip_change_cl:
        cmp al,'$'
        jne loop_selectedWord
        
        cmp cl,1;if cl = 1 not need to print the char - char in the word
        jne print_char
            mov dl,ch ; Print letter  ch
            mov ah, 2     
            int 21h
            mov dl,' '; pritn ' ' between the chars
            int 21h   
        print_char:
    inc bx
        
    cmp ch,0;check if we got to the end (0)
    jne loop_old_letters
    
    popa
    ret  
endp print_letter_guses

;-------------------------------------------------- 
; Function: Generate number bettwen (0 - number in stack-1) and put in the stack. 
; Input:    Number to div,space in stack.
; Output:   Return into stack the random number.
;--------------------------------------------------

proc generate_random_number 
    pusha 
        mov ah, 02Ch;Get the Time in format of hours, minutes, seconds, and milliseconds (HH:MM:SS:MS) 
        mov ah,0    ;interrupts to get the system time 
        int 1ah     ;now clocks ticks will be saved in DX
        
        mov bp, sp
        mov ax,dx
        mov dx,0        ;clear the DX to zero
        mov bx,[bp+18]  ;generate between 0 - number-1, 18 - pusha 16+fun 2
        div bx          ;divide ax by bx 
        
        mov bp, sp      ;bp work with like bx with data segment
        mov [bp+22],dx  ;22 - because pusha 16,fun 2,push x 2 - 4 
     
    popa
    retn 2
endp generate_random_number

;-------------------------------------------------- 
; Function: Printing \n witn 13,10 and interapt. 
; Input:    None.
; Output:   None.
;--------------------------------------------------
            
proc newline
     
    push ax
    push dx
        
    mov ah, 02h       ; for print only one char
    mov dl, 10        ; Line Feed  10
    int 21h
    mov dl, 13        ; Carriage Return  13
    int 21h  
           
    pop dx
    pop ax
    
    ret  
endp newline 

 
end

    

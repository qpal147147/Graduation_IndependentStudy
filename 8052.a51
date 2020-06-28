		ORG 00H
		JMP START
		;ORG 0BH
		;JMP Timer0
START:
		CLR RI
		MOV TMOD,#21H
		MOV TH1,#253
		MOV TL1,#253
		SETB TR1
		ANL PCON,#7FH
		MOV SCON,#50H
        MOV 30H,#00H
        MOV 31H,#00H
	    MOV 32H,#00H	
        MOV P2,#0FH
		CLR P2.1
		MOV R2,#00H
		MOV R4,#0
		CLR P1.0
DD1:	
        CALL DELAY
	    DJNZ R4,DD1
		MOV R4,#0
DD2:	CALL DELAY
	    DJNZ R4,DD2			
;========AT========
BEGIN:  CLR TI
		MOV SBUF,#41H	
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			;jmp $
			CALL ROK
;==========AT+CWMODE=3======
			CLR TI
		MOV SBUF,#41H	
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	
			JNB TI,$
			CLR TI
		MOV SBUF,#57H	
			JNB TI,$
			CLR TI
		MOV SBUF,#4DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#4FH	
			JNB TI,$
			CLR TI
		MOV SBUF,#44H	
			JNB TI,$
			CLR TI
		MOV SBUF,#45H	
			JNB TI,$
			CLR TI
		MOV SBUF,#3DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#33H	
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
;=====AT+CWJAP="1234","12345678"====
			CLR TI
		MOV SBUF,#41H	
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	
			JNB TI,$
			CLR TI			
		MOV SBUF,#2BH	
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	
			JNB TI,$
			CLR TI
		MOV SBUF,#57H	
			JNB TI,$
			CLR TI
		MOV SBUF,#4AH	
			JNB TI,$
			CLR TI
		MOV SBUF,#41H	
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	
			JNB TI,$
			CLR TI
		MOV SBUF,#3DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#22H	
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	
			JNB TI,$
			CLR TI
		MOV SBUF,#32H	
			JNB TI,$
			CLR TI
		MOV SBUF,#33H	
			JNB TI,$
			CLR TI
		MOV SBUF,#34H	
			JNB TI,$
			CLR TI
		MOV SBUF,#22H	
			JNB TI,$
			CLR TI
		MOV SBUF,#2CH	
			JNB TI,$
			CLR TI
		MOV SBUF,#22H	
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	
			JNB TI,$
			CLR TI
		MOV SBUF,#32H	
			JNB TI,$
			CLR TI
		MOV SBUF,#33H	
			JNB TI,$
			CLR TI
		MOV SBUF,#34H	
			JNB TI,$
			CLR TI
		MOV SBUF,#35H	
			JNB TI,$
			CLR TI
		MOV SBUF,#36H	
			JNB TI,$
			CLR TI
		MOV SBUF,#37H	
			JNB TI,$
			CLR TI
		MOV SBUF,#38H	
			JNB TI,$
			CLR TI
		MOV SBUF,#22H	
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
;==========AT+CIFSR======
			CLR TI
		MOV SBUF,#41H	
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	
			JNB TI,$
			CLR TI
		MOV SBUF,#46H	
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	
			JNB TI,$
			CLR TI
		MOV SBUF,#52H	
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
RLOPIP:
			JNB RI,$
            CLR RI
		MOV R1,SBUF
			CJNE R1,#053H,RLOPIP
			JNB RI,$
			CLR RI
		MOV R1,SBUF
			CJNE R1,#054H,RLOPIP
			JNB RI,$
			CLR RI
		MOV R1,SBUF
			CJNE R1,#041H,RLOPIP
			JNB RI,$
			CLR RI
		MOV R1,SBUF
			CJNE R1,#049H,RLOPIP
			JNB RI,$
			CLR RI
		MOV R1,SBUF
			CJNE R1,#050H,RLOPIP
			JNB RI,$
			CLR RI
		MOV R1,SBUF
			CJNE R1,#02CH,RLOPIP
			JNB RI,$
			CLR RI
		MOV A,SBUF
			CJNE A,#022H,RLOPIP
		MOV R3,#0
		MOV R1,#40H
RIP:		JNB RI,$
			CLR RI
		MOV A,SBUF
			CJNE A,#022H,PRIIP
		MOV 6EH,R3
			JMP R4L
PRIIP:	MOV @R1,A
			INC R3
			INC R1
			JMP RIP
R4L:		CALL ROK
;============AT+CIPMUX=1=====
			CLR TI
		MOV SBUF,#41H	
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	
			JNB TI,$
			CLR TI
		MOV SBUF,#4DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#55H	
			JNB TI,$
			CLR TI
		MOV SBUF,#58H	
			JNB TI,$
			CLR TI
		MOV SBUF,#3DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
;===========AT+CIPSERVER=1,8888========
			CLR TI
		MOV SBUF,#41H	
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	
			JNB TI,$
			CLR TI
		MOV SBUF,#45H	
			JNB TI,$
			CLR TI
		MOV SBUF,#52H	
			JNB TI,$
			CLR TI
		MOV SBUF,#56H	
			JNB TI,$
			CLR TI
		MOV SBUF,#45H	
			JNB TI,$
			CLR TI
		MOV SBUF,#52H	
			JNB TI,$
			CLR TI
		MOV SBUF,#3DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	
			JNB TI,$
			CLR TI
		MOV SBUF,#2CH	
			JNB TI,$
			CLR TI
		MOV SBUF,#38H	
			JNB TI,$
			CLR TI
		MOV SBUF,#38H	
			JNB TI,$
			CLR TI
		MOV SBUF,#38H	
			JNB TI,$
			CLR TI
		MOV SBUF,#38H	
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
            CLR RI
;			SETB P2.1
AAA:    	JB  RI,RDATA
                JMP AAA
AA:    						
                SETB P2.0
			JNB   P2.0,BB
			JMP  AA
BB:			CALL DELAY
			SETB P2.0
			JB  P2.0,AA
		    INC  R2
CC:			SETB P2.0
			JNB  P2.0,CC
			CJNE R2,#04H,EE
;			MOV 30H,#00H
;            MOV 31H,#00H
;	        MOV 32H,#00H	
 ;           MOV P2,#0FH
			CALL SSP
;			CLR P2.1
;		    MOV R2,#00H
 ;           CLR RI	
			JMP START
EE:			CALL SDP
			MOV A,R2
			SWAP A
			ANL P2,#00001111B
			ORL A,P2
			MOV P2,A
			MOV A,R2
            ADD A,#30H			
            CJNE A,30H,D1
            CLR P2.1			
            JMP  WAIT1			
D1:         CJNE A,31H,D2
            CLR  P2.1
            JMP  WAIT1	
D2:         CJNE A,32H,D3
            CLR  P2.1
            JMP  WAIT1	
D3:	        CALL SDP2
			CALL DELAY2
			JMP AA
;=========================
RDATA1:JMP AAA
RDATA:
     JNB  RI,$
;     SETB P2.1
	 CLR  RI
	 MOV  R1,SBUF
     CJNE R1,#047H,RDATA1  ;/G 
;	 SETB P2.1
     JNB  RI,$
     CLR  RI
;	 SETB P2.1
     MOV  R1,SBUF
     CJNE R1,#045H,RDATA1  ;/E
;	 SETB P2.1
     JNB  RI,$
     CLR  RI
     MOV  R1,SBUF
     CJNE R1,#054H,RDATA1  ;/T
;	 SETB P2.1
     JNB  RI,$
     CLR  RI
     MOV  R1,SBUF
     CJNE R1,#020H,RDATA1  ;/
     JNB  RI,$
     CLR  RI
     MOV  R1,SBUF
     CJNE R1,#02FH,RDATA1  ;//
     JNB  RI,$
     CLR  RI
     MOV  R1,SBUF
     CJNE R1,#071H,RDATA1  ;/q
     JNB  RI,$
     CLR  RI
     MOV  R1,SBUF
     CJNE R1,#03DH,RDATA1  ;/=
;	 SETB P2.1
     JNB  RI,$
     CLR  RI
     MOV  R1,SBUF
	 MOV  30H,R1
	 JNB  RI,$
     CLR  RI
     MOV  R1,SBUF
     CJNE R1,#03AH,READ1  ;q=:
;	 MOV  P1,R1
	 JMP  ROK1
READ1:MOV  31H,R1
	 JNB  RI,$
     CLR  RI
     MOV  R1,SBUF
     CJNE R1,#03AH,READ2  ;q=:
;	 MOV  P1,R1
	 JMP  ROK1
READ2:MOV 32H,R1
	 JNB  RI,$
     CLR  RI
     MOV  R1,SBUF
     CJNE R1,#03AH,READ3  ;q=:
;	 MOV  P1,R1
	 JMP  ROK1
READ3:MOV 30H,#00H
      MOV 31H,#00H
	  MOV 32H,#00H
ROK1: 
          SETB P2.1
	  CLR  RI
	  CALL CLE
	  JMP AA
WAIT1:MOV R5,#00H
WAIT2:MOV R6,#00H  
WAIT3:MOV R7,#00H
      SETB P1.0
WAIT4:SETB P2.2
	  JNB P2.2,WAIT5
	  DJNZ R7,WAIT4
	  DJNZ R6,WAIT3
	  DJNZ R5,WAIT2
      SETB P2.1
	  CLR P1.0
	  JMP AA
WAIT5:SETB P2.3
      CLR P1.0
      JNB P2.3,LEAVE
	  JMP WAIT5
LEAVE:SETB P2.1
	  CALL SDP2
	  CALL DELAY
      JMP AA
;====SEND POINT=======
SDP:
;====AT+CIPSTART=0,"TCP","projectorder.hostingerapp.com",80======			
		CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	;+
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	;I
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI	
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI		
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI	
		MOV SBUF,#52H	;R
			JNB TI,$
			CLR TI		
        MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI       
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI 		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI			
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI		
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI		
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI		
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI		
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI			
		MOV SBUF,#6AH	;j
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI			
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI			
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI		
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI		
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI		
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI		
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI		
		MOV SBUF,#67H	;g
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI		
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI			
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI			
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI		
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI			
		MOV SBUF,#6DH	;m
			JNB TI,$
			CLR TI			
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#38H	;8
			JNB TI,$
			CLR TI		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI			
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
;====AT+CIPSEND=0,165======					
		CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	;+
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	;I
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI			
		MOV SBUF,#45H	;E
			JNB TI,$
			CLR TI			
		MOV SBUF,#4EH	;N
			JNB TI,$
			CLR TI		
		MOV SBUF,#44H	;D
			JNB TI,$
			CLR TI				
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI 		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI		
		MOV SBUF,#36H	;6
			JNB TI,$
			CLR TI
		MOV SBUF,#34H	;4
			JNB TI,$
			CLR TI				
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
;=========================================	
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#4FH	;O
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
        MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI
	    MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI			
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI
		MOV SBUF,#48H	;H
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T  
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T  
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI	
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI	
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI
		MOV SBUF,#48H	;H
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#6AH	;j
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI			
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI			
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI		
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI		
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI		
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI		
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI		
		MOV SBUF,#67H	;g
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI		
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI		
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI			
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI		
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI			
		MOV SBUF,#6DH	;m
			JNB TI,$
			CLR TI		
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI	
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI	
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI	
		MOV SBUF,#2AH	;*
			JNB TI,$
			CLR TI	
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI	
		MOV SBUF,#2AH	;*
			JNB TI,$
			CLR TI	
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI	
		MOV SBUF,#43H	;C
			JNB TI,$
		    CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI	
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#79H	;y
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI	
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI	
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#6CH	;l
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI
		MOV SBUF,#78H	;x
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#77H	;w
			JNB TI,$
			CLR TI
		MOV SBUF,#77H	;w
			JNB TI,$
			CLR TI
		MOV SBUF,#77H	;w
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#66H	;f
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#6DH	;m
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#75H	;u
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#6CH	;l
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI	
		MOV SBUF,#43H	;C
			JNB TI,$
		    CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#4CH	;L
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#67H	;g
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI
		MOV SBUF,#35H	;5
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI	
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI
		MOV A,R2
			ADD A,#30H
		MOV SBUF,A     ;
			JNB TI,$
			CLR TI 
	        RET  

;====SEND POINT2=======
SDP2:
;====AT+CIPSTART=0,"TCP","projectorder.hostingerapp.com",80======			
		CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	;+
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	;I
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI	
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI		
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI	
		MOV SBUF,#52H	;R
			JNB TI,$
			CLR TI		
        MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI       
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI 		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI			
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI		
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI		
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI		
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI		
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI			
		MOV SBUF,#6AH	;j
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI			
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI			
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI		
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI		
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI		
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI		
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI		
		MOV SBUF,#67H	;g
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI		
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI	
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI			
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI		
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI			
		MOV SBUF,#6DH	;m
			JNB TI,$
			CLR TI			
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#38H	;8
			JNB TI,$
			CLR TI		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI			
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
;====AT+CIPSEND=0,165======					
		CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	;+
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	;I
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI			
		MOV SBUF,#45H	;E
			JNB TI,$
			CLR TI			
		MOV SBUF,#4EH	;N
			JNB TI,$
			CLR TI		
		MOV SBUF,#44H	;D
			JNB TI,$
			CLR TI				
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI 		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI		
		MOV SBUF,#36H	;6
			JNB TI,$
			CLR TI
		MOV SBUF,#34H	;4
			JNB TI,$
			CLR TI				
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
;=========================================	
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#4FH	;O
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
        MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI
	    MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI			
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI
		MOV SBUF,#48H	;H
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T  
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T  
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI	
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI	
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI
		MOV SBUF,#48H	;H
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#6AH	;j
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI			
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI			
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI		
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI		
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI		
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI		
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI		
		MOV SBUF,#67H	;g
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI		
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI		
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI			
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI		
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI			
		MOV SBUF,#6DH	;m
			JNB TI,$
			CLR TI		
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI	
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI	
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI	
		MOV SBUF,#2AH	;*
			JNB TI,$
			CLR TI	
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI	
		MOV SBUF,#2AH	;*
			JNB TI,$
			CLR TI	
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI	
		MOV SBUF,#43H	;C
			JNB TI,$
		    CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI	
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#79H	;y
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI	
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI	
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#6CH	;l
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI
		MOV SBUF,#78H	;x
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#77H	;w
			JNB TI,$
			CLR TI
		MOV SBUF,#77H	;w
			JNB TI,$
			CLR TI
		MOV SBUF,#77H	;w
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#66H	;f
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#6DH	;m
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#75H	;u
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#6CH	;l
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI	
		MOV SBUF,#43H	;C
			JNB TI,$
		    CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#4CH	;L
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#67H	;g
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI
		MOV SBUF,#35H	;5
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI	
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI
		MOV A,R2
			ADD A,#34H
		MOV SBUF,A     ;
			JNB TI,$
			CLR TI 
	        RET 
			
;====SEND START POINT=======
SSP:
;====AT+CIPSTART=0,"TCP","projectorder.hostingerapp.com",80======			
		CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	;+
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	;I
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI	
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI		
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI	
		MOV SBUF,#52H	;R
			JNB TI,$
			CLR TI		
        MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI       
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI 		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI			
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI		
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI		
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI		
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI		
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI			
		MOV SBUF,#6AH	;j
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI			
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI			
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI		
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI		
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI		
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI		
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI		
		MOV SBUF,#67H	;g
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI		
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI		
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI			
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI		
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI			
		MOV SBUF,#6DH	;m
			JNB TI,$
			CLR TI			
		MOV SBUF,#22H	;"
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#38H	;8
			JNB TI,$
			CLR TI		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI			
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
;====AT+CIPSEND=0,165======					
		CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	;+
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	;I
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI			
		MOV SBUF,#45H	;E
			JNB TI,$
			CLR TI			
		MOV SBUF,#4EH	;N
			JNB TI,$
			CLR TI		
		MOV SBUF,#44H	;D
			JNB TI,$
			CLR TI				
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI 		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI		
		MOV SBUF,#2CH	;,
			JNB TI,$
			CLR TI			
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI		
		MOV SBUF,#36H	;6
			JNB TI,$
			CLR TI
		MOV SBUF,#34H	;4
			JNB TI,$
			CLR TI				
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
;=========================================	
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#4FH	;O
			JNB TI,$
			CLR TI
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
        MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI
	    MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI			
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI
		MOV SBUF,#48H	;H
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T  
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T  
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI	
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI	
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI
		MOV SBUF,#48H	;H
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#6AH	;j
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI			
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI			
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI		
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI		
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI		
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI		
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI		
		MOV SBUF,#67H	;g
			JNB TI,$
			CLR TI		
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI		
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI		
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI			
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI		
		MOV SBUF,#2EH	;.
			JNB TI,$
			CLR TI		
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI		
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI			
		MOV SBUF,#6DH	;m
			JNB TI,$
			CLR TI		
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI	
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI	
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI	
		MOV SBUF,#2AH	;*
			JNB TI,$
			CLR TI	
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI	
		MOV SBUF,#2AH	;*
			JNB TI,$
			CLR TI	
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI	
		MOV SBUF,#43H	;C
			JNB TI,$
		    CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI	
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#79H	;y
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI	
		MOV SBUF,#20H	;  
			JNB TI,$
			CLR TI	
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#70H	;p
			JNB TI,$
			CLR TI
		MOV SBUF,#6CH	;l
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#2FH	;/
			JNB TI,$
			CLR TI
		MOV SBUF,#78H	;x
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#77H	;w
			JNB TI,$
			CLR TI
		MOV SBUF,#77H	;w
			JNB TI,$
			CLR TI
		MOV SBUF,#77H	;w
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#66H	;f
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#6DH	;m
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#75H	;u
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#6CH	;l
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#63H	;c
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI
		MOV SBUF,#64H	;d
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI	
		MOV SBUF,#43H	;C
			JNB TI,$
		    CLR TI	
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI	
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI	
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#2DH	;-
			JNB TI,$
			CLR TI
		MOV SBUF,#4CH	;L
			JNB TI,$
			CLR TI
		MOV SBUF,#65H	;e
			JNB TI,$
			CLR TI	
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#67H	;g
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#68H	;h
			JNB TI,$
			CLR TI
		MOV SBUF,#3AH	;:
			JNB TI,$
			CLR TI
		MOV SBUF,#31H	;1
			JNB TI,$
			CLR TI
		MOV SBUF,#35H	;5
			JNB TI,$
			CLR TI
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI	
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
		    CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#72H	;r
			JNB TI,$
			CLR TI
		MOV SBUF,#61H	;a
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#73H	;s
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#74H	;t
			JNB TI,$
			CLR TI
		MOV SBUF,#69H	;i
			JNB TI,$
			CLR TI
		MOV SBUF,#6FH	;o
			JNB TI,$
			CLR TI
		MOV SBUF,#6EH	;n
			JNB TI,$
			CLR TI
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI
		MOV SBUF,#30H   ;0
			JNB TI,$
			CLR TI 
	        RET
;====AT+CIPCLOSE=0======					
CLE:		CLR TI
		MOV SBUF,#41H	;A
			JNB TI,$
			CLR TI
		MOV SBUF,#54H	;T
			JNB TI,$
			CLR TI
		MOV SBUF,#2BH	;+
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI
		MOV SBUF,#49H	;I
			JNB TI,$
			CLR TI
		MOV SBUF,#50H	;P
			JNB TI,$
			CLR TI
		MOV SBUF,#43H	;C
			JNB TI,$
			CLR TI			
		MOV SBUF,#4CH	;L
			JNB TI,$
			CLR TI			
		MOV SBUF,#4FH	;O
			JNB TI,$
			CLR TI		
		MOV SBUF,#53H	;S
			JNB TI,$
			CLR TI
		MOV SBUF,#45H	;E
			JNB TI,$
			CLR TI					
		MOV SBUF,#3DH	;=
			JNB TI,$
			CLR TI 		
		MOV SBUF,#30H	;0
			JNB TI,$
			CLR TI					
		MOV SBUF,#0DH	
			JNB TI,$
			CLR TI
		MOV SBUF,#0AH	
			JNB TI,$
			CALL ROK
			RET
;====READ OK ======
ROK:  CLR RI
	  JNB  RI,$
      MOV R1,SBUF
	  CJNE R1,#04FH,ROK
	  CLR RI
	  JNB RI,$
	  MOV R1,SBUF
	  CJNE R1,#04BH,ROK
	  RET
DELAY:
      MOV R5,#250
S1:	  MOV R6,#50
S2:   DJNZ R6,S2
	  DJNZ R5,S1
	  RET
DELAY2:
      MOV R5,#20
S3:	  MOV R6,#250
S4:   DJNZ R6,S4
	  DJNZ R5,S3
	  RET
	  END
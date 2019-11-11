     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
	    
        MOV R0,#10 				;Number of Terms in Series 'n'
        MOV R1,#1  				;Counting Variable 'i'
        VLDR.F32 S0,=1			;Final answer
        VLDR.F32 S1,=1			;Temp variable 'temp'
        VLDR.F32 S2,=12			;'x' value

LOOP    CMP R1,R0				;Compare 'i' and 'n' 
        BLE LOOP1				;if i < n goto LOOP
        B stop					;else goto stop

LOOP1   VMUL.F32 S1,S1,S2		;temp = temp*x
        VMOV.F32 S4,R1			;Move the value in R1 i.e i to S4
        VCVT.F32.S32 S4, S4		;Converting int to floating point
        VDIV.F32 S1,S1,S4		;temp = temp/ i
        VADD.F32 S0,S0,S1		;Final answer = Final answer + temp
        ADD R1,R1,#1			;i = i + 1
        B LOOP					;To LOOP

stop    B stop
        ENDFUNC
        END
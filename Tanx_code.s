     AREA     appcode, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION	
; IGNORE THIS PART 	
	    
        MOV R0,#11 				;Number of Terms in Series 'n'
        MOV R1,#1  				;Counting Variable 'i'
        VLDR.F32 S0,=1			;Final answer
        VLDR.F32 S1,=1			;Temp variable 'temp'
        VLDR.F32 S2,=315			;'x' value in radians
		VLDR.F32 S10,=3.14159		
		VMUL.F32 S2,S2,S10
		VLDR.F32 S11,=180
		VDIV.F32 S2,S2,S11		;'x' value converted into degrees
		VLDR.F32 S3,=-1			;S3 = -1
		
		VMOV.F32 S7,S2			;Final answer 1 = x
        VMOV.F32 S8,S2			;Temp variable 'temp1' = x
		
LOOP    CMP R1,R0				;Compare 'i' and 'n' 
        BLE LOOP1				;if i < n goto LOOP
        B TANX					;else goto stop

LOOP1   ADD R2,R1,R1			;value in R2 is 2*i
		SUB R3,R2,#1			;value in R3 in ((2*i) - 1)
		VMUL.F32 S1,S1,S2		;temp = temp*x
		VMUL.F32 S1,S1,S2		;temp = temp*x. So above both lines result in initial temp = initial temp * x^2
		VMUL.F32 S1,S1,S3		;temp = temp * -1 (So that every alternate term is negative)
        VMOV.F32 S5,R2			;Move the value in R2 i.e 2*i to S5
        VCVT.F32.U32 S5, S5		;Converting int to floating point
        VMOV.F32 S6,R3			;Move the value in R3 i.e ((2*i) - 1) to S6
        VCVT.F32.U32 S6, S6		;Converting int to floating point
		VDIV.F32 S1,S1,S5		;temp = temp/ 2*i
		VDIV.F32 S1,S1,S6		;temp = temp/ ((2*i) - 1). So above both lines result in temp = temp / 2*i * ((2*i) - 1)
        VADD.F32 S0,S0,S1		;Final answer = Final answer + temp
		
		
		ADD R4,R2,#1			;value in R3 in ((2*i) + 1)
		VMUL.F32 S8,S8,S2		;temp1 = temp1*x
		VMUL.F32 S8,S8,S2		;temp1 = temp1*x. So above both lines result in initial temp = initial temp * x^2
		VMUL.F32 S8,S8,S3		;temp1 = temp1 * -1 (So that every alternate term is negative)
        VMOV.F32 S9,R4			;Move the value in R4 i.e ((2*i) + 1) to S9
        VCVT.F32.U32 S9, S9		;Converting int to floating point
		VDIV.F32 S8,S8,S5		;temp1 = temp1/ 2*i
		VDIV.F32 S8,S8,S9		;temp1 = temp1/ ((2*i) + 1). So above both lines result in temp = temp / 2*i * ((2*i) + 1)
		VADD.F32 S7,S7,S8		;Final answer 1 = Final answer 1 + temp1
		
		ADD R1,R1,#1			;i = i + 1
        B LOOP					;To LOOP

TANX	VDIV.F32 S12,S7,S0		;Tanx value is stored in S12 which is Sinx (S7) / Cosx (S0)  
		B stop

stop    B stop
        ENDFUNC
        END
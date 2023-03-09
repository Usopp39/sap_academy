*&---------------------------------------------------------------------*
*& Report zbd10_codice_fiscale
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_codice_fiscale.
PARAMETERS : p_m RADIOBUTTON GROUP rad,
             p_f RADIOBUTTON GROUP rad.

PARAMETERS : p_cf type string DEFAULT 'ABCDEF12G12V123A'.


PERFORM lunghezza using p_cf.
PERFORM letteranumero using p_cf.
perform mf using p_cf.



form lunghezza using p_cf.
if strlen( p_cf ) <> 16.
write |lunghezza del cf errata|.
endif.
endform.

form letteranumero using p_cf.
if not p_cf(6) && p_cf+8(1) && p_cf+11(1) && p_cf+15(1) co 'ABCDEFGHILMNOPQRSTUVZ'.
write / |non va bene LE lettere|.
else.
write / 'ok LE LETTERE'.
endif.
if not p_cf+6(2) && p_cf+9(2) && p_cf+12(3) co '123456789'.
write / |non va bene I numeri|.
els
write / 'ok I NUMERI'.
endif.
endform.
FORM MF USING P_CF.
CASE 'X'.
WHEN P_M.
IF P_CF+9(2) < 40.
WRITE / 'sessp CORRETTO'.
ELSE.
WRITE / 'SESSO SBAGLIATO'.
ENDIF.
WHEN P_F.
 IF P_CF+9(2) > 40.
WRITE / 'sesso CORRETTO'.
ELSE.
WRITE / 'SESSO SBAGLIATO'.
ENDIF.
ENDCASE.
ENDFORM.

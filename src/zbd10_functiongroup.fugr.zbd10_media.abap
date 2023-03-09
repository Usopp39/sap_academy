FUNCTION ZBD10_MEDIA.
*"----------------------------------------------------------------------
*"*"Interfaccia locale:
*"  IMPORTING
*"     REFERENCE(IT_NUM) TYPE  ZBD10_TABLE OPTIONAL
*"  EXPORTING
*"     REFERENCE(MEDIA) TYPE  FLOAT
*"----------------------------------------------------------------------
data: numeratore type float,
      risultatoo type float.
CALL FUNCTION 'ZBD04_SOMMAN'
 EXPORTING
   IV_TABELLA       = it_num
   IMPORTING
   EV_SOMMA         = numeratore
          .

CALL FUNCTION 'ZBD06_DIVISIONE'
 EXPORTING
  NUMERATORE         = numeratore
   DENOMINATORE       = lines( it_num )
IMPORTING
  RISULTATO          = risultatoo
EXCEPTIONS
  ZERO_DIV           = 1
   OTHERS             = 2
          .


ENDFUNCTION.

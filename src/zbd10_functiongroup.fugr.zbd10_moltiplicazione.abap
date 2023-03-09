FUNCTION ZBD10_MOLTIPLICAZIONE.
*"----------------------------------------------------------------------
*"*"Interfaccia locale:
*"  IMPORTING
*"     REFERENCE(IV_FATTORE1) TYPE  INT4
*"     REFERENCE(IV_FATTORE2) TYPE  INT4
*"  EXPORTING
*"     REFERENCE(EV_PRODOTTO) TYPE  INT4
*"     REFERENCE(EV_RISPETTO_A_SOGLIA) TYPE  CHAR10
*"----------------------------------------------------------------------


  ev_prodotto = iv_fattore1 * iv_fattore2.

  PERFORM confronto_soglia USING ev_prodotto CHANGING ev_rispetto_a_soglia.




ENDFUNCTION.

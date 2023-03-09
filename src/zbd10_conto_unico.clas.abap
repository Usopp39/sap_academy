CLASS zbd10_conto_unico DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      deposito IMPORTING i_importo TYPE i RETURNING VALUE(rv_saldo) TYPE i,
      prelievo IMPORTING i_ammontare TYPE i RETURNING VALUE(rv_saldo) TYPE i,
      crea_istanza RETURNING VALUE(r_conto) TYPE REF TO zbd10_conto_unico.
  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA: saldo   TYPE i, o_conto TYPE REF TO zbd10_conto_unico.
ENDCLASS.



CLASS zbd10_conto_unico IMPLEMENTATION.
  METHOD crea_istanza.
    IF o_conto IS INITIAL.
      CREATE OBJECT o_conto.
    ENDIF.
    r_conto = o_conto.
  ENDMETHOD.

  METHOD deposito.
    saldo += i_importo.
    rv_saldo = saldo.
  ENDMETHOD.
  METHOD prelievo.
    IF saldo >= i_ammontare.
      saldo -= i_ammontare.
      rv_saldo = saldo.

    ELSE.
      WRITE 'limite saldo'.
      EXIT.
    ENDIF.
  ENDMETHOD.


ENDCLASS.



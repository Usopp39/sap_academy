CLASS zbd10_bank_account DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      METHODS:
      deposito IMPORTING i_importo TYPE i RETURNING VALUE(rv_saldo) TYPE i,
      prelievo IMPORTING i_ammontare TYPE i RETURNING VALUE(rv_saldo) TYPE i,
      constructor importing i_saldo type i i_nome  type string i_cognome type string.
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: saldo TYPE i, v_nome type string, v_cognome type string.
ENDCLASS.



CLASS zbd10_bank_account IMPLEMENTATION.

  METHOD deposito.
    saldo += i_importo.
        rv_saldo = saldo.
  ENDMETHOD.

  METHOD prelievo.
  if saldo >= i_ammontare.
    saldo -= i_ammontare.
            rv_saldo = saldo.

else.
write 'limite saldo'.
exit.
endif.
  ENDMETHOD.

  METHOD constructor.
  saldo = i_saldo.
  v_nome = i_nome.
  v_cognome = i_cognome.
  ENDMETHOD.
ENDCLASS.

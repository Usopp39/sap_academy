*&---------------------------------------------------------------------*
*& Report zbd10_bank
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_bank.


DATA: o_account TYPE REF TO zbd10_bank_account.
CREATE OBJECT o_account
  EXPORTING
    i_nome    = 'Andrea'
    i_cognome = 'usopp'
    i_saldo = 1000.


    data(saldo) = o_account->prelievo( 200 ).

    write saldo.

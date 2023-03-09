*&---------------------------------------------------------------------*
*& Report zbd10_rubrica_telefonica
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_rubrica_telefonica.
data: BEGIN OF voce_elenco,
      id type i,
      nome type string,
      cognome type string,
      numero type string,
      END OF VOCE_ELENCO.

      voce_elenco-id = 1.
      voce_elenco-nome = 'Andrea'.
      voce_elenco-cognome = 'Zhou'.
      voce_elenco-numero = '123623713'.

      write: voce_elenco-id, voce_elenco-nome, voce_elenco-cognome, voce_elenco-numero.

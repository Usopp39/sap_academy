CLASS zbd10_cliente_normale DEFINITION INHERITING FROM zbd10_cliente_abs
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS: blocca REDEFINITION, sblocca REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zbd10_cliente_normale IMPLEMENTATION.


METHOD blocca.

    ls_cliente-bloccato = 'X'.
    ls_cliente-importo_credito = 0.
ENDMETHOD.
METHOD sblocca.
clear ls_cliente-bloccato.
ENDMETHOD.
ENDCLASS.

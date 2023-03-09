FUNCTION ZBD10_CF.
*"----------------------------------------------------------------------
*"*"Interfaccia locale:
*"  IMPORTING
*"     REFERENCE(CF) TYPE  CHAR20 OPTIONAL
*"     REFERENCE(LUNGHEZZA) TYPE  INT4 DEFAULT 16
*"  EXPORTING
*"     REFERENCE(CORRETTO) TYPE  STRING
*"----------------------------------------------------------------------


data hey type string.
perform lunghezza using cf changing hey.
perform nomecogn  using cf CHANGING hey.
perform mf        using cf changing hey.

ENDFUNCTION.

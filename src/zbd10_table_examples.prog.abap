*&---------------------------------------------------------------------*
*& Report zbd10_table_examples
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_table_examples.


DATA: BEGIN OF gs_voce_elenco,
        id      TYPE i,
        nome    TYPE text20,
        cognome TYPE text20,
        numero  TYPE text20,
      END OF gs_voce_elenco.

DATA: gs_voce2 LIKE gs_voce_elenco.

data: gt_rubrica like TABLE OF gs_voce_elenco.


**********************************************************************
** Alimento la tabella
gs_voce_elenco-id = 1.
gs_voce_elenco-nome = 'Gianluca'.
gs_voce_elenco-cognome = 'Collot'.
gs_voce_elenco-numero = '+39 345 1234567'.
cl_demo_output=>write( gs_voce_elenco ).
APPEND gs_voce_elenco TO gt_rubrica.    "aggingo una riga alla tabella
gs_voce_elenco-id = 2.
APPEND gs_voce_elenco TO gt_rubrica.
gs_voce2-id = 3.
gs_voce2-nome = 'Mattia'.
gs_voce2-cognome = 'Rossi'.
gs_voce2-numero = '+39 654 5234567'.
APPEND gs_voce2 TO gt_rubrica.

cl_demo_output=>write( gt_rubrica ).

**********************************************************************
** Leggo una riga della tabella (modo vecchio)
read table gt_rubrica index 4 into gs_voce_elenco.
cl_demo_output=>write( gs_voce_elenco ).

**********************************************************************
** Leggo una riga della tabella (modo nuovo)
cl_demo_output=>write( gt_rubrica[ 4 ] ).



**********************************************************************
** Cancello una riga



cl_demo_output=>display(  ).

*&---------------------------------------------------------------------*
*& Report ZBD10_READ_SCARR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_read_scarr.

DATA ls_scarr TYPE scarr.
SELECT-OPTIONS s_scarr FOR ls_scarr-carrid.

START-OF-SELECTION.
  SELECT * FROM scarr INTO TABLE @DATA(lt_scarr) WHERE carrid in @s_scarr.
 cl_salv_table=>factory( IMPORTING r_salv_table = data(lo_alv) CHANGING t_table = lt_scarr ).
    lo_alv->get_functions( )->set_all( ).

    lo_alv->get_columns( )->get_column( 'MANDT' )->set_technical( 'X' ).
    lo_alv->display( ).

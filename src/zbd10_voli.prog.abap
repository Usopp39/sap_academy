*&---------------------------------------------------------------------*
*& Report zbd10_voli
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_voli.
DATA T_SPFLI TYPE TABLE OF SPFLI.
PARAMETERS: p_from TYPE spfli-cityfrom DEFAULT 'ROME',
            p_to   TYPE spfli-cityto DEFAULT 'NEW YORK'.

START-OF-SELECTION.
  DATA(found) = abap_false.
  DATA: t_nodes TYPE TABLE OF spfli-cityto.
  APPEND p_from TO t_nodes.

  WHILE NOT found = abap_true.
    SELECT * FROM spfli
               INTO @data(ls_spfli)
                 WHERE cityfrom = @p_from.
      APPEND ls_spfli-cityto TO t_nodes.
      DATA: LT_SPFLI TYPE TABLE OF SPFLI.
      APPEND ls_spfli TO LT_SPFLI.
    ENDSELECT.


    IF sy-subrc = 0.
      found = abap_true.
      EXIT.
    ENDIF.
  ENDWHILE.

  SORT t_nodes.
  DELETE ADJACENT DUPLICATES FROM t_nodes.
    select * from spfli into @data(temp) where  cityto = @p_to and cityfrom = @p_from .

      APPEND temp TO t_spfli.



    ENDSELECT.
    if lines( t_spfli ) = 0.
          write: | non ce nulla |.
    endif.
  cl_demo_output=>display( LT_SPFLI ).
  cl_demo_output=>display( t_nodes ).

  cl_demo_output=>display( t_spfli ).

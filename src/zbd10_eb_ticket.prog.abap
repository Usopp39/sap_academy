*&---------------------------------------------------------------------*
*& Report zbd10_eb_ticket
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_eb_ticket.
DATA: ls_ticket TYPE zbd10_eb_ticket.

PARAMETERS: p_id_evt TYPE zbd10_eb_evento-id_evento.

PARAMETERS: p_ins  RADIOBUTTON GROUP rad DEFAULT 'X',
            p_del  RADIOBUTTON GROUP rad,
            p_mod  RADIOBUTTON GROUP rad,
            p_list RADIOBUTTON GROUP rad.

START-OF-SELECTION.
  CASE 'X'.
    WHEN p_ins.
      "Gestisco insrimento nuovo ticket
      ls_ticket-data_di_acquisto = sy-datum.
      ls_ticket-evento = p_id_evt.
      ls_ticket-id_partecipante = sy-uname.
      SELECT MAX( evento ) FROM zbd10_eb_ticket INTO ls_ticket-evento.
      ls_ticket-evento += 1.
      INSERT zbd10_eb_ticket FROM ls_ticket.

    WHEN  p_del.
      "Gestisco cancellazione ticket
    WHEN    p_mod.
      "Gestisco modifica ticket
    WHEN    p_list.
      "visualizzo lista ticket
      PERFORM visualizza_dati.
  ENDCASE.

FORM visualizza_dati.
  DATA BEGIN OF ls_output.
       INCLUDE TYPE zbd10_eb_ticket.
  DATA titolo TYPE zbd10_eb_evento-titolo.
  DATA END OF ls_output.
  DATA lt_output LIKE TABLE OF ls_output.

  "seleziono tutti i ticket della mia utenza
  SELECT * FROM zbd10_eb_ticket
           INTO TABLE @DATA(lt_ticket)
           WHERE id_partecipante = @sy-uname.

  LOOP AT lt_ticket INTO DATA(ls_ticket).
    MOVE-CORRESPONDING ls_ticket TO ls_output.
    SELECT SINGLE titolo FROM zbd10_eb_evento
                          INTO   ls_output-titolo
                          WHERE id_partecipante = ls_output-evento.
    APPEND ls_output TO lt_output.
  ENDLOOP.

  cl_salv_table=>factory(
    IMPORTING
      r_salv_table = DATA(lo_alv)
    CHANGING
      t_table      = lt_output ).
  "Display the ALV Grid
  "Enable default ALV toolbar functions
  lo_alv->get_functions( )->set_all( ).
  lo_alv->display( ).
ENDFORM.

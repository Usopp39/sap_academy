*&---------------------------------------------------------------------*
*& Report zbd10_eb_admin
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_eb_admin.

data: ls_evento type zbd10_eb_evento.

PARAMETERS: p_titolo TYPE zbd10_eb_evento-titolo DEFAULT 'fiera',
            p_descr  TYPE zbd10_eb_evento-descrizione DEFAULT '',
            p_luogo  TYPE zbd10_eb_evento-luogo,
            p_prezzo TYPE zbd10_eb_evento-prezzo,
            p_data_i TYPE zbd10_eb_evento-data_inizio,
            p_data_f TYPE zbd10_eb_evento-data_fine,
            p_ora_in TYPE zbd10_eb_evento-ora_inizio,
            p_ora_fi TYPE zbd10_eb_evento-ora_fine,
            p_catego TYPE zbd10_eb_evento-categoria,
            p_num_bi TYPE zbd10_eb_evento-numero_biglietti_disponibili.

PARAMETERS: p_ins  RADIOBUTTON GROUP rad DEFAULT 'X',
            p_del  RADIOBUTTON GROUP rad,
            p_mod  RADIOBUTTON GROUP rad,
            p_list RADIOBUTTON GROUP rad.

START-OF-SELECTION.
  CASE 'X'.
    WHEN p_ins.
      "Gestisco insrimento nuovo evento
      ls_evento-titolo       =   p_titolo.
      ls_evento-descrizione  =   p_descr .
      ls_evento-luogo        =   p_luogo .
      ls_evento-prezzo       =   p_prezzo.
      ls_evento-data_inizio  =   p_data_i.
      ls_evento-data_fine    =   p_data_f.
      ls_evento-ora_inizio   =   p_ora_in.
      ls_evento-ora_fine     =   p_ora_fi.
      ls_evento-categoria    =   p_catego.
      ls_evento-numero_biglietti_disponibili =  p_num_bi.
      ls_evento-organizzazione = sy-uname.
      select max( id_evento ) from zbd10_eb_evento into ls_evento-id_evento.
      ls_evento-id_evento += 1.
      insert zbd10_eb_evento from ls_evento.

    WHEN  p_del.
      "Gestisco cancellazione evento
    WHEN    p_mod.
      "Gestisco modifica evento
    WHEN    p_list.
      "visualizzo lista eventi
  ENDCASE.

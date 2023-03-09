*&---------------------------------------------------------------------*
*& Report zbd10_file
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_file.


SELECTION-SCREEN BEGIN OF BLOCK b01 WITH FRAME TITLE t01.
PARAMETERS  p_tab TYPE tabname OBLIGATORY.
SELECTION-SCREEN: SKIP 1.
PARAMETERS:
  upl   RADIOBUTTON GROUP file,
  downl RADIOBUTTON GROUP file.
SELECTION-SCREEN: SKIP 1.
PARAMETERS p_file  TYPE rlgrap-filename.
SELECTION-SCREEN END OF BLOCK b01.
SELECTION-SCREEN BEGIN OF BLOCK b02 WITH FRAME TITLE t02.
PARAMETERS:
  mod RADIOBUTTON GROUP act,
  del RADIOBUTTON GROUP act.
SELECTION-SCREEN END OF BLOCK b02.

DATA table TYPE REF TO data.
FIELD-SYMBOLS: <tab>  TYPE STANDARD TABLE,
               <line> TYPE any.

DATA: lt_f0         TYPE STANDARD TABLE OF char20,
      lv_f0         LIKE LINE OF lt_f0.

INITIALIZATION.
  t01 = 'Prepare data'.
  t02 = 'Action'.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM select_file USING p_file.

START-OF-SELECTION.


  CREATE DATA table TYPE TABLE OF (p_tab).
  ASSIGN table->* TO <tab>.

  IF upl = abap_true.

    TRY.
        CALL FUNCTION 'UPLOAD_XLS_FILE_2_ITAB'
          EXPORTING
            i_filename = p_file
          TABLES
            e_itab     = <tab>
          EXCEPTIONS
            file_error = 1
            OTHERS     = 2.
        IF sy-subrc <> 0.
          RETURN.
        ENDIF.
      CATCH    cx_sy_move_cast_error.
        RETURN.
    ENDTRY.

    IF mod = abap_true. "insert/modify

      MODIFY (p_tab) FROM TABLE <tab>.

    ENDIF.

    IF del = abap_true. "delete

      DELETE (p_tab) FROM TABLE <tab>.

    ENDIF.

  ENDIF.

  IF downl = abap_true.

    DATA lv_filename TYPE string.

    SELECT * FROM (p_tab) INTO TABLE <tab>.

    lv_filename = p_file.

    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        filename                = lv_filename
      TABLES
        data_tab                = <tab>
      EXCEPTIONS
        file_write_error        = 1
        no_batch                = 2
        gui_refuse_filetransfer = 3
        invalid_type            = 4
        no_authority            = 5
        unknown_error           = 6
        header_not_allowed      = 7
        separator_not_allowed   = 8
        filesize_not_allowed    = 9
        header_too_long         = 10
        dp_error_create         = 11
        dp_error_send           = 12
        dp_error_write          = 13
        unknown_dp_error        = 14
        access_denied           = 15
        dp_out_of_memory        = 16
        disk_full               = 17
        dp_timeout              = 18
        file_not_found          = 19
        dataprovider_exception  = 20
        control_flush_error     = 21
        OTHERS                  = 22.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
  ENDIF.

*&---------------------------------------------------------------------*
*&      Form  SELECT_FILE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_P_FILE  text
*----------------------------------------------------------------------*
FORM select_file  USING    p_p_file.
  CALL FUNCTION 'WS_FILENAME_GET'
    EXPORTING
      def_filename     = '*.*'
      def_path         = 'C:\'
      mask             = ',All files,*.*.'
      mode             = 'O'
      title            = 'PC file'
    IMPORTING
      filename         = p_file
    EXCEPTIONS
      inv_winsys       = 1
      no_batch         = 2
      selection_cancel = 3
      selection_error  = 4
      OTHERS           = 5.
ENDFORM.





*PARAMETERS: p_id TYPE but000-partner.
*
*DATA:
*  ls_but000 TYPE but000,
*  lv_name   TYPE char100,
*  lt_but000 TYPE TABLE OF but000.
*
*SELECT-OPTIONS so_bpid FOR ls_but000-partner.
*
*
*SELECT * FROM but000 INTO TABLE lt_but000
*  WHERE partner IN so_bpid.
*
*IF sy-subrc NE 0.
**  WRITE: / |Nessu BP trovato con codice: { p_id }|.
**  EXIT.
**  RETURN.
*  MESSAGE |Nessu BP trovato| TYPE 'E'.
*ENDIF.
*
*LOOP AT lt_but000 INTO ls_but000.
*
*  CLEAR: lv_name.
*
*  PERFORM prepare_name USING ls_but000 CHANGING lv_name.
*
*  WRITE: / |output ottenuto con select: { lv_name }|.
*
*
*  CALL FUNCTION 'BUP_BUT000_SELECT_SINGLE'
*    EXPORTING
*      i_partner       = ls_but000-partner
**     I_VALID_TIME    =
**     I_VALDT         =
**     I_VALDT_SEL     = SY-DATLO
**     I_CP_EXCLUDE    = ' '
**     IV_REQ_BLK_MSG  = ' '
**     IV_REQ_MASK     = 'X'
*    IMPORTING
*      e_but000        = ls_but000
*    EXCEPTIONS
*      not_found       = 1
*      internal_error  = 2
*      blocked_partner = 3
*      OTHERS          = 4.
*  IF sy-subrc <> 0.
*    WRITE: / |Nessu BP trovato con codice: { ls_but000-partner }|.
*  ENDIF.
*
*  PERFORM prepare_name USING ls_but000 CHANGING lv_name.
*
*  WRITE: / |output ottenuto con funzione: { lv_name }|.
*
*
*
*ENDLOOP.
**&---------------------------------------------------------------------*
**& Form prepare_name
**&---------------------------------------------------------------------*
**& text
**&---------------------------------------------------------------------*
**&      --> LS_BUT000
**&      <-- LV_NAME
**&---------------------------------------------------------------------*
*FORM prepare_name  USING    is_but000 TYPE but000
*                   CHANGING cv_name.
*
*  CASE is_but000-type.
*    WHEN '1'. "person
*      CONCATENATE is_but000-name_first is_but000-name_last INTO cv_name SEPARATED BY space.
*    WHEN '2'. "org
*      CONCATENATE is_but000-name_org1 is_but000-name_org2 INTO cv_name SEPARATED BY space.
*    WHEN '3'. "group
*      CONCATENATE is_but000-name_grp1 is_but000-name_grp2 INTO cv_name SEPARATED BY space.
*  ENDCASE.
*
*ENDFORM.

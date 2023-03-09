*&---------------------------------------------------------------------*
*& Report zbd10_dataset
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_dataset.


PARAMETERS p_file LIKE rlgrap-filename.
DATA: filename TYPE string,
      lt_tabella type table of zbd10_academy23,
      temp type string,
      parteci type zbd10_academy23.
PARAMETERS: download RADIOBUTTON GROUP rad,
            upload RADIOBUTTON GROUP rad,
            alv AS CHECKBOX DEFAULT '',
            test as checkbox default ''.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file. "per selezionare il file attraverso la finestra
  CALL FUNCTION 'WS_FILENAME_GET'
    EXPORTING
      def_filename     = '*.*'
      def_path         = 'C:\'
      mask             = ',All files,*.*.'
      mode             = 'O'
      title            = 'PC file'
    IMPORTING
      filename         = p_file
*   RC                     =
    EXCEPTIONS
      inv_winsys       = 1
      no_batch         = 2
      selection_cancel = 3
      selection_error  = 4
      OTHERS           = 5.

START-OF-SELECTION.
data table type table of zbd10_academy23.
filename = p_file.




if upload = 'X'.
  DATA(dset) = '/tmp/Academy_csv.csv'.
      OPEN DATASET dset FOR INPUT IN TEXT MODE ENCODING DEFAULT.
      IF sy-subrc <> 0.
        CALL FUNCTION 'POPUP_TO_INFORM'
          EXPORTING
            titel = 'Errore apertura file'
            txt1  = 'Non riuscito ad aprire'
            txt2  = 'Non possibile leggere i dati'.
*           TXT3  = ' '
*           TXT4  = ' '
        .
        EXIT.
      ENDIF.
      DO 3 times.
        READ DATASET dset INTO temp.
clear parteci.
          SPLIT temp AT ';' INTO

          parteci-id_partecipante
          parteci-cognome
          parteci-nome
          parteci-data_di_nascita
          parteci-luogo_di_nascita
          parteci-ccelera.

  parteci-client = 100.

     append parteci to lt_tabella.


write / parteci.




      ENDDO.
close DATASET dset.

ENDIF.


if download = abap_true.
    SELECT * FROM zbd10_academy23 INTO TABLE table.
  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename                        = filename

    tables
      data_tab                        = table
   EXCEPTIONS
     FILE_WRITE_ERROR                = 1
     NO_BATCH                        = 2
     GUI_REFUSE_FILETRANSFER         = 3
     INVALID_TYPE                    = 4
     NO_AUTHORITY                    = 5
     UNKNOWN_ERROR                   = 6
     HEADER_NOT_ALLOWED              = 7
     SEPARATOR_NOT_ALLOWED           = 8
     FILESIZE_NOT_ALLOWED            = 9
     HEADER_TOO_LONG                 = 10
     DP_ERROR_CREATE                 = 11
     DP_ERROR_SEND                   = 12
     DP_ERROR_WRITE                  = 13
     UNKNOWN_DP_ERROR                = 14
     ACCESS_DENIED                   = 15
     DP_OUT_OF_MEMORY                = 16
     DISK_FULL                       = 17
     DP_TIMEOUT                      = 18
     FILE_NOT_FOUND                  = 19
     DATAPROVIDER_EXCEPTION          = 20
     CONTROL_FLUSH_ERROR             = 21
     OTHERS                          = 22
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


  endif.

if alv = abap_true.

  DATA: gt_sspr TYPE TABLE OF zbd10_academy23.

DATA: it_fieldcat TYPE slis_t_fieldcat_alv,
      wa_fieldcat TYPE slis_fieldcat_alv.

** ALV
REFRESH it_fieldcat. CLEAR it_fieldcat[].


wa_fieldcat-fieldname  = 'ID_PARTECIPANTE'.
wa_fieldcat-seltext_m  = 'Partecipante'.
APPEND wa_fieldcat TO it_fieldcat.
CLEAR wa_fieldcat.

wa_fieldcat-fieldname  = 'NOME'.
wa_fieldcat-seltext_m  = 'Nome'.
APPEND wa_fieldcat TO it_fieldcat.
CLEAR wa_fieldcat.

wa_fieldcat-fieldname  = 'COGNOME'.
wa_fieldcat-seltext_m  = 'Cognome'.
APPEND wa_fieldcat TO it_fieldcat.
CLEAR wa_fieldcat.

wa_fieldcat-fieldname  = 'DATA_DI_NASCITA'.
wa_fieldcat-seltext_m  = 'Data di nascita'.
APPEND wa_fieldcat TO it_fieldcat.
CLEAR wa_fieldcat.

wa_fieldcat-fieldname  = 'LUOGO_DI_NASCITA'.
wa_fieldcat-seltext_m  = 'Luogo di nascita'.
APPEND wa_fieldcat TO it_fieldcat.
CLEAR wa_fieldcat.

wa_fieldcat-fieldname  = 'CCELERA'.
wa_fieldcat-seltext_m  = 'SEDE'.
APPEND wa_fieldcat TO it_fieldcat.
CLEAR wa_fieldcat.



** Function module to display ALV list
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    it_fieldcat   = it_fieldcat
  TABLES
    t_outtab      = lt_tabella
  EXCEPTIONS
    program_error = 1
    OTHERS        = 2.
  ENDIF.

if test = abap_true.
*MODIFY zbd10_academy23 from table table.

cl_demo_output=>write( lt_tabella ).
  ENDIF.

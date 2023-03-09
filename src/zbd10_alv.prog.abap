*&---------------------------------------------------------------------*
*& Report zbd10_alv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_alv.




PARAMETERS p_file LIKE rlgrap-filename.
DATA filename TYPE string.
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
  CALL FUNCTION 'GUI_UPLOAD'            "carica file
  EXPORTING
    filename                      = filename
   FILETYPE                      = 'ASC'

  tables
    data_tab                      = table
 EXCEPTIONS
   FILE_OPEN_ERROR               = 1
   FILE_READ_ERROR               = 2
   NO_BATCH                      = 3
   GUI_REFUSE_FILETRANSFER       = 4
   INVALID_TYPE                  = 5
   NO_AUTHORITY                  = 6
   UNKNOWN_ERROR                 = 7
   BAD_DATA_FORMAT               = 8
   HEADER_NOT_ALLOWED            = 9
   SEPARATOR_NOT_ALLOWED         = 10
   HEADER_TOO_LONG               = 11
   UNKNOWN_DP_ERROR              = 12
   ACCESS_DENIED                 = 13
   DP_OUT_OF_MEMORY              = 14
   DISK_FULL                     = 15
   DP_TIMEOUT                    = 16
   OTHERS                        = 17
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

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
    t_outtab      = table
  EXCEPTIONS
    program_error = 1
    OTHERS        = 2.
  ENDIF.

if test = abap_true.
MODIFY zbd10_academy23 from table table.

cl_demo_output=>write( table ).
  ENDIF.

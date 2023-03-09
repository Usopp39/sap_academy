*&---------------------------------------------------------------------*
*& Report zbd10_file2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_file2.
PARAMETERS p_file LIKE rlgrap-filename.
DATA filename TYPE string.

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
data table type TABLe of zbd00_academy23.
filename = p_file.
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

  cl_demo_output=>display( table ). "stampa tabella

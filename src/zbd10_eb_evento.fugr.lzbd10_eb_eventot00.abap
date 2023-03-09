*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZBD10_EB_EVENTO.................................*
DATA:  BEGIN OF STATUS_ZBD10_EB_EVENTO               .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZBD10_EB_EVENTO               .
CONTROLS: TCTRL_ZBD10_EB_EVENTO
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZBD10_EB_EVENTO               .
TABLES: ZBD10_EB_EVENTO                .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

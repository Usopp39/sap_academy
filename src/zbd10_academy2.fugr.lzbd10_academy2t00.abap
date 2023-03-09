*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZBD10_ACADEMY2..................................*
DATA:  BEGIN OF STATUS_ZBD10_ACADEMY2                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZBD10_ACADEMY2                .
CONTROLS: TCTRL_ZBD10_ACADEMY2
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZBD10_ACADEMY2                .
TABLES: ZBD10_ACADEMY2                 .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .

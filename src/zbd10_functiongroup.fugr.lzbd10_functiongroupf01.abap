*----------------------------------------------------------------------*
***INCLUDE LZBD10_FUNCTIONGROUPF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form lunghezza
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> CF
*&      <-- HEY
*&---------------------------------------------------------------------*
FORM lunghezza  USING    cf
                CHANGING hey.
                if strlen( cf ) <> 16.
                write |lunghezza del cf errata|.
                hey = 1.
                endif.
ENDFORM.

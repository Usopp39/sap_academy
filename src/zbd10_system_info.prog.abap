*&---------------------------------------------------------------------*
*& Report zbd10_system_info
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_system_info.
write / |utente corrente { sy-uname }|.
write / |data corrente { sy-datum date = ENVIRONMENT }|.
write / |ora corrente { sy-uzeit time = ENVIRONMENT }|.
WRITE / |Nome programma: { sy-repid }|.
WRITE / |Transazione corrente: { sy-tcode }|.
WRITE / |System ID corrente: { sy-sysid }|.
WRITE / |Mandante corrente: { sy-mandt }|.

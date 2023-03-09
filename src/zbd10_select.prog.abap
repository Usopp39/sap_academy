*&---------------------------------------------------------------------*
*& Report zbd10_select
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_select.

PARAMETERS ID TYPE ZBD00_ACADEMY23-ID_PARTECIPANTE DEFAULT 'BD10'.
DATA: TEMP type zbd00_academy23.
SELECT NOME FROM zbd00_academy23 INTO @DATA(A) WHERE id_partecipante = @ID.
write A.
ENDSELECT.

SELECT COGNOME FROM zbd00_academy23 INTO @A WHERE id_partecipante = @ID.
write / A.
ENDSELECT.

SELECT DATA_DI_NASCITA FROM zbd00_academy23 INTO @DATA(B) WHERE id_partecipante = @ID.
DATA(ETA) = sy-datum - B.
ETA = ETA / 365.
WRITE: / |HA { ETA } ANNI|.
ENDSELECT.

*&---------------------------------------------------------------------*
*& Report zbd10_clienti
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_clienti.
PARAMETERS: p_blocca RADIOBUTTON GROUP rad,
            p_disp   RADIOBUTTON GROUP rad,
            p_sblocc radiobutton GROUP rad.

data gt_kunnr type kunnr.
SELECT-OPTIONS kurrn for gt_kunnr.

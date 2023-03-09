*&---------------------------------------------------------------------*
*& Report zbd10_report_test
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_report_test.
PARAMETERS: p_nome type string DEFAULT 'gian',
            p_cognom type string DEFAULT 'verdi',
            p_data type dats,
            p_citta type string DEFAULT 'firenze',
            p_sede type ZBD10_SEDE_CCELERA.

DATA: TEMP type zbd10_academy2.

temp-nome = P_NOME.
temp-COGNOMe = P_COGNOM.
temp-DATA_di_nascita = P_DATA.
Temp-luogo_di_nascita = P_CITTA.
temp-ccelera = P_SEDE.

temp-id_partecipante = 'BD02'.
DELETE zbd10_academy2 from temp.

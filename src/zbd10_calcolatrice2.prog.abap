*&---------------------------------------------------------------------*
*& Report ZBD10_CALCOLATRICE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_calcolatrice2.

DATA:
      risultato TYPE CHAR40,
      tipo_cal  TYPE char1.




CALL SCREEN 100.





*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*MODULE status_0100 OUTPUT.
*  SET PF-STATUS 'MYSTATUS'.
* SET TITLEBAR 'xxx'.
*ENDMODULE.




*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
 data t_num1    TYPE CHAR40.
  CASE sy-ucomm.
    WHEN 'BACK' OR '%EX' OR 'RW'.
      LEAVE PROGRAM.
    WHEN '+' OR '-' OR '*' OR '/'.
      tipo_cal = sy-ucomm.
      t_num1 = risultato.
      clear risultato.
    WHEN '='.
      DATA: n1     TYPE int4,
            n2     TYPE int4,
            result TYPE f.

      n1 = t_num1.
      n2 = risultato.

      CASE tipo_cal.
        WHEN '+'.
          result = n1 + n2.
        WHEN '-'.
          result = n1 - n2.
        WHEN '*'.
          result = n1 * n2.
        WHEN '/'.
          result = n1 / n2.
      risultato = result.
      ENDCASE.

    WHEN OTHERS.
      risultato = risultato && sy-ucomm.
  ENDCASE.

ENDMODULE.

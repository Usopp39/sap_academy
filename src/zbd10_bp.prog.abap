*&---------------------------------------------------------------------*
*& Report zbd10_bp
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_bp.

PARAMETERS: p_id TYPE but000-partner.

DATA: lv_org_name TYPE but000,
      bp_name type but000-name_first.

SELECT single * FROM but000 INTO lv_org_name
  WHERE partner = p_id.

PERFORM cerca using lv_org_name changing bp_name.
write: '(select)', bp_name.

DATA:
      ls_but000 TYPE but000.

CALL FUNCTION 'BUP_BUT000_SELECT_SINGLE'
  EXPORTING
    i_partner       = p_id
*   I_VALID_TIME    =
*   I_VALDT         =
*   I_VALDT_SEL     = SY-DATLO
*   I_CP_EXCLUDE    = ' '
*   IV_REQ_BLK_MSG  = ' '
*   IV_REQ_MASK     = 'X'
  IMPORTING
    e_but000        = ls_but000
  EXCEPTIONS
    not_found       = 1
    internal_error  = 2
    blocked_partner = 3
    OTHERS          = 4.
IF sy-subrc <> 0.
message |no| type 'S'.
ENDIF.

perform cerca using ls_but000 changing bp_name.
write: / '(funzione)', bp_name.
form cerca using bp type but000 changing bp_name.

if bp-type = 1.
concatenate bp-name_first  bp-name_last into bp_name SEPARATED BY space.

elseif  bp-type = 2.
bp_name = bp-name_org1.

elseif bp-type = 3.
bp_name = bp-name_grp1.

endif.
ENDFORM.

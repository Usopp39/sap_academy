*&---------------------------------------------------------------------*
*& Report zbd10_esercizio7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_esercizio7.

PARAMETERS p_num type string DEFAULT '10.5,3,4,5'.
pARAMETERS: maggiore  RADIOBUTTON GROUP rad,
min  RADIOBUTTON GROUP rad,
media  RADIOBUTTON GROUP rad.
if not p_num co '0123456789,-.'.
write: |nooooooooooo| color COL_NEGATIVE.
exit.
endif.
DATA: t_num TYPE TABLE OF string.
 data a type float.

 SPLIT p_num AT ',' INTO TABLE t_num.

if maggiore = 'X'.
PERFORM max using p_num changing a.
endif.

if min = 'X'.
PERFORM min using p_num changing a.
endif.
if media = 'X'.
PERFORM media using p_num changing a.
endif.
 form max using p_num changing a.

 loop at t_num into data(t_i).
if a < t_i
or sy-tabix = 1.

a = t_i.
endif.
endloop.
write |il numero più grande è { a }| color COL_POSITIVE.

 endform.


 form min using p_num changing a.

 loop at t_num into data(t_i).
if a > t_i
or sy-tabix = 1.

a = t_i.
endif.
endloop.
write |il numero più piccolo è { a }| color COL_POSITIVE.

 endform.
 form media using p_num changing a.
 loop at t_num into data(t_i).
 a = a + t_i.


 endloop.
  a = a / lines( t_num ).
 write |la media è { a }| color COL_POSITIVE.

 endform.

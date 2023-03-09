*&---------------------------------------------------------------------*
*& Report zbd10_inverti2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbd10_inverti2.

PARAMETERS p_testo type string lower case DEFAULT 'Le montagne sono alte'.
perform inverti CHANGING p_testo.
write / p_testo.

form inverti CHANGING p_testo type string.
data output type string.
data(lunghezza) = strlen( p_testo ).
write / |il testo è { p_testo }|.
write / |la lunghezza è { lunghezza }|.
do lunghezza times.
data(posizione) = ( sy-index - 1 ).
data(lettera) = p_testo+posizione(1).
write / |la lettera selezionata è { lettera }|.
CONCATENATE lettera output into output.
enddo.
p_testo = output.
ENDFORM.

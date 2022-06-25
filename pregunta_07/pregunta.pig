/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lineas = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letra:chararray,
            col_2:BAG{t: TUPLE(p:chararray)},
            col_3:MAP[]         
    );
letras = FOREACH lineas GENERATE letra AS letra, SIZE(col_2), SIZE(col_3);
ordered = ORDER letras BY $0 ASC, $1 ASC, $2 ASC;
STORE ordered INTO 'output/' USING PigStorage(',');
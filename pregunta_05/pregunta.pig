/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lineas = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letra:chararray,
            col_2:BAG{t: TUPLE(p:chararray)},
            col_3:chararray         
    );
words = FOREACH lineas GENERATE FLATTEN(col_2) AS word;
grouped = GROUP words BY word;
wordcount = FOREACH grouped GENERATE group, COUNT(words);
STORE wordcount INTO 'output/' USING PigStorage(',');
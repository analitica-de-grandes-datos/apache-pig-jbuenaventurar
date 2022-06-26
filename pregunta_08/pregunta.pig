/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

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
words = FOREACH lineas GENERATE FLATTEN(col_2) AS c2, FLATTEN(col_3) AS c3;
claves = FOREACH words GENERATE ($0, $1) AS clave;
grouped = GROUP claves BY clave;
conteo = FOREACH grouped GENERATE group, COUNT(claves);
STORE conteo INTO 'output/' USING PigStorage(',');

/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lineas = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letra:chararray,
            fecha:chararray,
            numero:int,
            
    );

specific_columns = FOREACH lineas GENERATE letra, numero;

grouped = GROUP specific_columns BY letra;

registros_letras = FOREACH grouped GENERATE group, COUNT(letra);

STORE registros_letras INTO 'output/specific_columns' USING PigStorage(',');


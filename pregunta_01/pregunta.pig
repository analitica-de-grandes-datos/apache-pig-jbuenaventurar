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
A = LOAD 'data.tsv' as (line:chararray);
B = FOREACH A GENERATE FLATTEN(TOKENIZE(line)) as (line:chararray);    
C = GROUP B BY line;                                                   
D = FOREACH C GENERATE group,COUNT(B);
STORE D INTO 'output' USING PigStorage(',');

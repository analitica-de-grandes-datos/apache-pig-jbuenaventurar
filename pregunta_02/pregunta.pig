/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/
lineas = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            letra:chararray,
            fecha:chararray,
            numero:int         
    );

DOS = GROUP lineas BY letra;
TRES = FOREACH DOS {
    sort = ORDER lineas BY numero ASC;
    GENERATE FLATTEN(sort);
   };
STORE TRES INTO 'output' USING PigStorage(',');
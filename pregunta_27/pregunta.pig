/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname, 
       LOCATE('ia', firstname) 
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
lineas = LOAD 'data.csv' USING PigStorage(',')
    AS (
            numero:int,
            nombre:chararray,
            apellido:chararray,
            fecha:chararray,
            color:chararray,
            last_number:int
    );
indexs= FOREACH lineas GENERATE INDEXOF(nombre, 'ia', 0);
STORE indexs INTO 'output' USING PigStorage(',');

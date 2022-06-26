/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       color 
   FROM 
       u 
   WHERE 
       color NOT LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

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
colores = FOREACH lineas GENERATE color;
selected = FILTER colores by NOT(color matches '.*b.*'); 
STORE selected INTO 'output/' USING PigStorage(',');

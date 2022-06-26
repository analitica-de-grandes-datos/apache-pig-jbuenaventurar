/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

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
months = FOREACH lineas GENERATE fecha,
SUBSTRING(fecha, 8, 10) as n0, 
GetDay(ToDate(fecha, 'yyyy-MM-dd')) AS nday,
LOWER(ToString(ToDate(fecha, 'yyyy-MM-dd'), 'EEE')) AS dia,
LOWER(ToString(ToDate(fecha, 'yyyy-MM-dd'), 'EEEE')) AS ndia;

A = FOREACH months GENERATE fecha,
n0,
nday,
REPLACE(dia, 'mon', 'lun') AS day1,
REPLACE(ndia, 'monday', 'lunes') AS ndia1;

B = FOREACH A GENERATE fecha,
n0,
nday,
REPLACE(day1, 'thu', 'jue') AS day2,
REPLACE(ndia1, 'thursday', 'jueves') AS ndia2;

C = FOREACH B GENERATE fecha,
n0,
nday,
REPLACE(day2, 'sun', 'dom') AS day3,
REPLACE(ndia2, 'sunday', 'domingo') AS ndia3;

D = FOREACH C GENERATE fecha,
n0,
nday,
REPLACE(day3, 'wed', 'mie') AS day4,
REPLACE(ndia3, 'wednesday', 'miercoles') AS ndia4;

E = FOREACH D GENERATE fecha,
n0,
nday,
REPLACE(day4, 'fri', 'vie') AS day5,
REPLACE(ndia4, 'friday', 'viernes') AS ndia5;

F = FOREACH E GENERATE fecha,
n0,
nday,
REPLACE(day5, 'tue', 'mar') AS day6,
REPLACE(ndia5, 'tuesday', 'martes') AS ndia6;

STORE F INTO 'output' USING PigStorage(',');

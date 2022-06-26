/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

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
apellidos = FOREACH lineas GENERATE apellido;
selected = FILTER apellidos by (apellido matches '.*D.*') 
OR (apellido matches '.*E.*')
OR (apellido matches '.*F.*')
OR (apellido matches '.*G.*')
OR (apellido matches '.*H.*')
OR (apellido matches '.*I.*')
OR (apellido matches '.*J.*')
OR (apellido matches '.*K.*');
STORE selected INTO 'output/' USING PigStorage(',');

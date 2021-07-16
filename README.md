# Curso de PostgreSQL

## Archivos de configuración

Los archivos de configuración son tres principales:

- **postgreql.conf**

- **pg.hba.conf**

- **pg_ident.conf**

La ruta de los mismos depende del sistema Operarivo, para saber que que ruta estan, basta con hacer una Query

SHOW config_file;
NOTA: siempre es bueno hacer una copia original de los archivos antes de modificarlos por si movemos algo que no.

Algo a tener en cuenta es que en la ruta por default de instalación no se puede acceder debido a falta de permisos.
Para acceder a estos archivos y editarlos es necesario ser superusuario

**postgresql.conf**: Configuración general de postgres, múltiples opciones referentes a direcciones de conexión de entrada, memoria, cantidad de hilos de pocesamiento, replica, etc.

**pg_hba.conf**: Muestra los roles así como los tipos de acceso a la base de datos.

**pg_ident.conf**: Permite realizar el mapeo de usuarios. Permite definir roles a usuarios del sistema operativo donde se ejecuta postgres.

## Comandos más utilizados en PostgreSQL

La Consola

La consola en PostgreSQL es una herramienta muy potente para crear, administrar y depurar nuestra base de datos. podemos acceder a ella después de instalar PostgreSQL y haber seleccionado la opción de instalar la consola junto a la base de datos.

```sql
SELECT VERSION();

\? -- Con el cual podemos ver la lista de todos los comandos disponibles en consola, comandos que empiezan con backslash ()

-- Comandos de navegación y consulta de información

\c -- Saltar entre bases de datos

\l -- Listar base de datos disponibles

\dt -- Listar las tablas de la base de datos

\d <nombre_tabla> -- Describir una tabla

\dn -- Listar los esquemas de la base de datos actual

\df -- Listar las funciones disponibles de la base de datos actual

\dv -- Listar las vistas de la base de datos actual

\du -- Listar los usuarios y sus roles de la base de datos actual

-- Comandos de inspección y ejecución

\g -- Volver a ejecutar el comando ejecutando justo antes

\s -- Ver el historial de comandos ejecutados

\s <nombre_archivo> -- Si se quiere guardar la lista de comandos ejecutados en un archivo de texto plano

\i <nombre_archivo> -- Ejecutar los comandos desde un archivo

\e -- Permite abrir un editor de texto plano, escribir comandos y ejecutar en lote. \e abre el editor de texto, escribir allí todos los comandos, luego guardar los cambios y cerrar, al cerrar se ejecutarán todos los comandos guardados.

\ef -- Equivalente al comando anterior pero permite editar también funciones en PostgreSQL

-- Comandos para debug y optimización

\timing -- Activar / Desactivar el contador de tiempo por consulta
Comandos para cerrar la consola

\q -- Cerrar la consola

-- Ejecutando consultas en la base de datos usando la consola

CREATE DATABASE base; -- crea base de datos
CREATE TABLE tabla (columnas); -- crea tabla
INSERT INTO tabla(columna) VALUES('dato'); -- insert en tabla
SELECT * FROM tabla; -- seleccionar datos
UPDATE tabla SET cammpo = dato WHERE condicion;  -- actualizar datos
DELETE FROM tabla WHERE condicion -- borrar datos donde
```

## Tipos de datos

[Tipos de datos relevantes en Postgresql](https://www.ibiblio.org/pub/linux/docs/LuCaS/Tutoriales/NOTAS-CURSO-BBDD/notas-curso-BD/node134.html)

**Principales:**
Numéricos(Numeros enteros, Numeros Decimales, Seriales)
Monetarios(cantidad de moneda)
Texto(almacenar cadenas y texto, existen tres VARCHAR, CHAR, TEXT)
Binario(1 Y 0)
Fecha/Hora(Para almacenar Fechas y/o Horas, DATE TYPE, TIME TYPE, TIMESTAMP, INTERVAL)
Boolean(Verdadero o Falso)
Especiales propios de postgres
Geométricos: Permiten calcular distancias y áreas usando dos valores X y Y.
Direcciones de Red: Cálculos de máscara de red
Texto tipo bit: Cálculos en otros sistemas, ejm(hexadecimal, binario)
XML, JSON: Postgres no permite guardar en estos formatos
Arreglos: Vectores y Matrices

## Diseñando nuestra base de datos: estructura de las tablas

![diagrama](./images/diagrama_uml_postgresql.jpeg)

## Jerarquía de Bases de Datos

Toda jerarquía de base de datos se basa en los siguientes elementos:

- **Servidor de base de datos:** Computador que tiene un motor de base de datos instalado y en ejecución.

- **Motor de base de datos:** Software que provee un conjunto de servicios encargados de administrar una base de datos.

- **Base de datos:** Grupo de datos que pertenecen a un mismo contexto.

- **Esquemas de base de datos en PostgreSQL:** Grupo de objetos de base de datos que guarda relación entre sí (tablas, funciones, relaciones, secuencias).

- **Tablas de base de datos:** Estructura que organiza los datos en filas y columnas formando una matriz.

PostgreSQL es un motor de base de datos.

La estructura de la base de datos diseñada para el reto corresponde a los siguientes
elementos:

![jerarquia](./images/jerarquia_db.webp)

## Creación de Tablas

- CREATE
- ALTER
- DROP

```sql
-- create database
CREATE DATABASE transporte
    WITH
    OWNER = luis
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

-- create table
CREATE TABLE IF NOT EXISTS public.passenger
(
    id bigserial NOT NULL,
    name character varying(100),
    address character varying,
    birthdate date,
    CONSTRAINT passenger_pkey PRIMARY KEY (id)
);

ALTER TABLE public.passenger
    OWNER to luis;

-- insert script
INSERT INTO public.passenger(
  id, name, address, birthdate)
  VALUES (?, ?, ?, ?);
```

Obtener fecha actual

```sql
SELECT current_date;
```

### Reto

crear el resto de las tablas del diagrama

```sql
CREATE TABLE IF NOT EXISTS train(
  id bigserial NOT NULL,
  model character varying(100),
  capacity integer,
  CONSTRAINT train_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS station(
  id bigserial NOT NULL,
  name CHARACTER VARYING(100),
  address CHARACTER VARYING,
  CONSTRAINT station_pkey PRIMARY KEY(id)
);

-- viaje
CREATE TABLE IF NOT EXISTS trip(
  id BIGSERIAL NOT NULL,
  passenger_id INTEGER,
  FOREIGN KEY (passenger_id) REFERENCES passenger(id),
  CONSTRAINT trip_pkey PRIMARY KEY (id)
);

ALTER TABLE trip
  ADD COLUMN IF NOT EXISTS start_trip date,
  ADD COLUMN IF NOT EXISTS end_trip date;

-- trayecto
CREATE TABLE IF NOT EXISTS journey(
  id BIGSERIAL NOT NULL,
  name CHARACTER VARYING(100),
  station_id INTEGER,
  train_id INTEGER,
  FOREIGN KEY (station_id) REFERENCES station(id),
  FOREIGN KEY (train_id) REFERENCES train(id),
  CONSTRAINT journey_pkey PRIMARY KEY (id)
);

-- journey & trip many to many relationship
CREATE TABLE IF NOT EXISTS journey__trip__relation(
  id BIGSERIAL NOT NULL,
  journey_id INTEGER,
  trip_id INTEGER,
  FOREIGN KEY (journey_id) REFERENCES journey(id),
  FOREIGN KEY (trip_id) REFERENCES trip(id),
  CONSTRAINT journey__trip__relation_pkey PRIMARY KEY (id)
);

```

## Particiones

- separacion fisica de datos
- Estructura logica

Cuando una tabla tiene cientos de miles de datos hacer consultas entre rangos requieren un alto consumo del computo del CPU

por ello al particionar la tabla se segmenta la ubicacion de los datos de forma fisica en el disco, manteniendo las propiedades logicas a la hora de realizacion de consultas

```sql
-- tabla de bitacora de viaje

CREATE TABLE IF NOT EXISTS public.trip_log
(
    id bigint NOT NULL DEFAULT nextval('trip_log_id_seq'::regclass),
    id_trip integer,
    date date
) PARTITION BY RANGE (date);

ALTER TABLE public.trip_log
    OWNER to luis;

-- se crea una particion para enero de 2010
-- para poder insertar valores en ese rango de fechas
CREATE TABLE trip_log_2010_01 PARTITION OF trip_log
FOR VALUES FROM ('2010-01-01') TO ('2010-01-31');

-- se inserta un valor que se encuentra entre el rango de fecha
INSERT INTO public.trip_log(
  id_trip, date)
  VALUES (1, '2010-01-01');

-- de esta forma permite realizar consultas de forma normal
SELECT * FROM trip_log;
```

Otra de las ventajas de las tablas particionadas es que puedes utilizar la sentencia TRUNCATE, la cual elimina toda la información de una tabla, pero a nivel partición. Es decir, si tienes una tabla con 12 particiones (1 para cada mes del año) y deseas eliminar toda la información del mes de Enero; con la sentencia ALTER TABLE tabla TRUNCATE PARTITION enero; podrías eliminar dicha información sin afectar el resto.

al usar las tablas particionadas no hace falta declarar el id como primary key ya que las llaves primarias que utilizara Postgresql son
la columnas utilizadas para paticionar, en esta caso la fecha

## Creación de Roles

Los roles se asignan a los usuarios y poseen multiples funciones

- Crear y eleminar (incluso otros roles)
- Asginar atributos
- Agrupar con otros Roles
- Roles predeterminados

Lo ideal en un servidor seria tener un rol para la creacion y borrado de base de datos y tablas, y un rol para la consulta y borrado de datos dentro de una tabla

```sql
postgres=# \h CREATE ROLE
Command:     CREATE ROLE
Description: define a new database role
Syntax:
CREATE ROLE name [ [ WITH ] option [ ... ] ]

where option can be:

      SUPERUSER | NOSUPERUSER
    | CREATEDB | NOCREATEDB
    | CREATEROLE | NOCREATEROLE
    | INHERIT | NOINHERIT
    | LOGIN | NOLOGIN
    | REPLICATION | NOREPLICATION
    | BYPASSRLS | NOBYPASSRLS
    | CONNECTION LIMIT connlimit
    | [ ENCRYPTED ] PASSWORD 'password' | PASSWORD NULL
    | VALID UNTIL 'timestamp'
    | IN ROLE role_name [, ...]
    | IN GROUP role_name [, ...]
    | ROLE role_name [, ...]
    | ADMIN role_name [, ...]
    | USER role_name [, ...]
    | SYSID uid

URL: https://www.postgresql.org/docs/13/sql-createrole.html
```

Despues de la version 9.3 de Postgresql ROLE y USER son lo mismo

```sql
CREATE ROLE usuario_consulta;
```

listar los roles

```sql
\dg
```

modificar un rol

```sql
-- agregandole la capacidad de hacer login
ALTER ROLE usuario_consulta WITH LOGIN;

-- agregando superuser
ALTER ROLE usuario_consulta WITH SUPERUSER;

-- Agregando contraseña
ALTER ROLE usuario_consulta WITH PASSWORD 'etc123';
```

borrando roles

```sql
DROP ROLE usuario_consulta;
```

Dandole permisos de consulta a un usuario en un tabla

```sql
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE trip TO usuario_consulta;
```

## Llaves foráneas

Creacion de una realación foranea

```sql
CREATE TABLE IF NOT EXISTS public.trayecto
(
    id bigserial,
    train_id integer,
    PRIMARY KEY (id),
    CONSTRAINT trayecto_train_fkey FOREIGN KEY (train_id)
        REFERENCES public.train (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

ALTER TABLE public.trayecto
    OWNER to luis;
```

Agregar un constrain

```sql
ALTER TABLE trip
  ADD CONSTRAINT trip_passenger_id_fkey FOREIGN KEY (passenger_id)
    REFERENCES passenger (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;
```

Para actualizar un constrain primero se debe hacer drop del constrain anterior y luego se vuelve a crear

```sql
ALTER TABLE trip
  DROP CONSTRAINT trip_passenger_id_fkey;

ALTER TABLE trip
  ADD CONSTRAINT trip_passenger_id_fkey
    FOREIGN KEY (passenger_id)
    REFERENCES passenger (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;
```

## Inserción y consulta de datos

Insert de datos

```SQL
-- insertando valores en estacion
INSERT INTO station(
  name, address)
  VALUES (?, ?);

INSERT INTO public.station(
  name, address)
  VALUES ('Estacion Norte', 'St #203');

-- insertando valores en trenes
INSERT INTO train(
  model, capacity)
  VALUES (?, ?);

INSERT INTO public.train(
  model, capacity)
  VALUES ('Frances 3004', 100);

-- insert trayecto
INSERT INTO public.journey(
  name, station_id, train_id)
  VALUES ('Centro Maracaibo', 1, 1);
```

Cambiando el id

```sql
UPDATE public.train
  SET id=1
  WHERE id = 2;
```

Con los CONSTRAINTS en cascada al cambiar el id de un registro este tambien cambia en los datos que lo referencian

y al borrar un registro tambien se borran los registros en otras tablas que lo referencian

### Otras notas

Hay una situación importante sobre las claves foráneas (FK) que se explica en esta clase y me gustaría resaltarla un poco mas:
Primeramente recordar del curso de Fundamentos de BD que a las tablas se les llama “independientes” cuando no tienen FK’s. Del mismo modo una tabla es “dependiente” cuando tiene al menos una FK, es decir, son tablas que dependen de tablas independientes.
Es importante **al momento de crear tablas e insertar datos en ellas** , empezar siempre por las tablas independientes y una vez terminadas seguir con las dependientes

## Inserción masiva de datos

Herramienta para crear data falsa para hacer test de forma masiva
[mockaroo](https://mockaroo.com/)

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

CREATE TABLE station(
  id bigserial NOT NULL,
  name CHARACTER VARYING(100),
  address CHARACTER VARYING,
  CONSTRAINT station_pkey PRIMARY KEY(id)
);

CREATE TABLE trip(
  id BIGSERIAL NOT NULL,
  FOREIGN KEY (passenger_id) REFERENCES passenger(id),
  CONSTRAINT trip_pkey PRIMARY KEY (id),
);
```

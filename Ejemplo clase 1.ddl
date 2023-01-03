-- Generado por Oracle SQL Developer Data Modeler 21.2.0.183.1957
--   en:        2021-08-01 15:30:40 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE alumno (
    id_alumno        VARCHAR2(20) NOT NULL,
    nombre           VARCHAR2(75) NOT NULL,
    apellido         VARCHAR2(75) NOT NULL,
    telefono         INTEGER,
    direccion        VARCHAR2(150) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

ALTER TABLE alumno ADD CONSTRAINT alumno_pk PRIMARY KEY ( id_alumno );

CREATE TABLE alumno_carrera (
    alumno_id_alumno   VARCHAR2(20) NOT NULL,
    carrera_id_carrera NUMBER NOT NULL,
    id_alumno_carrera  NUMBER NOT NULL
);

ALTER TABLE alumno_carrera ADD CONSTRAINT alumno_carrera_pk PRIMARY KEY ( id_alumno_carrera );

CREATE TABLE carrera (
    id_carrera     NUMBER NOT NULL,
    nombre_carrera VARCHAR2(75) NOT NULL
);

ALTER TABLE carrera ADD CONSTRAINT carrera_pk PRIMARY KEY ( id_carrera );

CREATE TABLE curso (
    id_curso     NUMBER NOT NULL,
    nombre_curso VARCHAR2(75) NOT NULL,
    id_matricula NUMBER
);

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY ( id_curso );

CREATE TABLE matricula (
    alumno_id_alumno VARCHAR2(20) NOT NULL,
    curso_id_curso   NUMBER NOT NULL,
    id_matricula     NUMBER NOT NULL
);

ALTER TABLE matricula ADD CONSTRAINT matricula_pk PRIMARY KEY ( id_matricula );

ALTER TABLE alumno_carrera
    ADD CONSTRAINT alumno_carrera_alumno_fk FOREIGN KEY ( alumno_id_alumno )
        REFERENCES alumno ( id_alumno );

ALTER TABLE alumno_carrera
    ADD CONSTRAINT alumno_carrera_carrera_fk FOREIGN KEY ( carrera_id_carrera )
        REFERENCES carrera ( id_carrera );

ALTER TABLE matricula
    ADD CONSTRAINT matricula_alumno_fk FOREIGN KEY ( alumno_id_alumno )
        REFERENCES alumno ( id_alumno );

ALTER TABLE matricula
    ADD CONSTRAINT matricula_curso_fk FOREIGN KEY ( curso_id_curso )
        REFERENCES curso ( id_curso );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             0
-- ALTER TABLE                              9
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

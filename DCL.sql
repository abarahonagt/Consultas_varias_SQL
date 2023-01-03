-- 1. Cree un usuario denominado "coordinador", con contraseña 
-- "cor", asignándole 100M de espacio en "system" (100M).

Create User COORDINADOR Identified By COR
Default Tablespace System
Quota 100M On System;

-- 2. Intente iniciar una sesión como "coordinador".

--no es posible iniciar sesion.

-- 3. Vea los permisos de "coordinador" (utilice la tabla dba_sys_privs)

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'COORDINADOR';

-- 4. Conceda a "coordinador" permiso para iniciar sesion y para crear tablas 

GRANT CREATE SESSION TO COORDINADOR;
GRANT CREATE TABLE TO COORDINADOR;

-- 5. Vea los permisos de "coordinador". Tiene permiso "create session" y 
--para crear tablas.

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'COORDINADOR';

-- 7. Como "administrador (System)", elimine los usuarios "catedratico" y 
--"alumno", por si existen

DROP USER CATEDRATICO;
DROP USER ALUMNO;

--LOS USUARIOS NO EXIXSTEN!

-- 8. Cree un usuario denominado "catedratico", con contraseña 
-- "cat", asigne espacio en "system" (100M)

CREATE USER CATEDRATICO IDENTIFIED BY CAT
DEFAULT TABLESPACE SYSTEM
QUOTA 100M ON SYSTEM;

-- 9. Cree un usuario denominado "alumno", con contraseña "alu" 
--    y tablespace "system" (no asigne "quota")

CREATE USER ALUMNO IDENTIFIED BY ALU
DEFAULT TABLESPACE SYSTEM;

-- 10. Consulte el diccionario de datos correspondiente para ver si 
--     existen los 3 usuarios creados

SELECT * FROM all_users;

-- 11. Conceda a "catedratico" y a "alumno" permiso para conectarse

GRANT CREATE SESSION TO CATEDRATICO;
GRANT CREATE SESSION TO ALUMNO;

-- 12. Conceda a "alumno" permiso para crear tablas

GRANT CREATE TABLE TO ALUMNO;

-- 13. Consulte el diccionario de datos "sys_privs" para ver los permisos de 
--     los 3 usuarios creados "coordinador" y "estudiante" tienen permisos 
--     para conectarse y para crear tablas, "catedratico" 
--     tiene permiso para conectarse.

SELECT * FROM DBA_SYS_PRIVS 
    WHERE GRANTEE IN ('COORDINADOR','ALUMNO','CATEDRATICO');

-- 14. Retome su sesión como "coordinador" y cree una tabla:

CREATE TABLE TABLE_CLASE(
  SECCION varchar2(2),
  GRADO varchar2(2)
 );
 
-- 15. Inicie una sesión como "catedratico" e intente crear una tabla:

 create table TABLA_COLEGIO(
  NOMBRE varchar2(30),
  DIRECCION varchar2(50)
 );
 
 --aparece mensaje de priveilegios insuficientes.

-- 16. Consulte los permisos de "catedratico" (user_sys_privs;)

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CATEDRATICO';

-- 17. Cambie a la conexión de administrador y conceda a "catedratico" 
--     permiso para crear tablas

GRANT CREATE TABLE TO CATEDRATICO;

-- 18. Cambie a la sesión de "catedratico" y cree una tabla
--     Ahora si podemos hacerlo, "catedratico" tiene permiso "create table".

create table TABLA_CURSO(
  CODIGO numeric,
  NOMBRE varchar2(30)
 );
 
 -- 19. Consulte nuevamente los permisos de "catedratico"
-- Tiene permiso para crear tablas y para crear sesión.

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CATEDRATICO';

--Inicie una sesión como "alumno" e intente crear una tabla:

SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'ALUMNO';

CREATE TABLE TABLA_ALUMNO(
  nombre VARCHAR2(30),
  apellido VARCHAR2(30)
 );
 
--Informe de error -
--ORA-01950: no privileges on tablespace 'SYSTEM'
--01950. 00000 -  "no privileges on tablespace '%s'"

-- 21. Vuelva a la conexión de "administrador" y 
-- consulte todas las tablas denominadas "tbl_colegio"

SELECT * FROM CATEDRATICO.TABLA_CURSO;
SELECT * FROM COORDINADOR.TABLA_COLEGIO;

-- 22. Cree un rol llamado rol_consulta_coordinar  asígnele permisos 
--     de lectura (select) a la tabla coordinador.tbl_colegio

CREATE ROLE rol_consulta_coordinar;

GRANT SELECT ON COORDINADOR.TABLA_COLEGIO TO rol_consulta_coordinar;

-- 23. asignele el rol rol_consulta_coordinar al usuario catedratico

GRANT rol_consulta_coordinar TO CATEDRATICO;

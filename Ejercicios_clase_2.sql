-- practica exist y not exist

SELECT * FROM HR.employees
SELECT * FROM HR.jobs;

SELECT FIRST_NAME, LAST_NAME, EMAIL
    FROM HR.EMPLOYEES E
WHERE EXISTS (SELECT * FROM HR.JOBS J
    WHERE J.JOB_ID = E.JOB_ID
    AND J.MAX_SALARY > 25000);

--empleados activos 17 octubre 2005, nombre apellido email

SELECT * FROM HR.job_history;

SELECT FIRST_NAME, LAST_NAME, EMAIL
    FROM HR.job_history J, HR.employees E
WHERE J.END_DATE <> '17/10/05';

SELECT FIRST_NAME, LAST_NAME, EMAIL, START_DATE, END_DATE
    FROM HR.job_history J, HR.employees E
WHERE '17/10/05' BETWEEN J.START_DATE AND J.END_DATE;

--OTRA FORMA CORRECTA

SELECT E.FIRST_NAME, E.LAST_NAME, E.EMAIL
    FROM HR.employees E
    WHERE EXISTS(
        SELECT * FROM  HR.job_history j 
        WHERE '17/10/05' BETWEEN J.START_DATE AND J.END_DATE
        AND j.employee_id = E.EMPLOYEE_ID
    );
    
--scripts del chat

SELECT FIRST_NAME, LAST_NAME, EMAIL 
    FROM HR.employees e
WHERE  EXISTS (SELECT * FROM HR.jobs j 
    WHERE j.job_id = e.job_id
    AND j.max_salary > 25000)

--consulta de empleados activo en una fecha
SELECT e.FIRST_NAME, e.LAST_NAME, e.EMAIL FROM HR.employees e
WHERE EXISTS (
    SELECT * 
        FROM HR.job_history h
        WHERE '17/10/2005' BETWEEN h.start_date AND h.end_date
        AND h.employee_id = e.employee_id
    )

--otra forma de consulata dee empleados activos

SELECT FIRST_NAME, LAST_NAME, EMAIL 
FROM HR.employees WHERE HIRE_DATE <= '17/10/2005'

UNION

SELECT e.FIRST_NAME, e.LAST_NAME, e.EMAIL FROM HR.employees e
WHERE EXISTS (
    SELECT * 
        FROM HR.job_history h
        WHERE '17/10/2005' BETWEEN h.start_date AND h.end_date
        AND h.employee_id = e.employee_id
    )

--creacion de vistas. las vistas permiten crear consultas que son recurrentes y en lugar
--de escribir toda la consulta, solo se llama a la vista y se pueden manejar sus componenestes de forma individual

CREATE OR REPLACE VIEW VW_EMPLEADOS AS 
  SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  HR.employees e,
  HR.departments d,
  HR.jobs j,
  HR.locations l,
  HR.countries c,
  HR.regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id;

--uso de vistas

Select first_name, last_name, region_name
from vw_empleados
where salary = 17000;

--creacion de funciones


CREATE OR REPLACE FUNCTION calcula_iva (valor number)
    RETURN number
IS
    BEGIN
        RETURN (valor * 0.12);
    END;
    
SELECT calcula_iva(100) FROM DUAL;

--USO DE PIVOT

CREATE TABLE VENTAS (
    NOMBRE_VENDEDOR VARCHAR2(100),
    MES VARCHAR2(100),
    NO_REFERENCIA NUMBER(10),
    VENTA NUMBER(10)
)

    INSERT INTO VENTAS VALUES ('JUAN', 'ENERO',3,4000);
    INSERT INTO VENTAS VALUES ('JUAN', 'ENERO',4,5000);
    INSERT INTO VENTAS VALUES ('ANDREA', 'ENERO',5,1000);
    INSERT INTO VENTAS VALUES ('ANDREA', 'ENERO',8,1500);
    INSERT INTO VENTAS VALUES ('JAISON', 'FEBRERO',10,200);
    INSERT INTO VENTAS VALUES ('JAISON', 'MARZO',8,500);
    INSERT INTO VENTAS VALUES ('ABNER', 'MAYO',10,6000);
    INSERT INTO VENTAS VALUES ('ABNER', 'NOVIEMBRE',11,100);
    
SELECT * 
FROM (
       SELECT NOMBRE_VENDEDOR, MES, VENTA
       FROM VENTAS
    )
PIVOT 
    (
    SUM (VENTA)
    FOR (MES) IN ('ENERO','FEBRERO','MARZO','MAYO','NOVIEMBRE')
    )

--CREACION DE BACKUP
CREATE TABLE EMPLOYEES_BK 
AS
SELECT * FROM HR.employees


CREATE TABLE MATRIZ_VENTAS
AS
SELECT * 
FROM (
       SELECT NOMBRE_VENDEDOR, MES, VENTA
       FROM VENTAS
    )
PIVOT 
    (
    SUM (VENTA)
    FOR (MES) IN ('ENERO','FEBRERO','MARZO','MAYO','NOVIEMBRE')
    )

  


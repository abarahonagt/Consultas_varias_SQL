-- 1. MOSTRAR NOMBRE, APELLIDOS Y CARGO

--SELECCIONAR NOMBRE, APELLIDO Y CARGO DESDE HR.EMPLEADOS (OBJETO E) Y DE HR.JOBS (OBEJTO J)
--DONDE EL ID DE CARGO DE E SEA EL MISMO QUE J

SELECT FIRST_NAME, LAST_NAME, JOB_TITLE
    FROM HR.EMPLOYEES E, HR.JOBS J
    WHERE E.JOB_ID = J.JOB_ID;
    
-- 2. MOSTRAR NOMBRE Y APELLIDO DE TODOS LOS EMPLEADOS CON
-- SU RESPECTIVO DEPTO. PERTENECIENTE.

SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME
    FROM HR.employees E, HR.departments D
    WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;
    
-- 3. Mostrar los nombres de todas las regiones con sus respectivos 
-- nombres de países ordenados por nombre de región.
    
--(LO QUE NECESITO - ORIGEN - CONDICION - ORDENADO POR...)

SELECT REGION_NAME, COUNTRY_NAME
    FROM HR.regions R, HR.countries C
    WHERE r.region_id = c.region_id
    ORDER BY r.region_name ASC;

-- 4. Mostrar los nombres de todas las regiones con sus respectivos 
-- nombres de países ordenados por nombre de región y por nombre de país.

SELECT REGION_NAME, COUNTRY_NAME
    FROM HR.regions R, HR.countries C
    WHERE r.region_id = c.region_id
    ORDER BY r.region_name, c.country_name;
    
-- 5.  Realice una consulta que muestre el código de la región, nombre de 
-- la región y el nombre de los países que se encuentran en Asia.

-- COMO EXISTEN DOS REGION_ID (UNO EN PAISES Y OTRO EN REGIONES) HAY
-- DEFINIR CUAL DE LOS REGION_ID SE NECESITAN.

SELECT R.REGION_ID, REGION_NAME, COUNTRY_NAME
    FROM HR.REGIONS R JOIN HR.COUNTRIES C 
    ON (R.REGION_ID = C.REGION_ID)
    WHERE region_name = 'Asia';
    
-- 6. Mostrar los nombres y apellidos de todos los empleados con su respectivo 
-- nombre del departamento al cual pertenecen de aquellos cuya fecha de contrato 
-- este entre '10/06/2005' and '16/07/2006'

SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, HIRE_DATE
    FROM HR.employees E JOIN HR.departments D
    ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID)
    WHERE HIRE_DATE BETWEEN '10/06/2005' AND '16/07/2006'
    ORDER BY e.hire_date ASC;
    
--7. Mostrar los nombres de las regiones, con los nombres de países que tiene así 
--como el nombre de las ciudades y la dirección de las calles, ordenados en forma 
--ascendente por el nombre de región y en forma descendente por el nombre del país    

SELECT REGION_NAME, COUNTRY_NAME, CITY, STREET_ADDRESS
    FROM HR.REGIONS R, HR.COUNTRIES C, HR.LOCATIONS L
    WHERE R.REGION_ID = C.REGION_ID AND c.country_id = l.country_id
    ORDER BY 1,2 DESC;
    
--8. Elabore una consulta que liste nombre del trabajo y el salario de los 
--empleados que son manager, cuyo código es 100 o 125 y cuyo salario sea 
--mayor de 6000.

 SELECT JOB_TITLE, SALARY
    FROM HR.JOBS J, HR.EMPLOYEES E
    WHERE E.JOB_ID=J.JOB_ID AND JOB_TITLE like '%Manager%' and Manager_id in
    (100,125) and salary >6000;
    
--9. Desarrolle una consulta que liste el código de la localidad, la ciudad y el 
--nombre del departamento de únicamente de los que se encuentran fuera de 
--estados unidos (US).

SELECT L.LOCATION_ID, CITY, DEPARTMENT_ID
    FROM HR.locations L, HR.countries C, HR.departments D
    WHERE l.country_id = c.country_id AND L.LOCATION_ID = D.LOCATION_ID 
    AND upper (COUNTRY_NAME) <> upper ('UNITED STATES OF AMERICA');
    
--10. Realice una consulta que muestre el nombre y apellido de los empleados que 
--trabajan para departamentos que están localizados en países cuyo nombre comienza 
--con la letra C, que muestre el nombre del país.

SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, c.country_name
     FROM HR.EMPLOYEES E, HR.DEPARTMENTS D, HR.LOCATIONS L, HR.COUNTRIES C
     WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID AND D.LOCATION_ID=L.LOCATION_ID AND
     L.COUNTRY_ID=C.COUNTRY_ID
     AND COUNTRY_NAME LIKE 'C%';
     
--11. Mostrar la cantidad de empleados

SELECT COUNT (*) FROM HR.EMPLOYEES;

--12. Mostrar la cantidad de paises que no se repitan

SELECT COUNT (DISTINCT country_name) from HR.countries;

--13. Mostrar el mayor y el menor salario de los empleados

SELECT MAX (salary) 
    AS MAXIMO, MIN (salary) AS MINIMO 
    FROM HR.employees;

--14. Mostrar el nombre y apellido del empleado que tenga el sueldo maximo

SELECT FIRST_NAME, LAST_NAME, SALARY
    FROM HR.employees
    WHERE SALARY = (SELECT MAX (salary) AS MAXIMO FROM HR.employees);
    
--15. Cuantos empleados tienen un salario mayor al salario promedio

SELECT COUNT (*) AS CANTIDAD 
    FROM ( SELECT last_name
        FROM HR.employees 
        WHERE salary >( SELECT AVG (salary)
            FROM HR.employees));
    
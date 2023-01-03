--CODIGO DE LOCALIDAD, CIUDAD, DEPTO DE LOS QUE ESTAN FUERA DE ESTADOS UNIDOS.

--HR.LOCATION, HR.DEPARTMENT, HR.COUNTRY

SELECT * FROM HR.LOCATIONS;

SELECT * FROM HR.departments;

SELECT * FROM HR.countries;

SELECT l.street_address,l.city, d.department_name, c.country_name
FROM HR.locations L INNER JOIN HR.departments D 
ON L.location_id = D.location_id
INNER JOIN HR.countries C
ON L.COUNTRY_ID = c.country_id WHERE C.COUNTRY_NAME != 'United States of America';

SELECT l.street_address,l.city, d.department_name, c.country_name
FROM HR.locations L, HR.departments D, HR.countries C
WHERE L.location_id = D.location_id
AND C.COUNTRY_ID = l.country_id AND C.COUNTRY_NAME != 'United States of America';






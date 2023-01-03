select first_name, last_name, department_id, hire_date
from hr.employees 
order by department_id, hire_date asc;

select first_name, last_name, start_date, end_date, jh.job_id
from hr.employees e, HR.job_history jh
where jh.employee_id = e.employee_id;    

Muestre el nombre de la región, 
nombre del país, 
estado de la provincia, 
código, nombre y apellido del empleado 
que se encuentren en los países del reino Unido (UK),Estados Unidos de América (US)
respectivamente de los estados de la provincia de Washington y Oxford.

select region_name, country_name, state_province, e.employee_id, first_name, last_name
from hr.regions r, hr.countries c, hr.locations l, HR.employees e
where r.region_id = c.region_id 
and c.country_id = l.country_id 
and c.country_id in ('US','UK')
and l.state_province in ('Washington','Oxford');

select first_name, last_name, salary, department_name, street_address, postal_code, city 
from hr.employees e, hr.departments d, HR.locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and city = 'South San Francisco'
and salary between 4100 and 7100;

select r.region_id, region_name,
count (*)
from hr.regions r, hr.countries c
where r.region_id = c.region_id
group by r.region_id, region_name
order by 3 desc;
                           ***////---COVID ANALYSIS OF COUNTRYWISE ---////***

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
--Number of the  table  includes inthis--
select * from covid_death
select * from covid_vacsin



select * from covid_death
where continent is not null
ORDER BY 3,4

select * from covid_vacsin
ORDER BY 3,4

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
                  ---------///***QUESTIONS///***---------

--1)//**---Select data that we are going to be using**//--

select Location ,date, total_cases , new_cases,total_deaths,population
from covid_death
where continent is not null
order by 1,2


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
--2)Looking at Total Cases Vs Total Deaths----
----HERE WE ARE TRYING TO FINDOUT THE TOTAL DEATH PERCENTAGE----
--show likelihood of dying if you contract covid in your country----

select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as death_percentage
from covid_death
where location like '%state%'
and continent is not null
order by 1,2

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
 --3)looking at total_cases Vs populations---
 -- show what percentage people got covid_cases---

select location,date,total_cases,population, (total_cases/population)*100 as covid_percentage
from covid_death
--where location like '%state%'
where  (total_cases/population)*100 is not null
order by 5 


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
--4)looking at the which country hisght infection rate compared to populations--

select location,max(total_cases) as highst_infection,population, max((total_cases/population))*100 as per_population_infect
from covid_death
--where location like '%state%'
where continent is not null
group by location ,population
order by per_population_infect desc


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
--5)showing countreis with highst death count per polpulations BY COUNTRY WISE

select location,max(total_deaths ) as total_deathcount
from covid_death
--where location like '%state%'
group by location 
order by 2 desc


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
--6)LETS THINGS BREAK DOWN BY CONTINENTS BY CONTINENT WISE 

select continent,max(total_deaths ) as total_deathcount
from covid_death
--where location like '%state%'
where continent is not null
group by continent 
order by total_deathcount desc


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
--7 SHOWING THE CONTINENT HIGHST DEATH COUNT PER POLPULATIONS

select date,SUM(new_cases) as totol_new_cases,sum(new_deaths) as totol_new_daeth
,(SUM(new_deaths)/(sum(new_cases)))*100 as covid_death_percentage
from covid_death
--where location like '%state%'
where  continent is not null
group by date
having sum(new_deaths) >0
order by   4


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
---GLOBAL NUMBERS
--8)--TOTAL CASES AND TOTAL DEATH IN THE WORLD--

 SELECT SUM(new_cases) AS total_cases  ,sum(new_deaths) as total_deaths 
 ,sum(new_deaths)/sum(new_cases)*100 as DeathPercentage
 from covid_death
 --where location like '%states%'
 where continent is not null
 and new_deaths is not null
 order by 1,2


 ------------------------------------------------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------------------------------------
--Total Polpulation VS vaccinations
--9)--NEW VACCINATION PER DAY

Select d.continent , d.location , d.date ,d.population ,v.new_vaccinations,
SUM(V.new_vaccinations) OVER(PARTITION BY D.LOCATION ORDER BY D.LOCATION ,D.DATE) as rolling_PeopleVaccination
from covid_death D
join covid_vacsin  V ON V.location = D.location
	AND V.date = D.date
where d.continent is not null
and v.new_vaccinations is not null
order by 2,3


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
--10) USE CTE
                           
With PopvsVac (continent,location ,date,population,new_vaccinations,rolling_PeopleVaccination)
as
(
Select d.continent , d.location , d.date ,d.population ,v.new_vaccinations,
SUM(V.new_vaccinations) OVER(PARTITION BY D.LOCATION ORDER BY D.LOCATION ,D.DATE) as rolling_PeopleVaccination
from covid_death D
join covid_vacsin  V ON V.location = D.location
	AND V.date = D.date
where d.continent is not null
and v.new_vaccinations is not null
--order by 2,3
)
select * ,(rolling_PeopleVaccination/population)*100
from PopvsVac

                          -------///***THANK YOU***///-------
						  -------///***THANK YOU***///-------
--First Look on the File
select *
from [Project 1(covid)].dbo.CovidDeaths
order by 1,2
 
--Select the columns I am interested in 

select location, date, total_cases, new_cases, total_deaths, population
from [Project 1(covid)].dbo.CovidDeaths
order by 1, 2

--Total Cases vs Total Deaths Shows likelihood of death if contracted covid in my country(India)

select
    location,
    date,
    MAX(total_cases) AS MaxCases,
    MAX(total_deaths) AS MaxDeaths,
    case
        when MAX(total_cases) = 0 then null
        else (CAST(MAX(total_deaths) AS float) / MAX(total_cases)) * 100
    end AS DeathPercentage
from
    [Project 1(covid)].dbo.CovidDeaths
where location LIKE 'India'
group by
    location, date
order by
    DeathPercentage desc

--Total Cases vs Population Shows what percentage of the population contracted covid

select
    location,
    date,
    population,
	total_cases,
	(total_cases/cast(population as float))*100 AS CovidPercentage
from
    [Project 1(covid)].dbo.CovidDeaths
where location LIKE 'India'
order by
    CovidPercentage desc

--Countries with Highest Infection Rate compared to Population Using MAX
select
    location,
    population,
	MAX(total_cases)AS HighestInfectionRate,
	MAX((total_cases/cast(population as float)))*100 AS CovidPercentage
from
    [Project 1(covid)].dbo.CovidDeaths
group by location, population
order by
    HighestInfectionRate desc

--Countries with Highest Infection Rate compared to Population by Date
select
    location,
	date,
    population,
	MAX(total_cases)AS HighestInfectionRate,
	MAX((total_cases/cast(population as float)))*100 AS CovidPercentage
from
    [Project 1(covid)].dbo.CovidDeaths
group by location, population,date
order by
    HighestInfectionRate desc

--Countries with Highest Death Count per Population
select 
	location,
	Max(cast(total_deaths as int)) as HighestDeathCount
from
    [Project 1(covid)].dbo.CovidDeaths
where 
	continent is not null and location not like '%income%'
	and location not in ('World', 'European Union', 'International','Europe','Asia','North America','South America','Africa')
group by 
	location
order by
	HighestDeathCount desc

--Highest Death Count by Continent

select 
	continent,
	SUM(cast(new_deaths as int)) as HighestDeathCount
from
    [Project 1(covid)].dbo.CovidDeaths
where 
	location is not null and continent not like ''
group by 
	continent
order by
	HighestDeathCount desc

-- Global Numbers

select 
	SUM(cast(new_cases as float)) as total_case,
	SUM(cast(new_deaths as float)) as total_death,
	(SUM(cast(new_deaths as float))/(SUM(cast(new_cases as float))))*100 as DeathPercentage
from
    [Project 1(covid)].dbo.CovidDeaths
where 
	location is not null and continent not like ''

-- Let's look at Vaccinations file 

select *
from
	[Project 1(covid)]..CovidVaccinations
order by 1,2

--JOIN Deaths and Vaccinations tables

select 
	death.continent,
	death.location,
	death.date,
	death.population,
	SUM(cast(vaccin.new_vaccinations as float)) as Vaccinationscount
from
	[Project 1(covid)]..CovidDeaths as death
join
	[Project 1(covid)]..CovidVaccinations as vaccin
on
	death.location=vaccin.location
	and
		death.date=vaccin.date
where 
	death.continent is not null
	and
		death.continent not like ''
		and
			vaccin.new_vaccinations is not null
			and
				vaccin.new_vaccinations !=0
group by
	death.continent,
    death.location,
    death.date,
    death.population
order by 1,2,3

--Total Population vs Vaccinations through Partition by statement

select 
	death.continent,
	death.location,
	death.date,
	death.population,
	vaccin.new_vaccinations,
	SUM(cast(vaccin.new_vaccinations as bigint)) over (Partition by death.location order by death.location, death.date) as RollingPeopleVaccinated
from
	[Project 1(covid)]..CovidDeaths as death
join
	[Project 1(covid)]..CovidVaccinations as vaccin
on
	death.location=vaccin.location
	and
		death.date=vaccin.date
where 
	death.continent is not null
		and	
			death.continent not like ''
			and
				vaccin.new_vaccinations is not null
				and
					vaccin.new_vaccinations !=0

-- Total Population vs Vaccinations using CTE

with 
	PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as
(
select 
	death.continent,
	death.location,
	death.date,
	death.population,
	vaccin.new_vaccinations,
	SUM(cast(vaccin.new_vaccinations as bigint)) over (Partition by death.location order by death.location, death.date) as RollingPeopleVaccinated
from
	[Project 1(covid)]..CovidDeaths as death
join
	[Project 1(covid)]..CovidVaccinations as vaccin
on
	death.location=vaccin.location
	and
		death.date=vaccin.date
where 
	death.continent is not null
		and	
			death.continent not like ''
			and
				vaccin.new_vaccinations is not null
				and
					vaccin.new_vaccinations !=0
)
select *,
	(RollingPeopleVaccinated /cast(population as float))*100 as VaccinationPercentage
from 
	PopvsVac

-- Total Population vs Vaccinations using Temp Tables

drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated

select 
	death.continent,
	death.location,
	death.date,
	death.population,
	vaccin.new_vaccinations,
	SUM(cast(vaccin.new_vaccinations as bigint)) over (Partition by death.location order by death.location, death.date) as RollingPeopleVaccinated
from
	[Project 1(covid)]..CovidDeaths as death
join
	[Project 1(covid)]..CovidVaccinations as vaccin
on
	death.location=vaccin.location
	and
		death.date=vaccin.date
where 
	death.continent is not null
		and	
			death.continent not like ''
			and
				vaccin.new_vaccinations is not null
				and
					vaccin.new_vaccinations !=0
select *,
	(RollingPeopleVaccinated/cast(population as float))*100

from #PercentPopulationVaccinated

-- Creating View to store data for later visualizations
CREATE VIEW 
	PercentPopulationVaccinated 
as
select 
	death.continent,
	death.location,
	death.date,
	death.population,
	vaccin.new_vaccinations,
	SUM(cast(vaccin.new_vaccinations as bigint)) over (Partition by death.location order by death.location, death.date) as RollingPeopleVaccinated
from
	[Project 1(covid)]..CovidDeaths as death
join
	[Project 1(covid)]..CovidVaccinations as vaccin
on
	death.location=vaccin.location
	and
		death.date=vaccin.date
where 
	death.continent is not null
		and	
			death.continent not like ''
			and
				vaccin.new_vaccinations is not null
				and
					vaccin.new_vaccinations !=0

-- Let's see the saved VIEW.

select *
from PercentPopulationVaccinated

-- Covid 19 Data Exploration 
-- Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

SELECT location, DATE, total_cases, total_deaths,
(total_cases/total_deaths)*100 AS deathpercentage FROM covidd
ORDER BY 1,2


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths, 
(total_deaths/total_cases)*100 as DeathPercentage
From covidd
where continent is not null 
order by 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From covidd
where continent is not null 
order by 1,2

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  
(total_cases/population)*100 as PercentPopulationInfected
From covidd
order by 1,2

-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  
Max((total_cases/population))*100 as PercentPopulationInfected
From covidd
Group by Location, Population
order by PercentPopulationInfected DESC

-- Showing contintents with the highest death count per population

Select continent, MAX(Total_deaths) as TotalDeathCount
From covidd
Where continent is not null 
Group by continent
order by TotalDeathCount DESC


-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, 
SUM(new_deaths) as total_deaths, 
SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From covidd
where continent is not null 
order by 1,2

-- join covid_vaccinations and covid_deaths on location and date
-- total population vs total vaccinations

Create View PercentPopulationVaccinated as
Select covidd.continent, covidd.location, 
covidd.date, covidd.population, covidv.new_vaccinations,
SUM(covidv.new_vaccinations) OVER 
(Partition by covidd.Location Order by covidd.location, covidd.Date) 
as RollingPeopleVaccinated
From covidd
Join covidv
	On covidd.location = covidv.location
	and covidd.date = covidv.date
where covidd.continent is not null 





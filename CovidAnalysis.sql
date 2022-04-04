Select * 
From Project.dbo.CovidDeaths
Where Location is not NULL
Order By 3,4;

Select * 
From Project.dbo.CovidVaccinations
Where Location is not NULL
Order By 3,4;

Select Location, Date, total_cases, new_cases, total_deaths, population
From Project..CovidDeaths
Where Location is not NULL
Order By 1,2 ;

Select Location, Date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From Project..CovidDeaths
Where Location is not NULL
Order By 1,2;

Select Location, Population, 
		MAX(total_cases) as HighestInfectionCount, 
		MAX(total_cases/population)*100 as PercentPopulationInfected	
From CovidDeaths 
Where location like '%states%' 
Group By location, population
Order by 4;

Select Continent, Max(cast(total_deaths AS Int)) as totalDeathCount
From CovidDeaths
Where continent is not NULL
Group BY Continent
Order By totalDeathCount desc

Select date, Sum(new_cases) as total_cases, Sum(cast(new_deaths as INT)) as total_deaths, 
		sum(cast(new_deaths as INT))/sum(new_cases)*100 as DeathPercentage
From CovidDeaths
Where continent is not NULL
Group BY date
Order By 1,2

Select d.continent, d.location, d.date, d.population, v.new_vaccinations,
		sum(cast(v.new_vaccinations as BIGINT)) OVER 
		(Partition By d.location Order By d.location, d.date) as RollingPeopleVaccinated,
From CovidDeaths d
Join CovidVaccinations v
	ON d.location = v.location
	and d.date = v.date
where d.continent is not NULL
order by 2,3
----------------------------------------------------------------------------------
With PopVsVac(Continent, Location, date, population,new_vaccinations, RollingPeopleVaccinated)
as 
(Select d.continent, d.location, d.date, d.population, v.new_vaccinations,
		sum(cast(v.new_vaccinations as BIGINT)) OVER 
		(Partition By d.location Order By d.location, d.date) as RollingPeopleVaccinated
From CovidDeaths d
Join CovidVaccinations v
	ON d.location = v.location
	and d.date = v.date
where d.continent is not NULL
--order by 2,3
)
Select *, (RollingPeopleVaccinated/population)*100 as PercentPeopleVaccinated
From PopVsVac
Order By 1,2,3
-------------------------------------------------------------------------------------------------
Drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric, 
RollingPeopleVaccinated numeric
)
Insert Into #PercentPopulationVaccinated
Select d.continent, d.location, d.date, d.population, v.new_vaccinations,
		sum(cast(v.new_vaccinations as BIGINT)) OVER 
		(Partition By d.location Order By d.location, d.date) as RollingPeopleVaccinated
From CovidDeaths d
Join CovidVaccinations v
	ON d.location = v.location
	and d.date = v.date
where d.continent is not NULL
order by 1,2,3
Select *, (RollingPeopleVaccinated/population)*100 as PercentPeopleVaccinated
From #PercentPopulationVaccinated

-------------------------------------------------------------------------------------------------
Create View PercentPopulationVaccinated as 
Select d.continent, d.location, d.date, d.population, v.new_vaccinations,
		sum(cast(v.new_vaccinations as BIGINT)) OVER 
		(Partition By d.location Order By d.location, d.date) as RollingPeopleVaccinated
From CovidDeaths d
Join CovidVaccinations v
	ON d.location = v.location
	and d.date = v.date
where d.continent is not NULL

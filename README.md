# ProjectOnCovidAnalysis
a comprehensive set of SQL queries for analyzing COVID-19 data, focusing on cases, deaths, population, and vaccinations. The queries include various perspectives such as death likelihood, infection rates, death rates, and vaccination statistics. Below is a summary of your queries:

Data Exploration:

Displaying the full contents of the CovidDeaths table.
Selecting specific columns of interest.
Death Likelihood in India:

Calculating the death percentage based on total cases and total deaths in India.
Infection and Death Rates in India:

Calculating the percentage of the population that contracted COVID-19 in India.
Highest Infection Rate Globally:

Identifying countries with the highest infection rates compared to their populations.
Highest Death Count per Population:

Identifying countries with the highest death counts per population.
Highest Death Count by Continent:

Summing up the new deaths for each continent to find the highest death count.
Global Numbers:

Summarizing global COVID-19 statistics.
Vaccination Analysis:

Displaying the contents of the CovidVaccinations table.
Joining the CovidDeaths and CovidVaccinations tables to analyze vaccination counts.
Total Population vs Vaccinations:

Calculating the rolling sum of new vaccinations over time for each location.
Vaccination Percentage using CTE:

Using a Common Table Expression (CTE) to calculate the vaccination percentage.
Vaccination Percentage using Temp Tables:

Using temporary tables to store and calculate the vaccination percentage.
Creating a View:

Creating a view named PercentPopulationVaccinated to store data for later visualizations.
Viewing the Saved View:

Displaying the contents of the PercentPopulationVaccinated view.

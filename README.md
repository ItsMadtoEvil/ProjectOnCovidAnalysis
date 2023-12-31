# COVID-19 Data Analysis

Analyze COVID-19 data using SQL queries to gain insights into cases, deaths, population, and vaccinations.

## Overview

This repository contains SQL queries for analyzing COVID-19 data, focusing on cases, deaths, population, and vaccinations. The queries provide various perspectives such as death likelihood, infection rates, death rates, and vaccination statistics.

## Queries Overview

1. **Data Exploration:**
   - Displaying the full contents of the CovidDeaths table.
   - Selecting specific columns of interest.

2. **Death Likelihood in India:**
   - Calculating the death percentage based on total cases and total deaths in India.

3. **Infection and Death Rates in India:**
   - Calculating the percentage of the population that contracted COVID-19 in India.

4. **Highest Infection Rate Globally:**
   - Identifying countries with the highest infection rates compared to their populations.

5. **Highest Death Count per Population:**
   - Identifying countries with the highest death counts per population.

6. **Highest Death Count by Continent:**
   - Summing up the new deaths for each continent to find the highest death count.

7. **Global Numbers:**
   - Summarizing global COVID-19 statistics.

8. **Vaccination Analysis:**
   - Displaying the contents of the CovidVaccinations table.
   - Joining the CovidDeaths and CovidVaccinations tables to analyze vaccination counts.

9. **Total Population vs Vaccinations:**
   - Calculating the rolling sum of new vaccinations over time for each location.

10. **Vaccination Percentage using CTE:**
    - Using a Common Table Expression (CTE) to calculate the vaccination percentage.

11. **Vaccination Percentage using Temp Tables:**
    - Using temporary tables to store and calculate the vaccination percentage.

12. **Creating a View:**
    - Creating a view named `PercentPopulationVaccinated` to store data for later visualizations.

13. **Viewing the Saved View:**
    - Displaying the contents of the `PercentPopulationVaccinated` view.

## Getting Started

To run these queries locally, follow these steps:




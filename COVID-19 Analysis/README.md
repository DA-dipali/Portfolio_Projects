## COVID-19 Analysis

## Introduction:
The **'Global COVID-19 Analysis Project'** is an initiative aimed at leveraging data visualization techniques to gain insights into the global impact of the COVID-19 pandemic. Utilizing Tableau, this project provides interactive dashboards and visualizations that facilitate a comprehensive understanding of the Global virus's spread, vaccination rates, and related trends.

The **'COVID-19 in India Using Power BI and Python Project'** is an initiative focused on State-wise Analysis, Temporal Trends, and Vaccination Coverage with  comprehensive visualizations.

## Data Used:
'Global COVID-19 Tracker' and 'Global COVID-19 Vaccination Tracker' projects use COVID-19 (2020-2023) data from reputable sources [Our world in Data](https://ourworldindata.org/coronavirus) to visualize and understand trends, patterns, and insights related to the pandemic.

COVID-19 in India Project uses [Github Data (2020-2021)](https://github.com/abhisarahuja/Covid-19-Data-Analysis-Project-Using-Python-And-Tableau) to visualize and interpret visuals.

## Tools Used:
- Global COVID-19 Tracker and Global COVID-19 Vaccination Tracker - Tableau Public
- COVID-19 in India - Power BI Desktop and Jupyter Notebook

## Data Cleaning and Data Transformation

- **Global COVID-19 Analysis:** Performed necessary calculated fields in Tableau such as Fully Vaccinated Count, Partially Vaccinated Count, and Total Boosters Over Population, Removed Unnecessary Columns, Empty columns and empty rows, replaced Continent Abbreviation with corresponding full names.

- **Global COVID-19 Analysis:** Power Query Editor used to remove unnecessary columns, remove empty rows to ensure clean and correct data for accurate results. 

## Data Modelling Challenges:
- **Global COVID-19 Analysis :** 
1. **Data Source Complexity:** Dealing with complex and poorly structured data that contains null values can make it challenging to create meaningful relationships and extract relevant insights.

**Solution:** Performed preprocessing and cleaning data before connecting it to Tableau.

2. **Time-Based Analysis:** Performing time-based analyses, such as year-over-year comparisons or rolling averages, may require a solid understanding of Tableau's time functions.

**Solution:** Implemented date hierarchies and used parameters for dynamic date filtering.

- **COVID-19 in India :** 
1. **Relationship Ambiguity:** Establishing accurate and effective relationships between tables can be challenging, especially with many-to-many relationships.
**Solution:** Created Bridge table with unique identifiers.

2. **DAX Complexity:** Writing complex DAX formulas for calculated columns and measures can be challenging.
**Solution:** Broke down complex calculations into simpler steps, and used variables to store intermediate results.

**Data Visualization**
- [**Power BI**](https://app.powerbi.com/groups/me/reports/249ce6da-fee4-4a0c-9d15-726d59aa73e6/ReportSectioncd265f2e68411169a698?experience=power-bi)
- [**Tableau**](https://public.tableau.com/app/profile/dipali.hiremani/vizzes) 
- **Python**

## Summary of Findings
 - Global COVID-19 Tracker:
 1. Cumulative Deaths increasing from Nov 2021 up to its peak in Apr 2022 and decreasing from Dec 2022.
 2. There is a rapid increase in global COVID cases from Jan 2022 to May 2022 following a nearly steady trend up to June 2023.  
 3. The United States is the most-COVID-affected country in the world.
 4. People from the 78 to 82 Age Group were more concerned about death during the COVID period.

 - Global COVID-19 Vaccination Tracker:
 1. Gibraltar is the country with a high no of fully vaccinated people while Kuwait with high no of partially vaccinated people.
 2. 'COVID doses administered' trend increasing greatly from Apr 2021 to Jul 2021 and slowly decreasing till Oct 2021.
 3. Israel is the highest booster doses administered country.
 4. Canada, the United States, and Norway are the countries with the highest no of people vaccinated per hundred while Countries in Africa have the lowest numbers.
 5. There is a positive correlation between the maximum number of people Vaccinated Per Hundred and GDP per Capita.
With an R-squared value of 0.63, it suggests that the logarithmic regression model captures a significant portion of the variability in 'People Vaccinated Per Hundred', but there is still room for improvement. 

 - COVID-19 in India Using Power BI:
1. Cumulative Confirmed cases, Cumulative Death cases, and Cumulative Recovered cases started trending up in May 2021 and continued rising for 3 months.
2. Cumulative Confirmed cases, Cumulative Death cases and Cumulative Recovered cases jumped to its steepest incline between April 2021 and May 2021
3. 'Total Individuals Vaccinated' and 'Total Doses Administered' started trending up in March 2021 and continued rising for 3.23 months.'Total Individuals Vaccinated' and 'Total Doses Administered' jumped to its steepest incline between March 2021 and June 2021. 
4. 'Total Doses Administered' and 'Total Individuals Vaccinated' both trended up between 16 Jan 2021 and 9 Aug 2021.
5. Covishield doses were the most administered vaccines followed by Covaxin and Sputnik. Sputnik vaccines administered had a relatively steady graph.
6. In Uttar Pradesh, the 18-44 age group people are vaccinated at the highest rate while In Maharashtra 45-60 age group people are vaccinated at the highest rate.
7. North-East India and Indian Territory have the Lowest Vaccination Rates.
8. Maharashtra is the most affected Covid state in India.

- COVID-19 in India Using Python:


## Limitations

- Data Complexity may impact visuals.

## Conclusion
We have found that regions and countries with high human development index have higher cases and deaths per million population due to COVID-19. This is due to the international connectedness and mobility of their population related to trade and tourism, and their vulnerability related to older populations and higher rates of non-communicable diseases. We have also identified that the burden of the pandemic is also variable among high- and middle-income countries due to differences in the governance of the pandemic, fragmentation of health systems, and socio-economic inequities.

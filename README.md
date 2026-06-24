# FEM Shiny App

This app is an MVP R Shiny implementation of the <a href='https://github.com/Ministry-for-Primary-Industries/FarmEmissionsModel' target='_blank'>Farm Emissions R Model.</a> User provides farm data on the input tab, and the output tab shows the summary emissions results. See Info tab for step-by-step instructions.


Please follow these steps:

1. Provide the required data by filling out the tables on the input tab. * The fields are pre-populated with example farm data.
2. If more rows are required, right click on any cell and click 'Insert row...'. You can also remove rows.
3. On the output tab, click 'Calculate Emissions'. Tables and graph will be generated with emissions results.
4. Click 'Download Data' to download results and input data.



Tables are pre-populated with example data; you can remove all table contents by clicking 'Clear Tables' button at the bottom of the tab. The model currently has limited validations, please ensure that your inputs are accurate. Columns have restrictions on what values you can enter:

a. Stock count columns should be whole numbers.
b. Allocation columns should be between 0 and 1, inclusive.
c. All numeric columns should be greater than or equal to 0 (except BreedingValues which can be between -0.4 and 1, inclusive).
d. _hrs_day columns can't be more than 24.
e. Date inputs should follow the format 'YYYY-MM-DD'.
f. Date columns should be within the reporting period, inclusive.
g. Categorical columns are limited to options in the drowpdown list.

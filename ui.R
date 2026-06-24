shinyUI(
  fluidPage(
    titlePanel(
      "FEM Shiny App (Batch Processing)"
      ),
    titlePanel(
    h5(HTML("This app is an MVP R Shiny implementation of the <a href='https://github.com/Ministry-for-Primary-Industries/FarmEmissionsModel' target='_blank'>Farm Emissions R Model.</a>
             User provides farm data on the input tab, and the output tab shows the summary emissions results. See Info tab for step-by-step instructions.<br><br><br>"))
      ),
    # sidebarPanel(
    #   width = 3,
    #   textInput("Entity_ID", "Entity_ID", value = "10002"),
    #   dateInput("Period_Start", "Period_Start", value = "2022-06-01"),
    #   dateInput("Period_End", "Period_End", value = "2023-05-31"),
    #   selectInput("Territory", "Territory", choices = allowable_Territory, selected = "Southland District"),
    #   selectInput("Primary_Farm_Class", "Primary_Farm_Class", choices = allowable_Primary_Farm_Class, selected = "Dairy"),
    #   strong("Solid_Separator_Use"),
    #   checkboxInput("Solid_Separator_Use", "Yes", value = FALSE)
    #   ),
    mainPanel(
      tabsetPanel(
        tabPanel(
          "Inputs",
          br(),
          br(),
          fluidRow(
            column(12, "FarmYear", rHandsontableOutput("FarmYear"))
          ),
          br(),
          br(),
          fluidRow(
            column(6, "StockRec_OpeningBalance", rHandsontableOutput("StockRec_OpeningBalance")),
            column(6, "StockRec_BirthsDeaths", rHandsontableOutput("StockRec_BirthsDeaths"))
            ),
          br(),
          br(),
          fluidRow(
            column(6, "StockRec_Movements", rHandsontableOutput("StockRec_Movements")),
            column(6, "SuppFeed_DryMatter", rHandsontableOutput("SuppFeed_DryMatter"))
            ),
          br(),
          br(),
          fluidRow(
            column(6, "Dairy_Production", rHandsontableOutput("Dairy_Production")),
            column(6, "Breed_Allocation", rHandsontableOutput("Breed_Allocation"))
            ),
          br(),
          br(),
          fluidRow(
            column(6, "Effluent_Structure_Use", rHandsontableOutput("Effluent_Structure_Use")),
            column(6, "Effluent_EcoPond_Treatments", rHandsontableOutput("Effluent_EcoPond_Treatments"))
            ),
          br(),
          br(),
          fluidRow(
            column(6, "BreedingValues", rHandsontableOutput("BreedingValues")),
            column(6, "Fertiliser", rHandsontableOutput("Fertiliser"))
          ),
          br(),
          br(),
          actionButton("ClearTables", "Clear Tables"),
          br(),
          br(),
          h5("End")
          ),
        
        tabPanel(
          "Outputs",
          br(),
          actionButton("CalcEmissions", "Calculate Emissions"),
          verbatimTextOutput("ErrorMsg"),
          br(),
          br(),
          br(),
          "Emissions summary in kg CO2-e", br(), br(), rHandsontableOutput("Output_Smry_All"), # br(), plotlyOutput("plot_Output_Smry_All"),
          br(),
          br(),
          "Detailed emissions summary in kg gas",
          br(),
          br(),
          "Emissions_Summary_by_Type", br(), br(), rHandsontableOutput("Output_Smry_Type"), # br(), plotlyOutput("plot_Output_Smry_Type"),
          br(),
          br(),
          "Emissions_Summary_by_Gas", br(), br(), rHandsontableOutput("Output_Smry_Gas"), # br(), plotlyOutput("plot_Output_Smry_Gas"),
          br(),
          br(),
          "Mitigation_Summary_by_Type", br(), br(), rHandsontableOutput("Mitigation_Smry_Type"),
          br(),
          br(),
          "Mitigation_Summary_by_Gas", br(), br(), rHandsontableOutput("Mitigation_Smry_Gas"),
          br(),
          br(),
          downloadButton("DLData", "Download Data"),
          br(),
          br(),
          h5("End")
          ),
        
        tabPanel(
          "Info",
          HTML("<br>Please follow these steps.<br>
                      1. Provide the required data by filling out the tables on the input tab. * The fields are pre-populated with example farm data.<br>
                      2. If more rows are required, right click on any cell and click 'Insert row...'. You can also remove rows.<br>
                      3. On the output tab, click 'Calculate Emissions'. Tables will be generated with emissions results.<br>
                      4. Click 'Download Data' to download results and input data. <br>
                      <br><br><br<br><br>
                      * <i>Tables are pre-populated with example data; you can remove all table contents by clicking 'Clear Tables' button at the bottom of the tab.<br>
                      &nbsp;&nbsp;&nbsp;The model currently has limited validations, please ensure that your inputs are accurate.<br>
                      &nbsp;&nbsp;&nbsp;Columns have restrictions on what values you can enter:<br>
                      &nbsp;&nbsp;&nbsp;a. Stock count columns should be whole numbers.<br>
                      &nbsp;&nbsp;&nbsp;b. Allocation columns should be between 0 and 1, inclusive.<br>
                      &nbsp;&nbsp;&nbsp;c. All numeric columns should be greater than or equal to 0 (except BreedingValues which can be between -0.4 and 1, inclusive).<br>
                      &nbsp;&nbsp;&nbsp;d. _hrs_day columns can't be more than 24.<br>
                      &nbsp;&nbsp;&nbsp;e. Date inputs should follow the format 'YYYY-MM-DD'.<br>
                      &nbsp;&nbsp;&nbsp;f. Date columns should be within the reporting period, inclusive.<br>
                      &nbsp;&nbsp;&nbsp;g. Categorical columns are limited to options in the drowpdown list.</i><br>
                    <br><br><br<br><br>
                    For suggestions, questions or issues, contact joe.valalipin@mpi.govt.nz or create a pull request on <a href=https://github.com/joevalalipin/FEM_shiny_app>GitHub</a>.")
          )
        )
      )
    )
  )
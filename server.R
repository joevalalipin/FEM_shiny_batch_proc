shinyServer(function(input, output, session) {

  # to check that date fall within reporting period
  date_validator <- reactive({
    paste0("function(value, callback) {
          const date = new Date(value);
          const minDate = new Date('", input$Period_Start, "');
          const maxDate = new Date('", input$Period_End, "');
          callback(date >= minDate && date <= maxDate);
        }")
  })
  
  # write input tables, including example farm inputs
  output$FarmYear <- renderRHandsontable({
    
    data <- FarmYear_df_ex %>% 
      bind_rows(FarmYear_df_default)
    
    rhandsontable(data, rowHeaders = FALSE) %>%
      hot_col("Period_Start", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("Territory", type = "dropdown", source = allowable_Territory, allowInvalid = FALSE) %>% 
      hot_col("Primary_Farm_Class", type = "dropdown", source = allowable_Primary_Farm_Class, allowInvalid = FALSE) %>%
      hot_col("Solid_Separator_Use", type = "dropdown", source = c(TRUE, FALSE), allowInvalid = FALSE)
    
  })
  
  output$StockRec_OpeningBalance <- renderRHandsontable({
    
    data <- StockRec_OpeningBalance_df_ex %>% 
      bind_rows(StockRec_OpeningBalance_df_default) 

    rhandsontable(data, rowHeaders = FALSE) %>%
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("StockClass", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>% 
      hot_col("Opening_Balance", type = "numeric", validator = integer_validator, allowInvalid = FALSE)
    
  })
  
  output$StockRec_BirthsDeaths <- renderRHandsontable({
    
    data <- StockRec_BirthsDeaths_df_ex %>% 
      bind_rows(StockRec_BirthsDeaths_df_default)

    rhandsontable(data, rowHeaders = FALSE) %>%
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("Month", type = "dropdown", source = c(1:12), allowInvalid = FALSE) %>% 
      hot_col("StockClass", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>% 
      hot_col(c("Births", "Deaths"), type = "numeric", validator = integer_validator, allowInvalid = FALSE)

  })
  
  output$StockRec_Movements <- renderRHandsontable({
    
    data <- StockRec_Movements_df_ex %>% 
      bind_rows(StockRec_Movements_df_default) 

    rhandsontable(data, rowHeaders = FALSE) %>%
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("Transaction_Date", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("StockClass", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>% 
      hot_col("Transaction_Type", type = "dropdown", source = allowable_Transaction_Type, allowInvalid = FALSE) %>% 
      hot_col("Stock_Count", type = "numeric", validator = integer_validator, allowInvalid = FALSE)

  })
  
  output$SuppFeed_DryMatter <- renderRHandsontable({
    
    data <- SuppFeed_DryMatter_df_ex %>% 
      bind_rows(SuppFeed_DryMatter_df_default)

    rhandsontable(data, rowHeaders = FALSE) %>%
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("Supplement", type = "dropdown", source = allowable_Supplementary_Feed, allowInvalid = FALSE) %>% 
      hot_validate_numeric(c("Dry_Matter_t", "Beef_Allocation", "Dairy_Allocation", "Deer_Allocation", "Sheep_Allocation"), min = 0, allowInvalid = FALSE)
    
  })
  
  output$Dairy_Production <- renderRHandsontable({
    
    data <- Dairy_Production_df_ex %>% 
      bind_rows(Dairy_Production_df_default) 

    rhandsontable(data, rowHeaders = FALSE) %>% 
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("Month", type = "dropdown", source = c(1:12), allowInvalid = FALSE) %>% 
      hot_validate_numeric(c("Milk_Yield_Herd_L", "Milk_Fat_Herd_kg", "Milk_Protein_Herd_kg"), min = 0, allowInvalid = FALSE)
    
  })
  
  output$Breed_Allocation <- renderRHandsontable({
    
    data <-  Breed_Allocation_df_ex %>% 
      bind_rows(Breed_Allocation_df_default)

    rhandsontable(data, rowHeaders = FALSE) %>% 
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("Sector", type = "dropdown", source = allowable_Sector, allowInvalid = FALSE) %>% 
      hot_col("Breed", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>%
      hot_validate_numeric("Breed_Allocation", min = 0, max = 1, allowInvalid = FALSE)
    
  })
  
  output$Effluent_Structure_Use <- renderRHandsontable({
    
    data <- Effluent_Structure_Use_df_ex %>% 
      bind_rows(Effluent_Structure_Use_df_default)

    rhandsontable(data, rowHeaders = FALSE) %>% 
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("Month", type = "dropdown", source = c(1:12), allowInvalid = FALSE) %>% 
      hot_validate_numeric(c("Dairy_Shed_hrs_day", "Other_Structures_hrs_day"), min = 0, max = 24, allowInvalid = FALSE)
    
  })
  
  output$Effluent_EcoPond_Treatments <- renderRHandsontable({
    
    data <- Effluent_EcoPond_Treatments_df_ex %>% 
      bind_rows(Effluent_EcoPond_Treatments_df_default)

    rhandsontable(data, rowHeaders = FALSE) %>% 
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("Treatment_Date", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator())
    
  })
  
  output$BreedingValues <- renderRHandsontable({
    
    data <- BreedingValues_df_ex %>% 
      bind_rows(BreedingValues_df_default)

    rhandsontable(data, rowHeaders = FALSE) %>% 
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_col("StockClass", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>% 
      hot_validate_numeric("BV_aCH4", min = -0.4, max = 1, allowInvalid = FALSE)
    
  })
  
  output$Fertiliser <- renderRHandsontable({
    
    data <- Fertiliser_df_ex %>% 
      bind_rows(Fertiliser_df_default)
    
    rhandsontable(data, rowHeaders = FALSE) %>% 
      hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
      hot_validate_numeric(c("N_Urea_Coated_t", "N_Urea_Uncoated_t", "N_NonUrea_SyntheticFert_t", "N_OrganicFert_t", "Lime_t", "Dolomite_t"), min = 0, allowInvalid = FALSE)
    
  })

  # reset the input tables
  
  observeEvent(input$ClearTables, {
    showModal(modalDialog(title = "Are you sure?",
                          tagList(actionButton("ConfirmClearTables", "Yes"),
                                  modalButton("No")),
                          footer = NULL))
  })
  
  observeEvent(input$ConfirmClearTables, {
    
    output$FarmYear <- renderRHandsontable({
      data <- FarmYear_df_default
      rhandsontable(data, rowHeaders = FALSE) %>%
        hot_col("Period_Start", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("Territory", type = "dropdown", source = allowable_Territory, allowInvalid = FALSE) %>% 
        hot_col("Primary_Farm_Class", type = "dropdown", source = allowable_Primary_Farm_Class, allowInvalid = FALSE) %>%
        hot_col("Solid_Separator_Use", type = "dropdown", source = c(TRUE, FALSE), allowInvalid = FALSE)
      
    })
    
    output$StockRec_OpeningBalance <- renderRHandsontable({
      data <- StockRec_OpeningBalance_df_default
      rhandsontable(data, rowHeaders = FALSE) %>%
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("StockClass", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>% 
        hot_col("Opening_Balance", type = "numeric", validator = integer_validator, allowInvalid = FALSE)
    })
    
    output$StockRec_BirthsDeaths <- renderRHandsontable({
      data <- StockRec_BirthsDeaths_df_default
      rhandsontable(data, rowHeaders = FALSE) %>%
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("Month", type = "dropdown", source = c(1:12), allowInvalid = FALSE) %>% 
        hot_col("StockClass", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>% 
        hot_col(c("Births", "Deaths"), type = "numeric", validator = integer_validator, allowInvalid = FALSE)
    })
    
    output$StockRec_Movements <- renderRHandsontable({
      data <- StockRec_Movements_df_default 
      rhandsontable(data, rowHeaders = FALSE) %>%
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("Transaction_Date", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("StockClass", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>% 
        hot_col("Transaction_Type", type = "dropdown", source = allowable_Transaction_Type, allowInvalid = FALSE) %>% 
        hot_col("Stock_Count", type = "numeric", validator = integer_validator, allowInvalid = FALSE)
    })
    
    output$SuppFeed_DryMatter <- renderRHandsontable({
      data <- SuppFeed_DryMatter_df_default 
      rhandsontable(data, rowHeaders = FALSE) %>%
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("Supplement", type = "dropdown", source = allowable_Supplementary_Feed, allowInvalid = FALSE) %>% 
        hot_validate_numeric(c("Dry_Matter_t", "Beef_Allocation", "Dairy_Allocation", "Deer_Allocation", "Sheep_Allocation"), min = 0, allowInvalid = FALSE)
    })
    
    output$Dairy_Production <- renderRHandsontable({
      data <- Dairy_Production_df_default 
      rhandsontable(data, rowHeaders = FALSE) %>% 
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("Month", type = "dropdown", source = c(1:12), allowInvalid = FALSE) %>% 
        hot_validate_numeric(c("Milk_Yield_Herd_L", "Milk_Fat_Herd_kg", "Milk_Protein_Herd_kg"), min = 0, allowInvalid = FALSE)
    })
    
    output$Breed_Allocation <- renderRHandsontable({
      data <- Breed_Allocation_df_default
      rhandsontable(data, rowHeaders = FALSE) %>% 
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("Sector", type = "dropdown", source = allowable_Sector, allowInvalid = FALSE) %>% 
        hot_col("Breed", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>%
        hot_validate_numeric("Breed_Allocation", min = 0, max = 1, allowInvalid = FALSE)
    })
    
    output$Effluent_Structure_Use <- renderRHandsontable({
      data <- Effluent_Structure_Use_df_default
      rhandsontable(data, rowHeaders = FALSE) %>% 
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("Month", type = "dropdown", source = c(1:12), allowInvalid = FALSE) %>% 
        hot_validate_numeric(c("Dairy_Shed_hrs_day", "Other_Structures_hrs_day"), min = 0, max = 24, allowInvalid = FALSE)
    })
    
    output$Effluent_EcoPond_Treatments <- renderRHandsontable({
      data <- Effluent_EcoPond_Treatments_df_default 
      rhandsontable(data, rowHeaders = FALSE) %>% 
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("Treatment_Date", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator())
    })
    
    output$BreedingValues <- renderRHandsontable({
      data <- BreedingValues_df_default
      rhandsontable(data, rowHeaders = FALSE) %>% 
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_col("StockClass", type = "dropdown", source = allowable_StockClass, allowInvalid = FALSE) %>% 
        hot_validate_numeric("BV_aCH4", min = -0.4, max = 1, allowInvalid = FALSE)
    })
    
    output$Fertiliser <- renderRHandsontable({
      data <- Fertiliser_df_default
      rhandsontable(data, rowHeaders = FALSE) %>% 
        hot_col("Period_End", type = "date", dateFormat = "YYYY-MM-DD", validator = date_validator()) %>% 
        hot_validate_numeric(c("N_Urea_Coated_t", "N_Urea_Uncoated_t", "N_NonUrea_SyntheticFert_t"), min = 0, allowInvalid = FALSE)
    })
    
    removeModal()
    
  })
  
  ErrorText <- reactiveVal("")  # store error message
  
  # calculate emissions
  observeEvent(input$CalcEmissions, {
    
    source("src/model_pipeline/1.1_load_static_inputs.R")
    
    
    FarmYear_df <- hot_to_r(input$FarmYear) %>% 
      filter(Entity_ID != "") %>% 
      mutate(Period_Start = as.Date(Period_Start),
             Period_End = as.Date(Period_End))
    print(FarmYear_df)
    
    StockRec_BirthsDeaths_df <- hot_to_r(input$StockRec_BirthsDeaths) %>% 
      filter(Entity_ID != "") %>%
      mutate(Period_End = as.Date(Period_End),
             StockClass = as.character(StockClass))
    print(StockRec_BirthsDeaths_df)
    
    StockRec_Movements_df <- hot_to_r(input$StockRec_Movements) %>% 
      mutate(Period_End = as.Date(Period_End),
             Transaction_Date = as.Date(Transaction_Date),
             Transaction_Type = as.character(Transaction_Type),
             StockClass = as.character(StockClass)) %>% 
      filter(Entity_ID != "")
    print(StockRec_Movements_df)
    
    StockRec_OpeningBalance_df <- hot_to_r(input$StockRec_OpeningBalance) %>% 
      filter(Entity_ID != "") %>%
      mutate(Period_End = as.Date(Period_End),
             StockClass = as.character(StockClass))
    print(StockRec_OpeningBalance_df)
    
    SuppFeed_DryMatter_df <- hot_to_r(input$SuppFeed_DryMatter) %>% 
      filter(Entity_ID != "") %>%
      mutate(Period_End = as.Date(Period_End),
             Supplement = as.character(Supplement))
    print(SuppFeed_DryMatter_df)
    
    Dairy_Production_df <- hot_to_r(input$Dairy_Production) %>% 
      filter(Entity_ID != "") %>% 
      mutate(Period_End = as.Date(Period_End))
    print(Dairy_Production_df)
    
    Breed_Allocation_df <- hot_to_r(input$Breed_Allocation) %>% 
      filter(Entity_ID != "") %>%
      mutate(Period_End = as.Date(Period_End),
             Sector = as.character(Sector),
             Breed = as.character(Breed))
    print(Breed_Allocation_df)
    
    Effluent_Structure_Use_df <- hot_to_r(input$Effluent_Structure_Use) %>% 
      filter(Entity_ID != "") %>% 
      mutate(Period_End = as.Date(Period_End))
    print(Effluent_Structure_Use_df)
    
    Effluent_EcoPond_Treatments_df <- hot_to_r(input$Effluent_EcoPond_Treatments) %>% 
      mutate(Period_End = as.Date(Period_End),
             Treatment_Date = as.Date(Treatment_Date)) %>% 
      filter(Entity_ID != "")
    print(Effluent_EcoPond_Treatments_df)
    
    BreedingValues_df <- hot_to_r(input$BreedingValues) %>% 
      filter(Entity_ID != "") %>%
      mutate(Period_End = as.Date(Period_End),
             StockClass = as.character(StockClass))
    print(BreedingValues_df)
    
    Fertiliser_df <- hot_to_r(input$Fertiliser) %>% 
      filter(Entity_ID != "") %>% 
      mutate(Period_End = as.Date(Period_End))
    print(Fertiliser_df)
 
    save(FarmYear_df,
         StockRec_BirthsDeaths_df,
         StockRec_Movements_df,
         StockRec_OpeningBalance_df,
         SuppFeed_DryMatter_df,
         Dairy_Production_df,
         Breed_Allocation_df,
         Effluent_Structure_Use_df,
         Effluent_EcoPond_Treatments_df,
         BreedingValues_df,
         Fertiliser_df,
         file = "user_inputs.RData")
  
    source("load_user_inputs.R")
    
    ErrorText("")  # reset error message
    # run FEM, tryCatch prevents app from closing when validation errors are encountered
    tryCatch({
      source("src/model_pipeline/2_preprocessing.R")
      source("src/model_pipeline/3.1_livestock.R")
      source("src/model_pipeline/3.2_fertiliser.R")
      source("src/model_pipeline/4_summary_outputs.R")
    }, error = function(e) {
      ErrorText(e$message)  # capture error message
    })
    
    output$ErrorMsg <- renderText({
      if (ErrorText() != "") paste("Error:", ErrorText())
    })
    
    print(smry_all_annual_by_emission_type_df)
    print(smry_all_annual_by_gas_df)
    
    # display outputs
    
    smry_all_annual_df <- smry_all_annual_by_gas_df %>%
      mutate(` ` = "Emissions", .before = Entity_ID) %>%
      bind_rows(smry_all_annual_by_gas_mitign_delta_df %>%
                  rename(CH4_total_kg = CH4_total_mitign_delta_kg,
                         N2O_total_kg = N2O_total_mitign_delta_kg,
                         CO2_total_kg = CO2_total_mitign_delta_kg) %>%
                  mutate(` ` = "Mitigations", .before = Entity_ID)) %>%
      # convert of CO2e
      mutate(CH4_total_kg = 28 * CH4_total_kg,
             N2O_total_kg = 265 * N2O_total_kg) %>%
      # summarise
      mutate(Total_kg = CH4_total_kg + N2O_total_kg + CO2_total_kg) %>% 
      arrange(Entity_ID, Period_End)

    output$Output_Smry_All <- renderRHandsontable({
      rhandsontable(smry_all_annual_df, rowHeaders = FALSE, readOnly = TRUE)
    })

    # output$plot_Output_Smry_All <- renderPlotly({
    #   smry_all_annual_df %>%
    #     gather(key = "Gas", value = "Value", 2:5) %>%
    #     spread(` `, Value) %>%
    #     mutate(Mitigations = 0 - Mitigations) %>%  # for visually stacking
    #     gather(key = ` `, value = "Emissions", 2:3) %>%
    #     plot_ly(x = ~Gas, y = ~Emissions, type = "bar", color = ~` `) %>%
    #     layout(xaxis = list(title = ""),
    #            yaxis = list(title = ""),
    #            barmode = "stack")
    # })
    
    output$Output_Smry_Type <- renderRHandsontable({
      rhandsontable(smry_all_annual_by_emission_type_df, rowHeaders = FALSE, readOnly = TRUE)
    })
    
    # output$plot_Output_Smry_Type <- renderPlotly({
    #   smry_all_annual_by_emission_type_df %>% 
    #     select(-1,-2) %>% 
    #     gather(key = "type", value = "emissions in kg") %>% 
    #     plot_ly(x = ~type, y = ~`emissions in kg`, type = "bar") %>% 
    #     layout(xaxis = list(title = ""),
    #            yaxis = list(title = ""))
    # })
    
    output$Output_Smry_Gas <- renderRHandsontable({
      rhandsontable(smry_all_annual_by_gas_df, rowHeaders = FALSE, readOnly = TRUE)
    })
    
    # output$plot_Output_Smry_Gas <- renderPlotly({
    #   smry_all_annual_by_gas_df %>% 
    #     select(-1,-2) %>% 
    #     gather(key = "type", value = "emissions in kg") %>% 
    #     plot_ly(x = ~type, y = ~`emissions in kg`, type = "bar") %>% 
    #     layout(xaxis = list(title = ""),
    #            yaxis = list(title = ""))
    # })
    
    output$Mitigation_Smry_Type <- renderRHandsontable({
      rhandsontable(smry_all_annual_by_emission_type_mitign_delta_df, rowHeaders = FALSE, readOnly = TRUE)
    })
    
    output$Mitigation_Smry_Gas <- renderRHandsontable({
      rhandsontable(smry_all_annual_by_gas_mitign_delta_df, rowHeaders = FALSE, readOnly = TRUE)
    })
    
    # build the workbook and download results and inputs
    output$DLData <- downloadHandler(
      filename = function() {paste0("fem_data_", Sys.time(), ".xlsx")},
      
      content = function(file) {
        
        wb <- createWorkbook()
        
        addWorksheet(wb, "FarmYear")
        writeData(wb, "FarmYear", FarmYear_df)
        
        addWorksheet(wb, "StockRec_BirthsDeaths")
        writeData(wb, "StockRec_BirthsDeaths", StockRec_BirthsDeaths_df)
        
        addWorksheet(wb, "StockRec_Movements")
        writeData(wb, "StockRec_Movements", StockRec_Movements_df)
        
        addWorksheet(wb, "StockRec_OpeningBalance")
        writeData(wb, "StockRec_OpeningBalance", StockRec_OpeningBalance_df)
        
        addWorksheet(wb, "SuppFeed_DryMatter")
        writeData(wb, "SuppFeed_DryMatter", SuppFeed_DryMatter_df)
        
        addWorksheet(wb, "Dairy_Production")
        writeData(wb, "Dairy_Production", Dairy_Production_df)
        
        addWorksheet(wb, "Breed_Allocation")
        writeData(wb, "Breed_Allocation", Dairy_Production_df)
        
        addWorksheet(wb, "Effluent_Structure_Use")
        writeData(wb, "Effluent_Structure_Use", Dairy_Production_df)
        
        addWorksheet(wb, "Effluent_EcoPond_Treatments")
        writeData(wb, "Effluent_EcoPond_Treatments", Dairy_Production_df)
        
        addWorksheet(wb, "BreedingValues")
        writeData(wb, "BreedingValues", Dairy_Production_df)
        
        addWorksheet(wb, "Fertiliser")
        writeData(wb, "Fertiliser", Fertiliser_df)
        
        addWorksheet(wb, "Emissions_Summary_CO2e")
        writeData(wb, "Emissions_Summary_CO2e", smry_all_annual_df)
        
        addWorksheet(wb, "Emissions_Summary_by_Type")
        writeData(wb, "Emissions_Summary_by_Type", smry_all_annual_by_emission_type_df)
        
        addWorksheet(wb, "Emissions_Summary_by_Gas")
        writeData(wb, "Emissions_Summary_by_Gas", smry_all_annual_by_gas_df)
        
        addWorksheet(wb, "Mitigation_Summary_by_Type")
        writeData(wb, "Mitigation_Summary_by_Type", smry_all_annual_by_emission_type_mitign_delta_df)
        
        addWorksheet(wb, "Mitigation_Summary_by_Gas")
        writeData(wb, "Mitigation_Summary_by_Gas", smry_all_annual_by_gas_mitign_delta_df)
        
        saveWorkbook(wb, file, overwrite = TRUE)
        }
      )
  })
})









shinyServer(function(input, output, session) {
  
  output$lter_penguins <- renderImage({
    list(
      src = "www/lter_penguins.png", 
      height = "100%"
    )
  }, deleteFile = FALSE)
  
  output$culmen_depth <- renderImage({
    list(
      src = "www/culmen_depth.png", 
      height = "100%"
    )
  }, deleteFile = FALSE)
  
  output$hist_out <- renderPlot({
    ggplot(data = penguins, aes(x = flipper_length_mm)) +
      geom_histogram(aes(fill = species), 
                     alpha = 0.5, binwidth = input$hist_slider,
                     position = "identity") +
      scale_fill_manual(values = c("darkorange","purple","cyan4")) +
      theme_minimal() +
      labs(x = "Flipper length (mm)",
           y = "Frequency",
           title = "Penguin flipper lengths")
  })
  
  output$hist_out_2 <- renderPlot({
    ggplot(data = penguins, aes(x = flipper_length_mm)) +
      geom_histogram(aes(fill = species), 
                     alpha = 0.5, binwidth = input$hist_knob,
                     position = "identity") +
      scale_fill_manual(values = c("darkorange","purple","cyan4")) +
      theme_minimal() +
      labs(x = "Flipper length (mm)",
           y = "Frequency",
           title = "Penguin flipper lengths")
  })
  
  island_radio_df <- reactive({
    
    island_filter <- if (input$island_radio != "All") {
      input$island_radio
    } else {unique(penguins$island)}
    
    penguins %>% 
      filter(island %in% island_filter)
  })
  
  output$scatter_radio_out <- renderPlot({
    ggplot(data = island_radio_df(), 
           aes(x = flipper_length_mm,
               y = body_mass_g)) +
      geom_point(aes(color = species, 
                     shape = species),
                 size = 3,
                 alpha = 0.8) +
      theme_minimal() +
      scale_color_manual(values = c("darkorange","purple","cyan4")) +
      labs(title = "Penguin size, Palmer Station LTER",
           subtitle = "Flipper length and body mass for Adelie, Chinstrap, and Gentoo Penguins",
           x = "Flipper length (mm)",
           y = "Body mass (g)",
           caption = paste(input$island_radio, "island(s)"),
           color = "Penguin species",
           shape = "Penguin species")
  })

  output$df_output <- renderDT({
    datatable(
      island_radio_df(), rownames = FALSE, extensions = 'Buttons',  
      options = list(
        searching = TRUE,  paging = FALSE,
        ordering = TRUE, info = FALSE,
        scrollX = TRUE, scrollY = "500px", dom = 'Bfrtip',
        buttons =  c('copy', 'csv', 'excel', 'pdf', 'print'),
        initComplete = JS(
          "function(settings, json) {",
          "$(this.api().table().header()).css({",
          "'background-color': '#000000', 'color': '#fff'});}"))) %>%
      formatStyle(names(island_radio_df), color = "black", backgroundColor = 'white')
  }) 
  
  island_check_df <- reactive({
    penguins %>% 
      filter(island %in% input$island_check)
  })
  
  output$scatter_check_out <- renderPlot({
    ggplot(data = island_check_df(), 
           aes(x = flipper_length_mm,
               y = body_mass_g)) +
      geom_point(aes(color = species, 
                     shape = species),
                 size = 3,
                 alpha = 0.8) +
      theme_minimal() +
      scale_color_manual(values = c("darkorange","purple","cyan4")) +
      labs(title = "Penguin size, Palmer Station LTER",
           subtitle = "Flipper length and body mass for Adelie, Chinstrap, and Gentoo Penguins",
           x = "Flipper length (mm)",
           y = "Body mass (g)",
           caption = paste(paste0(c(input$island_check), collapse = ", "), "island(s)"),
           color = "Penguin species",
           shape = "Penguin species")
  })

})

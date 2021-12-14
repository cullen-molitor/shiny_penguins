

# Use ALT + O to see outline

# Use ALT + Shift + O to expand from outline


# Define the User Interface for application 
# Dashboard Page  ----
dashboardPage(
  title = "Palmer Penguins",
  skin = "black",
  # .. Dashboard Header  ----
  dashboardHeader(
    title = tags$strong(
      "Palmer Penguins",
      tags$img(height = 45, width = 40, src = 'logo.png')),
    titleWidth = 250
    
  ),
  # .. Dashboard Sidebar  ----
  dashboardSidebar( 
    width = 250,
    sidebarMenu(
      id = 'sidebar',
      # Icons found here:
      # https://fontawesome.com/v6.0/icons/database
      # or here:
      # https://getbootstrap.com/docs/3.3/components/#glyphicons
      # ...... Sidebar - Penguins  ----
      menuItem(
        text = 'Penguin Data', 
        icon = icon('feather', lib = "font-awesome"),
        tabName = 'penguin'
      ),
      # ...... Sidebar - Ice  ----
      menuItem(
        text = 'Ice Data', 
        icon = icon('snowflake', lib = "font-awesome"),
        tabName = 'ice'
      )
    )
  ),
  # .. Dashboard Body  ----
  dashboardBody(
    tabItems(
      # ...... Body - penguins    ---- 
      tabItem(
        tabName = 'penguin',
        h1("Palmer Penguins Data Exploration"),
        tabsetPanel(
          # ............  Tab - about    ---- 
          tabPanel(
            title = "About",
            fluidRow(
              imageOutput(
                outputId = "lter_penguins"
              ),
              tags$hr(),
              fluidRow(
                tags$img(height = 450, width = 725, src = 'culmen_depth.png')
              )
            ), 
            tags$text("Artwork by @allison_horst")
          ),
          # ............  Tab - histogram    ---- 
          tabPanel(
            title = "Histogram",
            fluidRow(
              column(
                width = 4,
                sliderInput(
                  inputId = "hist_slider",
                  label = "Binwidth",
                  min = .5,
                  max = 5,
                  step = .5,
                  value = 2.5,
                  animate = T
                )
              ),
              column(
                width = 6,
                plotOutput(
                  outputId = "hist_out"
                )
              )
            ),
            tags$hr(),
            fluidRow(
              column(
                width = 4,
                shinyWidgets::knobInput(
                  inputId = "hist_knob",
                  label = "Binwidth",
                  min = .5,
                  max = 5,
                  step = .5,
                  value = 2.5,
                  fgColor = 'black',
                  bgColor = 'white'
                )
              ),
              column(
                width = 6,
                plotOutput(
                  outputId = "hist_out_2"
                )
              )
            )
          ),
          # ............  Tab - scatterplot    ---- 
          tabPanel(
            title = "Scatterplot",
            h2("Penguin Scatterplot"),
            fluidRow(
              column(
                width = 4,
                radioButtons(
                  inputId = "island_choice",
                  label = "Choose an Island",
                  choices = c("All", levels(penguins$island))
                )
              ),
              column(
                width = 6,
                plotOutput(
                  outputId = "scatter_out"
                )
              )
            ),
            tags$hr(),
            fluidRow(
              column(
                width = 12,
                DTOutput(
                  outputId = "df_output"
                )
              )
            )
          )
        )
      ),
      tabItem(
        tabName = "ice",
        h1("Antarctic Ice Data"),
        
      )
    )
  )
)


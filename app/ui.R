

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
      # ...... Sidebar - about PP  ----
      menuItem(
        text = 'About', 
        icon = icon('globe', lib = "font-awesome"),
        tabName = 'about'
      ),
      # ...... Sidebar - Histogram  ----
      menuItem(
        text = 'Histogram', 
        icon = icon('signal', lib = "font-awesome"),
        tabName = 'hist'
      ),
      # ...... Sidebar - Scatter plot  ----
      menuItem(
        text = 'Scatterplot', 
        icon = icon('braille', lib = "font-awesome"),
        tabName = 'scatter'
      ),
      # ...... Sidebar - Ice  ----
      menuItem(
        text = 'Other Data', 
        icon = icon('snowflake', lib = "font-awesome"),
        tabName = 'other'
      ),
      menuItem(
        text = "Palmer Penguins Site", 
        icon = icon('linux', lib = "font-awesome"),
        href = "https://allisonhorst.github.io/palmerpenguins/")
    )
  ),
  # .. Dashboard Body  ----
  dashboardBody(
    tabItems(
      # ...... Body - about    ---- 
      tabItem(
        tabName = 'about',
        h1("Palmer Penguins Data Exploration"),
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
      # ...... Body - histogram    ---- 
      tabItem(
        tabName = 'hist',
        tabsetPanel(
          # ............  Tab - hist slider   ---- 
          tabPanel(
            title = "Slider",
            tags$hr(),
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
                width = 8,
                plotOutput(
                  outputId = "hist_out"
                )
              )
            )
          ),
          # ............  Tab - hist knob   ---- 
          tabPanel(
            title = 'Knob',
            tags$hr(),
            fluidRow(
              column(
                width = 3,
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
                width = 8,
                plotOutput(
                  outputId = "hist_out_2"
                )
              )
            )
          )
        )
      ),
      # ...... Body - scatter plot    ---- 
      tabItem(
        tabName = 'scatter',
        h2("Penguin Scatterplot"),
        tabsetPanel(
          tabPanel(
            title = "radiobuttons",
            tags$hr(),
            fluidRow(
              column(
                width = 2,
                radioButtons(
                  inputId = "island_radio",
                  label = "Choose an Island",
                  choices = c("All", levels(penguins$island))
                )
              ),
              column(
                width = 8,
                plotOutput(
                  outputId = "scatter_radio_out"
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
          ),
          tabPanel(
            title = 'checkbox',
            tags$hr(),
            fluidRow(
              column(
                width = 2,
                checkboxGroupButtons(
                  inputId = "island_check",
                  label = "Choose an Island",
                  direction = 'vertical',
                  choices = levels(penguins$island),
                  selected = levels(penguins$island),
                  checkIcon = list(
                    yes = icon("ok", lib = "glyphicon", style = "color: green"),
                    no = icon("remove", lib = "glyphicon", style = "color: red"))
                )
              ),
              column(
                width = 8,
                plotOutput(
                  outputId = "scatter_check_out"
                )
              )
            )
          )
        )
      ),
      # ...... Body - other    ---- 
      tabItem(
        tabName = "other",
        h1("Other Data"),
      )
    )
  )
)


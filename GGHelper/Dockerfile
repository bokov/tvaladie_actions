# Could also use specific version number, e.g.
# FROM rocker/shiny:4.2.3
FROM rocker/shiny:latest
# Space-delimited list of all the libraries your app will need
RUN install2.r rsconnect dplyr ggplot2 DT plotly
WORKDIR /home/shinyusr
# One line in the format you see here for each file you want
# copied into the Docker environment
COPY ui.R ui.R
COPY server.R server.R
COPY global.R global.R
COPY deploy.R deploy.R
CMD Rscript deploy.R

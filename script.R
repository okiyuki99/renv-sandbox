# Package install
remotes::install_github("rstudio/renv")
library(renv)
print(packageVersion("renv"))

# Write analysis.R

# Initialization
renv::init()

# Then add load package
#library(tidyr)
renv::snapshot()

# Change snapshot type
# URL : https://rstudio.github.io/renv/reference/snapshot.html
#options(renv.settings.snapshot.type = "packrat") -- not work
#options(renv.settings.snapshot.type = "simple")  -- not work
#renv::settings$snapshot.type("simple")
renv::settings$snapshot.type("packrat")
settings$snapshot.type()

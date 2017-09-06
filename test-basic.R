library(testthat)
library(RSelenium)

user <- Sys.getenv("SAUCE_USERNAME") # Your Sauce Labs username
pass <- Sys.getenv("SAUCE_SECRET_KEY") # Your Sauce Labs access key 
port <- 80
ip <- paste0(user, ':', pass, "@ondemand.saucelabs.com")
rdBrowser <- "firefox"
version <- "26"
platform <- "Linux"
extraCapabilities <- list(name = "R Shiny Testing", username = user
                          , accessKey = pass, 
                          tags = list("R", "Travis", "Shiny"))
remDr <- remoteDriver$new(remoteServerAddr = ip, port = port, 
                          browserName = rdBrowser
                          , version = version, platform = platform
                          , extraCapabilities = extraCapabilities)

remDr$open()
appURL <- "http://localhost:6012"

test_that("can connect to app", {  
  remDr$navigate(appURL)
  appTitle <- remDr$getTitle()[[1]]
  expect_equal(appTitle, "Old Faithful Geyser Data")  
})

remDr$close()

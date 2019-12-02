## Local raptor tooling: 

### Running local tests

• Customize and run the include `run_raptor.py` and `tests.txt`

###R plots and summaries from collections of raptor .json

Copy your raptor results folders over and run an R script to generate pretty graphs.

The data flow is:

```raptor.json -> csv -> R data frame -> plot to .png, output as text summary```


### Setup
• Clone this repo

• Copy your root `browsertime-results` into `experiment/data`
  
    The name of the folder in which the browsertime.json resides is used as the 'mode'.
    This is a test variation (e.g. a browser, preference change, etc). 
  ```
     ├── data
     │   │   └──experiment
     │   │       ├── raptor-tp6-amazon-firefox-cold
     │   │       │   ├── firefox_option1
     │   │       │   │   ├── raptor.json
     │   │       │   │   
     │   │       │   └── firefox_option2
     │   │       │       ├── raptor.json
```


• open `raptor_loadtime.R` and modify this line

```setwd("/users/acreskey/tools/R/data/raptor")``` to match your local configuration.


• Run the R script (select all and then command-enter in RStudio for MacOS)

• The generated graph will be in `experiment/plots`

• A summary will appear in the R log, but you will need to update the option names (currently `firefox_live` etc)

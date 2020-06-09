// cd to STATA_WD environment variable
local stata_wd : env STATA_WD
cd "`stata_wd'"

// Set FRED API key
local fred_api_key : env FRED_API_KEY
set fredkey "`fred_api_key'"

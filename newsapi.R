library(httr2)
library(lubridate)
library(jsonlite)
req <- request("https://newsapi.org/v2/everything") |>
  req_url_query(
    q = '`"data science"`',
    from = Sys.Date() - 1,
    pageSize = 10,
    apiKey = Sys.getenv("NEWS_API_KEY")
  )

cat(req$url, file=stderr())
resp <- req_perform(req)
cat(resp$status_code, file=stderr())

resp_json <- resp_body_json(resp)

write(toJSON(resp_json), paste0('data/', year(Sys.Date()), '-', month(Sys.Date()), '-', day(Sys.Date()), '.json'))

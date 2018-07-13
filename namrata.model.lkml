connection: "looker-dcl-dev"

# include all the views
include: "*.view"

datagroup: namrata_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}
explore: popularactors {
  from: popularactors
}

persist_with: namrata_default_datagroup

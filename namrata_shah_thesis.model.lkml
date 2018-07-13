connection: "big_query_db"

# include all the views
include: "*.view"

datagroup: namrata_shah_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: namrata_shah_thesis_default_datagroup

connection: "big_query_db"

# include all the views
include: "*.view"

view: actors {
  dimension: name {
    sql: ${TABLE}.array[replace(${bollywood_film.actor}, "|", ",")] ;;
  }
}

explore: bollywood_film {
  join: actors {
      sql: LEFT JOIN unnest(${actors.name}) as actors ;;
      relationship: one_to_many
    }
}


# view: pubmed__pubmed_data_article_id_list {
#   dimension: article_id {
#     type: string
#     sql: ${TABLE}.ArticleId ;;
#     primary_key: yes
#   }
# }
#
#
# explore: pubmed {
#   join: pubmed__pubmed_data_article_id_list {
#     sql: LEFT JOIN UNNEST(${pubmed.pubmed_data_article_id_list}) as pubmed__pubmed_data_article_id_list ;;
#     relationship: one_to_many
#   }
#   }

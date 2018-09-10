view: top_bol_film_year{
  derived_table: {
  sql:SELECT releaseYear,genres,(CASE WHEN rating="hitFlop" then null
            else CAST(rating AS INT64)
          end) as rating,CASE WHEN RANK() OVER(PARTITION BY  genres order by (CASE WHEN rating="hitFlop" then null
            else CAST(rating AS INT64)
          end) DESC) = 1 THEN title else null end as top_film


      from (SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, f0_[OFFSET(0)] as actor, f1_[OFFSET(0)] as genres FROM `se-pbl.bollywood_movies.final_films`
           UNION ALL
           SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, f0_[OFFSET(1)] as actor, f1_[OFFSET(0)] as genres FROM `se-pbl.bollywood_movies.final_films` WHERE ARRAY_LENGTH(f0_) = 2
           UNION ALL
           SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, f0_[OFFSET(2)] as actor, f1_[OFFSET(0)] as genres FROM `se-pbl.bollywood_movies.final_films` WHERE ARRAY_LENGTH(f0_) = 3
           UNION ALL
           SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, f0_[OFFSET(3)] as actor, f1_[OFFSET(0)] as genres FROM `se-pbl.bollywood_movies.final_films` WHERE ARRAY_LENGTH(f0_) = 4) as movies


  ORDER BY releaseYear DESC;;
 }
  dimension: primary_key {
    type: string
    sql: CONCAT(${genres},${top_film}) ;;
    primary_key: yes
    hidden: yes
  }
  dimension: releaseYear {
    type: number
    sql: CASE WHEN
           ${TABLE}.releaseYear = "releaseYear"
          then null
          else cast(${TABLE}.releaseYear as INT64)
          end ;;
    value_format_name: id
  }
  dimension: rating {
    type: number
#     sql:  CASE WHEN ${TABLE}.rating="hitFlop" then null
#             else cast(${TABLE}.rating as INT64)
#           end;;
      sql: ${TABLE}.rating ;;
  }
  dimension: genres {
    type: string
    sql: CASE WHEN ${TABLE}.genres="genres" then null
            else RTRIM(${TABLE}.genres," ")
          end;;
  }
  dimension: top_film {
    type: string
    sql: CASE WHEN ${TABLE}.top_film="top_film" then null
            else RTRIM(${TABLE}.top_film," ")
          end;;
  }


}

  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }


# view: top_films_year {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }

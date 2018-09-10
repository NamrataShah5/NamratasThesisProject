view: bollywood_directors {
  sql_table_name: bollywood_movies.Bollywood_Directors ;;

  dimension: director_id {
    type: number
    sql: CASE WHEN ${TABLE}.directorID="directorId" or ${TABLE}.directorID="NULL" then null
          else cast(${TABLE}.directorID as INT64)
          end;;
  }

  dimension: director_name {
    type: string
    sql: CASE WHEN ${TABLE}.directorName="directorName" or ${TABLE}.directorName="NULL" then null
          else ${TABLE}.directorName
          end;;
  }

  dimension: google_hits {
    type: number
    sql: CASE WHEN ${TABLE}.googleHits="googleHits" or ${TABLE}.googleHits="NULL" then null
          else cast(${TABLE}.googleHits as INT64)
          end;;
  }

  dimension: movie_count {
    type: string
    sql: CASE WHEN ${TABLE}.movieCount="movieCount" or ${TABLE}.movieCount="NULL" then null
          else cast(${TABLE}.movieCount as INT64)
          end;;
  }

  dimension: normalized_google_rank {
    type: string
    sql: CASE WHEN ${TABLE}.normalizedGoogleRank="normalizedGoogleRank" or ${TABLE}.normalizedGoogleRank="NULL" then null
          else cast(${TABLE}.normalizedGoogleRank as FLOAT64)
          end;;
  }



  dimension: normalized_rating {
    type: string
    sql: CASE WHEN ${TABLE}.normalizedRating="normalizedRating" or ${TABLE}.normalizedRating="NULL" then null
          else cast(${TABLE}.normalizedRating as FLOAT64)
          end;;
  }
  dimension: normalized_movie_rank {
    type: string
    sql: CASE WHEN ${TABLE}.normalizedMovieRank="normalizedMovieRank" or ${TABLE}.normalizedMovieRank="NULL" then null
          else cast(${TABLE}.normalizedMovieRank as FLOAT64)
          end;;
  }
  dimension: rating_sum {
    type: string
    sql: CASE WHEN ${TABLE}.ratingSum="ratingSum" or ${TABLE}.ratingSum="NULL" then null
          else cast(${TABLE}.ratingSum as INT64)
          end;;
  }

  measure: count {
    type: count
    drill_fields: [director_name]
  }
}

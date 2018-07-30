view: bollywood_actors {
  #sql_table_name: bollywood_movies.Bollywood_Actors ;;
  derived_table: {
    sql: select *,concat(actorID,actorName,movieCount,normalizedGoogleRank) as the_row from bollywood_movies.Bollywood_Actors ;;
  }
  dimension: unique_id {
    type: string
    sql: ${TABLE}.the_row ;;
    primary_key: yes
   # hidden: yes
  }
  dimension: actor_id {
    type: number
    sql: CASE WHEN
     ${TABLE}.actorID = "actorId"
    then null
    else cast(${TABLE}.actorID as INT64)
    end ;;
  }

  dimension: actor_name {
    type: string
    sql: CASE WHEN ${TABLE}.actorName ="actorName" then null else RTRIM(${TABLE}.actorName," ") end ;;
  }

  dimension: google_hits {
    type: number
    sql: CASE WHEN
    ${TABLE}.googleHits = "googleHits" then null
    else ${TABLE}.googleHits
    end;;
  }

  dimension: movie_count {
    type: number
    sql: CASE WHEN ${TABLE}.movieCount="movieCount" then null
    else ${TABLE}.movieCount
    end;;
  }

  dimension: normalized_google_rank {
    type: number
    sql: CASE WHEN ${TABLE}.normalizedGoogleRank = "normalizedGoogleRank"
    or ${TABLE}.normalizedGoogleRank ="NULL"
      then 0 else
    cast(${TABLE}.normalizedGoogleRank as FLOAT64)
    end;;
  }

  dimension: normalized_movie_rank {
    type: number
    sql: CASE WHEN ${TABLE}.normalizedMovieRank="normalizedMovieRank"
    or ${TABLE}.normalizedMovieRank ="NULL"
      then 0
    else cast(${TABLE}.normalizedMovieRank as FLOAT64)
    end;;
  }

  dimension: normalized_movie_rank_test {
    type: number
    sql: CASE WHEN ${TABLE}.normalizedMovieRank="normalizedMovieRank"
     or ${TABLE}.normalizedMovieRank = "NULL"
            then 0
          else cast(${TABLE}.normalizedMovieRank as FLOAT64)
          end;;
  }

  dimension: normalized_rating {
    type: number
    sql: CASE WHEN ${TABLE}.normalizedRating= "normalizedRating"
    or ${TABLE}.normalizedRating ="NULL"
      then 0
      else cast(${TABLE}.normalizedRating as FLOAT64)
      end ;;
  }

  dimension: rating_sum {
    type: number
    sql: CASE WHEN ${TABLE}.ratingSum="ratingSum" or ${TABLE}.ratingSum is NULL
    then 0
    else ${TABLE}.ratingSum
    end;;
  }
  dimension: avgNormalizedRank {
    type: number
    sql: (${normalized_google_rank}+${normalized_rating})/2.0 ;;

  }
  measure: averageNormalizedRank {
    type: sum_distinct
    sql: ${avgNormalizedRank} ;;

    label: "Average Normalized Rank"
    drill_fields: [actor_name,movie_count,normalized_google_rank,normalized_rating]
  }

  measure: averageNormalizedRanktest {
    type: sum_distinct
    sql: (${normalized_google_rank}+${normalized_rating})/2.0  ;;
    sql_distinct_key: ${actor_id} ;;
    label: "Average Normalized Rank Test"
    drill_fields: [actor_name,movie_count,normalized_google_rank,normalized_rating]
  }


  measure: normalizedMovieRank {
    type: sum_distinct
    sql: ${normalized_movie_rank_test} ;;
    sql_distinct_key: ${actor_id} ;;
    label: "Normalized Movie Rank"
    drill_fields: [actor_name,movie_count,normalized_movie_rank]
  }

  measure: normalizedMovieRank_test {
    type: sum
    sql: ${normalized_movie_rank_test} ;;
    label: "Normalized Movie Rank Test"
    drill_fields: [actor_name,movie_count,normalized_movie_rank]
  }
  measure: count {
    type: count
    drill_fields: [actor_name]
  }
}

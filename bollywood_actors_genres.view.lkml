view: bollywood_actors_genres {


    derived_table: {
      persist_for: "24 hours"
      sql: SELECT
      actor,
    title as name,
    MAX(rating),
    genre,
    releaseYear as year,
    RANK() OVER (PARTITION BY releaseYear,genre ORDER BY rating DESC) AS ranks
  FROM
    bollywood_movies.Bollywood_Films_copy as b cross join unnest(split(b.actors, " | ")) as actor cross join unnest(split(b.genre," | ")) as genre
    group by
      rating,year,name,genre,actor
      order by releaseYear
     ;;
#       sql:select row_number() over() as unique_id,(CASE WHEN RANK() OVER(PARTITION BY actor order by count(*) DESC) = 1 THEN genres else null end)
# #     as top_genre,genre,sequel, rating, imdbID,directors,writers,releaseDate,releaseYear,title,actor from bollywood_movies.Bollywood_Films_copy as b cross join unnest(split(b.actors, " | ")) as actor cross join unnest(split(b.genre," | ")) as genre;;
    }
#     sql: SELECT actor,  (CASE WHEN RANK() OVER(PARTITION BY actor order by count(*) DESC) = 1 THEN genres else null end)
#     as top_genre
#
#
#       from (SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, f0_[OFFSET(0)] as actor, f1_[OFFSET(0)] as genres FROM `se-pbl.bollywood_movies.final_films`
#            UNION ALL
#            SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, f0_[OFFSET(1)] as actor, f1_[OFFSET(0)] as genres FROM `se-pbl.bollywood_movies.final_films` WHERE ARRAY_LENGTH(f0_) = 2
#            UNION ALL
#            SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, f0_[OFFSET(2)] as actor, f1_[OFFSET(0)] as genres FROM `se-pbl.bollywood_movies.final_films` WHERE ARRAY_LENGTH(f0_) = 3
#            UNION ALL
#            SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, f0_[OFFSET(3)] as actor, f1_[OFFSET(0)] as genres FROM `se-pbl.bollywood_movies.final_films` WHERE ARRAY_LENGTH(f0_) = 4) as movies
#
#   GROUP BY actor,genres ORDER BY top_genre DESC LIMIT 1668;;


 dimension: primary_key {
   type: string
  sql: CONCAT(${actor},${ranks}) ;;
  primary_key: yes
  hidden: yes
 }
dimension: genre {
  sql: CASE WHEN
           ${TABLE}.genre = "genre"
          then null
          else RTRIM(${TABLE}.genre," ")
          end ;;
    type: string
}
  dimension: actor {
    sql:CASE WHEN
           ${TABLE}.actor = "actor"
          then null
          else RTRIM(${TABLE}.actor," ")
          end ;;
    type: string
  }
  dimension: name {
    sql:CASE WHEN
           ${TABLE}.name = "title"
          then null
          else RTRIM(${TABLE}.name," ")
          end ;;
    type: string
  }
  dimension: year {
    type: number
    sql: CASE WHEN
           ${TABLE}.year = "releaseYear"
          then null
          else cast(${TABLE}.year as INT64)
          end ;;
    value_format_name: id
  }
  dimension: film_year {
    type: string
    sql: cast(${year} as STRING) ;;
  }
  dimension: film_genre {
    type: string
    sql: CONCAT(${name}," , ",${genre}) ;;
  }
#   measure: all_top_genres {
#     type: string
#     sql: string_agg(distinct ${top_genre}, " , " order by ${top_genre}) ;;
#   }
#
  dimension: ranks {
    type: number
    sql: ${TABLE}.ranks ;;
  }

}

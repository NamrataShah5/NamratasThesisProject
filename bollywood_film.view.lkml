explore: bollywoodfilmtest {
  from: bollywood_film
}
view: bollywood_film {
  derived_table: {
  sql:select  row_number() over() as unique_id,genre,sequel, rating, imdbID,directors,writers,releaseDate,releaseYear,title,actor from bollywood_movies.Bollywood_Films_copy as b cross join unnest(split(b.actors, " | ")) as actor cross join unnest(split(b.genre," | ")) as genre;;
  #sql_table_name: bollywood_movies.Bollywood_Films_copy
  # derived_table: {
  #   persist_for: "24 hours"
  #   sql: SELECT releaseDate,releaseYear,title,actor,genre,sequel, writers, rating, imdbID,directors from (SELECT genre,title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, actor FROM `se-pbl.bollywood_movies.final_films`
  #   UNION ALL
  #   SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, actor,genre FROM `se-pbl.bollywood_movies.final_films` WHERE ARRAY_LENGTH(f0_) = 2
   #  UNION ALL
   #  SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, actor,genre FROM `se-pbl.bollywood_movies.final_films` WHERE ARRAY_LENGTH(f0_) = 3
   #  UNION ALL
   #  SELECT title,releaseDate,releaseYear,sequel,writers,rating,imdbID, directors, actor,genre FROM `se-pbl.bollywood_movies.final_films` WHERE ARRAY_LENGTH(f0_) = 4) as movies
    # ;;
   #}
}
measure: percent_above_six {
    sql: ${countAboveSix}/${film_count} ;;
    value_format: "0.00\%"
}
measure: countAboveSix {
    type: count
    filters: {
      field: rating
      value: ">=6"
    }
}
  measure: count {
    type: count
    drill_fields: [detail*]
  }
  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }
  dimension: rating {
    type: number
    sql: CASE WHEN
           ${TABLE}.rating = "hitFlop"
          then null
          else cast(${TABLE}.rating as INT64)
          end;;
          drill_fields: [genre,title,actor]
  }
  dimension: ratingAndGenre {
    type: number
    sql: ${rating};;
    html: <p>rating:</p> {{ value }} <p>genre:</p> {{ bollywood_film.genre._value }} ;;

  }
  measure: rating_average {
    type: average
    sql: ${rating} ;;
  }
  measure: rating_measure {
    type: sum
    sql: ${rating} ;;
  }
  dimension: genre {
    type: string
    sql: ${TABLE}.genre ;;
    drill_fields: [rating]
  }
  dimension: imdb_id {
    type: string
    sql: ${TABLE}.imdbID ;;
  }
  dimension: firstFilmDate {
    type: date
    sql: MIN(${release_date} ;;
  }
  dimension: lastFilmDate {
    type: date
    sql: MAX(${release_date}) ;;
  }
  measure: spanOfTime {
    sql: DATEDIFF(firstFilmDate,lastF) ;;
  }
  dimension: directors {
    type: string
    sql: CASE WHEN ${TABLE}.directors="directors" then null
            else RTRIM(${TABLE}.directors," ")
          end;;
  }

  dimension: actor {
    type: string
    sql: CASE WHEN ${TABLE}.actor = "actor" then null
    else RTRIM(${TABLE}.actor," ")
    end;;
  }
  dimension: release_date {
    type: string
    sql: ${TABLE}.releaseDate ;;
  }
  dimension: release_year {
    type: number
    sql: CASE WHEN
           ${TABLE}.releaseYear = "releaseYear"
          then null
          else cast(${TABLE}.releaseYear as INT64)
          end ;;
    value_format_name: id
  }

  dimension: sequel {
    type: string
    sql:  CASE WHEN
           ${TABLE}.sequel = "sequel" or ${TABLE}.sequel = "NULL"
          then "0"
          else ${TABLE}.sequel
          end ;;
  }

  dimension: title {
    type: string
    sql: CASE WHEN ${TABLE}.title = "title" then null
    else RTRIM(${TABLE}.title," ")
    end;;
  }

  dimension: writers {
    type: string
    sql: CASE WHEN ${TABLE}.writers = "writers" then null
    else RTRIM(${TABLE}.writers," ")
    end;;
  }
  parameter: genre_to_count {
    type: unquoted
    suggest_dimension: genre
  }
  measure: number_Genre {
    type: sum
    sql:
    CASE
    WHEN ${genre} = '{% parameter genre_to_count %}'
    THEN 1
    ELSE 0
    END
    ;;
  }
  measure: numberAction {
    type: count

    filters:  {
      field: genre
      value: "%Action%"
    }
    label: "Action Count"
    drill_fields: [title,rating]
  }
  measure: numberRomance {
    type: count

    filters: {
      field: genre
      value: "%Romance%"
    }
    label: "Romance Count"
    drill_fields: [title,rating]
  }
  measure: numberDramas {
    type:count

    filters: {
      field: genre
      value: "%Drama%"
    }
    label: "Drama Count"
    drill_fields: [title,rating]
  }
  measure: numberComedies {
    type: count

    filters: {
      field: genre
      value: "%Comedy%"
    }
    label: "Comedy Count"
    drill_fields: [title,rating]
  }
  measure: numberCrimes {
    type: count

    filters: {
      field: genre
      value: "%Crime%"
    }
    label: "Crime Count"
    drill_fields: [title,rating]
  }
  measure: numberAnimation {
    type: count

    filters: {
      field: genre
      value: "%Animation%"
    }
    label: "Animation Count"
    drill_fields: [title,rating]
  }
  measure: numberThriller {
    type: count

    filters: {
      field: genre
      value: "%Thriller%"
    }
    label: "Thriller Count"
    drill_fields: [title,rating]
  }
  measure: numberMystery {
    type: count

    filters: {
      field: genre
      value: "%Mystery%"
    }
    label: "Mystery Count"
    drill_fields: [title,rating]
  }
  measure: numberFantasy {
    type: count

    filters: {
      field: genre
      value: "%Fantasy%"
    }
    label: "Fantasy Count"
    drill_fields: [title,rating]
  }
  measure: numberFamily {
    type: count

    filters: {
      field: genre
      value: "%Family%"
    }
    label: "Family Count"
    drill_fields: [title,rating]
  }
  measure: numberMusical {
    type: count

    filters: {
      field: genre
      value: "%Musical%"
    }
    label: "Musical Count"
    drill_fields: [title,rating]
  }

  measure: film_count {
    type: count_distinct
    sql: ${title} ;;
    drill_fields: [title]
  }
  parameter: max_rank {
    type: number
  }
  dimension: rank_limit {
    type: number
    sql: {% parameter max_rank %} ;;
  }
  set: detail {
    fields: [imdb_id, directors, actor]
  }
}

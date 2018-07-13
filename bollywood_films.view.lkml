view: bollywood_films {
  sql_table_name: bollywood_movies.Bollywood_Films ;;

  dimension: actors {
    type: string
    sql: ${TABLE}.actors ;;
  }

  dimension: directors {
    type: string
    sql: ${TABLE}.directors ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.genre ;;
  }

  dimension: imdb_id {
    type: string
    sql: ${TABLE}.imdbID ;;
  }

  dimension: rating {
    type: string
    sql: ${TABLE}.rating ;;
  }

  dimension: release_date {
    type: string
    sql: ${TABLE}.releaseDate ;;
  }

  dimension: release_year {
    type: string
    sql: ${TABLE}.releaseYear ;;
  }

  dimension: sequel {
    type: string
    sql: ${TABLE}.sequel ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: writers {
    type: string
    sql: ${TABLE}.writers ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

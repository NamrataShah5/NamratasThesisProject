connection: "big_query_db"

# include all the views
include: "*.view"

datagroup: namrata_shah_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: namrata_shah_thesis_default_datagroup

explore: bollywood_actors {
  join: bollywood_directors {
    sql_on: ${bollywood_actors.actor_id}=${bollywood_directors.director_id} ;;
    relationship: one_to_one
  }
  join: bollywood_actors_genres {
    sql_on: ${bollywood_actors.actor_name} = ${bollywood_actors_genres.actor} ;;
    relationship: one_to_many
  }
  join: bollywood_film {
    sql_on: ${bollywood_actors.actor_name}=${bollywood_film.actor} ;;
    relationship: one_to_one
  }
}

explore: bollywood_directors {

}

explore: bollywood_film {
  join: bollywood_actors_genres {

    sql_on: ${bollywood_actors_genres.actor}=${bollywood_film.actor} ;;
    relationship: many_to_one
  }
  join: bollywood_actors {
    sql_on: ${bollywood_actors.actor_name}=${bollywood_film.actor} ;;
    relationship: one_to_one

  }
  join: hollywood_film {
    sql_on: ${bollywood_film.actor}=${hollywood_film.actor_1_name} ;;
    relationship: one_to_one
  }
}

explore: bollywood_actors_genres {
  join: bollywood_actors {
    sql_on: ${bollywood_actors.actor_name}=${bollywood_actors_genres.actor} ;;
    relationship: many_to_one

  }
}
explore: top_bol_film_year {
  join: bollywood_film {
    sql_on: ${bollywood_film.genre}=${top_bol_film_year.genres};;
    relationship: one_to_one
  }
}

explore: hollywood_film {
  join: bollywood_actors {
    sql_on: ${bollywood_actors.actor_name}=${hollywood_film.actor_1_name};;
    relationship: one_to_one
  }
  join: bollywood_film {
    sql_on: ${bollywood_film.actor}=${hollywood_film.actor_1_name} ;;
    relationship: one_to_one
  }
}

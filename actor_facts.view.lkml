view: actor_facts {
  derived_table: {
    sql: select actor, MIN(releaseDate) as first_film, MAX(releaseDate) as last_film
    from bollywood_movies.Bollywood_Film group by actor ;;
  }
  dimension: first_film {
    type: date
    sql: ${TABLE}.first_film ;;
  }
  dimension: last_film {
    type: date
    sql: ${TABLE}.last_film ;;
  }
  dimension: actor {
    type: string
    sql: ${TABLE}.actor ;;
  }
  dimension: timeSpan {
    type: number
    sql: DATEDIFF(${bollywood_actors.rating_sum},${last_film});;
  }
 }
 view: actor_facts_ext {
   extends: [actor_facts]
 }

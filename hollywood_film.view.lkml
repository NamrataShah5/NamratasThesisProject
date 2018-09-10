view: hollywood_film {
  derived_table: {
    sql: select row_number() over() as unique_id,actor_1_facebook_likes,actor_1_name,actor_2_facebook_likes,actor_2_name,actor_3_facebook_likes,actor_3_name,aspect_ratio,
    budget, cast_total_facebook_likes,color,content_rating,country,director_facebook_likes,director_name,duration,facenumber_in_poster,
    gross,imdb_score,language,movie_facebook_likes,movie_imdb_link,movie_title,num_user_for_reviews,num_critics_for_reviews,num_voted_users,
    plot_keywords,title_year,genres from bollywood_movies.hollywood_film as b cross join unnest(split(b.genres, "|")) as genres ;;

  }
  measure: movie_fb_likes {
    type: sum_distinct
    sql: ${movie_facebook_likes};;
    drill_fields: [movie_title,actor_1_name,actor_2_name,actor_3_name,num_critics_for_reviews]
  }
  measure: imdb_scores {
    type: sum_distinct
    sql: ${imdb_score} ;;
    drill_fields: [movie_title,actor_1_name,actor_2_name,actor_3_name,num_critics_for_reviews]

  }
  #sql_table_name: bollywood_movies.hollywood_film ;;
  dimension: id {
    type: number
    sql: ${TABLE}.unique_id ;;
    primary_key: yes
    #hidden: yes
  }
  dimension: actor_1_facebook_likes {
    type: string
    sql: CASE WHEN ${TABLE}.actor_1_facebook_likes="actor_1_facebook_likes" then null
    else ${TABLE}.actor_1_facebook_likes
    end;;
  }

  dimension: actor_1_name {
    type: string
    sql: CASE WHEN ${TABLE}.actor_1_name="actor_1_name" then null
    else ${TABLE}.actor_1_name
    end;;
  }

  dimension: actor_2_facebook_likes {
    type: string
    sql: CASE WHEN ${TABLE}.actor_2_facebook_likes="actor_2_facebook_likes" then null
    else ${TABLE}.actor_2_facebook_likes
    end;;
  }

  dimension: actor_2_name {
    type: string
    sql: CASE WHEN ${TABLE}.actor_2_name="actor_2_name" then null
    else ${TABLE}.actor_2_name
    end;;
  }

  dimension: actor_3_facebook_likes {
    type: string
    sql: CASE WHEN ${TABLE}.actor_3_facebook_likes="actor_3_facebook_likes" then null
    else ${TABLE}.actor_3_facebook_likes
    end;;
  }

  dimension: actor_3_name {
    type: string
    sql: CASE WHEN ${TABLE}.actor_3_name="actor_3_name" then null
    else ${TABLE}.actor_3_name
    end;;
  }

  dimension: aspect_ratio {
    type: number
    sql: CASE WHEN ${TABLE}.aspect_ratio="aspect_ratio" then null
    else cast(${TABLE}.aspect_ratio as FLOAT)
    end;;
  }

  dimension: budget {
    type: number
    sql: CASE WHEN ${TABLE}.budget="budget" then null
    else cast(${TABLE}.budget as INT64)
    end;;
    value_format_name: usd
  }

  dimension: cast_total_facebook_likes {
    type: number
    sql: CASE WHEN ${TABLE}.cast_total_facebook_likes="cast_total_facebook_likes" then null
    else cast(${TABLE}.cast_total_facebook_likes as INT64)
    end;;
  }

  dimension: color {
    type: string
    sql: CASE WHEN ${TABLE}.color="color" then null
    else ${TABLE}.color
    end;;
  }

  dimension: content_rating {
    type: string
    sql: CASE WHEN ${TABLE}.content_rating="content_rating" then null
    else ${TABLE}.content_rating
    end;;
    drill_fields: [genres]
    link: {
      label: "Drill To Films"
      url: "https://dcl.dev.looker.com/dashboards/184?ContentRating%20Filter={{ _filters['hollywood_film.content_rating'] | url_encode }}"
    }
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: CASE WHEN ${TABLE}.country="country" then null
    else ${TABLE}.country
    end;;
  }

  dimension: director_facebook_likes {
    type: number
    sql: CASE WHEN ${TABLE}.director_facebook_likes="director_facebook_likes" then null
    else cast(${TABLE}.director_facebook_likes as INT64)
    end;;
  }

  dimension: director_name {
    type: string
    sql: CASE WHEN ${TABLE}.director_name="director_name" then null
    else ${TABLE}.director_name
    end;;
  }

  dimension: duration {
    type: number
    sql:CASE WHEN ${TABLE}.duration="duration" then null
    else cast(${TABLE}.duration as INT64)
    end;;
  }

  dimension: facenumber_in_poster {
    type: string
    sql: CASE WHEN ${TABLE}.facenumber_in_poster="facenumber_in_poster" then null
    else cast(${TABLE}.facenumber_in_poster as INT64)
    end;;
  }

  dimension: genres {
    type: string
    sql: CASE WHEN ${TABLE}.genres="genres" then null
    else ${TABLE}.genres
    end;;
    drill_fields: [movie_title,title_year]
  }

  dimension: gross {
    type: number
    sql: CASE WHEN ${TABLE}.gross="gross" then null
    else cast(${TABLE}.gross as INT64)
    end;;
    value_format_name: usd
    drill_fields: [movie_title]
  }

  dimension: imdb_score {
    type: number
    sql: CASE WHEN ${TABLE}.imdb_score="imdb_score" then null
    else cast(${TABLE}.imdb_score as FLOAT64)
    end;;
    drill_fields: [genres,plot_keywords,movie_title,content_rating]
    link: {
      label: "Drill To Films"
      url:"https://dcl.dev.looker.com/dashboards/184?Movie=%25{{ hollywood_film.movie_title._rendered_value }}%25"

    }
  }

  dimension: language {
    type: string
    sql: CASE WHEN ${TABLE}.language="language" then null
    else ${TABLE}.language
    end;;
  }

  dimension: movie_facebook_likes {
    type: number
    sql: CASE WHEN ${TABLE}.movie_facebook_likes="movie_facebook_likes" then null
    else cast(${TABLE}.movie_facebook_likes as INT64)
    end;;

  }

  dimension: movie_imdb_link {
    type: string
    sql: CASE WHEN ${TABLE}.movie_imdb_link="movie_imdb_link" then null
    else ${TABLE}.movie_imdb_link
    end;;
  }

  dimension: movie_title {
    type: string
    sql: CASE WHEN ${TABLE}.movie_title="movie_title" then null
    else RTRIM(${TABLE}.movie_title," ")
    end;;
  }

#
  dimension: num_critics_for_reviews {
    type: number
    sql: CASE WHEN ${TABLE}.num_critics_for_reviews="num_critic_for_reviews" then null
        else cast(${TABLE}.num_critics_for_reviews as INT64)
        end;;
  }

  dimension: num_user_for_reviews {
    type: number
    sql: CASE WHEN ${TABLE}.num_user_for_reviews="num_user_for_reviews" then null
    else cast(${TABLE}.num_user_for_reviews as INT64)
    end;;
  }

  dimension: num_voted_users {
    type: number
    sql: CASE WHEN ${TABLE}.num_voted_users="num_voted_users" then null
    else cast(${TABLE}.num_voted_users as INT64)
    end;;
  }

  dimension: plot_keywords {
    type: string
    sql: CASE WHEN ${TABLE}.plot_keywords="plot_keywords" then null
    else ${TABLE}.plot_keywords
    end;;
  }
  dimension: avgRating {
    type: number
    sql: (${imdb_score}+${bollywood_film.rating})/2 ;;
  }
  dimension: title_year {
    type: number
    sql: CASE WHEN
           ${TABLE}.title_year = "title_year"
          then null
          else cast(${TABLE}.title_year as INT64)
          end ;;
    value_format_name: id
  }
  dimension: film_info {
    type: string
    sql: CONCAT(cast(${title_year} as STRING),",",${genres}) ;;


  }
  parameter: max_rank {
    type: number
  }
  dimension: rank_limit {
    type: number
    sql: {% parameter max_rank %} ;;
  }
  measure: rank_average {
    type: average
    sql: ${imdb_score} ;;
  }
  measure: count {
    type: count
    drill_fields: [actor_1_name, actor_2_name, director_name, actor_3_name]
  }
  measure: film_count {
    type: count_distinct
    sql: ${movie_title} ;;
  }
  parameter: genre_to_count {
    type: unquoted
    suggest_dimension: genres
  }
  measure: number_Genre {
    type: sum
    sql:
    CASE
    WHEN ${genres} = '{% parameter genre_to_count %}'
    THEN 1
    ELSE 0
    END
    ;;
  }
  measure: numberAction {
    type: count

    filters:  {
      field: genres
      value: "%Action%"
    }
    label: "Action Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberRomance {
    type: count

    filters: {
      field: genres
      value: "%Romance%"
    }
    label: "Romance Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberDramas {
    type: count

    filters: {
      field: genres
      value: "%Drama%"
    }
    label: "Drama Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberComedies {
    type: count

    filters: {
      field: genres
      value: "%Comedy%"
    }
    label: "Comedy Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberCrimes {
    type: count

    filters: {
      field: genres
      value: "%Crime%"
    }
    label: "Crime Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberAnimation {
    type: count

    filters: {
      field: genres
      value: "%Animation%"
    }
    label: "Animation Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberThriller {
    type: count

    filters: {
      field: genres
      value: "%Thriller%"
    }
    label: "Thriller Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberMystery {
    type: count

    filters: {
      field: genres
      value: "%Mystery%"
    }
    label: "Mystery Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberFantasy {
    type: count

    filters: {
      field: genres
      value: "%Fantasy%"
    }
    label: "Fantasy Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberFamily {
    type: count

    filters: {
      field: genres
      value: "%Family%"
    }
    label: "Family Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberMusical {
    type: count

    filters: {
      field: genres
      value: "%Musical%"
    }
    label: "Musical Count"
    drill_fields: [content_rating,imdb_score]
  }
  measure: numberHorror {
    type: count

    filters: {
      field: genres
      value: "%Horror%"
    }
    label: "Horror Count"
    drill_fields: [content_rating,imdb_score]
  }
 measure: movie_count {
   type: count_distinct
  sql: ${movie_title} ;;
 }
measure: totalMovies {
  type: number
  sql: ${numberHorror}+${numberAction}+${numberAnimation}+${numberComedies}+${numberCrimes}+${numberDramas}
  +${numberFamily}+${numberFantasy}+${numberHorror}+${numberMusical}+${numberMystery}+${numberRomance}
  +${numberThriller};;
}
  measure: minBudget {
    type: number
    sql: MIN(${budget}) ;;
    label: "Min Budget"
    drill_fields: [imdb_score,duration,actor_1_name,actor_2_name,actor_3_name,gross]
    value_format_name: usd
  }
  measure: maxBudget {
    type: number
    sql: MAX(${budget}) ;;
    label: "Max Budget"
    drill_fields: [imdb_score,duration,actor_1_name,actor_2_name,actor_3_name,gross]
#     html: <a href="https://learn.looker.com/dashboards/184?Actor={{ value }}&Actor={{ _filters['hollywood_film.actor_1_name'] | url_encode }}";;
    value_format_name: usd
      link: {
        label: "Drill To Films"
        url: "https://dcl.dev.looker.com/dashboards/184?Actor%20Filter={{ _filters['hollywood_film.actor_1_name'] | url_encode }}"
      }

  }

  measure: totalBudget {
    type: sum_distinct
    sql: ${budget} ;;
    label: "Total Budget"
    drill_fields: [imdb_score,duration,actor_1_name,actor_2_name,actor_3_name,gross]
    value_format_name: usd
  }
  measure: maxGross {
    type: number
    sql: MAX(${gross}) ;;
    label: "Max Gross"
    value_format_name: usd
    drill_fields: [imdb_score,duration,actor_1_name,actor_2_name,actor_3_name,budget]
    link: {
      label: "Drill to Films"
      url:"https://dcl.dev.looker.com/dashboards/184?Actor%20Filter={{ _filters['hollywood_film.actor_1_name'] | url_encode }}"
    }
  }

}

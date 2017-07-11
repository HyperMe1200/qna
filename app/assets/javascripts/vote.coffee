$(document).on 'turbolinks:load', ->
  $('.vote_link').bind 'ajax:success', (e) ->
    answer = e.detail[0]
    id = answer.controller + '-' + answer.id
    rating = "Rating: " + answer.object
    $('#rating-' + id).html(rating)
    $('#error-' + id).html('')
  $('.vote_link').bind 'ajax:error', (e) ->
    answer = e.detail[0]
    id = answer.controller + '-' + answer.id
    console.log(id)
    $('#error-' + id).html(answer.object)
$(document).on 'turbolinks:load', ->
  $('.vote_link').bind 'ajax:success', (e) ->
    resource = e.detail[0]
    id = resource.controller + '-' + resource.id
    rating = "Rating: " + resource.content
    $('#rating-' + id).html(rating)
    $('#error-' + id).html('')
  $('.vote_link').bind 'ajax:error', (e) ->
    resource = e.detail[0]
    id = resource.controller + '-' + resource.id
    $('#error-' + id).html(resource.content)
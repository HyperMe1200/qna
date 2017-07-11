# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
$(document).on 'click', '.edit-question-link', (e) ->
  e.preventDefault()
  $(this).hide()
  question_id = $(this).data('questionId')
  $('form#edit-question-' + question_id).show()
#else
#  $('#vote-' + votable_with_id).html('')
#$('#rate-' + votable_with_id).html(votable.rating)
#$('form#vote-' + votable_with_id).toggle()
#$('form#clear-vote-' + votable_with_id).toggle()
$('document').ready ->
  $('tbody.review_history').hide()
  $('.toggle_history').on 'click', ->
    $('tbody.review_history').slideToggle('slow')

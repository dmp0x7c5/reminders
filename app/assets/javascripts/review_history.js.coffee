toggleButtonText = (button_text, button_class) ->
  parent = $('#' + button_class)
  button = $('.toggle_history', parent)
  if button_text == "Show"
    button.text('Hide')
  else
    button.text('Show')

$('document').ready ->
  $('tbody.review_history').hide()
  $('.toggle_history').on 'click', ->
    expandable_class = $(this).parent('td').attr('class')
    $('tbody.review_history.' + expandable_class).slideToggle('slow')
    button_text = this.textContent.trim()

toggleTable = (expandable_class, button_text) ->
  table = $('tbody.review_history.' + expandable_class)
  table_header = $('#' + expandable_class)
  if table.is(':visible')
    $.when(table.slideUp('slow')).done ->
      toggleButtonText(button_text, expandable_class)
      table_header.toggleClass('expanded_table_header')
  else
    $.when(table_header.toggleClass('expanded_table_header')).done ->
      toggleButtonText(button_text, expandable_class)
      table.slideDown('slow')

toggleButtonText = (button_text, button_class) ->
  parent = $('#' + button_class)
  button = $('.toggle_history', parent)
  if button_text == "Show"
    button.text('Hide')
  else
    button.text('Show')

ready = ->
  $('tbody.review_history').hide()
  $('.toggle_history').on 'click', ->
    expandable_class = $(this).parent('td').attr('class')
    button_text = this.textContent.trim()

    toggleTable(expandable_class, button_text)

$(document).ready(ready)
$(document).on('page:load', ready)

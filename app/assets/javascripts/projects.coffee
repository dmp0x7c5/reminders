ready = ->
  $('input.js-toggle-switch').change (e) ->
    $(this).parent().submit()

$(document).on 'page:load', ready
$(document).ready ready


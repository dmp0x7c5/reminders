ready = ->
  $('.datatable').DataTable
    paging: false
    searching: false
    bInfo: false

$(document).on 'page:load', ready
$(document).ready ready

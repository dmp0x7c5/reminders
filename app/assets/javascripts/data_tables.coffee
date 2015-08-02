ready = ->
  $('.datatable').DataTable
    paging: false
    searching: false
    bInfo: false
    order: []

$(document).on 'page:load', ready
$(document).ready ready

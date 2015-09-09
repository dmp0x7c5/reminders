ready = ->
  dataTable = $('.assignments-datatable').DataTable
    paging: false
    bInfo: false
    dom: 'lrti'
    ordering: false

$(document).on 'page:load', ready
$(document).ready ready

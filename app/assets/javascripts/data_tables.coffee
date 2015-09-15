ready = ->
  dataTable = $('.datatable').DataTable
    paging: false
    searching: true
    bInfo: false
    order: []
    searchCols: [
      null
      null
      null
      null
      null
      null
      null
      { search: "all" }
    ]

  handleFilterClick = (e) ->
    e.preventDefault()
    filter = $(this).data('filter')
    $parent = $(this).parent()
    $parent.siblings('li').removeClass('active')
    $parent.addClass('active')
    dataTable.columns([-1]).search(filter).draw()

  $('.datatable-filters a').click handleFilterClick

$(document).on 'page:load', ready
$(document).ready ready

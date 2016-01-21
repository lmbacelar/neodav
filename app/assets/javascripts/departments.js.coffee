$(document).on 'focus', '#department_company', ->
  $('#department_company').autocomplete
    source: '/companies/autocomplete'
    minLength: 2

$(document).on 'focus', '#department_name', ->
  $('#department_name').autocomplete
    source: (request, response) ->
      $.getJSON '/departments/autocomplete', { company: $('#department_company').val(), term: $('#department_name').val() }, response
      return
    minLength: 2

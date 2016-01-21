$(document).on 'focus', '#instrument_brand', ->
  $('#instrument_brand').autocomplete
    source: '/brands/autocomplete'
    minLength: 2

$(document).on 'focus', '#instrument_model', ->
  $('#instrument_model').autocomplete
    source: (request, response) ->
      $.getJSON '/models/autocomplete', { brand: $('#instrument_brand').val(), term: $('#instrument_model').val() }, response
      return
    minLength: 2

$(document).on 'focus', '#instrument_company', ->
  $('#instrument_company').autocomplete
    source: '/companies/autocomplete'
    minLength: 2

$(document).on 'focus', '#instrument_department', ->
  $('#instrument_department').autocomplete
    source: (request, response) ->
      $.getJSON '/departments/autocomplete', { company: $('#instrument_company').val(), term: $('#instrument_department').val() }, response
      return
    minLength: 2

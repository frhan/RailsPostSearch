# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


getParameters = ->
  query = window.location.search.substring(1)
  raw_vars = query.split("&")

  params = {}

  for v in raw_vars
    [key,val] = v.split("=")
    params[key] = decodeURIComponent(val)
  params

checkFilters = (selector,filters) ->
  $(selector).each ->
    for filter in filters
      $(selector).find("input:checkbox[value='" + filter + "']").attr("checked",true)

#$(document).on 'ready', ->
ready = ->
  filters = {
    'categories': [],
    'locations': []
  }

  parameters = getParameters()
  console.log('caeded')
  if parameters.category_ids?
    for category in parameters.category_ids.split(',')
      filters.categories.push(category)
  if parameters.locations?
    for location in parameters.locations.split(',')
      filters.locations.push(location)

  #check box
  checkFilters('.category-search',filters.categories)
  checkFilters('.location-search',filters.locations)

  #set sort
  query = parameters.query
  if (!query)
    sort_by = 'recent'
  else
    sort_by = 'relevance'

  para_sort = parameters.sort_by
  if !!para_sort
    sort_by = para_sort
  $('#sort_by').val(sort_by)

  # Checking and unchecking filter boxes for industry
  $('.category-search [type="checkbox"]').on 'click', ->
    value = $(this).val()
    if $(this).is(':checked')
      filters.categories.push(value)
    else
      index = filters.categories.indexOf(value)
      filters.categories.splice(index, 1) if index > -1
    filterSearch(filters)

  # Checking and unchecking filter boxes for location
  $('.location-search [type="checkbox"]').on 'click', ->
    value = $(this).val()
    if $(this).is(':checked')
      filters.locations.push(value)
    else
      index = filters.locations.indexOf(value)
      filters.locations.splice(index, 1) if index > -1
    filterSearch(filters)

  #  $('#sort_by').on 'change', ->
  #    filterSearch(filters)

  filterSearch = (filters = undefined) ->
    complete_url = document.URL
    full = complete_url.substring(0, complete_url.indexOf('?'));#// location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
    query = getParameters().query
    if !query?
      query = ""
    url = full+"?query=" + query

    if filters?
      if filters.categories.length > 0
        url = url + '&category_ids=' + filters.categories.join(',')
      if filters.locations.length > 0
        url = url + '&locations=' + filters.locations.join(',')

    #sort_by = $('#sort_by').val()
    #if sort_by.length > 0
    #url = url + "&sort_by=" + sort_by

    window.location.href = url



$(document).ready(ready)
$(document).on('page:load',ready)










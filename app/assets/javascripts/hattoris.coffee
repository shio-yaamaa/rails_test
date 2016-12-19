ready ->
  $('.hattori_container').on 'click', ->
    Turbolinks.visit $(this).data 'detailUrl'
  
  $('#page_order').on 'change', ->
    document.location.search = addUrlParameter document.location.search, 'order', $(this).val()

addUrlParameter = (locationSearch, key, value) ->
  key = encodeURIComponent key
  value = encodeURIComponent value
  keyValue = key + '=' + value

  regExp = new RegExp "(&|\\?)#{key}=[^&]*"
  execResult = regExp.exec locationSearch
  if execResult
    locationSearch = locationSearch.replace regExp, execResult[0][0] + keyValue
  else
    locationSearch += (if locationSearch.length == 0 then '?' else '&') + keyValue
  
  return locationSearch
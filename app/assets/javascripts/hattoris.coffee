console.log location.host + location.pathname

ready ->
  $('.hattori_container').on 'click', ->
    Turbolinks.visit $(this).data 'detailUrl'
  
  $('#page_order').on 'change', ->
    location.href = "#{location.pathname}?order=#{$(this).val()}"
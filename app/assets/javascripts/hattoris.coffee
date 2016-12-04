ready ->
  $('.hattori_container').on 'click', ->
    Turbolinks.visit $(this).data 'detailUrl'
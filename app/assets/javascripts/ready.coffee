@ready_list = []
@ready = (func) -> ready_list.push func
$(document).on 'turbolinks:load', -> for ready in ready_list then ready()
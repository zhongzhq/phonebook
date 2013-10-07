# sidebar tree function
init_organ_tree = ->
  open_icon = "glyphicon-play"
  close_icon = "glyphicon-chevron-down"

  # init tree
  $(".tree .item").each ->
    item_action = $(this).find(".action")
    item_action.hide()
    $(this).mouseover ->
      item_action.show()
    $(this).mouseout ->
      item_action.hide()

    children_level = $(this).siblings("ul")
    children_level.hide()
    if children_level.find("li").size() > 0
      $(this).prepend("<span class=\"glyphicon #{open_icon} toggle-icon\"></span>")

  # show or hide tree
  $(".tree .item").find(".toggle-icon").click ->
    if $(this).is(".#{open_icon}")
      $(this).removeClass(open_icon)
      $(this).addClass(close_icon)
      $(this).parent().siblings("ul").show()
    else
      $(this).removeClass(close_icon)
      $(this).addClass(open_icon)
      $(this).parent().siblings("ul").hide()

# Ajax request
ajax_request = (selector) ->
  selector.bind("ajax:complete",
    (status, xhr) ->
      $('#content').html(xhr.responseText)
      )

$(document).ready ->
  # sidebar tree setting
  init_organ_tree()
  $(".tree .item").find(".toggle-icon").click()
  # add, edit or show organ
  ajax_request($(".tree .item").find("a"))  
  
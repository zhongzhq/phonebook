// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

function organ_tree(){
  var open_icon = "glyphicon-play";
  var close_icon = "glyphicon-chevron-down";

  $(".organ_tree .item").each(function(){
    var item_action = $(this).find(".action");
    item_action.hide();
    $(this).mouseover(function(){
      item_action.show();
    })
    $(this).mouseout(function(){
      item_action.hide();
    })

    var children_level = $(this).siblings("ul");
    children_level.hide();
    if(children_level.find("li").size() > 0){
      $(this).prepend("<span class=\"glyphicon " + open_icon + " toggle-icon\"></span>");
    }
  })

  $(".organ_tree .item").find(".toggle-icon").click(function(){
    if($(this).is("." + open_icon)){
      $(this).removeClass(open_icon);
      $(this).addClass(close_icon);
      $(this).parent().siblings("ul").show();
    }else{
      $(this).removeClass(close_icon);
      $(this).addClass(open_icon);
      $(this).parent().siblings("ul").hide();
    }
  })
}

function ajax_get(selector){
  selector.bind("ajax:complete", function(status, xhr){
    $('#content').html(xhr.responseText);
  })
}

$(document).ready(function(){
  $("[data-toggle~=tooltip]").tooltip();
})

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-dropdown
//= require chosen.jquery.min
//= require jquery.optionTree

function toggle_tree(selector){
  var opened_icon = "icon-folder-close"
  var closed_icon = "icon-folder-open"

  selector.find(".item").each(function(){
    $(this).siblings("ul").hide();
    if($(this).siblings("ul").find("li").size() > 0){
      $(this).prepend("<span class=\" " + opened_icon + " toggle-icon\"></span>");
    }
  });

  selector.find(".item .toggle-icon").click(function(){
    if($(this).is("." + opened_icon)){
      $(this).removeClass(opened_icon);
      $(this).addClass(closed_icon);
      $(this).parent().siblings("ul").show();
    } else {
      $(this).removeClass(closed_icon);
      $(this).addClass(opened_icon);
      $(this).parent().siblings("ul").hide();
    }
  });
}
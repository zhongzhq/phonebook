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
//= require jquery_nested_form
//= require twitter/bootstrap/transition
//= require twitter/bootstrap/collapse
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/alert
//= require_tree .

function option_tree(selector, url, func, options ){
  options = $.extend({
    indexed: true,
    set_value_on: 'each',    
    on_each_change: url,
    choose: '-- 请选择 --'
  }, options || {});

  $.getJSON(url, function(data){
    selector.optionTree(data, options).change(func);
  });
};

function toggle_tree(selector){
  var opened_icon = "glyphicon-play"
  var closed_icon = "glyphicon-chevron-down"

  selector.find(".item").each(function(){
    $(this).siblings("ul").hide();
    if($(this).siblings("ul").find("li").size() > 0){
      $(this).prepend("<span class=\"glyphicon " + opened_icon + " toggle-icon\"></span>");
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
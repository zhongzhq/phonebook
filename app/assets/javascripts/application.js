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
//= require bootstrap-alert
//= require chosen.jquery.min
//= require jquery.optionTree

function toggle_tree(selector){
  var opened_icon = '<img src="/img/closed.gif" class="opened"/>'
  var closed_icon = '<img src="/img/opened.gif" class="closed"/>'

  selector.find(".item").each(function(){
    $(this).siblings("ul").hide();
    if($(this).siblings("ul").find("li").size() > 0){
      $(this).prepend('<span class="toggle-icon">' + opened_icon + '</span>');
    }
  });

  selector.find(".item .toggle-icon").click(function(){
    img = $(this).children("img")
    if(img.hasClass("opened")){
      $(this).html(closed_icon);
      img.remove();
      $(this).parent().siblings("ul").show();
    }else{
      $(this).html(opened_icon);
      img.remove();
      $(this).parent().siblings("ul").hide();
    }
  });
}

function check_browser(){
  var browser=navigator.appName 
  var b_version=navigator.appVersion 
  var version=b_version.split(";"); 
  var trim_Version=version[1].replace(/[ ]/g,""); 
  if((browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0") || (browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0")){
    $("#flash").html('<div class="alert alert-warning text-center"><button class="close" data-dismiss="alert" type="button">×</button><strong>警告：</strong>你的浏览器版本过低，建议使用IE9及以上浏览器、或者火狐、谷歌浏览器，已获得更好的体验</div>')
  }
}

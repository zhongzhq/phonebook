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
// require twitter/bootstrap
//= require_tree .

// 刷新验证码
function refresh_captcha(){
    $('#captcha_img').attr('src', '/captcha?action=captcha&i=' + new Date().getTime())
}

$(function () {
    $("#organ_tree").jstree({
        "themes" : {
          "theme" : "default",
          "dots" : true,
          "icons" : true
        },
        "plugins" : [ "themes", "html_data" ]
    })
    .bind("loaded.jstree", function (event, data) {
      $(".jstree-closed").removeClass("jstree-closed").addClass("jstree-open");

      var init_open = $("#open").find("a:first")
      init_open.addClass("jstree-clicked");
      $.get(init_open.attr('path'), function(data){
        $("#organ_info").html(data);
      });
    })
    .delegate("a", "click", function (event, data) {
      $('li[class^="jstree-"]').each(function(){
        $(this).find("a").removeClass("jstree-clicked");
      });
      $(this).addClass("jstree-clicked");
      $.get($(this).attr('path'), function(data){
        $("#organ_info").html(data);
      });
    });
});

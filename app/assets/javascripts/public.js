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

function remote(selector, fn) {
  selector.attr("data-remote", "true");  
  selector.bind("ajax:complete", fn);  
}

function remote_content(selector, fn, replace_selector) {
  replace_selector = replace_selector || $("#content");
  
  selector.bind("ajax:before", function(){
    $("body").append('\
      <div class="backdrop">\
        <div class="progress progress-striped active">\
          <div class="progress-bar" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">\
            <span class="sr-only">100% Complete</span>\
          </div>\
        </div>\
      </div>');
  });
  
  remote(selector, function(status, xhr){
    replace_selector.html(xhr.responseText);
    if(fn != undefined){ fn.call(); }
    $(".backdrop").remove();
  });  
}

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
//= require twitter/bootstrap/dropdown
//= require_tree .

// 刷新验证码
function refresh_captcha(){
    $('#captcha_img').attr('src', '/captcha?action=captcha&i=' + new Date().getTime())
}

function get(obj){
    $.get($(obj).attr("href"), function(data){
        $('#organs').html(data);
    });
}
function show_message(txt){
    //IE6位置
    if (!window.XMLHttpRequest) {
	$("#targetFixed").css("top", $(document).scrollTop() + 2);
    }
    //创建半透明遮罩层
    if (!$("#overLay").size()) {
	$('<div id="overLay"></div>').prependTo($("body"));
	$("#overLay").css({
	    width: "100%",
	    backgroundColor: "#000",
	    opacity: 0.2,
	    position: "absolute",
	    left: 0,
	    top: 0,
	    zIndex: 10000
	}).height($(document).height());
    }
    //显示操作提示，最关键核心代码
    $("#floatBox_doing").show().html("提示：" + txt)
    //定时关闭，测试用
    setTimeout(function() {
	$("#overLay").remove();
	$("#floatBox_doing").hide();
    }, 1000);

}

// jsTree 设置
function organ_tree() {
    // jstree 设置
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
	})
	.delegate("a", "click", function (event, data) {
	    $('li[class^="jstree-"]').each(function(){
		$(this).find("a").removeClass("jstree-clicked");
	    });
	    $(this).addClass("jstree-clicked");
	    get(this);
	});
};

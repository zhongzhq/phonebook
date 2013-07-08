$(document).ready(function(){
    $('#captcha').next().find('a').click(function(){
        $('#captcha').next().find('img').attr('src', '/captcha?action=captcha')
    })
})

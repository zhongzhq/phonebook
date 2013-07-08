function refresh_captcha( obj ){
  $('#captcha').next().find('img').attr('src', '/captcha?action=captcha&i=' + new Date().getTime())
}
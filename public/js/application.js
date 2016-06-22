$(document).ready(function(){
  $('#login-trigger').on('click', function(e){
    e.preventDefault;
    // debugger
    $(this).next('#login-content').slideToggle();
    $(this).toggleClass('active');

    if ($(this).hasClass('active')) $(this).find('span').html('&#x25B2;')
      else $(this).find('span').html('&#x25BC;')

     $("input[name=email]").focus();

    $('#drop-login').on('submit', function(e) {
        e.preventDefault;
        var login = $(e.target).serialize();
        var thing = $.ajax({
          url: $(this).attr('action'),
          method: $(this).attr('method'),
          data: login
        });
        thing.done(function(response) {
          window.location.href = response;
        });
        thing.fail(function(response) {
          $('#login-content').html(response);
        });
    });
  });

});

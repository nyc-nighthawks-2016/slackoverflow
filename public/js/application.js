$(document).ready(function(){
  $('#login-trigger').click(function(e){
    e.preventDefault;
    $(this).next('#login-content').slideToggle();
    $(this).toggleClass('active');

    if ($(this).hasClass('active')) $(this).find('span').html('&#x25B2;')
      else $(this).find('span').html('&#x25BC;')
      debugger
    $.ajax({
      url: $(this).attr('href');
      method: 'POST'
    })
    .done(function() {

    })
    })
});

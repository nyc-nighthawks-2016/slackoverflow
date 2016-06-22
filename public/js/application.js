$(document).ready(function(){
  $('#login-trigger').on('mouseover', function(e){
    e.preventDefault;
    // debugger
    $(this).next('#login-content').slideToggle();
    $(this).toggleClass('active');

    if ($(this).hasClass('active')) $(this).find('span').html('&#x25B2;')
      else $(this).find('span').html('&#x25BC;')
      $("input[name=Email]").focus();
    // $.ajax({
    //   url: $(this).attr('href');
    //   method: 'POST'
    //   data: $('#inputs').serialize();
    // })
    // .done(function() {

    // })
    });
});

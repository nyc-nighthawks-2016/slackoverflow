$(document).ready(function(){
  $('#login-trigger').on('click', function(e){
    e.preventDefault();
    // debugger
    $(this).next('#login-content').slideToggle();
    $(this).toggleClass('active');

    if ($(this).hasClass('active')) $(this).find('span').html('&#x25B2;')
      else $(this).find('span').html('&#x25BC;')

    $("input[name=email]").focus();

    $('#drop-login').on('submit', function(e) {
      e.preventDefault();
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

    $('a[href=#question-form]').on('click', function(e) {
      // debugger
      e.preventDefault();
      $('#question-form').show();
      $('#question').find('input[name=title]').focus();
    });

    $('#question').on('submit', function(e) {
      e.preventDefault();
      // debugger
      var title = $('input[name=title]');
      var question = $('textarea[name=question]');

      $.ajax({
        url: $(this).attr('action'),
        method: $(this).attr('method'),
        data: $(this).serialize()
      })
      .done(function(response) {
        // debugger;
        $('.questions-list').append(response);
        $(title).val('');
        $(question).val('');
        $('#question').find('input[name=title]').focus();
      })
      .fail(function(error){
        $('#posts').prepend('<li id="error">'+error.responseText+'</li>');
        $(title).val('');
        $(question).val('');
      });
    });

    $('.tabs').on('click', 'li', function() {
    event.preventDefault();
    $('.tabs > li').removeAttr('class');
    $(this).addClass('active');
  });

    $('.question-link').on('click', function(e) {
      e.preventDefault();
      $.ajax({
        url: $(this).attr('href'),
        method: 'get'
      })
      .done(function(response) {
        $('#partial-container').html(response);
        // $(document).on('change', '#partial-container', function() {
        //   $('#partial-container').html(response);
      });
    });

    $('.tag-link').on('click', function(e) {
      e.preventDefault();
      $.ajax({
        url: $(this).attr('href'),
        method: 'GET'
      })
      .done(function(response) {
        $('#tag_partials').html(response);
      });
    });

    $('.each-tag-link').on('click', function(e) {
      e.preventDefault();
      $.ajax({
        url: $(this).attr('href'),
        method: 'GET'
      })
      .done(function(response) {
        $('#each_tag_partials').html(response);
      });
    });

    $('.question-vote-count').on('submit', 'form', function(e) {
      e.preventDefault();
      var upVoteCount = $(this).parent().find('div[class=vote-count]');
      $.ajax({
        url: $(this).attr('action'),
        method: $(this).attr('method')
      })
      .done(function(response) {
        $(upVoteCount).html(response);
      });
    });

// Question Downvote AJAX functionality - CHECK

    $('.question-vote-count').on('submit', 'form', function(e) {
      e.preventDefault();
      var downVoteCount = $(this).parent().find('div[class=vote-count]');
      $.ajax({
        url: $(this).attr('action'),
        method: $(this).attr('method')
      })
      .done(function(response) {
        $(downVoteCount).html(response);
      });
    });

// Answer Upvote AJAX functionality - CHECK

    $('.voting_box').on('submit', 'form', function(e) {
      e.preventDefault();
      var upVoteCount = $(this).parent().find('div[class=vote-count]');
      $.ajax({
        url: $(this).attr('action'),
        method: $(this).attr('method')
      })
      .done(function(response) {
        $(upVoteCount).html(response);
      });
    });

// Answer Downvote AJAX functionality - CHECK

    $('.voting_box').on('submit', '.downvote', function(e) {
      e.preventDefault();
      var downVoteCount = $(this).parent().find('div[class=vote-count]');
      $.ajax({
        url: $(this).attr('action'),
        method: $(this).attr('method')
      })
      .done(function(response) {
        $(downVoteCount).html(response);
      });
    });


});

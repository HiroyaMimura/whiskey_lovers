$(document).on('turbolinks:load', function(){
  $('.top_image').fadeIn(3000, function(){
    $('.message').fadeIn(3000, function(){
      $('.message2').fadeIn(3000, function(){
        $('.logout').slideUp(2000)
      });
    });
  });
});

$(document).on('turbolinks:load', function(){
  $('.title').slideDown(700)
});
$(document).on('turbolinks:load', function(){
  $('.top_image').fadeIn(3500, function(){
    $('.message').fadeIn(4000, function(){
      $('.message2').fadeIn(4000, function(){
        $('.logout').slideUp(2000)
      });
    });
  });
});

$(document).on('turbolinks:load', function(){
  $('.title').slideDown(1000)
});

$(function() {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $("#side_bar").toggleClass('open');
    $("#side_bar").css('transition-duration', '1s');
    $(".side_bar-wrapper").toggleClass('d-none');
    event.preventDefault();
  });
});
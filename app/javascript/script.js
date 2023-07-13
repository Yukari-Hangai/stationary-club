$(function() {
  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#side_ber').fadeToggle();
    event.preventDefault();
  });
});
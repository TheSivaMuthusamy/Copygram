$( document ).ready(function() {
  var posx = $('.notification-index-list > a > li').width();
  var posy = $('.notification-index-list > a > li').height();
  $('.notification-index-list > .mark-read-glyph').css('transform', 'translate(' + (posx-20) + 'px,' + (1-posy) + 'px)');
});

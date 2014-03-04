// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require thirdparty/masonry.pkgd.min

$(window).load(function(){
  $('#masonryContainer').masonry({
    itemSelector: '.masonry-brick',

    isAnimated: true,
  });
});

$(function(){
  // Load foundation
  $(document).foundation();

  // Fix broken avatar image
  $('img').error(function(){
    $(this).attr('src', '/assets/missing.png');
  });

  // Toggle active class about build filter
  var filter = [];
  $( '.left-off-canvas-menu span.tag' ).click(function() {
    if($(this).hasClass('active')) {
      $(this).removeClass('active');
      filter.splice( $.inArray($(this).text(), filter), 1);
    } else {
      $(this).addClass('active');
      filter.push($(this).text());
    }
    $('input.filter-hash').val(filter);
    console.log('Filter the tweets by these #hashtags:', filter);
  });
});

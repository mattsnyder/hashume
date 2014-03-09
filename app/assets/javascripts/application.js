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

$(function(){
  // Load foundation
  $(document).foundation();

  var $container = $('#masonryContainer');

  $container.isotope({
    // options
    itemSelector: '.masonry-brick',
    layoutMode: 'masonry'
  });

  // Fix broken avatar image
  $('img').error(function(){
    $(this).attr('src', '/assets/missing.png');
  });

  var filter = [];
  var filterFns = {
    // show if number is greater than 50
    numberGreaterThan50: function() {
      var number = $(this).find('.number').text();
      return parseInt( number, 10 ) > 50;
    },
    // show if name ends with -ium
    ium: function() {
      var name = $(this).find('.name').text();
      return name.match( /ium$/ );
    }
  };

  $( 'span.tag' ).click(function() {
    var filterValue = $(this).attr('data-filter-value');

    filterValue = filterFns[ filterValue ] || filterValue;
    $container.isotope({ filter: filterValue });
  });

  $('.tags').each( function( i, tag ) {
    var $tag = $( tag );
    $tag.on( 'click', 'span.tag', function() {
      $tag.find('.active').removeClass('active');
      $( this ).addClass('active');
    });
  });

  setTimeout(function() {
    $container.isotope('layout');
  }, 100);
});

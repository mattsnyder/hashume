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
    itemSelector: '.masonry-brick'
  });
});

$(function(){
  $(document).foundation({
    orbit: {
      animation: 'slide',
      pause_on_hover: false,
      slide_number: false,
      navigation_arrows: true,
      bullets: false,
      timer_progress_class: 'orbit-progress',
      next_class: 'orbit-next-custom',
      prev_class: 'orbit-prev',
      timer_paused_class: 'paused',
      timer: false,
      container_class: 'orbit-container',
      after_slide_change: orbit_step
    }
  });

  function login() {
    var step_selector = $('.orbit-step');
    var link = $('.orbit-next-custom');
    if (step_selector.hasClass('step-3')) {
      link.click(function(){
        window.location.href = '/auth/twitter';
        return false;
      });
    }
  }
  function orbit_step() {
    var step_selector = $('.orbit-step');
    if (step_selector.is('.step-1')) {
      step_selector.removeClass('step-1').addClass('step-2');
    } else if (step_selector.is('.step-2')) {
      step_selector.removeClass('step-2').addClass('step-3');
      login();
    } else {
      step_selector.removeClass('step-3').addClass('step-1');
      $('.orbit-next-custom').attr('href', '/auth/twitter');
    }
  }

});

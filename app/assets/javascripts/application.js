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

// $(function(){
//   $(document).foundation({
//     orbit: {
//       animation: 'slide', // Sets the type of animation used for transitioning between slides, can also be 'fade'
//       timer_speed: 10000, // Sets the amount of time in milliseconds before transitioning a slide
//       pause_on_hover: false, // Pauses on the current slide while hovering
//       resume_on_mouseout: false, // If pause on hover is set to true, this setting resumes playback after mousing out of slide
//       animation_speed: 500, // Sets the amount of time in milliseconds the transition between slides will last
//       stack_on_small: false,
//       navigation_arrows: true,
//       slide_number: false,
//       slide_number_text: '',
//       container_class: 'orbit-container',
//       next_class: 'orbit-next-custom', // Class name given to the next button
//       prev_class: 'orbit-prev', // Class name given to the previous button
//       timer_container_class: 'orbit-timer', // Class name given to the timer
//       timer_paused_class: 'paused', // Class name given to the paused button
//       timer_progress_class: 'orbit-progress', // Class name given to the progress bar
//       slides_container_class: 'orbit-slides-container', // Class name given to the
//       bullets_container_class: 'orbit-bullets',
//       slide_selector: 'li', // Default is '*' which selects all children under the container
//       bullets_active_class: 'active', // Class name given to the active bullet
//       slide_number_class: 'orbit-slide-number', // Class name given to the slide number
//       caption_class: 'orbit-caption', // Class name given to the caption
//       active_slide_class: 'active', // Class name given to the active slide
//       orbit_transition_class: 'orbit-transitioning',
//       bullets: false, // Does the slider have bullets visible?
//       circular: false, // Does the slider should go to the first slide after showing the last?
//       timer: false, // Does the slider have a timer visible?
//       variable_height: true, // Does the slider have variable height content?
//       swipe: true,
//       after_slide_change: orbit_step // Execute a function after the slide changes
//     }
//   });

//   function login() {
//     var step_selector = $('.orbit-step');
//     var link = $('.orbit-next-custom');
//     if (step_selector.hasClass('step-3')) {
//       link.click(function(){
//         window.location.href = '/auth/twitter';
//         return false;
//       });
//     }
//   }
//   function orbit_step() {
//     var step_selector = $('.orbit-step');
//     if (step_selector.is('.step-1')) {
//       step_selector.removeClass('step-1').addClass('step-2');
//     } else if (step_selector.is('.step-2')) {
//       step_selector.removeClass('step-2').addClass('step-3');
//       login();
//     } else {
//       step_selector.removeClass('step-3').addClass('step-1');
//       $('.orbit-next-custom').attr('href', '/auth/twitter');
//     }
//   }

// });

$(function(){
  $(document).foundation();
  $('img').error(function(){
    $(this).attr('src', '/assets/missing.png');
  });
});

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require materialize-sprockets
//= require materialize-form
//= require_tree .

// @import "materialize";
// @import "https://fonts.googleapis.com/icon?family=Material+Icons";


// Flash fade
$(function() {
   $('.alert-box').fadeIn('normal', function() {
      $(this).delay(3700).fadeOut();
   });
});

// Carousel function
$(document).ready(function(){
  $('.carousel').carousel();
});

// Sticky footer js
// Credit for this goes to Robert Vunabandi and his post:
// https://rvunabandi.medium.com/how-to-make-a-sticky-footer-using-javascript-2445d899d7b4
// to make this work, css #footer has to have `position: relative`
// when the page load, activate the sticky footer
window.addEventListener("load", activateStickyFooter);

function activateStickyFooter() {
  // need to adjust the footer top when the page just loads
  // because the footer may not be sticky
  adjustFooterCssTopToSticky();
  
  // whenever the window is resized, we need to re-adjust the
  // footer top to update its position
  window.addEventListener("resize", adjustFooterCssTopToSticky);
}

function adjustFooterCssTopToSticky() {
  const footer = document.querySelector("#footer");
  const bounding_box = footer.getBoundingClientRect();
  const footer_height = bounding_box.height;
  const window_height = window.innerHeight;

  // we need to subtract the footer top because it may have
  // changed due to another call to this method.
  const above_footer_height = bounding_box.top - getCssTopAttribute(footer);
  
  if (above_footer_height + footer_height <= window_height) {
    // if the whole page's content + footer height is less than
    // the browser window's height, we need to add in that extra
    // room in the footer top attribute.
    const new_footer_top = window_height - (above_footer_height + footer_height);
    footer.style.top = new_footer_top + "px";
  } else if (above_footer_height + footer_height > window_height) {
    // otherwise, we need the have a top of 0px (equivalent to 
    // setting it to null) so that we don't have extra space 
    // between the content and footer.
    footer.style.top = null;
  }
}

function getCssTopAttribute(htmlElement) {
  const top_string = htmlElement.style.top;
  if (top_string === null || top_string.length === 0) {
    return 0;
  }
  // assume this is written in pixels
  const extracted_top_pixels = top_string.substring(0, top_string.length - 2);
  return parseFloat(extracted_top_pixels);
}

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
//= require rails-ujs
//= require jquery
//= require owl.carousel
//= require_tree .

$(document).on("click", '[data-toggle="lightbox"]', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox();
});

$(document).on(
  "change",
  '[aria-describedby="inputGroupFileAddon"]',
  function() {
    //get the file name
    var fileName = document.getElementById("inputGroupFile").files[0].name;
    //replace the "Choose a file" label
    $(this)
      .next(".custom-file-label")
      .html(fileName);
  }
);

$(function() {
  $("#upload-button").click(function() {
    $("#upload-photo").slideToggle(300);
    return false;
  });
});

$(document).ready(function() {
  $(".owl-carousel").owlCarousel({
    loop: false,
    margin: 10,
    nav: true,
    responsive: {
      0: {
        items: 1
      },
      600: {
        items: 3
      },
      1000: {
        items: 5
      }
    }
  });
});

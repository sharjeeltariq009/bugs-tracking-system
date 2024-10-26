// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./bugs"; 
import "bootstrap"
import "popper"
//= require rails-ujs



$(document).ready(function() {
  $('#project_search').on('keypress', function(e) {
    if (e.which === 13) { // Enter key
      e.preventDefault(); // Prevent the default form submission
      $('#project-search-form').submit(); // Submit the form
    }
  });
});







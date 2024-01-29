// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import jquery from "jquery"
window.$ = jquery
window.jQuery = jquery


$(function() {
  $('body').on('submit', '#notes-form', function(e){
    event.preventDefault();

    e.preventDefault(); // Prevent the default form submission

    var formData = $(this).serialize(); // Serialize the form data

    $.ajax({
      type: 'POST',
      url: $(this).attr('action'), // Get the form action URL
      data: formData,
      success: function(response) {
        // Handle the successful response here
        console.log('Form submitted successfully');
        console.log(response); // You can log or process the server response
        debugger
      },
      error: function(error) {
        // Handle the error response here
        console.error('Error submitting form:', error);
        debugger
      }
    });
  })
})

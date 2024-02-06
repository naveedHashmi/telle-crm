import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submit_notes(e) {
    e.preventDefault();

    let form = $('#notes-form')
    let formData = form.serialize();

    $.ajax({
      type: 'POST',
      url: form.attr('action'),
      data: formData,
      success: function(data) {
        $('#exampleModalLong').modal('hide');
        $("#note_description").val('')
      },
      error: function(error) {
        console.error('Error submitting form:', error);
      }
    });
  }
}

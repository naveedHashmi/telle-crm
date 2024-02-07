import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submit_activities(e) {
    e.preventDefault();

    let confirmed = confirm('Are you sure you want to submit this form?');

    if (confirmed) {
      let form = $(e.target)
      var formData = form.serialize();

      $.ajax({
        type: 'POST',
        url: form.attr('action'),
        data: formData
      });
    }
  }

  filter_activities(e) {
    e.preventDefault();

    let dropdownValue = $('#activity_status_dropdown').val()
    let status = dropdownValue == 'All' ? ['Complete', 'Uncomplete'] : dropdownValue

    $.ajax({
      type: 'GET',
      url: '/activities.js',
      data: {'filter[status]': status}
      });
  }
}

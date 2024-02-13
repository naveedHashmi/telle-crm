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

  submit_leads_users_filter_form(e) {
    e.preventDefault();

    let dropdownValue = $('#filter_user_id').val()

    $.ajax({
      type: 'GET',
      url: '/leads.js',
      data: {'filter[user_id]': dropdownValue}
      });
  }

  submit_mapping_form(e) {
    let form = $('#mapping-form')

    form.attr('action', '/leads/process_csv');
    form.attr('id', 'file-process-form');
  }

}

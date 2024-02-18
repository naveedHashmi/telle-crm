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
    $("#leads_users_filter_form").submit()
  }

  submit_mapping_form(e) {
    let form = $('#mapping-form')

    form.attr('action', '/leads/process_csv');
    form.attr('id', 'file-process-form');
  }

  select_all_leads(e) {
    if (e.target.checked) {
      $('.lead-checkbox:not(:checked)').each(function (index, checkbox) {
        $(checkbox).prop('checked', true);
      });
    } else {
      $('.lead-checkbox').each(function (index, checkbox) {
        $(checkbox).prop('checked', false);
      });
    }
  }

  assign_selected_users() {
    const leadIds = $('.lead-checkbox:checked').map((index, checkbox) => $(checkbox).val()).get();

    $("#lead_ids").val(leadIds)
  }

  toggleModel() {
    $(".modal-backdrop").toggle();
    $("#lead-assignee-change").toggle()
  }
}

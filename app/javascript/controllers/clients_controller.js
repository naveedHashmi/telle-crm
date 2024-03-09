import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submit_clients_users_filter_form(e) {
    document.getElementById("clients_users_filter_form").requestSubmit()
  }

  select_all_clients(e) {
    if (e.target.checked) {
      $('.client-checkbox:not(:checked)').each(function (index, checkbox) {
        $(checkbox).prop('checked', true);
      });
    } else {
      $('.client-checkbox').each(function (index, checkbox) {
        $(checkbox).prop('checked', false);
      });
    }
  }

  assign_selected_users() {
    const clientIds = $('.client-checkbox:checked').map((index, checkbox) => $(checkbox).val()).get();

    $("#client_ids").val(clientIds)
  }

  toggleModel() {
    $(".modal-backdrop").toggle();
    $("#client-assignee-change").toggle()
  }
}

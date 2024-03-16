import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  filter_deals(e) {
    $("#deal_status_filter_form").submit();
  }

  updateStatus(event) {

    let {id, status} =event.target.dataset

    $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      type: 'PATCH',
      url: `${window.location.origin}/deals/${id}/update_status`,
      data: {status: status, id: id},
      success: function(res) {
        const status2 = res.status
        let included = true;
        document.querySelectorAll('.step').forEach((element) => {
          element.classList.remove('current')

          if (included) element.classList.add('current');
          if (element.dataset.status == status2) included = false;
        });
      },

      error: function(error) {
        console.error('Error submitting form:', error);
      }
    });
  }
}

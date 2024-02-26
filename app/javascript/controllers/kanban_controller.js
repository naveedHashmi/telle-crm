import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";
export default class extends Controller {
  connect() {
    new Sortable(this.element, {
      group: 'shared',
      animation: 150,
      onEnd: this.handleDrop.bind(this)
    });
  }

  handleDrop(event) {
    const { dealId } = event.item.dataset;
    const { status: targetStatus, textcolor: targetTextColor, bgcolor: targetBgColor } = event.to.dataset;

    $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      type: 'PATCH',
      url: `deals/${dealId}/update_status`,
      data: {status: targetStatus, id: dealId},
      success: function() {
        Array.from(event.item.classList).forEach(className => {
          if (className.startsWith("bg-") || className.startsWith("text-")) {
            event.item.classList.remove(className);
          }
        });

        event.item.classList.add(targetBgColor, targetTextColor);
      },

      error: function(error) {
        console.error('Error submitting form:', error);
      }
    });
  }
}

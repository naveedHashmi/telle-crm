import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('invoices connected')
  }
  toggleModel() {
    $(".modal-backdrop").toggle();
    $("#createInvoiceModal").toggle()
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  filter_deals(e) {
    $("#deal_status_filter_form").submit();
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  filter_analytics(e) {
    document.getElementById("analytics_filter_form").requestSubmit();
  }
}

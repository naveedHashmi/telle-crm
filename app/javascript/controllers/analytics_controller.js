import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  filter_analytics(e) {
    $("#analytics_filter_form").submit();
  }
}

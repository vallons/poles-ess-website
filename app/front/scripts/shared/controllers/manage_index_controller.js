import { Controller } from "stimulus";

export default class extends Controller {

  submitFilterForm(e) {
    e.target.closest("form").submit();
  }

  connect() {
    console.log("Manage index !");
  }

}

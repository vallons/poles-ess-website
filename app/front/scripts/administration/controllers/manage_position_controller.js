import { Controller } from "stimulus";

export default class extends Controller {

  submitSelect(e) {
    e.target.closest("form").submit();
  }

  connect() {
    console.log("Manage position !");
  }

}

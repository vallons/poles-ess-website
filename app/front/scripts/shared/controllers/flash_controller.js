import { Controller } from "stimulus";

export default class extends Controller {

  connect() {
    console.log("flash !");
    $(this.element).delay(3000).fadeOut("slow");
  }

  close() {
    this.element.style.display = "none";
  }
}

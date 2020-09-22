import { Controller } from "stimulus";

export default class extends Controller {
  
  close() {
    this.element.style.display = "none";
  }
  
  connect() {
    $(this.element).delay(3000).fadeOut("slow");
  }
}

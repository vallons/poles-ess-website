import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["dateField"];
  
  initialize() {
    console.log("initialize datepicker")
    $(this.dateFieldTarget).datepicker({
      format: 'dd/mm/yyyy', 
      language: 'fr', 
      autoclose: true
    });
  }


  connect() {

  }
}

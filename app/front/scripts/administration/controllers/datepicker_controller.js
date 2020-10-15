import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["dateField"];
  
  initialize() {
    $(this.dateFieldTarget).datepicker({
      format: 'dd/mm/yyyy', 
      language: 'fr', 
      autoclose: true
    });
  }


  connect() {

  }
}

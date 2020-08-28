import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["nameDisplayed"];
  
  displayFileName(e) {
    let filename = e.target.files[0].name;
    this.nameDisplayedTarget.innerHTML = `Fichier sélectionné : ${filename}`;
  }

  connect() {
    console.log("upload!");
    
  }

}

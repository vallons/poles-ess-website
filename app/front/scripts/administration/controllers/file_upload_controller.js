import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["nameDisplayed"];
  
  displayFileName(e) {
    console.log(this.nameDisplayedTarget);
    
    let filename = e.target.files[0].name;
    console.log(e.target.files[0].name);
    this.nameDisplayedTarget.innerHTML = `Fichier sélectionné : ${filename}`;
  }

  connect() {
    console.log("upload!");
    
  }

}

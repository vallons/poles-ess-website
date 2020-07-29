import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["sideMenu", "blockMenu"];

  toggleSideMenu() {
    this.sideMenuTarget.classList.toggle("side-menu_opened");
  }

  openBlockMenu(event) {
    event.target.classList.add("active");
    this.blockMenuTarget.classList.remove("hidden");
  }

  closeBlockMenu() {
    event.target.classList.remove("active");
    this.blockMenuTarget.classList.add("hidden");
  }

  connect() {
    console.log("Main menu connect");
  }
}

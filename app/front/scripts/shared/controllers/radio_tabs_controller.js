import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["content"];

  connect() {
    this.currentTab = this.element.querySelector("[data-action]:checked").dataset.tab
    this.showContent();
  }

  setCurrentTab(event) {
    this.currentTab = event.currentTarget.dataset.tab;
    this.showContent();
  }

  showContent() {
    for (let content of this.contentTargets) {
      content.dataset.tab == this.currentTab
        ? (content.style.display = "block")
        : (content.style.display = "none");
    }
  }

}

import { Controller } from "stimulus";

import { exists } from "@utils";

export default class extends Controller {
  static targets = ["links", "template", "copyField"];

  connect() {
    this.wrapperClass = this.data.get("wrapperClass") || "nested-fields";
    this.firstNestedField = document.querySelector("." + this.wrapperClass);
    let deleteLinkExists = exists(document.querySelector(".js-delete-link"))
    let allDeletable = this.data.get("allDeletable")
    if (deleteLinkExists && !allDeletable) {
      document.querySelector(".js-delete-link").style.display = "none";
    }
  }

  add_association(event) {
    event.preventDefault();

    var content = this.templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime()
    );
    this.linksTarget.insertAdjacentHTML("beforebegin", content);

    // Copy field values if exists
    if (this.hasCopyFieldTarget) {
      const sources = this.firstNestedField.querySelectorAll(
        "[data-target='nested-fields.copyField']"
      );
      for (let [index,field] of this.linksTarget.previousSibling
        .querySelectorAll("[data-target='nested-fields.copyField']")
        .entries()) {
        if (field.value === "") {
          field.value = sources[index].value;
        }
      }
    }

  }

  remove_association(event) {
    event.preventDefault();

    let wrapper = event.target.closest("." + this.wrapperClass);

    // New records are simply removed from the page
    if (wrapper.dataset.newRecord == "true") {
      wrapper.remove();

      // Existing records are hidden and flagged for deletion
    } else {
      wrapper.querySelector("input[name*='_destroy']").value = 1;
      wrapper.style.display = "none";
    }
  }

}

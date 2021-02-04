$(document).on("turbolinks:load", function () {
  $.expr.pseudos.external = function (obj) {
    return (
      !obj.href.match(/^mailto\:/) &&
      !obj.href.match(/^tel\:/) &&
      obj.hostname != location.hostname &&
      !obj.href.match(/^javascript\:/) &&
      !obj.href.match(/^$/)
    );
  };

  $("a:external").attr("target", "_blank");
});


function linkBoxes() {
  const boxes = document.querySelectorAll(".box-link");

  boxes.forEach(function (box) {
    const link = box.querySelector("a");
    if (link) {
      const url = link.getAttribute("href");
      box.addEventListener("click", function (e) {
        if (link !== e.target) {
          link.click();
        }
      });
      link.addEventListener("focus", function () {
        box.classList.add("active");
      });
      link.addEventListener("blur", function () {
        box.classList.remove("active");
      });
    }
  });
}

$(document).on("turbolinks:load", function () {
  if ("querySelector" in document) {
    linkBoxes();
  }
});
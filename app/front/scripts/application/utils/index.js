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

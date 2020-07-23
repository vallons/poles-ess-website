
require("@rails/ujs").start()
require("turbolinks").start()

// require("jquery");
// require("bootstrap");


// import FlashMessage from "@utils/flash-messages"

// STYLE =========================================================================
import "../styles/administration.scss"


// BOOTSTRAP JS =====================================================================
import "bootstrap"
import "bootstrap-datepicker"
import "bootstrap-datepicker/dist/locales/bootstrap-datepicker.fr.min.js"



// CONFIGURATION ===============================================================
Rails.start()

document.addEventListener("DOMContentLoaded", () => {
  console.log('yop')
  // $(".datepicker").datepicker({ format: 'dd/mm/yyyy', language: 'fr', autoclose: true })

  document.querySelectorAll('[data-trigger-submit]').forEach(el => {
    el.addEventListener('change', () => el.closest('form').submit())
  })


})
  
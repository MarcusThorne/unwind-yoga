require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "stylesheets/application"
import "@fortawesome/fontawesome-free/js/all";

import { nav } from "../components/nav"
import { backToTop } from "../components/backToTop"
import { flash } from "../components/flash"

document.addEventListener('turbolinks:load', () => {
  nav();
  backToTop();
  flash();
});

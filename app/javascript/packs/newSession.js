const weekly = document.querySelector("#weekly")
const until = document.querySelector("#until")

weekly.addEventListener("change", () => {
  if (weekly.checked) {
    until.classList.remove("hidden")
  } else {
    until.classList.add("hidden")
  }
})
const backToTop = () => {

  const button = document.querySelector("#back-to-top")

  button.addEventListener("click", () => {
    window.scrollTo(0, 0)
  })

  document.addEventListener("scroll", () => {
    if (window.scrollY > 400) {
      button.classList.remove("hidden")
    } else {
      button.classList.add("hidden")
    }
  })
}

export { backToTop };
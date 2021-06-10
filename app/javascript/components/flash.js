const flash = () => {

  let notice = document.querySelector("#notice")
  if (notice) {
    setTimeout(() => {
      notice.classList.add("hidden")
    }, 5000)
  }

  let alert = document.querySelector("#alert")
  if (alert) {
    setTimeout(() => {
      alert.classList.add("hidden")
    }, 5000)
  }


}

export { flash };
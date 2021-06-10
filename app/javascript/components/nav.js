const nav = () => {

  const openMenu = document.querySelector("#open-menu")
  const closeMenu = document.querySelector("#close-menu")
  const menu = document.querySelector("nav")

  const toggleMenu = () => {
    openMenu.classList.toggle("hidden")
    closeMenu.classList.toggle("hidden")
    menu.classList.toggle("hidden")
    menu.classList.toggle("flex")
  }

  openMenu.addEventListener("click", toggleMenu)
  closeMenu.addEventListener("click", toggleMenu)

  const profileIcon = document.querySelector("#profile-icon")
  const profileDropdown = document.querySelector("#profile-dropdown")

  const showProfileDropdown = (event) => {
    event.stopPropagation()
    profileDropdown.classList.remove("lg:hidden")
    profileIcon.classList.add("text-teal")
    document.addEventListener("click", hideProfileDropdown)
  }

  const hideProfileDropdown = () => {
    profileDropdown.classList.add("lg:hidden")
    profileIcon.classList.remove("text-teal")
    document.removeEventListener("click")
  }

  if (profileIcon) {
    profileIcon.addEventListener("click", showProfileDropdown)
  }

}

export { nav }
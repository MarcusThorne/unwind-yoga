const changePassword = document.querySelector("#change_password")
const changePasswordField = document.querySelector("#change-password-field")
const newPassword = document.querySelector("#user_password")
const newPasswordConfirm = document.querySelector("#user_password_confirmation")

changePassword.addEventListener("change", () => {
  if (changePassword.checked) {
    changePasswordField.classList.remove("hidden")
  }
  else {
    changePasswordField.classList.add("hidden")
    newPassword.value = ""
    newPasswordConfirm.value = ""
  }
})
// Elements
const form = document.querySelector("form");
const paymentIntent = document.querySelector("#booking_payment_intent")
const presence = document.querySelector("#booking_presence");
const attendees = document.querySelector("#booking_attendees");
const paymentMethod = document.querySelector("#booking_payment_method");
const stripeElement = document.querySelector("#stripe-element");
const stripeErrors = document.querySelector("#stripe-errors");
const pay = document.querySelector("#pay");
const submit = document.querySelector("#submit-button")

// Stripe bits
const stripe = Stripe("pk_test_51HdlOnLkJDKu0sqLMY0P8cQJxTxS0EPvhMNdtzBMWitaKDqeu8pGpbl6qQ21bZnTfdcRYTRopb6JsD6S90RqSmke00TS9dNjn6");
const elements = stripe.elements();
const card = elements.create("card");
const csrfToken = document.querySelector("[name='csrf-token']").content;

// Stripe up!
const stripeUp = () => {
  // Hide the submit button
  submit.classList.add("hidden")
  // Mount Stripe
  card.mount(stripeElement);
  stripeElement.parentElement.classList.remove("hidden")
  // Show the save button
  pay.classList.remove("hidden")

  // Watch the card for element for errors
  card.on("change", (event) => {
    stripeErrors.textContent = event.error ? event.error.message : "";
  });
}
// Let's do this when the page loads
stripeUp()

// Stripe pay!
const stripePay = (stripe, card, clientSecret) => {
  stripe
    .confirmCardPayment(clientSecret, {
      payment_method: {
        card: card
      }
    })
    .then((result) => {
      if (result.error) {
        // This needs changing
        stripeError(result.error.message);
        // Show the pay button
        pay.classList.remove("hidden")
      } else {
        form.submit()
      }
    });
};

// Show Stripe errors
const stripeError = (errorMsgText) => {
  stripeErrors.textContent = errorMsgText;
  setTimeout(() => {
    errorMsg.textContent = "";
  }, 4000);
};

// Stripe down
const stripeDown = () => {
  // Hide the pay button
  pay.classList.add("hidden")
  // Unmount Stripe
  stripeElement.parentElement.classList.add("hidden")
  card.unmount()
  // Show the submit button
  submit.classList.remove("hidden")
}

const checkPresence = () => {
  // If they're joining via Zoom
  if (presence.value == "online") {
    // Hide the attendees field
    attendees.parentElement.classList.add("hidden")
    // Hide the payment method dropdown
    paymentMethod.parentElement.classList.add("hidden")
    // Set the payment method to online
    paymentMethod.value = "online"
    // Stripe up!
    stripeUp()
  }
  // Otherwise
  else {
    // Show the attendees field
    attendees.parentElement.classList.remove("hidden")
    // Show the payment method dropdown
    paymentMethod.parentElement.classList.remove("hidden")
  }
}
checkPresence()
presence.addEventListener("change", checkPresence)

const checkPaymentMethod = () => {
  // If they're paying online
  if (paymentMethod.value == "online") {
    // Stripe up!
    stripeUp()
  }
  // Otherwise
  else {
    // Stripe down
    stripeDown()
  }
}
checkPaymentMethod()
paymentMethod.addEventListener("change", checkPaymentMethod)

// If the pay button is clicked
pay.addEventListener("click", () => {

  // Hide the pay button
  pay.classList.add("hidden")

  var data = {
    "presence": presence.value,
    "attendees": presence == "online" ? attendees.value : 1
  }

  // Create a payment intent
  response = fetch("/create-payment-intent", {

    method: "POST",

    headers: {
      "X-CSRF-Token": csrfToken,
      "Content-Type": "application/json"
    },

    body: JSON.stringify(data)

  })
    .then((result) => {
      return result.json();
    }).
    then((data) => {
      console.log(data)
      paymentIntent.value = data.id
      stripePay(stripe, card, data.client_secret);
    })

})
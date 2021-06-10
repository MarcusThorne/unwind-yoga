var slideIndex = 0;

const carousel = () => {
  var i;
  var slides = document.getElementsByClassName("slide");
  for (i = 0; i < slides.length; i++) {
    slides[i].classList.add("hidden");
  }
  slideIndex++;
  if (slideIndex > slides.length) { slideIndex = 1 }
  slides[slideIndex - 1].classList.remove("hidden");
  setTimeout(carousel, 5000);
}

carousel()
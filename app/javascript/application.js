const navbar = () => {
  document.addEventListener("DOMContentLoaded", () => {
    const menuToggle = document.getElementById("menu-toggle");
    const mobileMenu = document.getElementById("mobile-menu");

    menuToggle.addEventListener("click", () => {
      mobileMenu.classList.toggle("hidden");
    });
  });
};
const slider = () => {
  document.addEventListener("DOMContentLoaded", () => {
    const slides = document.querySelectorAll(".carousel-slide");
    const indicators = document.querySelectorAll(".indicator");
    let currentSlide = 0;

    const updateSlide = (index) => {
      slides.forEach((slide, i) => {
        slide.style.transform = `translateX(${(i - index) * 100}%)`;
      });
      indicators.forEach((indicator, i) => {
        indicator.classList.toggle("opacity-100", i === index);
        indicator.classList.toggle("opacity-50", i !== index);
      });
    };

    const nextSlide = () => {
      currentSlide = (currentSlide + 1) % slides.length;
      updateSlide(currentSlide);
    };

    const prevSlide = () => {
      currentSlide = (currentSlide - 1 + slides.length) % slides.length;
      updateSlide(currentSlide);
    };

    document.getElementById("next").addEventListener("click", nextSlide);
    document.getElementById("prev").addEventListener("click", prevSlide);
    indicators.forEach((indicator) => {
      indicator.addEventListener("click", () => {
        currentSlide = parseInt(indicator.getAttribute("data-slide"));
        updateSlide(currentSlide);
      });
    });

    setInterval(nextSlide, 3000);
  });
};
const copyLink = () => {
  document.addEventListener("DOMContentLoaded", function () {
    var copyBtn = document.getElementById("copyBtn");
    var referralLink = document.getElementById("referLink");
    if (copyBtn && referralLink) {
      copyBtn.addEventListener("click", function () {
        var tempInput = document.createElement("input");
        tempInput.value = referralLink.text;
        document.body.appendChild(tempInput);
        tempInput.select();
        document.execCommand("copy");
        copyBtn.textContent = "Link Copied!";
        document.body.removeChild(tempInput);
      });
    }
  });
};
const loadingCaptcha = () => {
  document.addEventListener("DOMContentLoaded", function () {
    var recaptchaContainer = document.getElementById("recaptcha-container");
    var recaptchaLoading = document.getElementById("recaptcha-loading");
    var checkRecaptcha = setInterval(function () {
      if (recaptchaContainer.querySelector(".g-recaptcha")) {
        clearInterval(checkRecaptcha);
        recaptchaLoading.style.display = "none";
        recaptchaContainer.style.display = "flex";
      }
    }, 500);
  });
};

navbar();
slider();
copyLink();
loadingCaptcha();

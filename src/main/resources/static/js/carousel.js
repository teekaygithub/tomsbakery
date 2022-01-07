let slideIndex = 0;
showSlides();

function showSlides() {
    var i;
    var slides = document.getElementsByClassName("carousel-slide");
    for (i=0; i<slides.length; i++) {
        slides[i].style.display="none";
    }
    slideIndex = (slideIndex+1)%slides.length;
    slides[slideIndex].style.display="block";
    setTimeout(showSlides, 5000);
}
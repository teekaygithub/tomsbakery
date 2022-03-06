$(document).ready(() => {
    let imgCount = $(".carousel-slide-img").length;
    console.log("carousel img count: " + imgCount.toString());
    console.log("Screen width: " + window.outerWidth);
    showSlides(imgCount);
});

function showSlides(imgCount) {

    imgWidth = parseInt($(".carousel-slide-img").width());
    console.log("img width: " + imgWidth);

    $(".next").on("click", () => {
        let offset = parseInt($("#carousel-slides").css("transform").split(',')[4]);
        let newOffset = (offset - imgWidth) <= -1 * imgWidth * imgCount ? offset : offset - imgWidth;
        let translate = "translateX(" + newOffset.toString() + "px)";
        
        $("#carousel-slides").css("transform", translate);
    });

    $(".prev").on("click", () => {
        let offset = parseInt($("#carousel-slides").css("transform").split(',')[4]);
        let newOffset = (offset + imgWidth) > 0 ? offset : offset + imgWidth;
        let translate = "translateX(" + newOffset.toString() + "px)";

        $("#carousel-slides").css("transform", translate);
    });
}
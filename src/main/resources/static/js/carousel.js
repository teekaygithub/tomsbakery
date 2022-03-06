$(document).ready(() => {
    let imgCount = $(".carousel-slide-img").length;
    console.log("carousel img count: " + imgCount.toString());
    showSlides(imgCount);
});

function showSlides(imgCount) {

    const imgWidth = 700;

    $(".next").on("click", () => {
        let offset = parseInt($("#carousel-slides").css("transform").split(',')[4]);
        let newOffset = (offset - 700) <= -1 * imgWidth * imgCount ? offset : offset - 700;
        let translate = "translateX(" + newOffset.toString() + "px)";
        
        $("#carousel-slides").css("transform", translate);
    });

    $(".prev").on("click", () => {
        let offset = parseInt($("#carousel-slides").css("transform").split(',')[4]);
        let newOffset = (offset + 700) > 0 ? offset : offset + 700;
        let translate = "translateX(" + newOffset.toString() + "px)";

        $("#carousel-slides").css("transform", translate);
    });
}
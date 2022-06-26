$(document).ready(() => {
    let imgCount = $(".carousel-slide-img").length;
    let imgWidth = parseInt($(".carousel-slide-img").width());
    let imgOffsets = [];
    for (let i = 0; i < imgCount; i++) {
        imgOffsets.push(-imgWidth * i);
    }

    showSlides(imgOffsets);
});

function showSlides(imgOffsets) {

    let offset = 0;

    $(".next").on("click", () => {
        offset = (offset + 1 >= imgOffsets.length) ? 0 : offset + 1;
        let translate = "translateX(" + imgOffsets[offset].toString() + "px)";
        
        $("#carousel-slides").css("transform", translate);
    });

    $(".prev").on("click", () => {
        offset = (offset - 1 < 0) ? imgOffsets.length-1 : offset - 1;
        let translate = "translateX(" + imgOffsets[offset].toString() + "px)";

        $("#carousel-slides").css("transform", translate);
    });
}
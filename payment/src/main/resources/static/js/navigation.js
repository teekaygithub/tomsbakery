$(document).ready(() => {
    $("#nav-collapsible").on("click", () => {
        let collapsible =  $('#nav-menu-small');
        collapsible.slideToggle(500);
    });
})
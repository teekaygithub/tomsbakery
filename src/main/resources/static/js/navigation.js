$(document).ready(() => {
    $("#nav-collapsible").on("click", () => {
        let collapsible =  $('#nav-menu-small');
        let status = collapsible.css("display");
        if (status === "none") {
            collapsible.css("display", "block");
        } else if (status === "block") {
            collapsible.css("display", "none");
        }
    });
})
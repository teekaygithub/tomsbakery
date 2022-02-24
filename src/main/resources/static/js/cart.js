$(document).ready(function() {
    var cart = localStorage.getItem('cart');
    if (cart) {
        var temp = JSON.parse(cart);
        $(".cart-count").text(temp.totalQuantity);
    }
});

$(".cart-button").on("click", function() {
    console.log('Add to cart button pressed');
    var cart = localStorage.getItem('cart');

    if (cart) {
        var temp = JSON.parse(cart);
        console.log('Existing cart, quantity: ' + temp.totalQuantity);
        temp.totalQuantity+=1;
        localStorage.setItem('cart', JSON.stringify(temp));
        $(".cart-count").text(temp.totalQuantity);
    } else {
        cart = {
            totalQuantity: 1
        };
        localStorage.setItem('cart', JSON.stringify(cart));
        $(".cart-count").text("1");
    }
});
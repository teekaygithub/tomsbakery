$(document).ready(function () {
    // Initialize the cart count icon with current count, if any
    var cart = localStorage.getItem('cart');
    if (cart) {
        var temp = JSON.parse(cart);
        $(".cart-count").text(temp.totalQuantity);
        $("#cart-empty").remove();

        // Populate the shopping cart page (/cart)
        let cartItemsList = JSON.parse(localStorage.getItem('cart-items'));
        cartItemsList.forEach((item) => {
            let image = "<div class=\"cart-item-image\"><img src=\"" + item.imageUrl + "\" ></div>";
            let name = "<div class=\"cart-item-name\"><p>" + item.name + "</p></div>";
            let buttons = "<div class=\"cart-item-buttons\"><input type=\"number\" min=\"1\" max=\"6\"><button>Update</button><button>Remove</button></div>"
            let price = "<div class=\"cart-item-price-qty\"><p>" + item.price + "</p><p>" + item.quantity + " x " + item.price + "</p></div>";
            let prod = "<div class=\"cart-item\" id=\"cart-item-" + item.ID + "\">" + image + name + buttons +  price + "</div>";
            $("#cart-hasitem").append(prod);
        });
    } else {
        console.log("Cart is empty");
        $("#cart-hasitem").remove();
    }
});

// Add a menu item to cart
$(".cart-button").on("click", function () {

    // Cart details
    var cart = localStorage.getItem('cart');

    if (cart) {
        var temp = JSON.parse(cart);
        console.log('Existing cart, quantity: ' + temp.totalQuantity);
        temp.totalQuantity += 1;
        localStorage.setItem('cart', JSON.stringify(temp));
        $(".cart-count").text(temp.totalQuantity);
    } else {
        cart = {
            totalQuantity: 1
        };
        localStorage.setItem('cart', JSON.stringify(cart));
        $(".cart-count").text("1");
    }

    // Cart items

    // First get the details of the product being added
    var temp = $(this).attr("id").split('-');
    var id = temp[temp.length - 1];

    var product = {
        ID: id,
        name: $("#item-name-" + id).text(),
        price: $("#item-price-" + id).text(),
        imageUrl: $("#item-image-" + id).attr("src"),
        quantity: "1"
    };

    // Second add the item to the array of existing cart items
    var cartItems = JSON.parse(localStorage.getItem('cart-items') || "[]");
    var existing = cartItems.find(function(item) {
        return item.name === product.name;
    });

    if (existing) {
        cartItems.forEach(function(item) {
            if (item.name === product.name) {
                let qty = parseInt(item.quantity) + 1;
                item.quantity = qty.toString();
            }
        })
    } else {
        cartItems.push(product);
    }
    
    localStorage.setItem('cart-items', JSON.stringify(cartItems));
});

function isEmpty() {
    return parseInt($(".cart-count").text()) > 0;
}
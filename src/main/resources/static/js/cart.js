$(document).ready(function () {
    // Initialize the cart count icon with current count, if any
    var cart = JSON.parse(localStorage.getItem('cart'));
    if (cart && cart.totalQuantity > 0) {
        $(".cart-count").text(cart.totalQuantity);
        $("#cart-empty").hide();

        // Populate the shopping cart page (/cart) and compute the subtotal
        let cartItemsList = JSON.parse(localStorage.getItem('cart-items'));
        let subtotal = 0;
        cartItemsList.forEach((item) => {
            let image = "<div class=\"cart-item-image\"><img src=\"" + item.imageUrl + "\" ></div>";
            let name = "<div class=\"cart-item-name\"><p>" + item.name + "</p></div>";
            let buttons = "<div class=\"cart-item-buttons\"><input type=\"number\" min=\"1\" max=\"6\" placeholder=\"1\"><button>Update</button><button class=\"cart-item-remove\">Remove</button></div>"
            let price = "<div class=\"cart-item-price-qty\"><p>$" + item.unitPrice + "</p><p>" + item.quantity + " x $" + item.unitPrice + "</p></div>";
            let prod = "<div class=\"cart-item\" id=\"cart-item-" + item.productId + "\">" + image + name + buttons + price + "</div>";
            $("#cart-hasitem").append(prod);
            subtotal += parseInt(item.quantity) * parseFloat(item.unitPrice);
        });

        console.log("Subtotal:" + subtotal);
        totalsAndCheckoutButton(subtotal.toFixed(2));
    } else {
        console.log("Cart is empty");
        $("#cart-hasitem").hide();
    }

    // ============================
    // Register event handlers
    // ============================
    addToCart();
    removeFromCart();
    
}); // end document ready

// Expected to be called from the menu page and the item-detail page
function addToCart() {
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

        // Object keys must be identical to the 'OrderItem' entity
        var product = {
            productId: id,
            name: $("#item-name-" + id).text(),
            unitPrice: $("#item-price-" + id).text().substring(1),
            imageUrl: $("#item-image-" + id).attr("src"),
            quantity: "1"
        };

        // Second add the item to the array of existing cart items
        var cartItems = JSON.parse(localStorage.getItem('cart-items') || "[]");
        var existing = cartItems.find(function (item) {
            return item.name === product.name;
        });

        if (existing) {
            cartItems.forEach(function (item) {
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
}

// Expected to be called from the shopping-cart details page
function removeFromCart() {
    $(".cart-item-remove").on("click", function () {
        console.log('Remove button clicked');

        if (confirm("Are you sure you want to remove this item?") == false) {
            return;
        }

        // Remove the element in shopping cart DOM
        let deletedItem = $(this).parent().parent();
        let deletedId = deletedItem.attr("id").split("-").slice(-1)[0];
        deletedItem.remove();
        console.log(deletedId);

        // Remove the item in localStorage
        // Update new cart item count
        let cartItemsList = JSON.parse(localStorage.getItem('cart-items'));
        let modifiedList = cartItemsList.filter(function (item) {
            return item.productId != deletedId;
        });
        console.log(modifiedList);
        localStorage.setItem('cart-items', JSON.stringify(modifiedList));

        let modifiedCart = {
            totalQuantity: modifiedList.length
        };


        if (modifiedList.length === 0) {
            // console.log('cart is empty again');
            localStorage.removeItem('cart');
            localStorage.removeItem('cart-items');
            $('#cart-empty').show();
            $('#cart-hasitem').hide();
            $(".cart-count").text(0);
        } else {
            localStorage.setItem('cart', JSON.stringify(modifiedCart));
            $(".cart-count").text(modifiedCart.totalQuantity);
            let newSubtotal = computeSubtotal(modifiedList);
            $("#subtotal").text("Your total: $" + newSubtotal.toString());
        }
    });
}

// Adds the subtotal and checkout button for the /cart page
function totalsAndCheckoutButton(subtotal) {
    let totals = "<div id=\"subtotal\">Your total: $" + subtotal.toString() + "</div>"
    let checkoutBtn = "<div><a href=\"/checkout\"><button id='checkout-button'>Checkout</button></a></div>"
    let component = "<div class=\"cart-checkout-container\">" + totals + checkoutBtn + "</div>";
    $("#cart-hasitem").append(component);
}

function computeSubtotal(itemList) {
    let subtotal = 0;
    itemList.forEach((item) => {
        subtotal += parseInt(item.quantity) * parseFloat(item.unitPrice);
    });

    return subtotal.toFixed(2);
}

function clearCart() {
    localStorage.removeItem('cart');
    localStorage.removeItem('cart-items');
    $(".cart-count").text(0);
}
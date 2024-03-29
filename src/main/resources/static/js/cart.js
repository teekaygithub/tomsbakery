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

            // PRODUCT IMAGE
            const imageContainer = document.createElement("div")
            imageContainer.className = "cart-item-image"
            const image = document.createElement("img")
            image.src = item.imageUrl
            imageContainer.appendChild(image)

            // PRODUCT NAME
            const nameContainer = document.createElement("div")
            nameContainer.className = "cart-item-name"
            const para = document.createElement("p")
            const name = document.createTextNode(item.name)
            para.appendChild(name)
            nameContainer.appendChild(para)

            // PRODUCT BUTTONS
            const buttonPriceContainer = document.createElement("div")
            buttonPriceContainer.className = "cart-button-price-container"

            const buttonContainer = document.createElement("div")
            buttonContainer.className = "cart-item-buttons"

            const quantitySelect = document.createElement("select")
            quantitySelect.className = "cart-item-quantity"
            quantitySelect.id=`cart-item-quantity-${item.productId}`

            const removeButton = document.createElement("button")
            removeButton.className = "cart-item-remove"
            removeButton.appendChild(document.createTextNode("Remove"))

            buttonContainer.appendChild(quantitySelect)
            buttonContainer.appendChild(removeButton)

            // PRODUCT PRICE
            const priceContainer = document.createElement("div")
            priceContainer.className = "cart-item-price-qty"

            const paraUnitPrice = document.createElement("p")
            paraUnitPrice.id = "cart-item-price"
            paraUnitPrice.appendChild(document.createTextNode(`$${item.unitPrice}`))

            const paraTotalPrice = document.createElement("p")
            paraTotalPrice.id = `current-quantity-${item.productId}`
            paraTotalPrice.appendChild(document.createTextNode(`${item.quantity} x $${item.unitPrice}`))

            priceContainer.appendChild(paraUnitPrice)
            priceContainer.appendChild(paraTotalPrice)
            buttonPriceContainer.appendChild(buttonContainer)
            buttonPriceContainer.appendChild(priceContainer)

            // Now put everything together
            const prod = document.createElement("div")
            prod.className = "cart-item"
            prod.id = `cart-item-${item.productId}`

            prod.appendChild(imageContainer)
            prod.appendChild(nameContainer)
            prod.appendChild(buttonPriceContainer)

            $("#cart-hasitem").append(prod);
            subtotal += parseInt(item.quantity) * parseFloat(item.unitPrice);
        });

        // Populate the quantity drop-down
        for (let qty = 1; qty <= 6; qty++) {
            $(".cart-item-quantity").append("<option value=" + qty + ">" + qty + "</option>")
        }

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
    updateCartQuantity();
    
}); // end document ready

// Expected to be called from the menu page and the item-detail page
function addToCart() {
    $(".cart-button").on("click", function () {

        // Cart details
        var cart = localStorage.getItem('cart');
        let delta = $("#item-quantity option:selected").val();
        if (typeof delta === 'undefined') {
            delta = parseInt(1);
        } else {
            delta = parseInt(delta);
        }

        if (cart) {
            var temp = JSON.parse(cart);
            console.log('Existing cart, quantity: ' + temp.totalQuantity);
            temp.totalQuantity += delta;
            localStorage.setItem('cart', JSON.stringify(temp));
            $(".cart-count").text(temp.totalQuantity);
        } else {
            cart = {
                totalQuantity: delta
            };
            localStorage.setItem('cart', JSON.stringify(cart));
            $(".cart-count").text(delta.toString());
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
            quantity: delta
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
        let deletedItem = $(this).parent().parent().parent();
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
            totalQuantity: computeCartQuantity(modifiedList)
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

function updateCartQuantity() {
    $(".cart-item-quantity").on("change", function() {
        console.log($(this).val());
        let updatedItem = $(this);
        let updatedId = updatedItem.attr("id").split("-").slice(-1)[0];
        let updatedQty = parseInt($(this).val());

        // Update cart item quantity in local storage
        let cartItemsList = JSON.parse(localStorage.getItem('cart-items'));
        let prevQty = null;
        cartItemsList.forEach(x => {
            if (x.productId == updatedId) {
                prevQty = x.quantity;
                x.quantity = updatedQty;
            }
        });
        localStorage.setItem('cart-items', JSON.stringify(cartItemsList));

        // Update total quantity in 'cart' object in local storage
        let cart = JSON.parse(localStorage.getItem("cart"));
        if (prevQty > 0) {
            if (prevQty < updatedQty) { // Added item
                cart.totalQuantity += (updatedQty - prevQty);
            } else { // Removed item
                cart.totalQuantity -= (prevQty - updatedQty);
            }
            localStorage.setItem("cart", JSON.stringify(cart));
        }

        // Update the displayed item count in cart page
        let cur = $("#current-quantity-" + updatedId);
        cur.text(updatedQty + " x " + $("#cart-item-price").text());

        // Update the cart logo in navigation bar
        $(".cart-count").text(cart.totalQuantity);

        // Recompute cart totals
        let newSubtotal = computeSubtotal(cartItemsList);
        $("#subtotal").text("Your total: $" + newSubtotal.toString());
    })
}

// Adds the subtotal and checkout button for the /cart page
function totalsAndCheckoutButton(subtotal) {
    let totals = "<div id=\"subtotal\">Your total: $" + subtotal.toString() + "</div>"
    let checkoutBtn = "<div><a href=\"/checkout\"><button id='checkout-button'>Checkout</button></a></div>"
    let component = "<div class=\"cart-checkout-container\">" + totals + checkoutBtn + "</div>";
    $("#cart-hasitem").append(component);
}

function computeCartQuantity(itemList) {
    let totalQty = 0;
    itemList.forEach((item) => {
        totalQty += item.quantity
    })
    
    return totalQty;
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
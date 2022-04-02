$(document).ready(function () {

    window.stripe = Stripe("pk_test_51KEexnHEUlhmshphjn2do85kicKKNDgac3REa3N19rSv1H5A7zpRIJTYohbJtUYBTUtRhWWorEKXag4jXrZNURND00VG6I1IzW");

    let elements = stripe.elements();

    window.cardElement = elements.create('card');

    cardElement.mount("#card-element");

    // Populate the subtotals

    const itemList = JSON.parse(localStorage.getItem('cart-items'));
    const subTotal = computeSubtotal(itemList);
    $('#subtotal-amount').text("Subtotal: $" + subTotal.toString());

    // FORM SUBMISSION
    $('#checkoutForm').submit((event) => {
        event.preventDefault();
        console.log("Submitting form...");

        // Disable checkout button and indicate loading with spinner
        $('#checkout-button').prop('disabled', true);        
        $('#checkout-button').append('<i class="fas fa-spinner fa-spin"></i>')

        // Corresponds with 'CheckoutData' DTO

        let subTotalAmount = parseInt(computeSubtotal(JSON.parse(localStorage.getItem('cart-items')))*100);
        const purchase = {
            name: $("#customer-name").val(),
            email: $("#customer-email").val(),
            phoneNumber: $("#customer-phone").val(),
            subTotal: subTotalAmount.toString(),
            orderItems: itemList
        }

        console.log('Purchase object: ' + purchase);

        fetch("/api/payment-intent", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(purchase)
        })
        .then(response => response.json())
        .then(data => {
            // Confirm payment
            console.log('Data: ');
            console.log(data);
            const clientSecret = data.clientSecret;
            
            stripe.confirmCardPayment(clientSecret, {
                payment_method: {
                    card: cardElement
                }
            }).then(result => {
                if (result.error) {
                    // TODO: Implement alerts for payment confirmation failure
                    console.log("Confirm payment error: " + result.error.message);
                    $("#checkout-button").prop('disabled',false);
                    $(".fa-spinner").remove();
                } else {
                    console.log("Payment confirmation successful.");
                    console.log(result.paymentIntent.id);

                    clearCart();

                    // TODO: Save the order details (minus payment card details) to our DB
                    fetch("/orderComplete", {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(purchase),
                    })
                    .then(res => {
                        console.log(res);
                        window.location.href = window.location.origin  + "/success";
                    })
                    .catch(err => {
                        console.log(err)
                    });
                }
            });
        }); // end fetch /api/payment-intent
    }); // end form-submission event-handler
}); // end document ready
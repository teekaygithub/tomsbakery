$(document).ready(function () {

    window.stripe = Stripe("pk_test_51KEexnHEUlhmshphjn2do85kicKKNDgac3REa3N19rSv1H5A7zpRIJTYohbJtUYBTUtRhWWorEKXag4jXrZNURND00VG6I1IzW");

    let elements = stripe.elements();

    window.cardElement = elements.create('card');

    cardElement.mount("#card-element");

    // FORM SUBMISSION
    $('#checkoutForm').submit((event) => {
        // TODO: delete once server is ready to accept form submission
        event.preventDefault();
        console.log("Submitting form...");

        // TODO: Disable submit button until server can process submission

        // TODO: Display spinner icon

        // TODO: Integrate stripe card-element as described here: https://stripe.com/docs/payments/card-element

        // Corresponds with 'CheckoutData' DTO
        const purchase = {
            name: $("#customer-name").val(),
            email: $("#customer-email").val(),
            phoneNumber: $("#customer-phone").val()
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
                } else {
                    console.log("Payment confirmation successful.");
                    console.log(result.paymentIntent.id);

                    // TODO: Save the order details (minus payment card details) to our DB

                    // TODO:Clear the cart and redirect to a confirmation page
                }
            });
        }); // end fetch /api/payment-intent
    }); // end form-submission event-handler
}); // end document ready
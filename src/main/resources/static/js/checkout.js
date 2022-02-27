$(document).ready(function () {

    // FORM SUBMISSION
    $('#checkoutForm').submit((event) => {
        // TODO: delete once server is ready to accept form submission
        event.preventDefault();
        console.log("Submitting form...");

        // Disable submit button until server can process submission

        // Display spinner icon

        // Integrate stripe card-element as described here: https://stripe.com/docs/payments/card-element
    });

    initStripeElement();
});

function initStripeElement() {
    const stripe = Stripe("pk_test_51KEexnHEUlhmshphjn2do85kicKKNDgac3REa3N19rSv1H5A7zpRIJTYohbJtUYBTUtRhWWorEKXag4jXrZNURND00VG6I1IzW");

    let elements = stripe.elements();

    let cardElement = elements.create('card');

    cardElement.mount("#card-element");
}
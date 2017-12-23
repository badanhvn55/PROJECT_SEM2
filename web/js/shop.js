// function onSignIn(googleUser) {
//     var profile = googleUser.getBasicProfile();
//     console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
//     console.log('Name: ' + profile.getName());
//     console.log('Image URL: ' + profile.getImageUrl());
//     console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
// }
// function signOut() {
//     var auth2 = gapi.auth2.getAuthInstance();
//     auth2.signOut().then(function () {
//         console.log('User signed out.');
//     });
//
// }

function addProductToCart(bookId) {
    $.ajax({
        url: "/shoppingCart?command=plus&productId=" + bookId,
        type: "GET",
        success: function (resp) {
            alert("Đã thêm vào giỏ hàng.");
        },
        error: function (resp) {
            console.log(resp);
        }
    });
    location.reload();
}

function removeProductToCart(bookId) {
    $.ajax({
        url: "/shoppingCart?command=remove&productId=" + bookId,
        type: "GET",
        success: function (resp) {
            console.log(resp);
        },
        error: function (resp) {
            console.log(resp);
        }
    });
    location.reload();
}
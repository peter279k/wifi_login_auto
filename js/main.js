function setting() {
        console.log("setting...");
}

function reset() {
    console.log("reset");
}

function autoLogin(email,password) {
        if(email==="") {
            console.log("email empty!")
        }
        else if(password==="") {
            console.log("password empty!")
        }
        else {
            //do httprequest post data to the login url.
        }
}

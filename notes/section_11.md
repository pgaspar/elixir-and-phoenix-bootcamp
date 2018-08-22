# Github OAuth flow

Request phase:

* User clicks "Login with Github" (`/auth/github`)
* User gets redirected to Github and asked to authorize

Callback phase:

* Github sends user back to http://localhost:4000/auth/signin?provider=github&code=12345
* We use the code to fetch user details from Github
* Create a new user and save to database
* User logged in

We're going to use a helper library: [Ueberauth](https://github.com/ueberauth/ueberauth)

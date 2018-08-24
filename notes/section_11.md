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

# Querying the Repo

`find_by` equivalent (returns `nil`):

```elixir
Repo.get_by(Post, title: "My Post")
```

# Authentication flow

* User Oauths with Github
* We insert record into DB
* Database record gets an ID
* Put ID on user's cookie (that is what "signing in" means)

In Phoenix we interact with cookies through Sessions.

```elixir
conn
|> put_session(:user_id, user.id)
```

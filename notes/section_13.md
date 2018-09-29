# Adding comments

HTTP approach:

* User fills out form
* Click Submit
* Browser issues HTTP request
* Server catches request
* Server creates comment
* Server redirects to list of comments

Websocket approach:

* User fills out form
* Click Submit
* Websocket emits event
* Server catches event
* Server creates comment
* Server emits event with new list of comments

# Websockets

Websockets have implementation on both the server and client sides. We'll write some code on the server and some Javascript code on the client.

The server side code is inside `web/channels/`.

The client side code is in `web/static/js/socket.js`.

# Channels

Our channel objects are vaguely similar to our controllers - they kinda handle a resource.

When a user joins a channel there are 2 main functions to be aware of:

* `join` - called when a user joins a channel.
* `handle_in` - receives event from the user's browser.

In our app we'll have 1 channel for comments: `comments:id`.

You can think of the `user_socket.ex` file more like our router file and each channel as a controller.

```elixir
# In user_socket.ex
channel "comments:*", Discuss.CommentsChannel
```

This acts a bit like a router declaration - we forward every message named `comment:*` to the comments channel.

[Reference here](https://hexdocs.pm/phoenix/1.2.5/Phoenix.Channel.html#callbacks).

The `socket` object is like our `conn` object on our controllers.

# Pattern matching on string

```elixir
# Get number from "comments:5"
"comments:" <> topic_id
```

# Poison encoder

The typical error:

```
(Poison.EncodeError) unable to encode value: {nil, "comments"}
```

This means we need to serialize the comments struct to JSON. Poison is the library that encodes something to JSON and it fails to encode some of the fields from our struct. To make it work:

```elixir
defmodule Comment do
  # ...
  @derive {Poison.Encoder, only: [:content]}
  # ...
end
```

# Broadcasting socket updates

In the Channel's `handle_in` function, call:

```elixir
broadcast!(socket, "comments:#{socket.assigns.topic.id}:new",
  %{comment: comment}
)
```

You need to add an event listener on the JS side, when setting up:

```javascript
const createSocket = (topicId) => {
  // ...
  channel.on(`comments:${topicId}:new`, renderComment);
}

function renderComment(event) {
  const renderedComment = commentTemplate(event.comment);
  document.querySelector('.collection').innerHTML += renderedComment;
}
```

# Authentication in Sockets

**Server:**

* Generates a unique token and adds it to the layout

**Browser:**

* Gets the layout HTML
* Javascript initializes the socket, sending the unique token: `new Socket('/socket', {params: {token: window.userToken}});`

**Server:**

* Server verifies token and adds the user to the socket's assigns

# Authentication Token

Create the token on the layout's head, for example:

```html
<script>
  <%= if @conn.assigns.user do %>
    window.userToken = '<%= Phoenix.Token.sign(Discuss.Endpoint, "key", @conn.assigns.user.id) %>';
  <% end %>
</script>
```

`socket.js` will have this by default:

```javascript
let socket = new Socket("/socket", {params: {token: window.userToken}})
```

See boilerplate comments on `socket.js` for more detail.

On `user_socket.ex`:

```elixir
def connect(%{"token" => token}, socket) do
  case Phoenix.Token.verify(socket, "key", token) do
    {:ok, user_id} ->
      {:ok, assign(socket, :user_id, user_id)}
    {:error, _reason} ->
      :error
  end
end
```

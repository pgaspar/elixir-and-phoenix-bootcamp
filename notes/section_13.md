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

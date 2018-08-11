# Identicon

Utility that, given a string, generates an image similar to Github's default avatars. The same string always generates the same image.

## Format

Identicons consist of a 5x5 square grid. Each square is 50px tall and wide, making the whole image 250px by 250px.

The images are vertically symmetrical.

## Process

* Start with a string
* Compute its MD5 hash
* Get a list of numbers from the hash
* Pick a color
* Build the grid of squares
* Convert grid into image
* Save image

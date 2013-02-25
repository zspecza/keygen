[![Build Status](https://travis-ci.org/declandewet/keygen.png?branch=master)](https://travis-ci.org/declandewet/keygen)

# Description

A rather handy customizable random key sequence generator. It supports complex keys and can even simulate a key to the best of it's ability!

# Usage

Usage is simple. First, include the `keygen.js` file in your project. It can be found in the root directory of this repository. For Node.js users, this is not an NPM module just yet, but worry not, I've added the necessary parts to `exports`.

## Generating a key

```js
var key = new KeyGen();
key.generate();
```
This will generate a random alphanumeric key that is mixedcase with 5 sequences and each sequence will be 7 characters long.

It's as simple as that!

### Passing options into KeyGen()

`KeyGen()` supports a number of options. These options come in the form of an object. It's done like so:

```js
var options = {
  type: 'alphabetic',
  sequences: 8,
  lettercase: 'lower',
  sequencelength: 10
};

var key = new KeyGen(options);
key.generate();
```

Providing all options is *optional* - If you don't need to change a certain property from the default, your custom options will be merged with the defaults.

#### But I don't want my key's sequences to be exactly the same!

Fair enough, I've included a `complex` property just for this! However, you'll need to manually specify the options for each sequence:

```js
var options = {
  complex: true,
  sequences: {
    sequence1: {
      type: 'alphabetic',
      sequencelength: 3,
      lettercase: 'lower'
    },
    sequence2: {
      type: 'numeric',
      sequencelength: 5
    }
  }
};

var key = new KeyGen(options);
key.generate();
```

#### Option parameters:

* `complex`: true, false
* `sequences`: the number of sequences you want OR an object containing sequences with different properties
* `sequencelength`: An integer representing the length of each sequence
* `type`: 'numeric', 'alphabetic', 'alphanumeric'
* `lettercase`: 'lower', 'upper', 'mixed'

#### Configuring my own key is just too much work. Isn't there a way I can copy how a key I already have is structured?

There sure is! But be warned, it is not 100% accurate. It's about 95% accurate. It's rather simple to use:

```js
var key = new KeyGen(simulate('ABCD17-EFGH26A-55599A22'));
key.generate();
```

# Contributing

Fork this repo. All contributions are welcome. After cloning the repository:

```
$ npm install
```

Assuming you have CoffeeScript installed globally (`$ npm install coffee-script -g`):

Running tests:
```
$ cake test
```

Building and packaging:
```
$ cake build
```

# Contributors

[@declandewet](https://github.com/declandewet)
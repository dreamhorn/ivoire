Ivoire Core
===========

A pseudo-random number generator, rare, powerful, and extensible.

[![Build Status](https://travis-ci.org/dreamhorn/ivoire.svg?branch=master)](https://travis-ci.org/dreamhorn/ivoire)

Ivoire is a pseudo-random number generator, powered by the Mersenne
Twister. Ivoire provides the building blocks for generating deterministic
random sequences. Deterministic, or pseudo-random sequences appear random,
but reliably generate the same sequence from the same seed.

Ivoire is designed to be extensible, and has a constellation of plugins for
various purposes.

- [Installing](#installing)
- [Getting Started](#getting-started)
- [Reference](#reference)
- [Acknowledgements](#acknowledgements)


Installing
----------

To install, use `npm`:

    npm install ivoire

Alternately, you can find the source [on Github](https://github.com/dreamhorn/ivoire).


Getting Started
---------------

The `ivoire` package provides the basic necessities for pseudo-random number
generation. You can require it directly:

    var Ivoire = require('ivoire');


Then, instantiate and start rolling!

    var ivoire = new Ivoire();

    // Return a random float on the [0, 1) real interval (same as `Math.random`):
    ivoire.random();

    // Return a random integer on the provided interval:
    ivoire.integer({min: 0, max: 10});

    // Return a random natural integer on the provided interval:
    ivoire.natural({max: 10});

    // Return a random element (or random elements) from the provided array:
    ivoire.pick(['foo', 'bar', 'baz']);

    // Return random elements from the provided array:
    ivoire.pick_some(['foo', 'bar', 'baz'], 2);

    // Return a randomly shuffled copy of the provided array:
    ivoire.shuffle();


Reference
---------

TODO: Add API reference

- [`#TODO()`](#TODO')—TODO

### #TODO()

#### Syntax

    ivoire.TODO(arg)

#### Usage

TODO: Describe methods

```
var ivoire = new require('ivoire');

// TODO: Give usage examples
```


Acknowledgements
----------------

The core of Ivoire (and some of its plugins) is based roughly on the core of
[chancejs](http://chancejs.com/).


Changelog
---------

### 1.1.1

- Expanded README


### 1.1.0

- Fixed major bugs in `#integer()` and `#shuffle()`.
- Fixed other bugs.
- Added more/better tests.
- Removed interface mirroring of Mersenne Twister implementation. Only
  `#random()` is proxied now. This is technically a backwards-incompatible
  change, but it seems silly to go to 2.0 when the library is so new.

### 1.0.0

Initial release. Pretty broken.

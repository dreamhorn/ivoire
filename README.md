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

Acknowledgements
----------------

The core of Ivoire (and some of its plugins) is based roughly on the core of
[chancejs](http://chancejs.com/).


Changelog
---------

### 1.1.0

- Fixed major bugs in `#integer()` and `#shuffle()`.
- Fixed other bugs.
- Added more/better tests.
- Removed interface mirroring of Mersenne Twister implementation. Only
  `#random()` is proxied now. This is technically a backwards-incompatible
  change, but it seems silly to go to 2.0 when the library is so new.

### 1.0.0

Initial release. Pretty broken.

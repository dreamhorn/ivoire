###

Ivoire Core
===========

A pseudo-random number generator, rare, powerful, and extensible.

Ivoire is a pseudo-random number generator, powered by the Mersenne
Twister. Ivoire provides the building blocks for generating deterministic
random sequences. Deterministic, or pseudo-random sequences appear random,
but are repeatable from the same seed.

Ivoire is designed to be extensible, and has a constellation of plugins for
various purposes.

The core of Ivoire (and some of its plugins) is based roughly on the core of
[chancejs](http://chancejs.com/).

###
MersenneTwister = require('mersenne-twister')


# Constants
MAX_INT = 9007199254740992
MIN_INT = -MAX_INT


###
If the test is false, throw a RangeError with the given error message.
###
assert = (test, errorMessage) ->
  if not test
    throw new RangeError("Ivoire: " + errorMessage)

###
If the test is true, throw a RangeError with the given error message.
###
panic_if = (test, errorMessage) -> assert not test

class Ivoire
  constructor: (seed) ->
    @seed = seed
    @twister = new MersenneTwister(seed)

  panic_if: panic_if
  assert: assert

  ###
  Return a new Ivoire instance seeded from the next random number in sequence.
  ###
  subgen: () ->
    return new Ivoire @twister.random_int()

  ###
  Return a random float on the [0, 1) real interval (same as `Math.random`).
  ###
  random: () ->
    return @twister.random()

  ###
  Return a random integer on the provided interval.

  NOTE the max and min are INCLUDED in the range. So:
  ring.integer({min: 1, max: 3});
  would return either 1, 2, or 3.

  @param {Object} [options={}] can specify a min and/or max
  @returns {Number} a single random integer number
  @throws {RangeError} min cannot be greater than max
  ###
  integer: (options) ->
    # 9007199254740992 (2^53) is the max integer number in JavaScript
    # See: http://vq.io/132sa2j
    min = if options and options.min then options.min else MIN_INT
    max = if options and options.max then options.max else MAX_INT

    @panic_if(min > max, "Min cannot be greater than Max.");

    return Math.floor(@random() * (max - min + 1) + min);

  ###
  Return a random natural integer on the provided interval.

  NOTE the max and min are INCLUDED in the range. So:
  ring.natural({min: 1, max: 3});
  would return either 1, 2, or 3.

  If no interval is provided, use {min: 0, max: MAX_INT}

  @param {Object} [options={}] can specify a min and/or max
  @returns {Number} a single random integer number
  @throws {RangeError} min cannot be greater than max
  ###
  natural: (options) ->
    options.min = 0 if not options.min
    @panic_if(options.min < 0, "Min cannot be less than zero.")
    return this.integer(options);

  ###
  Return a random element (or random elements) from the provided array.

  @param {Array} [arr] the array to pick from
  @returns {Object} a single item from the array
  ###
  pick: (arr) ->
    @panic_if arr.length == 0, "Cannot pick() from an empty array"

    return arr[@natural({max: arr.length - 1})];

  ###
  Return random elements from the provided array.

  @param {Array} [arr] the array to pick from
  @param {Number} [count=1] how many items to pick from the array
  @returns {Array} a slice of item from the array
  ###
  pick_some: (arr, count) ->
    @panic_if arr.length == 0, "Cannot pick_some() from an empty array"

    return @shuffle(arr).slice(0, count);

  ###
  Return a randomly shuffled copy of the provided array.

  @param {Array} [arr] the array to shuffle
  @returns {Array} a shuffled copy of the array
  ###
  shuffle: (arr) ->
    old_array = arr.slice(0)
    new_array = []
    j = 0
    length = Number(old_array.length)

    for i in [0..length]
      # Pick a random index from the array
      j = @natural {max: old_array.length - 1}
      # Add it to the new array
      new_array[i] = old_array[j]
      # Remove that element from the original array
      old_array.splice j, 1

    return new_array


Ivoire.panic_if = panic_if
Ivoire.assert = assert

module.exports = Ivoire

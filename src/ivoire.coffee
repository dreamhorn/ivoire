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


use = require('use-plugin')
  prefix: 'ivoire-'
  module: module
  builtin: './lib/plugin/'

# Constants
MAX_INT = 9007199254740992
MIN_INT = -MAX_INT

test_range = (test, errorMessage) ->
  if test
    throw new RangeError(errorMessage)


class Ivoire
  constructor: (seed) ->
    @seed = seed
    @twister = new MersenneTwister(seed)

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
  Return a random integer on the [0, 4294967295] natural interval.
  ###
  random_int: () ->
    return @twister.random_int()

  ###
  Return a random float on the [0, 1] (inclusive) real interval.
  ###
  random_incl: () ->
    return @twister.random_incl()

  ###
  Return a random float on the (0, 1) (exclusive) real interval.
  ###
  random_excl: () ->
    return @twister.random_excl()

  ###
  Return a random float [0, 1) with 53-bit resolution
  ###
  random_long: () ->
    return @twister.random_long()

  ###
  Return a random integer on the [0, 2147483647] natural interval.
  ###
  random_int31: () ->
    return @twister.random_int31()

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

    test_range(min > max, "Ivoire: Min cannot be greater than Max.");

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
    test_range(options.min < 0, "Ivoire: Min cannot be less than zero.")
    return this.integer(options);

  ###
  Return a random element (or random elements) from the provided array.

  @param {Array} [arr] the array to pick from
  @returns {Object} a single item from the array
  ###
  pick: (arr) ->
    test_range arr.length == 0, "Ivoire: Cannot pick() from an empty array"

    return arr[@natural({max: arr.length - 1})];

  ###
  Return random elements from the provided array.

  @param {Array} [arr] the array to pick from
  @param {Number} [count=1] how many items to pick from the array
  @returns {Array} a slice of item from the array
  ###
  pick_some: (arr, count) ->
    test_range arr.length == 0, "Ivoire: Cannot pick_some() from an empty array"

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

###
Use the named plugin module.

If we `Ivoire.use('foo')`, this will require a plugin by name, trying 'foo',
'ivoire-foo', './foo', and './ivoire-foo'.

@param {String} [name] specify the plugin to load.
###
Ivoire.use = (name) ->
  plugin_description = use(name)
  return plugin_description.init(Ivoire)

module.exports = Ivoire

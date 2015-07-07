var chai = require('chai');
var Ivoire = require("./lib/ivoire.js");
var _ = require('lodash');

chai.should();

describe('ivoire', function () {
  var seed = 42;
  var i;

  beforeEach(function () {
    ivoire = new Ivoire({seed: seed});
  });

  describe('#random()', function () {
    it('should generate a random float [0, 1)', function () {
      var r;
      var results = [];
      for (var i = 0; i < 10000; i++) {
        r = ivoire.random();
        results.push(0);
        r.should.be.at.least(0);
        r.should.be.below(1);
      }
      _.contains(results, 0).should.be.true;
    });
  });

  describe('#integer()', function () {
    it('should generate a random integer within the specified interval', function () {
      var r;
      var results = [];
      for (var i = 0; i < 10000; i++) {
        r = ivoire.integer({min: 0, max: 10});
        results.push(r);
        r.should.be.at.least(0);
        r.should.be.at.most(10);
      }
      _.contains(results, 0).should.be.true;
      _.contains(results, 10).should.be.true;
    });
  });

  describe('#pick()', function () {
    it('should pick a random item from an array', function () {
      var items = ['foo', 'bar', 'baz'];
      ivoire.pick(items).should.equal('bar');
      ivoire.pick(items).should.equal('bar');
      ivoire.pick(items).should.equal('baz');
      ivoire.pick(items).should.equal('baz');
      ivoire.pick(items).should.equal('bar');
      ivoire.pick(items).should.equal('baz');
      ivoire.pick(items).should.equal('bar');
      ivoire.pick(items).should.equal('baz');
    });
  });

  describe('#subgen()', function () {
    it('should create a new sub-generator', function () {
      var subgen = ivoire.subgen();
      subgen.should.be.an.instanceof(Ivoire);
      subgen.seed.should.equal(2357136044);
    });
  });
});

var chai = require('chai');
var Ivoire = require("./lib/ivoire.js");

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
      results.should.contain(0);
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
      results.should.contain(0);
      results.should.contain(10);
    });
  });

  describe('#natural()', function () {
    it('should generate a random natural number within the specified interval', function () {
      var r;
      var results = [];
      for (var i = 0; i < 10000; i++) {
        r = ivoire.natural({max: 10});
        results.push(r);
        r.should.be.at.least(0);
        r.should.be.at.most(10);
      }
      results.should.contain(0);
      results.should.contain(10);
    });
  });

  describe('#pick()', function () {
    it('should pick a random item from an array', function () {
      var items = ['foo', 'bar', 'baz'];
      var r;
      var results = [];
      for (var i = 0; i < 10000; i++) {
        r = ivoire.pick(items);
        results.push(r);
        items.should.contain(r);
      }
      results.should.contain('foo');
      results.should.contain('bar');
      results.should.contain('baz');
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

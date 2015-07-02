var chai = require('chai');
var Ivoire = require("./lib/ivoire.js");

chai.should();

describe('ivoire', function () {
  var seed = 42

  describe('#random_int()', function () {
    it('should generate a random integer', function () {
      var i = new Ivoire({seed: seed});
      i.random_int().should.equal(2357136044)
    });
  });

  describe('#subgen()', function () {
    it('should create a new sub-generator', function () {
      var i = new Ivoire({seed: seed});
      var subgen = i.subgen();
      subgen.should.be.an.instanceof(Ivoire);
      subgen.seed.should.equal(2357136044);
    });
  });
});

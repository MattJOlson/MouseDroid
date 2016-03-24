var expect = require('expect');
var contracts = require('../src/contracts');

describe("contracts", function() {
    it("has a HipChat member", function() {
        expect(contracts.HipChat).toExist();
    });
});

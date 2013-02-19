chai = require 'chai'
do chai.should

{simulate} = require '../src/simulator'

describe 'simulator', ->
	key = null
	it 'should determine if a key is complex', ->
		key = '555-ddd-trejMup-abc-DEF-DeF1'
		simulate(key).complex.should.equal true
	it 'should determine if a key is not complex', ->
		key = '555-555-555'
		simulate(key).should.not.have.property('complex')
	it 'should return an object', ->
		key = '555-222-666'
		simulate(key).should.be.an 'object'
	it 'should return correctly formatted', ->
		key = 'abcdefg-hijklmnop-123-456-ab12cd34'
		simulate(key).complex.should.equal true
		simulate(key).sequences.sequence0.type.should.equal 'alphabetic'
		simulate(key).sequences.sequence0.lettercase.should.equal 'lower'
		simulate(key).sequences.sequence0.sequencelength.should.equal 7

		simulate(key).sequences.sequence1.type.should.equal 'alphabetic'
		simulate(key).sequences.sequence1.lettercase.should.equal 'lower'
		simulate(key).sequences.sequence1.sequencelength.should.equal 9

		simulate(key).sequences.sequence2.type.should.equal 'numeric'
		simulate(key).sequences.sequence2.sequencelength.should.equal 3

		simulate(key).sequences.sequence3.type.should.equal 'numeric'
		simulate(key).sequences.sequence3.sequencelength.should.equal 3

		simulate(key).sequences.sequence4.type.should.equal 'alphanumeric'
		simulate(key).sequences.sequence4.lettercase.should.equal 'lower'
		simulate(key).sequences.sequence4.sequencelength.should.equal 8

		simulate(key).sequences.should.not.have.property('sequence5')
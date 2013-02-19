chai = require 'chai'
do chai.should

{KeyGen} = require '../src/KeyGen'

describe 'KeyGen', ->
	key = null
	it 'should have a settings object', ->
		key = new KeyGen()
		key.should.have.property 'settings'

	it 'should have default settings', ->
		key = new KeyGen()
		key.settings.complex.should.equal false
		key.settings.type.should.equal 'alphanumeric'
		key.settings.sequences.should.equal 5
		key.settings.sequencelength.should.equal 7
		key.settings.lettercase.should.equal 'mixed'

	it 'should allow custom settings', ->
		options =
			type: 'alphabetic'
			sequences: 4
			sequencelength: 15
			lettercase: 'upper'
		key = new KeyGen options
		key.settings.complex.should.equal false
		key.settings.type.should.equal 'alphabetic'
		key.settings.sequences.should.equal 4
		key.settings.sequencelength.should.equal 15
		key.settings.lettercase.should.equal 'upper'

	it 'should be able to generate a random character', ->
		key = new KeyGen()
		key.generateCharacter().should.be.a 'string'
		key.generateCharacter().should.have.length 1

	it 'should be able to generate a random sequence of characters', ->
		key = new KeyGen()
		key.generateSequence().should.be.a 'string'
		key.generateSequence().should.have.length 7

	it 'should be able to generate a key of sequences', ->
		key = new KeyGen()
		key.generate().should.be.a 'string'
		key.generate().should.have.length 39

	it 'should ensure the randomness of seperate keys', ->
		key = new KeyGen()
		a = key.generate()
		b = key.generate()
		a.should.not.equal b

	it 'should support complex keys with differing sequences', ->
		options =
			complex: true
			sequences:
				sequence1:
					type: 'alphabetic'
					sequencelength: 5
					lettercase: 'mixed'
				sequence2:
					type: 'alphanumeric'
					sequencelength: 10
					lettercase: 'upper'
				sequence3:
					type: 'numeric'
					sequencelength: 5
				sequence4:
					type: 'alphabetic'
					sequencelength: 3
					lettercase: 'lower'
		key = new KeyGen options
		key.generate().should.be.a 'string'
		key.generate().should.have.length 26
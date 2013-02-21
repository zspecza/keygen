# Determines if supplied value is a function.
# @param {object} object to determine type
isFunction = (functionToCheck) ->
  getType = {}
  type = getType.toString.call(functionToCheck)
  functionToCheck and type is '[object Function]'

# Overwrites object1's values with object2's and
# adds object2's if nonexistant in object1.
# @param {boolean} [deepMerge=false] If true,
# will deep merge meaning it will merge
# sub-objects like {object:object2{foo:'bar'}}
# @param {object} first object
# @param {object} second object
# @returns {object} a new object based on object1 and object2
mergeObjects = ->
  # copy reference to target object
  target = arguments[0] or {}
  i = 1
  length = arguments.length
  deep = false
  
  # handle a deep copy situation
  if typeof target is 'boolean'
    deep = target
    target = arguments[1] or {}
    # skip the boolean and the target
    i = 2

  # handle case when target is a string or something (possibly in deep copy)
  unless typeof target is 'object' and not isFunction(target)
    target = {}

  # extend itself if only one argument is passed
  if length is i
    target = @
    --i

  while i < length
    # only deal with non-null/undefined values
    if (options = arguments[i])?
      # extend the base object
      for name of options
        # @NOTE: added hasOwnProperty check
        if options.hasOwnProperty(name)
          src = target[name]
          copy = options[name]
          # prevent never-ending loop
          if target is copy then continue
          # recurse if we're merging object values
          if deep and copy and typeof copy is 'object' and not copy.nodeType
            target[name] = mergeObjects deep,
            # never move original objects - clone them instead
            src or (if copy.length? then [] else {}),
            copy
          else unless copy is undefined # Don't bring in undefined values
            target[name] = copy
    i++

  # return the modified object
  return target

# Initiates the KeyGen object and sets up a
# few default options if none are supplied.
# Options are entered as object properties and non-supplied objects
# are merged with defaults as @settings
# e.g. keygen = new KeyGen(
#         type: 'alphanumeric',
#         lettercase: 'upper',
#         sequences: 10,
#         sequencelength: 7
#      )
#      keygen.generate()
class KeyGen
  constructor: (options = {}) ->
    # Set up default options
    defaults =
      complex: false
      type: 'alphanumeric'
      sequences: 5
      sequencelength: 7
      lettercase: 'mixed'
    @settings = mergeObjects true, defaults, options

  # Generates a single random character. Depending on the KeyGen settings, this
  # method can generate anything numeric, alphabetic, alphanumeric, uppercase,
  # middlecase or lowercase or any combination of the type and
  # lettercase settings.
  # It's important to note that it only
  # generates one single character at a time,
  # but the features play an important role when generateSequence() is called.
  generateCharacter: (sequence = @settings) =>
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    randomletter = alphabet[Math.floor Math.random() * alphabet.length]
    randomnumber = Math.round Math.random() * 9
    isLetter = Math.round Math.random()    # This seems repetitive,
                                           # but it's important,
    isCapital = Math.round Math.random()   # otherwise all letters will be
                                           # uppercase!
    switch sequence.type
      when 'alphabetic' then switch sequence.lettercase
        when 'lower' then randomletter
        when 'mixed' then switch isCapital
          when 1 then randomletter.toUpperCase() else randomletter
        when 'upper' then randomletter.toUpperCase()
      when 'alphanumeric' then switch isLetter
        when 1 then switch sequence.lettercase
          when 'lower' then randomletter
          when 'mixed' then switch isCapital
            when 1 then randomletter.toUpperCase() else randomletter
          when 'upper' then randomletter.toUpperCase()
        else randomnumber.toString()
      when 'numeric' then randomnumber.toString()

  # This method will call generateCharacter() for each iteration in the
  # length of the sequence, as supplied by the option/default settings.
  generateSequence: (sequence = @settings) =>
    results = []
    for i in [1..sequence.sequencelength]
      results.push @generateCharacter(sequence)
    results.toString().replace /,*/g, ''

  # This method uses the sequence generation method to structure the final
  # generated key, taking into account the number of sequences required.
  generate: =>
    sequences = []
    if @settings.complex is true
      for sequence of @settings.sequences
        sequence = @settings.sequences[sequence]
        sequences.push @generateSequence(sequence)
    else
      for i in [1..@settings.sequences]
        sequences.push @generateSequence()
    sequences.toString().replace /,/g, '-'

# define 'root' as exports if the environment is Node.js or require.js modules
# are available.
# Otherwise, define it as a global DOM element
# finally, attach KeyGen to the root declaration so it is available
# to outside sources
root = exports ? window
root.KeyGen = KeyGen
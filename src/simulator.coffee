# Determine if each sequence in a key is of the same length
samelengths = (key) ->
  lengths = []
  for i in key
    lengths.push i.length
  max = lengths.length - 1
  while max
    if lengths[max--] isnt lengths[max] then return false
  return true

# Is the sequence numeric?
isNumeric = (s) ->
  i = 0
  length = s.length
  while i < length
    c = s.charAt(i)
    if c < "0" or c > "9" then return false
    i++
  return true

# Is the sequence alphabetic?
isAlphabetic = (s) ->
  regex = (/^[a-zA-Z]*$/)
  regex.test s

# Run the isNumeric and isAlphabetic functions
# to identify the type of the sequence
type = (s) ->
  if isNumeric s
    return 'numeric'
  else if isAlphabetic s
    return 'alphabetic'
  else
    return 'alphanumeric'

# Does the sequence have lowercase characters?
hasLowerCase = (s) ->
  if s.toUpperCase() isnt s
    return true
  else
    return false

# Does the sequence have uppercase characters?
hasUpperCase = (s) ->
  if s.toLowerCase() isnt s
    return true
  else
    return false

# Identifies what case the sequence is
lettercase = (s) ->
  if hasLowerCase(s) and not hasUpperCase(s)
    return 'lower'
  else if hasUpperCase(s) and not hasLowerCase(s)
    return 'upper'
  else
    return 'mixed'

# Do all of the sequences in the key have the same type?
sametypes = (key) ->
  types = []
  for i in key
    types.push type(i)
  max = types.length - 1
  while max
    if types[max--] isnt types[max] then return false
  return true

# Do all of the sequences in the key have the same lettercase?
samecases = (key) ->
  cases = []
  for i in key
    cases.push lettercase(i)
  max = cases.length - 1
  while max
    if cases[max--] isnt cases[max] then return false
  return true

# Is the key complex?
# (i.e. does each sequence differ from the other in some way?)
Complex = (key) ->
  key = key.split '-'
  if not samelengths(key) or not sametypes(key) or not samecases(key)
    return true
  else
    return false

# Analyze a given key and simulate it, bitch.
# Returns an object structured to make KeyGen simulate the key.
simulate = (key) ->
  options = {}
  if not Complex key
    key = key.split '-'
    options.sequences = key.length
    options.lettercase = lettercase(key[0])
    options.type = type(key[0])
    options.sequencelength = key[0].length

  else
    options.complex = true
    options.sequences = {}
    key = key.split '-'
    i = 0
    max = key.length
    while i < max
      options.sequences["sequence"+i] = {}
      options.sequences["sequence"+i].type = type(key[i])
      options.sequences["sequence"+i].lettercase = lettercase(key[i])
      options.sequences["sequence"+i].sequencelength = key[i].length
      i++
  return options

# Attach the simulate function to the global object (window or exports)
root = exports ? window
root.simulate = simulate
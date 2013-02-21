(function() {
  var KeyGen, isFunction, mergeObjects, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  isFunction = function(functionToCheck) {
    var getType, type;
    getType = {};
    type = getType.toString.call(functionToCheck);
    return functionToCheck && type === '[object Function]';
  };

  mergeObjects = function() {
    var copy, deep, i, length, name, options, src, target;
    target = arguments[0] || {};
    i = 1;
    length = arguments.length;
    deep = false;
    if (typeof target === 'boolean') {
      deep = target;
      target = arguments[1] || {};
      i = 2;
    }
    if (!(typeof target === 'object' && !isFunction(target))) {
      target = {};
    }
    if (length === i) {
      target = this;
      --i;
    }
    while (i < length) {
      if ((options = arguments[i]) != null) {
        for (name in options) {
          if (options.hasOwnProperty(name)) {
            src = target[name];
            copy = options[name];
            if (target === copy) {
              continue;
            }
            if (deep && copy && typeof copy === 'object' && !copy.nodeType) {
              target[name] = mergeObjects(deep, src || (copy.length != null ? [] : {}), copy);
            } else if (copy !== void 0) {
              target[name] = copy;
            }
          }
        }
      }
      i++;
    }
    return target;
  };

  KeyGen = (function() {

    function KeyGen(options) {
      var defaults;
      if (options == null) {
        options = {};
      }
      this.generate = __bind(this.generate, this);

      this.generateSequence = __bind(this.generateSequence, this);

      this.generateCharacter = __bind(this.generateCharacter, this);

      defaults = {
        complex: false,
        type: 'alphanumeric',
        sequences: 5,
        sequencelength: 7,
        lettercase: 'mixed'
      };
      this.settings = mergeObjects(true, defaults, options);
    }

    KeyGen.prototype.generateCharacter = function(sequence) {
      var alphabet, isCapital, isLetter, randomletter, randomnumber;
      if (sequence == null) {
        sequence = this.settings;
      }
      alphabet = 'abcdefghijklmnopqrstuvwxyz';
      randomletter = alphabet[Math.floor(Math.random() * alphabet.length)];
      randomnumber = Math.round(Math.random() * 9);
      isLetter = Math.round(Math.random());
      isCapital = Math.round(Math.random());
      switch (sequence.type) {
        case 'alphabetic':
          switch (sequence.lettercase) {
            case 'lower':
              return randomletter;
            case 'mixed':
              switch (isCapital) {
                case 1:
                  return randomletter.toUpperCase();
                default:
                  return randomletter;
              }
              break;
            case 'upper':
              return randomletter.toUpperCase();
          }
          break;
        case 'alphanumeric':
          switch (isLetter) {
            case 1:
              switch (sequence.lettercase) {
                case 'lower':
                  return randomletter;
                case 'mixed':
                  switch (isCapital) {
                    case 1:
                      return randomletter.toUpperCase();
                    default:
                      return randomletter;
                  }
                  break;
                case 'upper':
                  return randomletter.toUpperCase();
              }
              break;
            default:
              return randomnumber.toString();
          }
          break;
        case 'numeric':
          return randomnumber.toString();
      }
    };

    KeyGen.prototype.generateSequence = function(sequence) {
      var i, results, _i, _ref;
      if (sequence == null) {
        sequence = this.settings;
      }
      results = [];
      for (i = _i = 1, _ref = sequence.sequencelength; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
        results.push(this.generateCharacter(sequence));
      }
      return results.toString().replace(/,*/g, '');
    };

    KeyGen.prototype.generate = function() {
      var i, sequence, sequences, _i, _ref;
      sequences = [];
      if (this.settings.complex === true) {
        for (sequence in this.settings.sequences) {
          sequence = this.settings.sequences[sequence];
          sequences.push(this.generateSequence(sequence));
        }
      } else {
        for (i = _i = 1, _ref = this.settings.sequences; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
          sequences.push(this.generateSequence());
        }
      }
      return sequences.toString().replace(/,/g, '-');
    };

    return KeyGen;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.KeyGen = KeyGen;

}).call(this);

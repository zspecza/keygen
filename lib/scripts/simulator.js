(function() {
  var Complex, hasLowerCase, hasUpperCase, isAlphabetic, isNumeric, lettercase, root, samecases, samelengths, sametypes, simulate, type;

  samelengths = function(key) {
    var i, lengths, max, _i, _len;
    lengths = [];
    for (_i = 0, _len = key.length; _i < _len; _i++) {
      i = key[_i];
      lengths.push(i.length);
    }
    max = lengths.length - 1;
    while (max) {
      if (lengths[max--] !== lengths[max]) {
        return false;
      }
    }
    return true;
  };

  isNumeric = function(s) {
    var c, i, length;
    i = 0;
    length = s.length;
    while (i < length) {
      c = s.charAt(i);
      if (c < "0" || c > "9") {
        return false;
      }
      i++;
    }
    return true;
  };

  isAlphabetic = function(s) {
    var regex;
    regex = /^[a-zA-Z]*$/;
    return regex.test(s);
  };

  type = function(s) {
    if (isNumeric(s)) {
      return 'numeric';
    } else if (isAlphabetic(s)) {
      return 'alphabetic';
    } else {
      return 'alphanumeric';
    }
  };

  hasLowerCase = function(s) {
    if (s.toUpperCase() !== s) {
      return true;
    } else {
      return false;
    }
  };

  hasUpperCase = function(s) {
    if (s.toLowerCase() !== s) {
      return true;
    } else {
      return false;
    }
  };

  lettercase = function(s) {
    if (hasLowerCase(s) && !hasUpperCase(s)) {
      return 'lower';
    } else if (hasUpperCase(s) && !hasLowerCase(s)) {
      return 'upper';
    } else {
      return 'mixed';
    }
  };

  sametypes = function(key) {
    var i, max, types, _i, _len;
    types = [];
    for (_i = 0, _len = key.length; _i < _len; _i++) {
      i = key[_i];
      types.push(type(i));
    }
    max = types.length - 1;
    while (max) {
      if (types[max--] !== types[max]) {
        return false;
      }
    }
    return true;
  };

  samecases = function(key) {
    var cases, i, max, _i, _len;
    cases = [];
    for (_i = 0, _len = key.length; _i < _len; _i++) {
      i = key[_i];
      cases.push(lettercase(i));
    }
    max = cases.length - 1;
    while (max) {
      if (cases[max--] !== cases[max]) {
        return false;
      }
    }
    return true;
  };

  Complex = function(key) {
    key = key.split('-');
    if (!samelengths(key) || !sametypes(key) || !samecases(key)) {
      return true;
    } else {
      return false;
    }
  };

  simulate = function(key) {
    var i, max, options;
    options = {};
    if (!Complex(key)) {
      key = key.split('-');
      options.sequences = key.length;
      options.lettercase = lettercase(key[0]);
      options.type = type(key[0]);
      options.sequencelength = key[0].length;
    } else {
      options.complex = true;
      options.sequences = {};
      key = key.split('-');
      i = 0;
      max = key.length;
      while (i < max) {
        options.sequences["sequence" + i] = {};
        options.sequences["sequence" + i].type = type(key[i]);
        options.sequences["sequence" + i].lettercase = lettercase(key[i]);
        options.sequences["sequence" + i].sequencelength = key[i].length;
        i++;
      }
    }
    return options;
  };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.simulate = simulate;

}).call(this);

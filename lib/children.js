// Generated by CoffeeScript 1.4.0
var Children;

module.exports = Children = (function() {

  function Children() {}

  Children.children = [];

  Children.add = function(child) {
    return this.children.push(child);
  };

  Children.stop = function() {
    var child, _i, _len, _ref, _results;
    _ref = this.children;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      child = _ref[_i];
      _results.push(child.kill());
    }
    return _results;
  };

  return Children;

})();

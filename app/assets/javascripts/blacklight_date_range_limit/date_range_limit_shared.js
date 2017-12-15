
// takes a string and parses into an integer, but throws away commas first, to avoid truncation when there is a comma
// use in place of javascript's native parseInt
!function(global) {
  'use strict';

  var previousBlacklightDateRangeLimit = global.BlacklightDateRangeLimit;

  function BlacklightDateRangeLimit(options) {
    this.options = options || {};
  }

  BlacklightDateRangeLimit.noConflict = function noConflict() {
    global.BlacklightDateRangeLimit = previousBlacklightDateRangeLimit;
    return BlacklightDateRangeLimit;
  };

  BlacklightDateRangeLimit.parseNum = function parseNum(str) {
    str = String(str).replace(/[^0-9]/g, '');
    return parseInt(str, 10);
  };

  global.BlacklightDateRangeLimit = BlacklightDateRangeLimit;
}(this);

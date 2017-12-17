// for Blacklight.onLoad:
//= require blacklight/core

Blacklight.onLoad(function() {
  
$(".range_limit .profile .range.slider_js").each(function() {
var range_element = $(this);

var boundaries = min_max(this);
var min = boundaries[0];
var max = boundaries[1];

if (isInt(min) && isInt(max)) {
$(this).contents().wrapAll('<div style="display:none" />');

var range_element = $(this);
var form = $(range_element).closest(".range_limit").find("form.range_limit");
var begin_el = form.find("input.range_begin");
var end_el = form.find("input.range_end");

$.fn.datepicker.defaults.format = "yyyy-mm-dd";

begin_el.datepicker({
  startDate: min
});

end_el.datepicker({
  startDate: max
});

// returns two element array min/max as numbers. If there is a limit applied,
// it's boundaries are are limits. Otherwise, min/max in current result
// set as sniffed from HTML. Pass in a DOM element for a div.range
// Will return NaN as min or max in case of error or other weirdness. 
function min_max(range_element) {
var current_limit =  $(range_element).closest(".limit_content.range_limit").find(".current")

var min = max = BlacklightRangeLimit.parseNum(current_limit.find(".single").text())
if ( isNaN(min)) {
min = BlacklightRangeLimit.parseNum(current_limit.find(".from").first().text());
max = BlacklightRangeLimit.parseNum(current_limit.find(".to").first().text());
}

if (isNaN(min) || isNaN(max)) {
//no current limit, take from results min max included in spans
min = BlacklightRangeLimit.parseNum($(range_element).find(".min").first().text());
max = BlacklightRangeLimit.parseNum($(range_element).find(".max").first().text());
}

return [min, max]
}


// Check to see if a value is an Integer
// see: http://stackoverflow.com/questions/3885817/how-to-check-if-a-number-is-float-or-integer
function isInt(n) {
return n % 1 === 0;
}

});
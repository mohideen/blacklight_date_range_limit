// for Blacklight.onLoad:
//= require blacklight/core

Blacklight.onLoad(function() {
  $.fn.datepicker.defaults.format = "yyyy-mm-dd";
  $(".limit_content.date_range_limit").each(function() {
    let $range_element = $(this);
    let $picker = $($range_element).find("form.date_range_limit > .input-daterange");
    $picker.datepicker({});
  })
});

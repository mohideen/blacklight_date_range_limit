class SearchHistoryController < ApplicationController
  include Blacklight::SearchHistory

  helper BlacklightDateRangeLimit::ViewHelperOverride
  helper DateRangeLimitHelper
end

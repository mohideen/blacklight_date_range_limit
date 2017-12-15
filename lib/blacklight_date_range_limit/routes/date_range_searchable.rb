module BlacklightDateRangeLimit
  module Routes
    class DateRangeSearchable
      def initialize(defaults = {})
        @defaults = defaults
      end

      def call(mapper, options = {})
        options = @defaults.merge(options)

        mapper.get 'date_range_limit', action: 'date_range_limit'
      end
    end
  end
end

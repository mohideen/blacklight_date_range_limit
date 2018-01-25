module BlacklightDateRangeLimit
  module DateRangeLimitBuilder
    extend ActiveSupport::Concern

    included do
      # Use setters so not to propagate changes
      self.default_processor_chain += [:add_date_range_limit_params]
    end

    # Method added to to fetch proper things for date ranges.
    def add_date_range_limit_params(solr_params)
       ranged_facet_configs = 
         blacklight_config.facet_fields.select { |key, config| config.date_range } 
       ranged_facet_configs.each_pair do |solr_field, config|
     
        hash =  blacklight_params["date_range"] && blacklight_params["date_range"][solr_field] ?
          blacklight_params["date_range"][solr_field] :
          {}
          
        if !hash["missing"].blank?
          # missing specified in request params
          solr_params[:fq] ||= []
          solr_params[:fq] << "-#{solr_field}:[* TO *]"
          
        elsif !(hash["begin"].blank? && hash["end"].blank?)
          # specified in request params, begin and/or end, might just have one
          start = hash["begin"].blank? ? "*" : DateTime.parse(hash["begin"]).strftime("%FT%TZ")
          finish = hash["end"].blank? ? "*" :  DateTime.parse(hash["end"]).strftime("%FT%TZ")
  
          solr_params[:fq] ||= []
          solr_params[:fq] << "#{solr_field}:[#{start} TO #{finish}]"
        end
      end
      
      return solr_params
    end

  end
end

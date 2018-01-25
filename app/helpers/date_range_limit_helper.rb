# Additional helper methods used by view templates inside this plugin. 
module DateRangeLimitHelper

  # type is 'begin' or 'end'
  def render_date_range_input(solr_field, type, input_label = nil, maxlength=10)
    type = type.to_s

    default = params["date_range"][solr_field][type] if params["date_range"] && params["date_range"][solr_field] && params["date_range"][solr_field][type]

    html = label_tag("date_range[#{solr_field}][#{type}]", input_label, class: 'sr-only') if input_label.present?
    html ||= ''.html_safe
    html += text_field_tag("date_range[#{solr_field}][#{type}]", default, :maxlength=>maxlength, :class => "form-control date_range_#{type}")
  end

  def date_range_display(solr_field, my_params = params)
    return "" unless my_params[:date_range] && my_params[:date_range][solr_field]

    hash = my_params[:date_range][solr_field]
    
    if hash["missing"]
      return BlacklightDateRangeLimit.labels[:missing]
    elsif hash["begin"] || hash["end"]
      if hash["begin"] == hash["end"]
        return "<span class='single'>#{h(hash["begin"])}</span>".html_safe
      else
        return "<span class='from'>#{h(hash['begin'])}</span> to <span class='to'>#{h(hash['end'])}</span>".html_safe
      end
    end

    return ""
  end

  # Show the limit areaif:
  #  count > 0 
  def should_show_limit(solr_field)
    @response.total > 0 
  end

  def stats_for_field(solr_field)
    @response["stats"]["stats_fields"][solr_field] if @response["stats"] && @response["stats"]["stats_fields"]
  end

  def add_date_range_missing(solr_field, my_params = params)
    my_params = Blacklight::SearchState.new(my_params, blacklight_config).to_h
    my_params["date_range"] ||= {}
    my_params["date_range"][solr_field] ||= {}
    my_params["date_range"][solr_field]["missing"] = "true"

    # Need to ensure there's a search_field to trick Blacklight
    # into displaying results, not placeholder page. Kind of hacky,
    # but works for now.
    my_params["search_field"] ||= "dummy_date_range"

    my_params
  end

  def add_date_range(solr_field, from, to, my_params = params)
    my_params = Blacklight::SearchState.new(my_params, blacklight_config).to_h
    my_params["date_range"] ||= {}
    my_params["date_range"][solr_field] ||= {}

    my_params["date_range"][solr_field]["begin"] = from
    my_params["date_range"][solr_field]["end"] = to
    my_params["date_range"][solr_field].delete("missing")

    # eliminate temporary date_range status params that were just
    # for looking things up
    my_params.delete("date_range_field")
    my_params.delete("date_range_start")
    my_params.delete("date_range_end")

    return my_params
  end

end

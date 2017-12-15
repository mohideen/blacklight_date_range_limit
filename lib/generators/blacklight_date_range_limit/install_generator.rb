require 'rails/generators'

module BlacklightDateRangeLimit
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_public_assets
      generate 'blacklight_date_range_limit:assets'
    end

    def install_catalog_controller_mixin
      inject_into_class 'app/controllers/catalog_controller.rb', CatalogController do
        "\n  include BlacklightDateRangeLimit::ControllerOverride\n"
      end
    end

    def install_search_builder
      path = 'app/models/search_builder.rb'
      if File.exists? path
        inject_into_file path, after: /include Blacklight::Solr::SearchBuilderBehavior.*$/ do
          "\n  include BlacklightDateRangeLimit::DateRangeLimitBuilder\n"
        end
      else
        say_status("error", "Unable to find #{path}. You must manually add the 'include BlacklightDateRangeLimit::DateRangeLimitBuilder' to your SearchBuilder", :red)
      end
    end

    def install_search_history_controller
     copy_file "search_history_controller.rb", "app/controllers/search_history_controller.rb"
    end

    def install_routing_concern
      route('concern :date_range_searchable, BlacklightDateRangeLimit::Routes::DateRangeSearchable.new')
    end

    def add_date_range_limit_concern_to_catalog
      sentinel = /concerns :searchable.*$/

      inject_into_file 'config/routes.rb', after: sentinel do
        "\n    concerns :date_range_searchable\n"
      end
    end
  end
end

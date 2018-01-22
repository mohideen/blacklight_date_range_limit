BlacklightDateRangeLimit:  date range limit for Blacklight applications

# Description

The BlacklightDateRangeLimit plugin provides a limit for date fields, that lets the user enter range limits with a text box or a date-picker. This plugin was cloned from [blacklight_range_limit](https://github.com/projectblacklight/blacklight_range_limit) plugin, 
and then pared down.

# Requirements

A Solr date field. Depending on your data, it may or may not be advantageous to use a tdate (trie with non-zero precision) type field. 

# Installation

The 6.x version of `blacklight_date_range_limit` work with `blacklight` 6.x -- we now synchronize the _major version number_ between `blacklight` and `blacklight_date_range_limit`.

Add

    gem "blacklight_date_range_limit"

to your Gemfile. Run "bundle install". 

Then add the following changes to your Blacklight app:

Add the plugin JS to your manifest ( i.e. app/assets/javascripts/application.js):

    //= require blacklight_date_range_limit

and the plugin CSS to your manifest ( i.e. app/assets/stylesheets/application.scss):

    *= require  blacklight_date_range_limit


Add an include the override to the CatalogController ( app/controllers/catalog_controller.rb ):

    include BlacklightDateRangeLimit::ControllerOverride

Add one fo the SearchBuilder ( app/models/search_builder.rb )

    include BlacklightDateRangeLimit::DateRangeLimitBuilder


This should include all the needed patches. 

# Configuration

You have at least one solr field you want to display as a range limit, that's why you've installed this plugin. 
In your CatalogController, the facet configuration should look like:

```ruby
config.add_facet_field 'date', label: 'Publication Date' , date_range: true
```
  
You should now get range limit display.

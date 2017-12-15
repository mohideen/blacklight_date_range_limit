# We want to add a new collection action to Catalog, without over-writing
# what's already there. This SEEMS to do it. 
Rails.application.routes.draw do 
#  match "catalog/date_range_limit" => "catalog#date_range_limit"
end


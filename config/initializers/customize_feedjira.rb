class Feedjira::Parser::AtomEntry
  element 'media:thumbnail', :value => :url, :as => :media_thumbnail_url
  element 'media:description', :as => :summary
end

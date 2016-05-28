class Feedjira::Parser::RSSEntry
  element 'summary', :as => :description
end

class Feedjira::Parser::AtomEntry
  element 'media:thumbnail', :value => :url, :as => :media_thumbnail_url
  element 'media:description', :as => :description
end


#!/usr/bin/env jruby

require "uri"
require "rss"
require "freetts"


feed_url = "http://feeds.feedburner.com/RailsInside"

uri = URI.parse(feed_url)

feed_items = RSS::Parser.parse(uri.read, false).items.first(5)

feed_items.each do |item|
  title = item.title.content
  puts title
  FreeTTS.speak(title)
end

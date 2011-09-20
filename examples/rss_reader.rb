#!/usr/bin/env jruby

require "uri"
require "rss"
require "freetts"


feed_url = "http://feeds.feedburner.com/RubyInside"

uri = URI.parse(feed_url)

feed_items = RSS::Parser.parse(uri.read, false).items.first(5)

feed_items.each do |item|
  title = begin
    item.title.content    # works for RSS:Atom feeds
  rescue NoMethodError
    item.title.to_s       # works for standard RSS
  end

  puts title
  FreeTTS.speak(title)
end

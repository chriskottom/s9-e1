#!/usr/bin/env jruby

require "uri"
require "rss"
require "lib/freetts"

feed_url = "http://feeds.feedburner.com/RubyInside"

uri = URI.parse(feed_url)

feed_items = RSS::Parser.parse(uri.read, false).items.first(5)

feed_items.each do |item|
  puts item.title.content
  FreeTTS.speak item.title.content
end

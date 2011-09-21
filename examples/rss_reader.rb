#!/usr/bin/env jruby

require "uri"
require "rss"
require_relative "../lib/freetts"


feed_url = "http://feeds.feedburner.com/RubyInside"

uri = URI.parse(feed_url)
content = uri.read
puts content
puts content.encoding
content.force_encoding("utf-8")
puts content.encoding

feed_items = RSS::Parser.parse(content, false).items.first(5)

feed_items.each do |item|
  title = begin
    item.title.content    # works for RSS:Atom feeds
  rescue NoMethodError
    item.title.to_s       # works for standard RSS
  end

  puts title
  FreeTTS.speak(title)
end

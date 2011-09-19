# Integration Exercise: Java Library Wrapper

## Exercise Summary

- You should create a gem using JRuby that wraps an existing Java library.
- Your gem should work with a Java library that doesn't already have
  a good wrapper.
- You should make the API for your library look and feel like Ruby, not Java.


## A JRuby wrapper for FreeTTS
FreeTTS is a speech synthesis system written entirely in the JavaTM programming
language. It is based upon Flite: a small run-time speech synthesis engine
developed at Carnegie Mellon University. Flite is derived from the Festival 
Speech Synthesis System from the University of Edinburgh and the FestVox project
from Carnegie Mellon University.

This wrapper exposes the most essential functionality required for processing
text-to-speech requests.


### Sample Code
It's easy enough to pass a String to FreeTTS:

```ruby
require "lib/freetts"

FreeTTS.speak "hello world"
```

With a little bit of manipulation, FreeTTS can read the news to you:

```ruby
require "uri"
require "rss"
require "lib/freetts"

uri = URI.parse("http://feeds.feedburner.com/RubyInside")
feed_items = RSS::Parser.parse(uri.read, false).items.first(5)
feed_items.each do |item|
  puts item.title.content
  FreeTTS.speak item.title.content
end
```

You can change the currently selected voice and make modifications that
will affect pitch, rate of speech, and so on.

```ruby
voice = FreeTTS::Voice.for_name("alan")
voice.pitch *= 1.25
voice.rate += 20
```

Feel free to run any of the sample programs in the `examples/` directory
to see the library in action.

```bash
examples/hello_world.rb
examples/rss_reader.rb
examples/voice_play.rb
```


## Future Enhancements
- An adapter for plugging IO objects directly into the speech synthesizer
- Whack out a gem version of the library

$:.unshift File.join(File.dirname(__FILE__), "../lib")

require "freetts"
require "test/unit"


class VoiceTest < Test::Unit::TestCase
  def valid_voice
    FreeTTS.current_voice
  end

  # Calling valid accessor methods should result in a successful invocation.
  def test_valid_accessor_methods
    valid_accessors = %w( description gender locale pitch rate style )
    valid_accessors.each do |method|
      assert_nothing_raised do
        valid_voice.send(method.to_sym)
      end
    end
  end

  # Calling unknown accessor methods should raise a NoMethodException.
  def test_invalid_accessor_methods
    invalid_accessors = %w( something voice wallaby wombat parakeet )
    invalid_accessors.each do |method|
      assert_raises(NoMethodError) do
        valid_voice.send(method.to_sym)
      end
    end
  end

  # A request for all voices should get an array of names.
  def test_fetch_voices
    voice_names = FreeTTS::Voice.all
    assert_instance_of(Array, voice_names)

    voice_names.each do |voice_name|
      assert_instance_of(String, voice_name)
    end
  end

  # Requesting an available voice by name should return the relevant voice.
  def test_fetch_any_single_valid_voice
    voice_names = FreeTTS::Voice.all

    voice_names.each do |voice_name|
      assert_nothing_raised do
        voice = FreeTTS::Voice.for_name(voice_name)
        assert_instance_of(FreeTTS::Voice, voice)
        assert_equal(voice_name, voice.name)
      end
    end
  end

  # Attempting to fetch a non-existent voice should raise an exception.
  def test_cannot_fetch_fake_voices
    fake_voices = ["Ed McMahon", "Casey Kasem", "Rick Dees", "Frank Sinatra"]
    fake_voices.each do |voice_name|
      assert_raises(RuntimeError) do
        FreeTTS::Voice.for_name(voice_name)
      end
    end
  end
end

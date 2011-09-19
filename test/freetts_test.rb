$:.unshift File.join(File.dirname(__FILE__), "../lib")

require "freetts"
require "test/unit"


class FreeTTSTest < Test::Unit::TestCase
  def test_setting_current_voice
    start_voice = FreeTTS.current_voice
    all_voices = FreeTTS::Voice.all

    new_voice_name = all_voices.reject { |name| name == start_voice.name }.first
    FreeTTS.current_voice = FreeTTS::Voice.for_name(new_voice_name)
    new_voice = FreeTTS.current_voice

    assert_not_nil(new_voice)
    assert_equal(new_voice_name, new_voice.name)
  end
end

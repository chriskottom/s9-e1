require "freetts/voice"

module FreeTTS
  @voice = Voice.for_name(Voice::DEFAULT_NAME)
  class << self; attr_accessor :voice; end


  def self.speak(speakable)
    self.voice.speak(speakable)
  end
end

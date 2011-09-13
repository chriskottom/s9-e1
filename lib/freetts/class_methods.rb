require "freetts/voice"

module FreeTTS
  @voice = Voice.for_name(Voice::DefaultName)
  class << self; attr_accessor :voice; end


  def self.speak(speakable)
    self.voice.speak(speakable)
  end

  #def self.voice
  #  @@voice ||= Voice.for_name(Voice::DefaultName)
  #end

  #def self.voice=(voice_name)
  #  @@voice = Voice.for_name(voice_name)
  #end
end

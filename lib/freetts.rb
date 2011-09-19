$:.unshift(File.dirname(__FILE__))

require "java"
require "vendor/freetts.jar"

require "freetts/voice"
require "freetts/version"


module FreeTTS
  @current_voice = Voice.for_name(Voice::DEFAULT_NAME)
  class << self; attr_accessor :current_voice; end


  def self.speak(speakable)
    self.current_voice.speak(speakable)
  end
end

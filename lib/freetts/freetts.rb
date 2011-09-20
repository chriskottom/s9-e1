module FreeTTS
  class << self
    attr_accessor :current_voice

    def speak(speakable)
      @current_voice.speak(speakable)
    end
  end

  @current_voice = Voice.for_name(Voice::DEFAULT_NAME)
end

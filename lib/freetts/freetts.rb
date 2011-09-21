module FreeTTS
  class << self
    attr_writer :current_voice

    def current_voice
      @current_voice ||= Voice.for_name(Voice::DEFAULT_NAME)
    end

    def speak(speakable)
      current_voice.speak(speakable)
    end
  end
end

module FreeTTS
  class Voice
    DEFAULT_NAME = "kevin16"

    ACCESSIBLE_ATTRIBUTES = %w( age description domain duration_stretch
                                gender locale name organization pitch 
                                pitch_range pitch_shift rate run_title style
                                volume )
    MODIFIABLE_ATTRIBUTES = %w( duration_stretch pitch pitch_range pitch_shift
                                rate volume )

    class << self
      attr_reader :voice_manager

      def all
        voice_manager.get_voices.map { |voice| voice.get_name }
      end

      def for_name(voice_name)
        voice = voice_manager.get_voice(voice_name)
        if voice
          voice.allocate
          Voice.new(voice)
        else
          raise "No voice found for name \"#{ voice_name }\""
        end
      end
    end

    @voice_manager = com.sun.speech.freetts.VoiceManager.get_instance

    ACCESSIBLE_ATTRIBUTES.each do |attribute|
      ruby_method = attribute
      java_method = "get_#{ attribute }"
      define_method(ruby_method) { @voice_impl.send(java_method) }
    end

    MODIFIABLE_ATTRIBUTES.each do |attribute|
      ruby_method = "#{ attribute }="
      java_method = "set_#{ attribute }"
      define_method(ruby_method) { |value| @voice_impl.send(java_method, value) }
    end

    def initialize(voice)
      @voice_impl = voice
    end

    def speak(saying)
      @voice_impl.speak(saying)
    end
  end
end

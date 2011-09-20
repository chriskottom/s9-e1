module FreeTTS
  class Voice
    DEFAULT_NAME = "kevin16"

    ACCESSIBLE_ATTRIBUTES = %w( age description domain duration_stretch
                                gender locale name organization pitch 
                                pitch_range pitch_shift rate run_title style
                                volume )
    MODIFIABLE_ATTRIBUTES = %w( duration_stretch pitch pitch_range pitch_shift
                                rate volume )


    @voice_manager = com.sun.speech.freetts.VoiceManager.get_instance
    class << self; attr_reader :voice_manager; end
    #class << self
    #  attr_accessor :voice_manager
    #  @voice_manager = com.sun.speech.freetts.VoiceManager.get_instance
    #end

    ACCESSIBLE_ATTRIBUTES.each do |attribute|
      ruby_method = attribute.to_sym
      java_method = "get_#{ attribute }".to_sym
      define_method(ruby_method) { @voice_impl.send(java_method) }
    end

    MODIFIABLE_ATTRIBUTES.each do |attribute|
      ruby_method = "#{ attribute }=".to_sym
      java_method = "set_#{ attribute }".to_sym
      define_method(ruby_method) { |value| @voice_impl.send(java_method, value) }
    end

    def initialize(voice)
      @voice_impl = voice
    end

    def speak(saying)
      @voice_impl.speak(saying)
    end

    def method_missing(method, *args, &block)
      method = method.to_s
      java_method_name = case method
      when /\A(.*)=\Z/
        "set_#{ $1 }"
      when /\A(.*)\Z/
        "get_#{ $1 }"
      end

      if java_method_name and @voice_impl.respond_to?(java_method_name.to_sym)
        return @voice_impl.send(java_method_name.to_sym, *args)
      else
        error_message = "undefined method #{ method } for #{ self }:Voice"
        raise NoMethodError.new(error_message)
      end
    end

    def self.all
      voice_manager.get_voices.map { |voice| voice.get_name }
    end

    def self.for_name(voice_name)
      voice = voice_manager.get_voice(voice_name)
      if voice
        voice.allocate
        Voice.new(voice)
      else
        raise "No voice found for name \"#{ voice_name }\""
      end
    end
  end
end

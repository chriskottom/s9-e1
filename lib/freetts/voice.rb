module FreeTTS
  class Voice
    DEFAULT_NAME = "kevin16"

    @voice_manager = com.sun.speech.freetts.VoiceManager.get_instance
    class << self; attr_reader :voice_manager; end


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
      voice_manager.get_voices.map {|voice| voice.getName }
    end

    def self.for_name(voice_name)
      voice = self.voice_manager.getVoice(voice_name)
      return nil unless voice

      voice.allocate
      Voice.new(voice)
    end
  end
end

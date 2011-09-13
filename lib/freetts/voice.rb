module FreeTTS
  class Voice
    DefaultName = "kevin16"

    @voice_manager = com.sun.speech.freetts.VoiceManager.getInstance
    class << self; attr_reader :voice_manager; end

    require "forwardable"
    extend ::Forwardable

    def_delegator :@voice_impl, :getDescription, :description
    def_delegator :@voice_impl, :getName, :name

    def_delegator :@voice_impl, :setDescription, :description=
    def_delegator :@voice_impl, :setName, :name=

    def_delegator :@voice_impl, :speak, :speak


    def initialize(voice)
      @voice_impl = voice
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

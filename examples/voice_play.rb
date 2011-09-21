#!/usr/bin/env jruby

require_relative "../lib/freetts"


# A summary of the available commands
HELP_MESSAGE = "Enter one of the following commands:\n" +
               "  v         select a voice\n" +
               "  i         view information for currently selected voice\n" +
               "  c         change a setting for currently selected voice\n" +
               "  s         speak a phrase\n" +
               "  h/?       view this help message\n" +
               "  q/x       quit"


# Display a summary of the available commands.
def display_help_message
  puts HELP_MESSAGE
end


# Prompt the user to enter a command and return his input.
def prompt_for_input(prompt_string="Command")
  $stdout.write("#{ prompt_string }:>> ")
  $stdin.gets.chomp
end


# Allow the user to select a new current_voice from a list of options.
def select_voice
  voices = FreeTTS::Voice.all
  options_with_indices = voices.each_with_index.map { |v, i| "(#{ i }) #{ v }" }
  puts "Select a voice by entering the appropriate number:"
  puts "  #{ options_with_indices.join("   ") }"

  user_input = prompt_for_input("Selection")

  if user_input =~ /\A\d+\Z/ and
     (selected_name = voices[user_input.to_i] rescue nil)
    FreeTTS.current_voice = FreeTTS::Voice.for_name(selected_name)
    puts "Voice \"#{ selected_name }\" has been selected."
  else
    puts "Sorry, but that is not a valid selection."
  end
end


# Display attribute values for the currently selected voice.
def show_voice_info
  attributes  = %w(age description domain duration_stretch gender locale)
  attributes += %w(organization pitch pitch_range pitch_shift rate style volume)

  voice = FreeTTS.current_voice
  puts "Current settings for voice \"#{ voice.name } \":"
  attributes.each do |attribute|
    puts "  #{ attribute.ljust(20) }#{ voice.send(attribute.to_sym) }"
  end
end

# Change an attribute for the currently selected voice.
def change_voice_setting
  update_attributes  = %w( duration_stretch pitch pitch_range pitch_shift )
  update_attributes += %w( rate volume )

  options_with_indices = update_attributes.each_with_index.
                                           map { |v, i| "(#{ i }) #{ v }" }
  puts "Select an attribute to update by entering the appropriate number:"
  puts "  #{ options_with_indices.join("   ") }"

  user_input = prompt_for_input("Selection")

  if user_input =~ /\A\d+\Z/ and 
     (0..update_attributes.size).include?(user_input.to_i)
    selected_attribute = update_attributes[user_input.to_i]
    current_value = FreeTTS.current_voice.send(selected_attribute.to_sym)

    user_input = prompt_for_input("New value (current: #{ current_value })")

    #begin
      new_value = Float(user_input)
      FreeTTS.current_voice.send((selected_attribute + "=").to_sym, new_value)
      puts "Set \"selected_attribute\" to value #{ new_value }"
    #rescue Exception => e
      #puts e
      #puts "Illegal argument: requested value may be out of range for this attribute"
    #end
  else
    puts "Sorry, but that is not a valid selection."
  end
end

# Prompt the user to enter text to speak, and pass it to FreeTTS.
def prompt_for_speakable
  puts "Enter text to be spoken:>> "
  user_input = $stdin.gets.chomp
  FreeTTS.speak(user_input)
end


def unknown_command(command)
  puts "Sorry, I don't know how to '#{ command }'."
end


display_help_message

loop do
  entered_command = prompt_for_input

  case entered_command.downcase.chars.to_a[0]
  when "v"
    select_voice
  when "i"
    show_voice_info
  when "c"
    change_voice_setting
  when "s"
    prompt_for_speakable
  when "h", "?"
    display_help_message
  when "q", "x"
    break
  else
    unknown_command(entered_command)
  end
end







require 'open_jtalk/config'
require 'open_jtalk/version'
require 'open_jtalk/open_jtalk'
require 'open_jtalk/wave_file_writer'
require 'open_jtalk/text_cutter'

begin
  require 'forwardable'
  require 'lame'
  require 'open_jtalk/mp3_file_writer'
  require 'open_jtalk/mp3_synthesizer'
  require 'open_jtalk/mp3_streaming_synthesizer'
rescue LoadError, StandardError => e
end

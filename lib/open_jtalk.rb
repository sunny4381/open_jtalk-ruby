require 'open_jtalk/config'
require 'open_jtalk/version'
require 'open_jtalk/open_jtalk'
require 'open_jtalk/wave_file_writer'

begin
  require 'forwardable'
  require 'lame'
  require 'open_jtalk/mp3_file_writer'
rescue LoadError, StandardError => e
end

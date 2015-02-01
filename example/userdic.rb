require 'open_jtalk'

text = "複数形".encode("UTF-8")

config = OpenJtalk::Config::Mei::NORMAL.configure do |cfg|
  cfg['userdic'] = File.expand_path('userdic.dic', File.dirname(__FILE__))
end

OpenJtalk.load(config) do |openjtalk|
  header, data = openjtalk.synthesis(openjtalk.normalize_text(text))
  OpenJtalk::WaveFileWriter.save("a.wav", header, data)
end

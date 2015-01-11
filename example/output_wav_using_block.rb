require 'open_jtalk'

text = "こんにちは。".encode("UTF-8")

config = OpenJtalk::Config::Mei::NORMAL
OpenJtalk.load(config.to_hash) do |openjtalk|
  header, data = openjtalk.synthesis(openjtalk.normalize_text(text))
  OpenJtalk::WaveFileWriter.save("a.wav", header, data)
end

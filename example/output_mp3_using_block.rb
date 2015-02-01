require 'open_jtalk'

text = "こんにちは。".encode("UTF-8")

OpenJtalk.load(config.OpenJtalk::Config::Mei::NORMAL) do |openjtalk|
  header, data = openjtalk.synthesis(openjtalk.normalize_text(text))
  OpenJtalk::Mp3FileWriter.save("a.mp3", header, data)
end

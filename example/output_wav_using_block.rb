require 'open_jtalk'

text = "こんにちは。".encode("UTF-8")

OpenJtalk.load(OpenJtalk::Config::Mei::NORMAL) do |openjtalk|
  header, data = openjtalk.synthesis(openjtalk.normalize_text(text))
  OpenJtalk::WaveFileWriter.save("a.wav", header, data)
end

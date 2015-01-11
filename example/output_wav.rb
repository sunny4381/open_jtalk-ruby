require 'open_jtalk'

text = "こんにちは。".encode("UTF-8")

config = OpenJtalk::Config::Mei::NORMAL
openjtalk = OpenJtalk.load(config.to_hash)
header, data = openjtalk.synthesis(openjtalk.normalize_text(text))

OpenJtalk::WaveFileWriter.save("a.wav", header, data)
openjtalk.close

require 'open_jtalk'

text = "こんにちは。".encode("UTF-8")

openjtalk = OpenJtalk.load(OpenJtalk::Config::Mei::NORMAL)
header, data = openjtalk.synthesis(openjtalk.normalize_text(text))

OpenJtalk::WaveFileWriter.save("a.wav", header, data)
openjtalk.close

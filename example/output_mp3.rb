require 'open_jtalk'

text = "こんにちは。".encode("UTF-8")

openjtalk = OpenJtalk.load(OpenJtalk::Config::Mei::NORMAL)
header, data = openjtalk.synthesis(openjtalk.normalize_text(text))

OpenJtalk::Mp3FileWriter.save("a.mp3", header, data)
openjtalk.close

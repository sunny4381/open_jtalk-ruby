require 'open_jtalk/mp3_streaming_synthesizer'

class OpenJtalk::Mp3Synthesizer

  def self.synthesize(file, config, text)
    File.open(file, "wb") do |f|
      OpenJtalk::Mp3StreamingSynthesizer.new(config, text).each do |mp3_data|
        f.write(mp3_data)
      end
    end
  end

end

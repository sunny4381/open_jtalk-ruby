require 'open_jtalk/text_cutter'

class OpenJtalk::Mp3StreamingSynthesizer
  include Enumerable

  def initialize(config, text, bit_rate = 128)
    @config = config
    @text = text
    @encoder = nil
    @bit_rate = bit_rate
  end

  def each
    e = OpenJtalk::TextCutter.new(@text)

    pending_slice = OpenJtalk.load(@config) do |openjtalk|
      e.reduce([]) do |pending, line|
        header, pcm_data = openjtalk.synthesis(openjtalk.normalize_text(line))

        @encoder = create_encoder(header) unless @encoder
        frame_size = @encoder.framesize

        pending += pcm_data.unpack("v*")
        pending.each_slice(frame_size).reduce do |_,slice|
          if slice.length == frame_size
            @encoder.encode_short(slice, slice) do |mp3_data|
              yield mp3_data
              []
            end
          else
            slice
          end
        end
      end
    end

    if @encoder
      unless pending_slice.empty?
        @encoder.encode_short(pending_slice, pending_slice) do |mp3_data|
          yield mp3_data
        end
      end

      @encoder.flush do |flush_frame|
        yield flush_frame
      end
    end

    # dispose
    @encoder = nil
  end

  private

  def create_encoder(header)
    encoder = LAME::Encoder.new
    encoder.configure do |config|
      config.bitrate = @bit_rate
      config.mode = :mono if header['number_of_channels'] == 1
      config.number_of_channels = header['number_of_channels']
      config.input_samplerate = header['sample_rate']
      config.output_samplerate = header['sample_rate']
    end
    encoder
  end
end

require 'lame'

class OpenJtalk::Mp3FileWriter
  def initialize(io, bit_rate = 128)
    @io = io
    @bit_rate = bit_rate
  end

  def write(header, data)
    encoder = LAME::Encoder.new
    encoder.configure do |config|
      config.bitrate = @bit_rate
      config.mode = :mono if header['number_of_channels'] == 1

      config.number_of_channels = header['number_of_channels']
      config.input_samplerate = header['sample_rate']
      config.output_samplerate = header['sample_rate']
    end

    data_array = data.unpack("v*")

    frame_size = encoder.framesize
    i = 0
    while i < data_array.length do
      slice = data_array[i, frame_size]
      i = i + frame_size

      encoder.encode_short(slice, slice) do |mp3_data|
        @io.write mp3_data
      end
    end
    encoder.flush do |flush_frame|
      @io.write flush_frame
    end
  end

  def self.save(file, header, data)
    File.open(file, "wb") do |f|
      new(f).write(header, data)
    end
  end
end

class OpenJtalk::WaveFileWriter
  def initialize(io)
    @io = io
  end

  def write(header, data)
    @io.write [ "RIFF",
              data.length + 36,
              "WAVE",
              "fmt ",
              16,
              header['compression_code'],
              header['number_of_channels'],
              header['sample_rate'],
              header['average_bytes_per_second'],
              header['block_align'],
              header['significant_bits_per_sample'],
              "data",
              data.length ].pack("a4Va4a4VvvVVvva4V")
    @io.write data
  end

  def self.save(file, header, data)
    File.open(file, "wb") do |f|
      new(f).write(header, data)
    end
  end
end

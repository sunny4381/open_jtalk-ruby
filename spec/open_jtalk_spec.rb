require 'spec_helper'
require 'lame'

describe OpenJtalk do
  config = OpenJtalk::Config::NORMAL
  # config = OpenJtalk::Config::ANGRY
  # config = OpenJtalk::Config::BASHFUL
  # config = OpenJtalk::Config::HAPPY
  # config = OpenJtalk::Config::SAD
  # config = OpenJtalk::Config::FAST
  # config = OpenJtalk::Config::SLOW
  # config = OpenJtalk::Config::HIGH
  # config = OpenJtalk::Config::LOW
  openjtalk = OpenJtalk.load(config.to_hash)

  describe "#normalize_text" do
    context "when 'abcd' is given" do
      subject { openjtalk.normalize_text("abcd") }
      it { expect(subject).to eq "ａｂｃｄ" }
      it { expect(subject.encoding.to_s).to eq "UTF-8" }
    end
    context "when 'ABCD' is given" do
      subject { openjtalk.normalize_text("ABCD") }
      it { expect(subject).to eq "ＡＢＣＤ" }
      it { expect(subject.encoding.to_s).to eq "UTF-8" }
    end
    context "when '1234' is given" do
      subject { openjtalk.normalize_text("1234") }
      it { expect(subject).to eq "１２３４" }
    end
  end

  describe "#synthesis" do
    text = "こんにちは。僕、ミッキーだよ。"
    header, data = openjtalk.synthesis(openjtalk.normalize_text(text))

    it "returns non-nil header" do
      expect(header).not_to be_nil
    end
    it "returns header as Hash" do
      expect(header).to be_a Hash
    end
    it "returns header containing valid 'compression_code'" do
      # 1: PCM
      expect(header['compression_code']).to eq 1
    end
    it "returns header containing valid 'number_of_channels'" do
      # 1: monoral
      expect(header['number_of_channels']).to eq 1
    end
    it "returns header containing 'sample_rate'" do
      expect(header['sample_rate']).not_to be_nil
    end
    it "returns header containing 'average_bytes_per_second'" do
      expect(header['average_bytes_per_second']).to eq header['sample_rate'] * header['block_align']
    end
    it "returns header containing valid 'block_align'" do
      # 2: 16-bit
      expect(header['block_align']).to eq 2
    end
    it "returns header containing valid 'significant_bits_per_sample'" do
      # 16: 16-bit
      expect(header['significant_bits_per_sample']).to eq 16
    end
    it "returns header containing valid 'total_nsamples'" do
      expect(header['total_nsamples']).to be > 0
    end

    it "returns non-nil data" do
      expect(data).not_to be_nil
    end
    it "returns data as String" do
      expect(data).to be_a String
    end
    it "returns valid data length" do
      expect(data.length).to eq header['total_nsamples'] * header['block_align']
    end
    it "returns ASCII-8BIT data" do
      expect(data.encoding.to_s).to eq "ASCII-8BIT"
    end

    OpenJtalk::WaveFileWriter.save("/tmp/c.wav", header, data)
    OpenJtalk::Mp3FileWriter.save("/tmp/c.mp3", header, data)
  end
end


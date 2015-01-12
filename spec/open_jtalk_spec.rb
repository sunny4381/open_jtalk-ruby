# encoding: utf-8
require 'spec_helper'
require 'lame'

describe OpenJtalk do
  config = OpenJtalk::Config::Mei::NORMAL
  # config = OpenJtalk::Config::Mei::ANGRY
  # config = OpenJtalk::Config::Mei::BASHFUL
  # config = OpenJtalk::Config::Mei::HAPPY
  # config = OpenJtalk::Config::Mei::SAD
  # config = OpenJtalk::Config::Mei::FAST
  # config = OpenJtalk::Config::Mei::SLOW
  # config = OpenJtalk::Config::Mei::HIGH
  # config = OpenJtalk::Config::Mei::LOW
  openjtalk = OpenJtalk.load(config.to_hash)

  describe "#normalize_text" do
    context "when 'abcd' is given" do
      subject { openjtalk.normalize_text("abcd".encode("UTF-8")) }
      it { expect(subject).to eq "ａｂｃｄ".encode("UTF-8") }
      it { expect(subject.encoding.to_s).to eq "UTF-8" }
    end
    context "when 'ABCD' is given" do
      subject { openjtalk.normalize_text("ABCD".encode("UTF-8")) }
      it { expect(subject).to eq "ＡＢＣＤ".encode("UTF-8") }
      it { expect(subject.encoding.to_s).to eq "UTF-8" }
    end
    context "when '1234' is given" do
      subject { openjtalk.normalize_text("1234".encode("UTF-8")) }
      it { expect(subject).to eq "１２３４".encode("UTF-8") }
      it { expect(subject.encoding.to_s).to eq "UTF-8" }
    end
    context "when 'オーストラリアの知人からの文書の文末に「Regards」とあり、' is given" do
      subject { openjtalk.normalize_text("オーストラリアの知人からの文書の文末に「Regards」とあり、".encode("UTF-8")) }
      it { expect(subject).to eq "オーストラリアの知人からの文書の文末に「Ｒｅｇａｒｄｓ」とあり、".encode("UTF-8") }
      it { expect(subject.encoding.to_s).to eq "UTF-8" }
    end
  end

  describe "#synthesis" do
    context "when 'こんにちは。僕、ミッキーだよ。' is given" do
      text = "こんにちは。僕、ミッキーだよ。".encode("UTF-8")
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

      context "when a result is written to wave file" do
        subject do
          wav_file = Tempfile.new([SecureRandom.hex(4), ".wav"])
          OpenJtalk::WaveFileWriter.save(wav_file.path, header, data)
          wav_file
        end

        it "has size > 100" do
          expect(subject.size).to be > 100
        end
      end

      context "when a result is written to mp3 file" do
        subject do
          mp3_file = Tempfile.new([SecureRandom.hex(4), ".mp3"])
          OpenJtalk::Mp3FileWriter.save(mp3_file.path, header, data)
          mp3_file
        end

        it "has size > 100" do
          expect(subject.size).to be > 100
        end
      end
    end
  end

  describe "#close" do
    subject {
      OpenJtalk.load(config.to_hash)
    }

    it "safely close twice or more" do
      expect(subject.closed?).to eq false
      subject.close
      expect(subject.closed?).to eq true
      expect { subject.close }.not_to raise_error
      expect(subject.closed?).to eq true
      expect { subject.close }.not_to raise_error
      expect(subject.closed?).to eq true
      expect { subject.close }.not_to raise_error
      expect(subject.closed?).to eq true
    end
  end

  context "block is given to load" do
    header = nil
    data = nil
    OpenJtalk.load(config.to_hash) do |openjtalk|
      text = "こんにちは。僕、ミッキーだよ。".encode("UTF-8")
      header, data = openjtalk.synthesis(openjtalk.normalize_text(text))
    end

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
  end
end


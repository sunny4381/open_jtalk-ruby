require 'spec_helper'

describe OpenJtalk::Mp3Synthesizer do
  describe ".synthesize" do
    it "creates mp3 file" do
      file = ::Tempfile.new(rand(0x10000000).to_s(36))
      OpenJtalk::Mp3Synthesizer.synthesize(file, OpenJtalk::Config::Mei::NORMAL, "僕、ミッキーだよ。")
      expect(file.length).to be > 2_000
    end
  end
end

# encoding: utf-8
require 'spec_helper'

describe OpenJtalk::Mp3Synthesizer do
  describe ".synthesize" do
    context "when '僕、ミッキーだよ。' is given" do
      it "creates mp3 file" do
        file = ::Tempfile.new(rand(0x10000000).to_s(36))
        OpenJtalk::Mp3Synthesizer.synthesize(file, OpenJtalk::Config::Mei::NORMAL, "僕、ミッキーだよ。")
        expect(file.length).to be > 2_000
      end
    end

    context "when '検索' is given" do
      it "creates mp3 file" do
        file = ::Tempfile.new(rand(0x10000000).to_s(36))
        OpenJtalk::Mp3Synthesizer.synthesize(file, OpenJtalk::Config::Mei::NORMAL, "検索")
        expect(file.length).to be > 2_000
      end
    end

    context "when '、' is given" do
      it "creates empty file" do
        file = ::Tempfile.new(rand(0x10000000).to_s(36))
        OpenJtalk::Mp3Synthesizer.synthesize(file, OpenJtalk::Config::Mei::NORMAL, "、")
        expect(file.length).to eq 768
      end
    end

    context "when '\\n\\n' is given" do
      it "creates empty file" do
        file = ::Tempfile.new(rand(0x10000000).to_s(36))
        OpenJtalk::Mp3Synthesizer.synthesize(file, OpenJtalk::Config::Mei::NORMAL, "\n\n")
        expect(file.length).to eq 768
      end
    end
  end
end

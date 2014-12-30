require 'spec_helper'

describe OpenJtalk::Config do
  describe ".NORMAL" do
    subject { OpenJtalk::Config::NORMAL }
    it { expect(subject['dicdir']).not_to be_nil }
    it { expect(subject['model']).not_to be_nil }
    it { expect(subject['style']).not_to be_nil }
    it { expect(subject['style']['interpolation0']).not_to be_nil }
    it { expect(subject['style']['interpolation1']).not_to be_nil }
    it { expect(subject['style']['duration']).not_to be_nil }
    it { expect(subject['style']['speed']).not_to be_nil }
    it { expect(subject['style']['half_tone']).not_to be_nil }
    it { expect(subject['style']['alpha']).not_to be_nil }
    it { expect(subject['style']['volume']).not_to be_nil }
  end

  describe ".ANGRY" do
    subject { OpenJtalk::Config::ANGRY }
    it { expect(subject['dicdir']).not_to be_nil }
    it { expect(subject['model']).not_to be_nil }
    it { expect(subject['style']).not_to be_nil }
    it { expect(subject['style']['interpolation0']).not_to be_nil }
    it { expect(subject['style']['interpolation1']).not_to be_nil }
    it { expect(subject['style']['duration']).not_to be_nil }
    it { expect(subject['style']['speed']).not_to be_nil }
    it { expect(subject['style']['half_tone']).not_to be_nil }
    it { expect(subject['style']['alpha']).not_to be_nil }
    it { expect(subject['style']['volume']).not_to be_nil }
  end

  describe ".BASHFUL" do
    subject { OpenJtalk::Config::BASHFUL }
    it { expect(subject['dicdir']).not_to be_nil }
    it { expect(subject['model']).not_to be_nil }
    it { expect(subject['style']).not_to be_nil }
    it { expect(subject['style']['interpolation0']).not_to be_nil }
    it { expect(subject['style']['interpolation1']).not_to be_nil }
    it { expect(subject['style']['duration']).not_to be_nil }
    it { expect(subject['style']['speed']).not_to be_nil }
    it { expect(subject['style']['half_tone']).not_to be_nil }
    it { expect(subject['style']['alpha']).not_to be_nil }
    it { expect(subject['style']['volume']).not_to be_nil }
  end

  describe ".HAPPY" do
    subject { OpenJtalk::Config::HAPPY }
    it { expect(subject['dicdir']).not_to be_nil }
    it { expect(subject['model']).not_to be_nil }
    it { expect(subject['style']).not_to be_nil }
    it { expect(subject['style']['interpolation0']).not_to be_nil }
    it { expect(subject['style']['interpolation1']).not_to be_nil }
    it { expect(subject['style']['duration']).not_to be_nil }
    it { expect(subject['style']['speed']).not_to be_nil }
    it { expect(subject['style']['half_tone']).not_to be_nil }
    it { expect(subject['style']['alpha']).not_to be_nil }
    it { expect(subject['style']['volume']).not_to be_nil }
  end

  describe ".SAD" do
    subject { OpenJtalk::Config::SAD }
    it { expect(subject['dicdir']).not_to be_nil }
    it { expect(subject['model']).not_to be_nil }
    it { expect(subject['style']).not_to be_nil }
    it { expect(subject['style']['interpolation0']).not_to be_nil }
    it { expect(subject['style']['interpolation1']).not_to be_nil }
    it { expect(subject['style']['duration']).not_to be_nil }
    it { expect(subject['style']['speed']).not_to be_nil }
    it { expect(subject['style']['half_tone']).not_to be_nil }
    it { expect(subject['style']['alpha']).not_to be_nil }
    it { expect(subject['style']['volume']).not_to be_nil }
  end

  describe ".FAST" do
    subject { OpenJtalk::Config::FAST }
    it { expect(subject['dicdir']).not_to be_nil }
    it { expect(subject['model']).not_to be_nil }
    it { expect(subject['style']).not_to be_nil }
    it { expect(subject['style']['interpolation0']).not_to be_nil }
    it { expect(subject['style']['interpolation1']).not_to be_nil }
    it { expect(subject['style']['duration']).not_to be_nil }
    it { expect(subject['style']['speed']).not_to be_nil }
    it { expect(subject['style']['half_tone']).not_to be_nil }
    it { expect(subject['style']['alpha']).not_to be_nil }
    it { expect(subject['style']['volume']).not_to be_nil }
  end

  describe ".SLOW" do
    subject { OpenJtalk::Config::SLOW }
    it { expect(subject['dicdir']).not_to be_nil }
    it { expect(subject['model']).not_to be_nil }
    it { expect(subject['style']).not_to be_nil }
    it { expect(subject['style']['interpolation0']).not_to be_nil }
    it { expect(subject['style']['interpolation1']).not_to be_nil }
    it { expect(subject['style']['duration']).not_to be_nil }
    it { expect(subject['style']['speed']).not_to be_nil }
    it { expect(subject['style']['half_tone']).not_to be_nil }
    it { expect(subject['style']['alpha']).not_to be_nil }
    it { expect(subject['style']['volume']).not_to be_nil }
  end

  describe ".HIGH" do
    subject { OpenJtalk::Config::HIGH }
    it { expect(subject['dicdir']).not_to be_nil }
    it { expect(subject['model']).not_to be_nil }
    it { expect(subject['style']).not_to be_nil }
    it { expect(subject['style']['interpolation0']).not_to be_nil }
    it { expect(subject['style']['interpolation1']).not_to be_nil }
    it { expect(subject['style']['duration']).not_to be_nil }
    it { expect(subject['style']['speed']).not_to be_nil }
    it { expect(subject['style']['half_tone']).not_to be_nil }
    it { expect(subject['style']['alpha']).not_to be_nil }
    it { expect(subject['style']['volume']).not_to be_nil }
  end

  describe ".LOW" do
    subject { OpenJtalk::Config::LOW }
    it { expect(subject['dicdir']).not_to be_nil }
    it { expect(subject['model']).not_to be_nil }
    it { expect(subject['style']).not_to be_nil }
    it { expect(subject['style']['interpolation0']).not_to be_nil }
    it { expect(subject['style']['interpolation1']).not_to be_nil }
    it { expect(subject['style']['duration']).not_to be_nil }
    it { expect(subject['style']['speed']).not_to be_nil }
    it { expect(subject['style']['half_tone']).not_to be_nil }
    it { expect(subject['style']['alpha']).not_to be_nil }
    it { expect(subject['style']['volume']).not_to be_nil }
  end
end

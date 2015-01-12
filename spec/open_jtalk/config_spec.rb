require 'spec_helper'

describe OpenJtalk::Config::Mei do
  describe "Mei" do
    describe ".NORMAL" do
      subject { OpenJtalk::Config::Mei::NORMAL }
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
      subject { OpenJtalk::Config::Mei::ANGRY }
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
      subject { OpenJtalk::Config::Mei::BASHFUL }
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
      subject { OpenJtalk::Config::Mei::HAPPY }
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
      subject { OpenJtalk::Config::Mei::SAD }
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
      subject { OpenJtalk::Config::Mei::FAST }
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
      subject { OpenJtalk::Config::Mei::SLOW }
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
      subject { OpenJtalk::Config::Mei::HIGH }
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
      subject { OpenJtalk::Config::Mei::LOW }
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

  describe "Nitech" do
    describe ".NORMAL" do
      subject { OpenJtalk::Config::Nitech::NORMAL }
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
      subject { OpenJtalk::Config::Nitech::FAST }
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
      subject { OpenJtalk::Config::Nitech::SLOW }
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
      subject { OpenJtalk::Config::Nitech::HIGH }
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
      subject { OpenJtalk::Config::Nitech::LOW }
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
end

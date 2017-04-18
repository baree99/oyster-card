require 'journey'

describe Journey do
  let(:station) { double :station }
  let(:card) { double :oystercard }

  it 'should start a journey' do
    allow(card).to receive(:touch_in).with(station) { subject.start(station) }
    card.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it 'should finish journey ' do
    allow(card).to receive(:touch_out).with(station) { subject.finish(station) }
    card.touch_out(station)
    expect(subject.exit_station).to eq station
  end

  describe '#fare' do
    it 'should return minimum fare'do
      subject.start(station)
      subject.finish(station)
      expect(subject.fare).to eq described_class::MINIMUM_FARE
    end

    it 'should return penalty fare if entry or exit station is nil' do
      subject.entry_station = nil
      expect(subject.fare).to eq described_class::PENALTY
    end

  end

end

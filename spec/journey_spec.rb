require 'journey'

describe Journey do
  let(:station) { double :station }
  let(:card) { double :oystercard }

  it 'should start a journey' do
    allow(card).to receive(:touch_in).with(station) { subject.entry_station = station }
    card.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it 'should finish journey ' do
    allow(card).to receive(:touch_out).with(station) { subject.exit_station = station }
    card.touch_out(station)
    expect(subject.exit_station).to eq station
  end

  describe '#fare' do
    it 'should return minimum fare'do
      subject.entry_station = station
      subject.exit_station = station
      expect(subject.fare).to eq described_class::MINIMUM_FARE
    end

    it 'should return penalty fare if entry station is nil' do
      subject.entry_station = nil
      expect(subject.fare).to eq described_class::PENALTY
    end

    it 'should return penalty fare if exit station is nil' do
      subject.exit_station = nil
      expect(subject.fare).to eq described_class::PENALTY
    end


  end

end

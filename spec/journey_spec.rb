require 'journey'

describe Journey do
  let(:journey) { described_class.new(:aldgate) }
  it 'initializes with an entry station' do
    expect(journey.entry_station).to eq :aldgate
  end

  describe '#finish' do
    it 'saves the exit station' do
      journey.finish(:angel)
      expect(journey.exit_station).to eq :angel
    end
  end

  describe '#fare' do
  it 'returns a fare' do
    journey.finish(:aldgate)
    expect(journey.fare).to eq described_class::MIN_FARE
  end
end
end

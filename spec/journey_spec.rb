require 'journey'
require 'station'

describe Journey do
  let(:station) { Station.new(:test_station, 1) }
  let(:journey) { described_class.new(station) }
  describe '#finish' do
    it 'saves the exit station' do
      journey.finish(station)
      expect(journey.exit_station).to eq station
    end
  end

  describe '#fare' do
    let(:test_exit_station) { Station.new(:test_exit, 5) }
    it 'returns a fare' do
      journey.finish(station)
      expect(journey.fare).to eq described_class::FARE
    end

    it 'returns a calculated fare when crossing multiple zones'  do
      journey.finish(test_exit_station)
      expect(journey.fare).to eq 5
    end
  end
end

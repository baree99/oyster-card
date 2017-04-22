require 'journeylog'

describe JourneyLog do
  let(:station) { Station.new(:station, 1)}
  describe '#start' do
    it 'starts a journey' do
      subject.start(station)
      expect(subject.current_journey.entry_station).to eq station
    end
  end

  describe '#finish' do
    it 'finishes a journey' do
      subject.start(station)
      expect { subject.finish(station) }.to change {subject.current_journey.exit_station}.from(nil).to(station)
    end
    it 'stores the last completed journey' do
      subject.start(station)
      subject.finish(station)
      subject.record_journey
      expect(subject.journeys[0].values_at(:entry_station, :exit_station)).to eq [station, station]
    end
  end
end

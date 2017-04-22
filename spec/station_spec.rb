require 'station'

describe Station do
 let(:station) { described_class.new(:test_station, 1) }

  it 'records a station\'s zone' do
    expect(station.zone).to eq 1
  end

  it 'records a station\'s name' do
    expect(station.name).to eq :test_station
  end

end

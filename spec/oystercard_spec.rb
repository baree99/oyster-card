require 'oystercard'
require 'journey'

describe Oystercard do
  station = Station.new(:station, 1)
  describe '#top_up' do
    it 'tops up balance by specified amount' do
      subject.top_up(15)
      expect(subject.balance).to eq 15
    end
end
    it 'raises an error if top-up would push balance above £90' do
      expect{ subject.top_up(100) }.to raise_error "Top-up would exceed £#{Oystercard::DEFAULT_LIMIT} limit"
    end



describe '#touch_in' do

  it 'touches in' do
    subject.top_up(90); subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it 'raises an error when insufficient funds' do
    expect { subject.touch_in(station) }.to raise_error 'Insufficient funds'
  end

  it 'charges a penalty fare if not touched out from previous trip' do
    subject.top_up(20); subject.touch_in(station)
    expect{subject.touch_in(station)}.to change { subject.balance }.by (-Journey::PEN_FARE)
  end

end

describe '#touch_out' do

  it 'touches out' do
    subject.top_up(90); subject.touch_in(station); subject.touch_out(station)
    expect(subject).not_to be_in_journey
  end

  it 'charges minimum fare' do
  subject.top_up(10); subject.touch_in(station)
  expect{ subject.touch_out(station) }.to change{ subject.balance }.by -Journey::FARE
  end

  it 'charges a penalty fare if not touched in for journey' do
    subject.top_up(20)
    expect{subject.touch_out(station)}.to change { subject.balance }.by (-Journey::PEN_FARE)
  end

end

describe '#save_journey' do
  it 'saves journey history' do
  subject.top_up(90); subject.touch_in(station); subject.touch_out(station)
  expect(subject.journeylog.journeys[0].values_at(:entry_station, :exit_station)).to eq [station, station]
  end
end

describe '#in_journey?' do

  it 'checks the journey status' do
    expect(subject.in_journey?).to eq(true).or(eq(false))
  end
end
end

require 'oystercard'

describe Oystercard do
let(:card) { described_class.new }
let(:station) { double("station") }

before do
@min = Oystercard::MIN_FUNDS
end
  it { is_expected.to respond_to(:balance) }

  it 'initializes with a balance of zero' do
    expect(card.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'initializes with an empty journey history' do
    expect(card.journey_history).to be_empty
  end

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
    card.top_up(@min); card.touch_in(station)
    expect(card).to be_in_journey
  end

  it 'raises an error when insufficient funds' do
    expect { card.touch_in(station) }.to raise_error 'Insufficient funds'
  end

  it 'charges a penalty fare if not touched out from previous trip' do
    card.top_up(20); card.touch_in(station)
    expect{card.touch_in(station)}.to change { card.balance }.by (-Journey::PEN_FARE)
  end

end

describe '#touch_out' do

  it 'touches out' do
    card.top_up(@min); card.touch_in(station); card.touch_out(station)
    expect(card).not_to be_in_journey
  end

  it 'charges minimum fare' do
  card.top_up(10); card.touch_in(station)
  expect{ card.touch_out(station) }.to change{ card.balance }.by -Oystercard::FARE
  end

  it 'charges a penalty fare if not touched in for journey' do
    card.top_up(20)
    expect{card.touch_out(station)}.to change { card.balance }.by (-Journey::PEN_FARE)
  end

end

describe '#save_journey' do
  it 'saves journey history' do
  card.top_up(@min); card.touch_in(station); card.touch_out(station)
  expect(card.journey_history[0].values_at(:entry_station, :exit_station)).to eq [station, station]
  end
end

describe '#in_journey?' do

  it 'checks the journey status' do
    expect(card.in_journey?).to eq(true).or(eq(false))
  end
end
end

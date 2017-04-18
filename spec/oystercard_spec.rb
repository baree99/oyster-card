require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  describe '#initialize' do
    it 'set balance variable to default zero' do
      expect(subject.balance).to eq described_class::DEFAULT_BALANCE
    end
  end

  describe '#top_up' do
    it 'adds money to your balance' do
      expect { subject.top_up(10) }.to change { subject.balance }.by +10
    end

    it "fails when maximum balance #{described_class::MAXIMUM_BALANCE} reached" do
      expect { subject.top_up(95) }.to raise_error "Maximum balance (£#{described_class::MAXIMUM_BALANCE}) reached"
    end
  end

  describe '#in_journey?' do
    it 'returns true when a card is touched in' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
    it 'returns false when a card is touched out' do
      subject.touch_out(exit_station)
      expect(subject).to_not be_in_journey
    end
  end

  describe '#touch_in' do
    it 'changes the status of the oystercard to be in journey' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it "stores the name of the entry entry_station" do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    it "raise an error when insufficient funds" do
      expect { subject.touch_in(entry_station) }.to raise_error "Insufficient funds"
    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
    end
    it 'changes the status of the oystercard to not in use' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).to_not be_in_journey
    end

    it "stores the name of the exit station" do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

    it 'keeps track of the journeys made' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey).to include ({entry_station: entry_station, exit_station: exit_station})
    end

    it "deducts £#{described_class::MINIMUM_FARE} from balance" do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -described_class::MINIMUM_FARE
    end
  end
end

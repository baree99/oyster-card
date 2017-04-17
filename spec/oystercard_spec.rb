require 'oystercard'

describe Oystercard do
  describe '#initialize' do
    it 'set balance variable to default zero' do
      expect(subject.balance).to eq 0
    end
  end
  describe '#top_up' do
    it 'adds money to your balance' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
    it "fails when maximum balance #{Oystercard::MAXIMUM_BALANCE} reached" do
      expect { subject.top_up(95) }.to raise_error "Maximum balance (£#{Oystercard::MAXIMUM_BALANCE}) reached"
    end
  end
  describe '#deduct' do
    it "deducts the money spent on travelling from the oystercard's balance" do
      subject.top_up(20)
      subject.deduct(2.5)
      expect(subject.balance).to eq 17.5
    end
  end
end

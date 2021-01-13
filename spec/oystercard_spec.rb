require 'oystercard'

describe Oystercard do

  min_balance = Oystercard::MINBALANCE
  max_balance = Oystercard::MAXBALANCE
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journeys){ {entry_station: entry_station, exit_station: exit_station} }


  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to equal(0)
  end

  describe "#top_up" do
    it "can be topped up" do
    expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it "has a top up limit of 90" do
      subject.top_up(1)
    expect{ subject.top_up(max_balance) }.to raise_error "exceeds top up limit of #{max_balance}"
    end
  end

  describe "#in_journey?" do
    it "expects a card to not be in journey upon initialization" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do

    before(:each) do
      subject.top_up(min_balance)
      subject.touch_in(entry_station)
    end
    it "can be touched in" do
      expect(subject).to be_in_journey
    end

    it "raises an error if a card is touched in without a minimum balance" do 
      subject.touch_out(exit_station)
      expect{ subject.touch_in(entry_station) }.to raise_error "must top up card with minimum balance of #{min_balance} first"
    end

    it "remembers the entry station the card was touched in at" do
      expect(subject.entry_station).to eq(entry_station)
    end
  end

  describe "#touch_out" do

    before(:each) do
      subject.top_up(min_balance)
      subject.touch_in("hackney")
      subject.touch_out("Liverpool Street")
    end

    it "can be touched out" do
      expect(subject).not_to be_in_journey
    end

    it "deducts the minimum fare when touched out" do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINBALANCE)
    end 

    it "forgets the entry station once touched out" do
      expect(subject.entry_station).to eq(nil)
    end

    it "stores the exit station" do
      expect(subject.exit_station).to eq("Liverpool Street")
    end
  end

  describe "#journeys" do
    it "starts with an empty jouney hash" do
      expect(subject.journeys).to be_empty
    end

    it "stores an entry station and exit station for the journey" do
      subject.top_up(min_balance)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journeys
    end

  end
end
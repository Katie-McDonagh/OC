require 'oystercard'

describe Oystercard do

  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to equal(0)
  end

  describe "#top_up" do
    it "can be topped up" do
    expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it "has a top up limit of 90" do
      max_balance = Oystercard::MAXBALANCE
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
    it "can be touched in" do
      min_balance = Oystercard::MINBALANCE
      subject.top_up(min_balance)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "raises an error if a card is touched in without a minimum balance" do 
      min_balance = Oystercard::MINBALANCE
      expect{ subject.touch_in }.to raise_error "must top up card with minimum balance of #{min_balance} first"
    end
  end

  describe "#touch_out" do
  it "can be touched out" do
    min_balance = Oystercard::MINBALANCE
    subject.top_up(min_balance)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it "deducts the minimum fare when touched out" do
  min_balance = Oystercard::MINBALANCE
  subject.top_up(min_balance)
  subject.touch_in
  subject.touch_out
  expect(subject.balance).to eq(0)
end

end
end
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

  describe "#deduct" do
    it "can deduct amount from the balance" do

      expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
    end

  end
end
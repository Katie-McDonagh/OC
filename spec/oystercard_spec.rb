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
    expect{ subject.top_up(91) }.to raise_error 'exceeds top up limit'
    end
  end
end
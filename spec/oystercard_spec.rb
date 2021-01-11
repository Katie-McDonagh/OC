require 'oystercard'

describe Oystercard do

  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to equal(0)
  end

  it "can be topped up" do
    subject.top_up(10)
    expect(subject.balance).to equal(10)
  end
  
end
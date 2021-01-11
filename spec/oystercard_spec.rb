require 'oystercard'

describe Oystercard do
  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to equal(0)
  end
end
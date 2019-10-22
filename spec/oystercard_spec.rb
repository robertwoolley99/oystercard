require 'oystercard'

describe Oystercard do
  let(:card) {Oystercard.new}

  context "balance on card" do
    it "has a balance" do
      expect(card.balance).to eq 0
    end

    it "allows you to add money to the card" do
      card.top_up(1)
      expect(card.balance).to eq(1)
    end

    it "doesn't allow you to add more money than the limit to the card" do
      expect{ card.top_up(100) }.to raise_error("Maximum balance is £#{Oystercard::BALANCE_LIMIT}.")
    end

    it "allows you to deduct money from the card" do
      card.deduct(5)
      expect(card.balance).to eq(-5)
    end

    it "gets blocked by the gateline if the balance is below minimum" do
      expect{ card.touch_in}.to raise_error("Access denied. Card balance below min.")
    end



  end

  context "is the card in use?" do
    it "the card is in use" do
      expect(card.in_journey?).to eq false
    end

    it "allows you to touch in to start a journey" do
      card.top_up(Oystercard::MIN_BALANCE)
      card.touch_in
      expect(card.in_journey?).to eq true
    end

    it "allows you to touch out to end a journey" do
      card.touch_out
      expect(card.in_journey?).to eq false
    end
  end

end

require 'checkout'

RSpec.describe Checkout do
  [
    { items: %w(VOUCHER TSHIRT MUG), price: 32.5 },
    { items: %w(VOUCHER TSHIRT VOUCHER), price: 25.0 },
    { items: %w(TSHIRT TSHIRT TSHIRT VOUCHER TSHIRT), price: 81.0 },
    { items: %w(VOUCHER TSHIRT VOUCHER VOUCHER MUG TSHIRT TSHIRT), price: 74.5 }
  ].each do |expectation|
    it 'satisfies cabify\'s expectations for the test' do
      expectation[:items].each { |item| subject.scan item }
      expect(subject.total).to eq(expectation[:price])
    end
  end
end

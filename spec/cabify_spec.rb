require 'checkout'

RSpec.describe Checkout do
  Checkout.configure do |config|
    config.repository = Model::InMemoryRepository.new [
      Model::Item.new(code: 'VOUCHER', name: 'Cabify Voucher', price: 5),
      Model::Item.new(code: 'TSHIRT', name: 'Cabify T-Shirt', price: 20),
      Model::Item.new(code: 'MUG', name: 'Cabify Mug', price: 7.5)
    ]
  end

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
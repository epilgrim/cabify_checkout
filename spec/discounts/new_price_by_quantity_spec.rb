require 'discounts/new_price_by_quantity'
require 'model/item'

RSpec.describe Discounts::NewPriceByQuantity do
  let(:subject) { described_class.new(code: 'rand', quantity: 2, new_price: 3) }
  let(:item) { Model::Item.new code: 'rand', name: 'Rand al\'thor', price: 5 }
  let(:item_irrelevant) { Model::Item.new code: 'matt', name: 'Matt Cauthon', price: 1 }

  it 'returns the items unchanged when the discount does not apply' do
    items = [item, item_irrelevant, item_irrelevant]
    expect(subject.apply_to(items)).to eq(items)
  end

  it 'adds a new item when the discount applies' do
    items = [item_irrelevant, item, item, item]
    allow(Model::Item).to(
      receive(:new)
      .with(code: 'discount_rand', name: 'Bulk Discount Rand al\'thor', price: -6)
      .and_return('correct_discount')
    )
    expected_items = items + ['correct_discount']
    expect(subject.apply_to(items)).to eq(expected_items)
  end
end

require 'discounts/every_x_get_y_free'
require 'model/item'

RSpec.describe Discounts::EveryXGetYFree do
  let(:subject) { described_class.new('rand', 2, 1) }
  let(:item) { Model::Item.new code: 'rand', name: 'Rand al\'thor', price: 5 }
  let(:item_irrelevant) { Model::Item.new code: 'matt', name: 'Matt Cauthon', price: 1 }

  it 'returns the items unchanged when the discount does not apply' do
    items = [item, item_irrelevant, item_irrelevant]
    expect(subject.apply_to(items)).to eq(items)
  end

  it 'adds a new item when the discount applies once' do
    items = [item, item]
    allow(Model::Item).to(
      receive(:new)
      .with(code: 'discount_rand', name: 'Free Rand al\'thor', price: -5)
      .and_return('correct_discount')
    )
    expected_items = items + ['correct_discount']
    expect(subject.apply_to(items)).to eq(expected_items)
  end

  it 'adds a new item with the correct price when the discount applies multiple times' do
    items = [item, item, item, item, item]
    allow(Model::Item).to(
      receive(:new)
      .with(code: 'discount_rand', name: 'Free Rand al\'thor', price: -10)
      .and_return('correct_discount')
    )
    expected_items = items + ['correct_discount']
    expect(subject.apply_to(items)).to eq(expected_items)
  end
end

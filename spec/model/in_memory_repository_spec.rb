require 'model/in_memory_repository'
require 'model/item_not_found'
require 'model/item'

RSpec.describe Model::InMemoryRepository do
  let(:smaug) { instance_double Model::Item, code: 'smaug' }
  let(:gandalf) { instance_double Model::Item, code: 'gandalf' }
  let(:subject) { described_class.new([smaug, gandalf]) }

  it 'raises error if the item is not in the repository' do
    expect { subject.find!('frodo') }.to raise_error(Model::ItemNotFound)
  end

  it 'returns items by code' do
    expect(subject.find!('smaug')).to be(smaug)
  end
end

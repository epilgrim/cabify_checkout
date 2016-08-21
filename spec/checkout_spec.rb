require 'checkout'

RSpec.describe Checkout do
  let(:repository) { instance_double Model::InMemoryRepository }
  let(:item_vader) { instance_double Model::Item, code: 'vader', name: 'darth vader', price: 3 }
  let(:item_luke) { instance_double Model::Item, code: 'luke', name: 'darth luke', price: 5 }

  before :each do
    Checkout.configure do |config|
      config.repository = repository
    end
    allow(repository).to receive(:find).with('vader').and_return(item_vader)
    allow(repository).to receive(:find).with('luke').and_return(item_luke)
  end

  describe 'total calculation' do
    context 'no items' do
      it 'has 0 value' do
        expect(subject.total).to eq(0)
      end
    end

    context 'single item' do
      it 'has the value of the item' do
        subject.scan 'vader'
        expect(subject.total).to eq(3)
      end
    end

    context 'multiple items' do
      it 'has the value of the sum of the items' do
        subject.scan 'vader'
        subject.scan 'luke'
        expect(subject.total).to eq(8)
      end
    end
  end
end

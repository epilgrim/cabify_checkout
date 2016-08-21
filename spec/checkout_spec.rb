require 'checkout'
require 'model/in_memory_repository'
require 'model/item'
require 'discounts/every_x_get_y_free'

RSpec.describe Checkout do
  let(:repository) { instance_double Model::InMemoryRepository }
  let(:item_vader) { instance_double Model::Item, code: 'vader', name: 'darth vader', price: 3 }
  let(:item_luke) { instance_double Model::Item, code: 'luke', name: 'darth luke', price: 5 }
  let(:discount_1) { instance_double Discounts::EveryXGetYFree }
  let(:discount_2) { instance_double Discounts::EveryXGetYFree }

  before :each do
    Checkout.configure do |config|
      config.repository = repository
    end
    allow(repository).to receive(:find).with('vader').and_return(item_vader)
    allow(repository).to receive(:find).with('luke').and_return(item_luke)
  end

  context 'without discounts' do
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
  context 'with discounts' do
    let(:subject) { described_class.new([discount_1, discount_2]) }
    before do
      allow(discount_1).to receive(:apply_to).with([item_vader]).and_return([item_luke])
      allow(discount_2).to receive(:apply_to).with([item_luke]).and_return([item_vader, item_luke])
    end

    it 'applies the discounts to the items' do
      subject.scan 'vader'
      expect(subject.total).to eq(8)
    end
  end
end

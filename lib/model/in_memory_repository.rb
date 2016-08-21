module Model
  class InMemoryRepository
    def initialize(items)
      @items = items
    end

    def find(code)
      @items.find(-> { raise Model::ItemNotFound }) { |i| i.code == code }
    end
  end
end

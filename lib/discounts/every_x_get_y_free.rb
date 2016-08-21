module Discounts
  class EveryXGetYFree
    def initialize(item_code, every, get_free)
      @item_code = item_code
      @every = every
      @get_free = get_free
    end

    def apply_to(items)
      relevant_items = items.select { |item| item.code == @item_code }
      number_of_relevant_items = relevant_items.count
      number_of_free_items = (number_of_relevant_items / @every) * @get_free
      return items unless number_of_free_items > 0

      item = relevant_items.first
      free_item = Model::Item.new(
        code: "discount_#{item.code}",
        name: "Free #{item.name}",
        price: - 1 * item.price * number_of_free_items
      )
      items << free_item
    end
  end
end

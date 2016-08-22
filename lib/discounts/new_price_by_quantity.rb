module Discounts
  class NewPriceByQuantity
    def initialize(code:, quantity:, new_price:)
      @item_code = code
      @quantity = quantity
      @new_price = new_price
    end

    def apply_to(items)
      relevant_items = items.select { |item| item.code == @item_code }
      number_of_relevant_items = relevant_items.count
      return items unless number_of_relevant_items >= @quantity

      item = relevant_items.first
      free_item = Model::Item.new(
        code: "discount_#{item.code}",
        name: "Bulk Discount #{item.name}",
        price: - 1 * (item.price - @new_price) * number_of_relevant_items
      )
      items + [free_item]
    end
  end
end

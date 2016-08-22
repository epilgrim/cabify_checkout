require 'dry-configurable'

class Checkout
  extend Dry::Configurable
  setting :repository

  def initialize(discounts = [])
    @discounts = discounts
    @items = []
  end

  def scan(item)
    @items << repository.find!(item)
  end

  def total
    invoice_items.reduce(0) { |partial, item| partial + item.price }
  end

  private

  def invoice_items
    @discounts.reduce(@items.dup) { |items, discount| discount.apply_to(items) }
  end

  def repository
    Checkout.config.repository
  end
end

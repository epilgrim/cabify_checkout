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
    items = @items.dup
    @discounts.each { |discount| items = discount.apply_to(items) }
    items
  end

  def repository
    Checkout.config.repository
  end
end

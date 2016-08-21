require 'dry-configurable'
require 'model/in_memory_repository'
require 'model/item'
require 'discounts/every_x_get_y_free'

class Checkout
  extend Dry::Configurable
  setting :repository

  def initialize(discounts = [])
    @discounts = discounts
    @items = []
  end

  def scan(item)
    @items << repository.find(item)
  end

  def total
    items = @items.dup
    @discounts.each { |discount| items = discount.apply_to(items) }
    items.reduce(0) { |partial, item| partial + item.price }
  end

  private

  def repository
    Checkout.config.repository
  end
end

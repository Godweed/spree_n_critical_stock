module Spree
  Product.class_eval do
    delegate_belongs_to :master, :critical_stock
  end
end
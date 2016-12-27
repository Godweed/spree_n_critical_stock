module Spree
  AppConfiguration.class_eval do
    preference :critical_stock_mail, :string, default: "spree@commerce.cl"
  end
end
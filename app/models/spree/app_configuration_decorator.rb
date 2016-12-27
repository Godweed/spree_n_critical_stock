module Spree
  AppConfiguration.class_eval do
    preference :critical_stock_mail_to, :string, default: "spree@commerce.cl"
  end
end
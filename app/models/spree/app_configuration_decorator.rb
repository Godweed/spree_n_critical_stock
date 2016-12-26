module Spree
  AppConfiguration.class_eval do
    preference :mail_to_address, :string, default: "spree@commerce.cl"
  end
end
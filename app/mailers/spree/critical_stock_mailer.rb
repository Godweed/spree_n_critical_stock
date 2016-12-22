module Spree
  class CriticalStockMailer < BaseMailer
    def send_warning(product)
      @product = product
      subject = "Stock Critico para "+@product.name
      mail(to: Spree::Config.mail_to_address, from: Spree::Store.current.mail_from_address, subject: subject)
    end
  end
end
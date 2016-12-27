module Spree
  class CriticalStockMailer < BaseMailer
    def send_warning(product, variant)
      @product = product
      @variant = variant
      subject = product.is_master ? "Stock Critico para "+@product.name : "Stock Critico para "+@product.name+" en la variante con sku "+variant.sku
      mail(to: Spree::Config.critical_stock_mail, from: Spree::Store.current.mail_from_address, subject: subject)
    end
  end
end
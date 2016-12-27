module Spree
  Variant.class_eval do
    before_save :check_critical_stock, if: :critical_stock_changed?
    after_destroy :check_variants_critical_stock

    def check_critical_stock
      if critical_stock.present?
        if critical_stock < total_on_hand && (has_critical_stock_was || !has_critical_stock_was.present?)
          self.has_critical_stock = false
          if product.variants.length > 0 && product.master.has_critical_stock
            self.product.master.has_critical_stock = false
            product.master.save
          else
            if !product.variants.where("has_critical_stock = true AND is_master = false AND id != ?", id).empty? && !product.master.has_critical_stock
              self.product.master.has_critical_stock = false
              self.product.master.save
            end
          end
        elsif critical_stock >= total_on_hand && (!has_critical_stock_was || !has_critical_stock_was.present?)
          if !new_record?
            Spree::CriticalStockMailer.send_warning(product, self).deliver_now
          end
          self.has_critical_stock = true
          if !product.master.has_critical_stock && product.variants.length > 0
            self.product.master.has_critical_stock = true
            product.master.save
          end
        end
      else
        self.has_critical_stock = false if has_critical_stock
        if product.variants.length > 0 && product.master.has_critical_stock && !product.variants.where("has_critical_stock = true AND is_master = false AND id != ?", id).empty?
            self.product.master.has_critical_stock = false
            product.master.save
        end
      end
      return
    end

    def check_variants_critical_stock
      if product.variants.length > 0 && product.master.has_critical_stock && product.variants.where(has_critical_stock: true).empty?
        self.product.master.has_critical_stock = false
        product.master.save
      end
      return
    end
  end
end
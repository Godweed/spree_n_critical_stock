module Spree
  Variant.class_eval do
    before_save :check_critical_stock, if: :critical_stock_changed?
    after_destroy :check_variants_critical_stock
    
    private
      def check_critical_stock
        product = self.product
        if critical_stock.present?
          if product.has_critical_stock == has_critical_stock
            if has_critical_stock
              if critical_stock < total_on_hand
                self.has_critical_stock = false
                check_variants_critical_stock
              end
            else
              if critical_stock >= total_on_hand
                if !new_record?
                  Spree::CriticalStockMailer.send_warning(product, self).deliver_now
                  self.has_critical_stock = true
                  self.product.has_critical_stock = true
                  product.save
                end
              end
            end
          else
            if critical_stock >= total_on_hand
              self.has_critical_stock = true
            end
          end
        else
          if has_critical_stock
            self.has_critical_stock = false
          end
          if product.has_critical_stock
            check_variants_critical_stock
          end
        end
        return
      end

      def check_variants_critical_stock
        product = self.product
        variants = product.variants.where(has_critical_stock: true)
        if product.present?
          if variants.empty? && product.has_critical_stock
            if product.is_master && product.master.critical_stock.present?
              if product.master.critical_stock < product.total_on_hand
                product.has_critical_stock = false
                product.save
              end
            else
              product.has_critical_stock = false
              product.save
            end
          elsif product.is_master && !product.has_critical_stock
            if product.master.critical_stock.present?
              if product.master.critical_stock >= product.total_on_hand
                product.has_critical_stock = true
                product.save
              end
            end
          end
        end
        return
      end
  end
end
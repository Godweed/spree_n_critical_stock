module Spree
  StockItem.class_eval do
    after_save :new_check_critical_stock, if: :count_on_hand_changed?
    after_destroy :new_check_critical_stock

    private
      def new_check_critical_stock
        if variant.critical_stock.present?
          if variant.has_critical_stock
            if variant.critical_stock < variant.total_on_hand
              self.variant.has_critical_stock = false
              variant.save
              if !variant.is_master && variant.product.variants.where(has_critical_stock: true, is_master: false).empty? && variant.product.master.has_critical_stock
                self.variant.product.master.has_critical_stock = false
                variant.product.master.save
              end
            end
          else
            if variant.critical_stock >= variant.total_on_hand
              Spree::CriticalStockMailer.send_warning(variant.product, variant).deliver_now
              self.variant.has_critical_stock = true
              variant.save
              if !variant.is_master
                self.variant.product.master.has_critical_stock = true
                variant.product.master.save
              end
            end
          end
        else
          if variant.has_critical_stock
            self.variant.has_critical_stock = false
            variant.save
          end
          if variant.product.master.has_critical_stock && !variant.is_master && !variant.product.variants.where(has_critical_stock: true, is_master: false)
            self.variant.product.master.has_critical_stock = false
            variant.product.master.save
          end
        end
        return
      end
  end
end
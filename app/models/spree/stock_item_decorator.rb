module Spree
  StockItem.class_eval do
    after_save :check_critical_stock, if: :count_on_hand_changed?
    after_destroy :check_critical_stock

    private

      def check_critical_stock
        product = self.variant.product
        variant = self.variant
        if variant.critical_stock.present?
          if product.has_critical_stock == variant.has_critical_stock
            if variant.has_critical_stock
              if variant.critical_stock < variant.total_on_hand
                variant.has_critical_stock = false
                variant.save
                check_variants_critical_stock
              end
            else
              if variant.critical_stock >= variant.total_on_hand
                Spree::CriticalStockMailer.send_warning(product).deliver_now
                variant.has_critical_stock = true
                variant.save
                product.has_critical_stock = true
                product.save
              end
            end
          else
            if variant.critical_stock >= variant.total_on_hand
              variant.has_critical_stock = true
              variant.save
            end
          end
        else
          if variant.has_critical_stock
            variant.has_critical_stock = false
            variant.save
          end
          if product.has_critical_stock
            check_variants_critical_stock
          end
        end
        return
      end

      def check_variants_critical_stock
        product = self.variant.product
        variants = product.variants.where(has_critical_stock: true)
        if variants.empty? && product.has_critical_stock
          product.has_critical_stock = false
          product.save
        end
        return
      end
  end
end
Deface::Override.new(:virtual_path => 'spree/admin/products/_form',
  :name => 'add_master_critical_stock_to_product_edit',
  :insert_before => "[data-hook='admin_product_form_sku']",
  :text => "
    <%= f.field_container :critical_stock do %>
      <%= f.label :critical_stock, Spree.t(:critical_stock) %>
      <%= f.text_field :critical_stock, class: 'form-control' %>
      <%= f.error_message_on :critical_stock %>
    <% end %>
  ")
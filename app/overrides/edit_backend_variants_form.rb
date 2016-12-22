Deface::Override.new(:virtual_path => 'spree/admin/variants/_form',
  :name => 'add_critical_stock_to_variants_edit',
  :insert_before => "[data-hook='discontinue_on']",
  :text => "
    <div class='form-group'>
      <%= f.field_container :critical_stock do %>
        <%= f.label :critical_stock %>
        <%= f.number_field :critical_stock, class: 'form-control' %>
        <%= f.error_message_on :critical_stock %>
      <% end %>
    </div>
  ")
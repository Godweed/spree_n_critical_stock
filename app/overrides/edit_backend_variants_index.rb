Deface::Override.new(:virtual_path => 'spree/admin/variants/index',
  :name => 'add_critical_stock_header_to_backend_variants_index',
  :replace => '[data-hook="variants_header"]',
  :text => '
    <thead data-hook="variants_header">
      <tr>
        <th colspan="2"><%= Spree.t(:options) %></th>
        <th><%= Spree.t(:price) %></th>
        <th><%= Spree.t(:sku) %></th>
        <th><%= Spree.t(:critical_stock) %></th>
        <th><%= Spree.t(:total_on_hand) %></th>
        <th class="actions"></th>
      </tr>
    </thead>
  ')

Deface::Override.new(:virtual_path => 'spree/admin/products/index',
  :name => 'add_critical_stock_row_to_backend_variants_index',
  :replace => '[data-hook="variants_header"]',
  :text => '
    <tr id="<%= spree_dom_id variant %>" <%= "style=\'color:red;\'" if variant.deleted? %> data-hook="variants_row">
        <td class="move-handle">
          <% if can? :edit, variant %>
            <span class="icon icon-move handle"></span>
          <% end %>
        </td>
        <td><%= variant.options_text %></td>
        <td><%= variant.display_price.to_html %></td>
        <td><%= variant.sku %></td>
        <td><%= variant.critical_stock %></td>
        <td><%= variant.total_on_hand %></td>
        <td class="actions actions-2 text-right">
          <%= link_to_edit(variant, no_text: true) if can?(:edit, variant) && !variant.deleted? %>
          <%= link_to_delete(variant, no_text: true) if can?(:destroy, variant) && !variant.deleted? %>
        </td>
      </tr>
  ')
# frozen_string_literal: true

module LeadsHelper
  def dropdwon_mappings
    {
      'status' => 'Status',
      'amount_owed' => 'Amount owed',
      'property_sold' => 'Property sold',
      'county' => 'County',
      'date_sold' => 'Date sold',
      'mortgage_company' => 'Mortgage company',
      'initial_bid_amount' => 'Initial bid amount',
      'sold_amount' => 'Sold amount',
      'label' => 'Label',
      'name' => 'Name'
    }.with_indifferent_access
  end

  def mapping_options
    dropdwon_mappings.map { |key, value| [value, key] }
  end

  def lead_users_options
    [%i[All All]] + lead_users_select_options
  end

  def lead_users_select_options
    User.pluck(Arel.sql("CONCAT(first_name, ' ', last_name) AS full_name"), :id).reject { |user| user.first.blank? }
  end
end

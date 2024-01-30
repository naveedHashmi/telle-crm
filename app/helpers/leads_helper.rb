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
end

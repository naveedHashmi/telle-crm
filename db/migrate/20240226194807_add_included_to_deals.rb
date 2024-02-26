class AddIncludedToDeals < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :included, :boolean, default: true
  end
end

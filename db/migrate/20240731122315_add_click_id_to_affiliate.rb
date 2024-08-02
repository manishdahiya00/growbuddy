class AddClickIdToAffiliate < ActiveRecord::Migration[7.1]
  def change
    add_column :affiliates, :click_id, :string
  end
end

class CreateAffiliates < ActiveRecord::Migration[7.1]
  def change
    create_table :affiliates do |t|
      t.string :paytm_number
      t.string :upi_id
      t.string :campaign_name
      t.string :refer_code
      t.integer :referrers_count, default: 0

      t.timestamps
    end
  end
end

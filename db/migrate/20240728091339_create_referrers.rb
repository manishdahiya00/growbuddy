class CreateReferrers < ActiveRecord::Migration[7.1]
  def change
    create_table :referrers do |t|
      t.string :live_offer_id
      t.references :app_offer, null: false, foreign_key: true
      t.string :click_id
      t.references :affiliate, null: false, foreign_key: true
      t.string :paytm_number
      t.string :upi_id
      t.string :source_ip
      t.boolean :aff_status, default: false
      t.boolean :ref_status, default: false
      t.string :aff_order_id
      t.string :ref_order_id
      t.string :aff_pay_response
      t.string :ref_pay_response

      t.timestamps
    end
  end
end

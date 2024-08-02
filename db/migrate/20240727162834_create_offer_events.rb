class CreateOfferEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :offer_events do |t|
      t.string :event_title
      t.string :event_amount
      t.string :pay_type
      t.integer :event_order, default: 1
      t.references :app_offer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

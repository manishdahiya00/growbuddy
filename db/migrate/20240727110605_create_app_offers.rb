class CreateAppOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :app_offers do |t|
      t.string :offer_name
      t.string :offer_amount, default: "0"
      t.boolean :status, default: true
      t.text :description
      t.string :daily_cap, default: "0"
      t.string :whatsapp_link
      t.boolean :insta_offer, default: false
      t.boolean :retention_offer, default: false
      t.boolean :event_offer, default: false
      t.string :identifier
      t.string :refer_amount, default: "0"
      t.string :image_url, default: "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.pngall.com%2Fwp-content%2Fuploads%2F2016%2F07%2FSpecial-offer-PNG-Images.png&f=1&nofb=1&ipt=6ecc7274e6f401a747c1eb85e483ce0b38037a10443a9f09c2db1d4463c588a7&ipo=images"
      t.text :instructions
      t.string :action_url
      t.integer :offer_priority, default: 1

      t.timestamps
    end
  end
end

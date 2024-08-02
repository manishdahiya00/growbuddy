class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :social_email
      t.string :social_name
      t.string :mobile_number
      t.string :source_ip
      t.text :social_token
      t.string :social_img_url
      t.string :social_type
      t.text :oauth_response

      t.timestamps
    end
  end
end

class CreatePostbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :postbacks do |t|
      t.string :click_id
      t.string :offer
      t.string :event
      t.string :source_ip
      t.boolean :status, default: true
      t.string :aff_status
      t.string :ref_status

      t.timestamps
    end
  end
end

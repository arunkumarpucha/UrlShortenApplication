class CreateUrlHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :url_histories do |t|
      t.text :countries
      t.integer :click_count
      t.integer :mini_url_id
      t.text :ip_addresses
      t.timestamps
    end
  end
end

class CreateMiniUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :mini_urls do |t|
      t.string :original_url
      t.string :short_url
      t.string :sanitize_url
      t.timestamps
    end
  end
end

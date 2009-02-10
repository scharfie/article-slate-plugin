class Initial < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.integer  :space_id
      t.string   :name
      t.string   :permalink
      t.text     :body
      t.text     :body_html
      t.integer  :article_id
      t.integer  :version,      :default => 0
      t.datetime :published_at
      t.timestamps
    end
    
    create_table :article_settings do |t|
      t.string   :name
      t.text     :description
    end
  end

  def self.down
    drop_table :articles
    drop_table :article_settings
  end
end

class CreateCacheStore < ActiveRecord::Migration
  def change
    create_table :cache_stores, id: :uuid do |t|
      t.json :data
      t.timestamps
    end
  end
end

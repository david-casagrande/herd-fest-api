class AddIndexToCreatedAtInCacheStore < ActiveRecord::Migration
  def change
    add_index :cache_stores, :created_at
  end
end

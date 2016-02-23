class AddImageUrlToBands < ActiveRecord::Migration
  def change
    add_column :bands, :image_url, :string
  end
end

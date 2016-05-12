class AddSocialMediaToBands < ActiveRecord::Migration
  def change
    add_column :bands, :facebook_url, :string
    add_column :bands, :twitter_url, :string
  end
end

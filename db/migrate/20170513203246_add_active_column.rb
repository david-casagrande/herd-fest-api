class AddActiveColumn < ActiveRecord::Migration
  def change
    add_column :bands, :active, :boolean
    add_column :set_times, :active, :boolean
    add_column :venues, :active, :boolean
    add_column :days, :active, :boolean
  end
end

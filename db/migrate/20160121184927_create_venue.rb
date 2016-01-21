class CreateVenue < ActiveRecord::Migration
  def change
    create_table :venues, id: :uuid do |t|
      t.string :name
      t.text :street_address
      t.timestamps
    end
  end
end

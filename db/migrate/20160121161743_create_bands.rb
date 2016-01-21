class CreateBands < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :bands, id: :uuid do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end

class CreateDays < ActiveRecord::Migration
  def change
    create_table :days, id: :uuid do |t|
      t.date :date
      t.string :name
      t.timestamps
    end
  end
end

class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.references :classification
      t.string     :name
	  t.string     :range
	  t.integer    :extinction_date
      t.timestamps null: false
    end
  end
end

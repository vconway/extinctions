class CreateCommonNames < ActiveRecord::Migration
  def change
    create_table :common_names do |t|
	  t.references 
      t.timestamps null: false
    end
  end
end

class CreateJobs < ActiveRecord::Migration

  def change
    create_table :jobs do |t|
      t.string :name
      t.string :id_char

      t.timestamps null: false
    end
    add_index :jobs, :id_char
    add_index :jobs, :name
  end

end

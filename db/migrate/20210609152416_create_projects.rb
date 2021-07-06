class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects, id: :uuid do |t|

      t.string :name
      t.monetize :price
      t.string :description
      t.datetime :date
      t.datetime :due_date
      t.timestamps
    end
  end
end

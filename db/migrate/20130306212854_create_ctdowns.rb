class CreateCtdowns < ActiveRecord::Migration
  def change
    create_table :ctdowns do |t|
      t.string :title
      t.datetime :goal
      t.string :slug

      t.timestamps
    end
  end
end

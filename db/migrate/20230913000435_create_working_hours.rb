class CreateWorkingHours < ActiveRecord::Migration[7.0]
  def change
    create_table :working_hours do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :doctor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

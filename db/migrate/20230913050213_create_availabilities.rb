class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :booked, default: false
      t.references :doctor, null: false, foreign_key: { to_table: :users }
      t.references :working_hours, null: false, foreign_key: true

      t.timestamps
    end
  end
end
